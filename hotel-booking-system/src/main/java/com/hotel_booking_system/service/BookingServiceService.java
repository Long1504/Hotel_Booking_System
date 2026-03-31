package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateBookingServiceRequest;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.entity.*;
import com.hotel_booking_system.entity.BookingService;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.BookingMapper;
import com.hotel_booking_system.repository.BookingRepository;
import com.hotel_booking_system.repository.BookingServiceRepository;
import com.hotel_booking_system.repository.ServiceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class BookingServiceService {
    private final BookingRepository bookingRepository;
    private final ServiceRepository serviceRepository;
    private final BookingServiceRepository bookingServiceRepository;

    private final BookingMapper bookingMapper;

    @Transactional
    public BookingResponse createBookingService(String bookingId, CreateBookingServiceRequest request) {

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        com.hotel_booking_system.entity.Service service = serviceRepository.findById(request.getServiceId())
                .orElseThrow(() -> new AppException(ErrorCode.SERVICE_NOT_FOUND));

        BigDecimal unitPrice = service.getBasePrice();

        int quantity = request.getQuantity() != null ? request.getQuantity() : 1;

        BigDecimal totalServicePrice = unitPrice.multiply(BigDecimal.valueOf(quantity));

        com.hotel_booking_system.entity.BookingService bookingService = BookingService.builder()
                .booking(booking)
                .service(service)
                .quantity(quantity)
                .unitPrice(unitPrice)
                .totalPrice(totalServicePrice)
                .build();

        booking.getBookingServices().add(bookingService);

        booking.setTotalPrice(booking.getTotalPrice().add(totalServicePrice));

        bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse deleteBookingService(String bookingId, String bookingServiceId) {

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        BookingService bookingService = bookingServiceRepository.findById(bookingServiceId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_SERVICE_NOT_FOUND));

        BigDecimal servicePrice = bookingService.getTotalPrice();

        // Xóa
        booking.getBookingServices().remove(bookingService);
        bookingServiceRepository.delete(bookingService);

        // Cập nhật lại tổng tiền
        booking.setTotalPrice(booking.getTotalPrice().subtract(servicePrice));

        bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }

    @Transactional
    public BookingResponse updateBookingServiceQuantity(String bookingId, String bookingServiceId, Integer newQuantity) {

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        BookingService bookingService = bookingServiceRepository.findById(bookingServiceId)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_SERVICE_NOT_FOUND));

        int oldQuantity = bookingService.getQuantity();
        BigDecimal unitPrice = bookingService.getUnitPrice();

        // Tính lại total price mới
        BigDecimal oldServiceTotalPrice = bookingService.getTotalPrice();
        BigDecimal newServiceTotalPrice = unitPrice.multiply(BigDecimal.valueOf(newQuantity));

        // update booking service
        bookingService.setQuantity(newQuantity);
        bookingService.setTotalPrice(newServiceTotalPrice);

        bookingServiceRepository.save(bookingService);

        // update booking total price (delta)
        BigDecimal diff = newServiceTotalPrice.subtract(oldServiceTotalPrice);

        booking.setTotalPrice(booking.getTotalPrice().add(diff));

        bookingRepository.save(booking);

        return bookingMapper.toBookingResponse(booking);
    }
}
