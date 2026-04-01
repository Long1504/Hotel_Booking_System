package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateBookingRequest;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.entity.*;
import com.hotel_booking_system.enums.BookingStatus;
import com.hotel_booking_system.enums.PaymentMethod;
import com.hotel_booking_system.enums.PaymentStatus;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.BookingMapper;
import com.hotel_booking_system.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookingService {
    private final VNPayService VNPayService;
    private final BookingRepository bookingRepository;
    private final PriceRuleRepository priceRuleRepository;
    private final RoomRepository roomRepository;
    private final UserRepository userRepository;
    private final BookingMapper bookingMapper;

    private final EmailService emailService;

    public Page<BookingResponse> getAllBookings(String bookingStatus,
                                                String paymentStatus,
                                                String bookingCode,
                                                Pageable pageable) {
        return bookingRepository.findAll(bookingStatus, paymentStatus, bookingCode, pageable)
                .map(booking -> bookingMapper.toBookingResponse(booking));
    }

    public BookingResponse getBookingById(String bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        return bookingMapper.toBookingResponse(booking);
    }

    public List<BookingResponse> getMyBookings() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        return bookingRepository.findAllByUserOrderByCreatedAtDesc(user).stream()
                .map(booking -> bookingMapper.toBookingResponse(booking))
                .toList();
    }

    @Transactional
    public BookingResponse cancelBooking(String bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        // Chỉ cho hủy khi đang PENDING
        if (!booking.getBookingStatus().equals(BookingStatus.PENDING.name())) {
            throw new AppException(ErrorCode.INVALID_BOOKING_STATUS);
        }

        // Chỉ cho hủy trong 24h kể từ lúc đặt
        LocalDateTime createdAt = booking.getCreatedAt();
        LocalDateTime now = LocalDateTime.now();

        if (createdAt.plusHours(24).isBefore(now)) {
            throw new AppException(ErrorCode.CANNOT_CANCEL_AFTER_24H);
        }

        booking.setBookingStatus(BookingStatus.CANCELLED.name());

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        BookingStatusHistory bookingStatusHistory = BookingStatusHistory.builder()
                .booking(booking)
                .status(BookingStatus.CANCELLED.name())
                .changedBy(user)
                .build();

        booking.getBookingStatusHistories().add(bookingStatusHistory);

        booking =  bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse updateBookingStatus(String bookingId, String newBookingStatus) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        BookingStatus currentBookingStatusEnum = BookingStatus.valueOf(booking.getBookingStatus());

        BookingStatus newBookingStatusEnum;
        try {
            newBookingStatusEnum = BookingStatus.valueOf(newBookingStatus);
        } catch (IllegalArgumentException e) {
            throw new AppException(ErrorCode.INVALID_BOOKING_STATUS);
        }

        if (!isValidBookingStatusTransition(currentBookingStatusEnum, newBookingStatusEnum)) {
            throw new AppException(ErrorCode.INVALID_BOOKING_STATUS_TRANSITION);
        }

        booking.setBookingStatus(newBookingStatus);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        BookingStatusHistory bookingStatusHistory = BookingStatusHistory.builder()
                .booking(booking)
                .status(newBookingStatus)
                .changedBy(user)
                .build();

        booking.getBookingStatusHistories().add(bookingStatusHistory);

        booking =  bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse updateIdentityCard(String bookingId, String identityCard) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        booking.setIdentityCard(identityCard);

        booking = bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse updatePaymentMethod(String bookingId, String newPaymentMethod) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        booking.setPaymentMethod(newPaymentMethod);

        booking =  bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse updatePaymentStatus(String bookingId, String newPaymentStatus) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        PaymentStatus currentPaymentStatusEnum = PaymentStatus.valueOf(booking.getPaymentStatus());

        PaymentStatus newPaymentStatusEnum;
        try {
            newPaymentStatusEnum = PaymentStatus.valueOf(newPaymentStatus);
        } catch (IllegalArgumentException e) {
            throw new AppException(ErrorCode.INVALID_PAYMENT_STATUS);
        }

        if (currentPaymentStatusEnum == PaymentStatus.PAID && newPaymentStatusEnum == PaymentStatus.UNPAID) {
            throw new AppException(ErrorCode.INVALID_BOOKING_STATUS_TRANSITION);
        }

        booking.setPaymentStatus(newPaymentStatus);

        booking.setPaidAt(LocalDateTime.now());

        booking =  bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    private boolean isValidBookingStatusTransition(BookingStatus currentBookingStatus, BookingStatus newBookingStatus) {
        return switch (currentBookingStatus) {
            case PENDING -> newBookingStatus == BookingStatus.CONFIRMED || newBookingStatus == BookingStatus.CANCELLED;

            case CONFIRMED -> newBookingStatus == BookingStatus.CHECKED_IN || newBookingStatus == BookingStatus.CANCELLED;

            case CHECKED_IN -> newBookingStatus == BookingStatus.CHECKED_OUT;

            default -> false;
        };
    }

    @Transactional
    public BookingResponse createBooking(CreateBookingRequest request) {
        if (!roomRepository.isRoomAvailable(request.getRoomId(), request.getCheckInDate(), request.getCheckOutDate())) {
            throw new AppException(ErrorCode.ROOM_NOT_AVAILABLE);
        }

        Room room = roomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_NOT_FOUND));

        LocalDate checkInDate = request.getCheckInDate();
        LocalDate checkOutDate = request.getCheckOutDate();

        Map<LocalDate, BigDecimal> priceMap = buildPriceMap(checkInDate, checkOutDate);

        BigDecimal roomPrice = calculateRoomPriceByDateRange(
                room.getBasePrice(),
                checkInDate,
                checkOutDate,
                priceMap
        );

        User user = null;

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal())) {
            String username = authentication.getName();
            user = userRepository.findByUsername(username)
                    .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        }

        Booking booking = Booking.builder()
                .bookingCode(generateBookingCode())
                .checkInDate(request.getCheckInDate())
                .checkOutDate(request.getCheckOutDate())
                .guestName(request.getGuestName())
                .guestPhone(request.getGuestPhone())
                .guestEmail(request.getGuestEmail())
                .identityCard(request.getIdentityCard())
                .adults(request.getAdults())
                .children(request.getChildren())
                .note(request.getNote())
                .roomPrice(roomPrice)
                .totalPrice(roomPrice)
                .bookingStatus(BookingStatus.PENDING.name())
                .paymentMethod(PaymentMethod.CASH.name())
                .paymentStatus(PaymentStatus.UNPAID.name())
                .user(user)
                .room(room)
                .build();

        BookingStatusHistory history = BookingStatusHistory.builder()
                .booking(booking)
                .status(BookingStatus.PENDING.name())
                .changedBy(user)
                .build();

        booking.setBookingStatusHistories(new ArrayList<>());
        booking.getBookingStatusHistories().add(history);

        booking = bookingRepository.save(booking);

        emailService.sendEmail(bookingMapper.toSendBookingEmailRequest(booking));

        return bookingMapper.toBookingResponse(booking);
    }

    public String createVNPayPayment(String bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        if (PaymentStatus.PAID.name().equals(booking.getPaymentStatus())) {
            throw new AppException(ErrorCode.BOOKING_ALREADY_PAID);
        }

        booking.setPaymentMethod(PaymentMethod.VNPAY.name());
        bookingRepository.save(booking);

        return VNPayService.createPaymentUrl(
                booking.getBookingCode(),
                booking.getTotalPrice()
        );
    }

    private String generateBookingCode() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmmss-ddMMyyyy");

        int randomNumber = 10000 + new Random().nextInt(90000); // Random 5 chữ số

        return "BK-" + now.format(formatter) + "-" + randomNumber;
    }

    private Map<LocalDate, BigDecimal> buildPriceMap(LocalDate checkInDate, LocalDate checkOutDate) {
        List<PriceRule> rules = priceRuleRepository.findRulesInRange(checkInDate, checkOutDate);

        Map<LocalDate, BigDecimal> priceMap = new HashMap<>();

        for (PriceRule rule : rules) {
            LocalDate startDate = rule.getStartDate().isBefore(checkInDate)
                    ? checkInDate
                    : rule.getStartDate();

            LocalDate endDate = rule.getEndDate().isAfter(checkOutDate)
                    ? checkOutDate.minusDays(1)
                    : rule.getEndDate();

            LocalDate date = startDate;

            while (!date.isAfter(endDate)) {
                priceMap.put(date, rule.getPriceMultiplier());
                date = date.plusDays(1);
            }
        }

        return priceMap;
    }

    private BigDecimal calculateRoomPriceByDateRange(BigDecimal basePrice,
                                                     LocalDate checkInDate,
                                                     LocalDate checkOutDate,
                                                     Map<LocalDate, BigDecimal> priceMap) {
        BigDecimal roomPrice = BigDecimal.ZERO;

        LocalDate date = checkInDate;

        while (date.isBefore(checkOutDate)) {
            BigDecimal multiplier = priceMap.getOrDefault(date, BigDecimal.ONE);

            roomPrice = roomPrice.add(basePrice.multiply(multiplier));

            date = date.plusDays(1);
        }

        return roomPrice;
    }
}
