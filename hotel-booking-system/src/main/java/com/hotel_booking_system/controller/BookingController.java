package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateBookingRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.service.BookingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/bookings")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class BookingController {
    private final BookingService bookingService;

    @PostMapping
    public ApiResponse<BookingResponse> createBooking(@RequestBody CreateBookingRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Đặt phòng thành công")
                .result(bookingService.createBooking(request))
                .build();
    }
}
