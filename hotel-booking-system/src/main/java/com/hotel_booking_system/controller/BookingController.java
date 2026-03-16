package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateBookingRequest;
import com.hotel_booking_system.dto.request.UpdateBookingStatusRequest;
import com.hotel_booking_system.dto.request.UpdatePaymentStatusRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.service.BookingService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/bookings")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class BookingController {
    private final BookingService bookingService;

    @GetMapping
    public ApiResponse<Page<BookingResponse>> getAllBookings(@RequestParam(required = false) String bookingStatus,
                                                             @RequestParam(required = false) String paymentStatus,
                                                             @RequestParam(required = false) String bookingCode,
                                                             Pageable pageable) {
        return ApiResponse.<Page<BookingResponse>>builder()
                .message("Lấy danh sách đặt phòng thành công")
                .result(bookingService.findAllBookings(bookingStatus, paymentStatus, bookingCode, pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<BookingResponse> createBooking(@RequestBody CreateBookingRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Đặt phòng thành công")
                .result(bookingService.createBooking(request))
                .build();
    }
    @PutMapping("/{bookingId}/booking-status")
    public ApiResponse<BookingResponse> updateBookingStatus(@PathVariable String bookingId,
                                                            @RequestBody UpdateBookingStatusRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật trạng thái đặt phòng thành công")
                .result(bookingService.updateBookingStatus(bookingId, request.getNewBookingStatus()))
                .build();
    }

    @PutMapping("/{bookingId}/payment-status")
    public ApiResponse<BookingResponse> updatePaymentStatus(@PathVariable String bookingId,
                                                            @RequestBody UpdatePaymentStatusRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật trạng thái thanh toán thành công")
                .result(bookingService.updatePaymentStatus(bookingId, request.getNewPaymentStatus()))
                .build();
    }
}
