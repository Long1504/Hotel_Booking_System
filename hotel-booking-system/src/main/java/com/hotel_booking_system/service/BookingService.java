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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookingService {
    private final BookingRepository bookingRepository;
    private final PriceRuleRepository priceRuleRepository;
    private final RoomRepository roomRepository;
    private final UserRepository userRepository;
    private final BookingMapper bookingMapper;

    private final EmailService emailService;

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

        BigDecimal totalPrice = calculateTotalPrice(
                room.getBasePrice(),
                checkInDate,
                checkOutDate,
                priceMap
        );

        User user = null;

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        log.info(authentication.getName());

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
                .adults(request.getAdults())
                .children(request.getChildren())
                .note(request.getNote())
                .totalPrice(totalPrice)
                .user(user)
                .room(room)
                .build();

        if (request.getPaymentMethod().equals(PaymentMethod.CASH.name())) {
            booking.setPaymentMethod(PaymentMethod.CASH.name());
            booking.setPaymentStatus(PaymentStatus.UNPAID.name());
            booking.setPaidAt(null);
        }

        BookingStatusHistory history = BookingStatusHistory.builder()
                .booking(booking)
                .status(BookingStatus.PENDING.name())
                .changedBy(user)
                .build();

        booking.setBookingStatusHistories(List.of(history));

        booking = bookingRepository.save(booking);

        emailService.sendEmail(
                booking.getGuestEmail(),
                booking.getBookingCode(),
                booking.getCheckInDate(),
                booking.getCheckOutDate(),
                booking.getGuestName(),
                booking.getGuestPhone(),
                booking.getGuestEmail(),
                booking.getAdults(),
                booking.getChildren(),
                booking.getTotalPrice(),
                booking.getCreatedAt(),
                booking.getBookingStatus(),
                booking.getPaymentMethod(),
                booking.getPaymentStatus(),
                booking.getRoom().getRoomName(),
                booking.getRoom().getFloor(),
                booking.getRoom().getRoomNumber(),
                booking.getRoom().getArea(),
                booking.getRoom().getRoomType().getRoomTypeName(),
                booking.getRoom().getView().getViewName(),
                booking.getRoom().getRoomImages().stream()
                        .filter(roomImage -> roomImage.getIsMain())
                        .findFirst()
                        .map(roomImage -> roomImage.getImageUrl())
                        .orElse(null)
        );

        return bookingMapper.toBookingResponse(booking);
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

    private BigDecimal calculateTotalPrice(BigDecimal basePrice,
                                           LocalDate checkInDate,
                                           LocalDate checkOutDate,
                                           Map<LocalDate, BigDecimal> priceMap) {
        BigDecimal totalPrice = BigDecimal.ZERO;

        LocalDate date = checkInDate;

        while (date.isBefore(checkOutDate)) {
            BigDecimal multiplier = priceMap.getOrDefault(date, BigDecimal.ONE);

            totalPrice = totalPrice.add(basePrice.multiply(multiplier));

            date = date.plusDays(1);
        }

        return totalPrice;
    }
}
