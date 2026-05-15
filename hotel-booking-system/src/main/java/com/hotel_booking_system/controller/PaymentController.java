package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.enums.PaymentStatus;
import com.hotel_booking_system.service.BookingService;
import com.hotel_booking_system.service.VNPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/payments")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class PaymentController {
    private final VNPayService vnPayService;
    private final BookingService bookingService;

    @PostMapping("/vnpay/{bookingId}")
    public ApiResponse<String> createVNPayPayment(@PathVariable String bookingId) {
        return ApiResponse.<String>builder()
                .message("Tạo link thanh toán thành công")
                .result(bookingService.createVNPayPayment(bookingId))
                .build();
    }

    @GetMapping("/vnpay-return")
    public void vnPayReturn(HttpServletRequest request, HttpServletResponse response) throws IOException {

        BookingResponse booking = vnPayService.handleVNPayReturn(request);

        String redirectUrl;

//        if (!booking.getPaymentStatus().equals(PaymentStatus.PAID.name())) {
//            redirectUrl = "https://hotel-booking-system-receptionist.vercel.app/bookings.html?bookingCode="
//                    + booking.getBookingCode()
//                    + "&status=fail";
//        } else {
//            redirectUrl = "https://hotel-booking-system-receptionist.vercel.app/bookings.html?bookingCode="
//                    + booking.getBookingCode()
//                    + "&status=success";
//        }

        if (!booking.getPaymentStatus().equals(PaymentStatus.PAID.name())) {
            redirectUrl = "http://127.0.0.1:5502/bookings.html?bookingCode="
                    + booking.getBookingCode()
                    + "&status=fail";
        } else {
            redirectUrl = "http://127.0.0.1:5502/bookings.html?bookingCode="
                    + booking.getBookingCode()
                    + "&status=success";
        }

        response.sendRedirect(redirectUrl);
    }
}