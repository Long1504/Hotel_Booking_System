package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateBookingServiceRequest;
import com.hotel_booking_system.dto.request.CreateExtraRequest;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.dto.response.ExtraResponse;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.BookingService;
import com.hotel_booking_system.entity.Extra;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.BookingMapper;
import com.hotel_booking_system.mapper.ExtraMapper;
import com.hotel_booking_system.repository.BookingRepository;
import com.hotel_booking_system.repository.BookingServiceRepository;
import com.hotel_booking_system.repository.ExtraRepository;
import com.hotel_booking_system.repository.ServiceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ExtraService {
    private final BookingRepository bookingRepository;
    private final ExtraRepository extraRepository;

    private final BookingMapper bookingMapper;
    private final ExtraMapper extraMapper;

    public List<ExtraResponse> getAllExtras(String bookingId) {

        List<Extra> extras = extraRepository.findByBookingBookingId(bookingId);

        return extras.stream()
                .map(extra -> extraMapper.toExtraResponse(extra))
                .toList();
    }

    @Transactional
    public BookingResponse createExtra(String bookingId, CreateExtraRequest request) {

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        Extra extra = Extra.builder()
                .booking(booking)
                .amount(request.getAmount())
                .note(request.getNote())
                .build();

        extraRepository.save(extra);

        booking.getExtras().add(extra);

        // Cập nhật total price
        booking.setTotalPrice(booking.getTotalPrice().add(request.getAmount()));

        bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse deleteExtra(String bookingId, String extraId) {

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        Extra extra = extraRepository.findById(extraId)
                .orElseThrow(() -> new AppException(ErrorCode.EXTRA_NOT_FOUND));

        booking.setTotalPrice(booking.getTotalPrice().subtract(extra.getAmount()));

        booking.getExtras().remove(extra);

        extraRepository.delete(extra);

        bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }
}
