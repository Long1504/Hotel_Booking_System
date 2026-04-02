package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.enums.PaymentStatus;
import com.hotel_booking_system.service.BookingService;
import com.hotel_booking_system.service.VNPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/api/v1/payments")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class VNPayController {
    private final VNPayService vnPayService;
    private final BookingService bookingService;

    @PostMapping("/vnpay/{bookingId}")
    public ApiResponse<String> createVNPayPayment(@PathVariable String bookingId) {
        return ApiResponse.<String>builder()
                .message("Tạo link thanh toán thành công")
                .result(bookingService.createVNPayPayment(bookingId))
                .build();
    }

//    @GetMapping("/vnpay-return")
//    public ApiResponse<BookingResponse> paymentReturn(HttpServletRequest request) {
//        BookingResponse response = vnPayService.handleVNPayReturn(request);
//        if (!response.getPaymentStatus().equals(PaymentStatus.PAID.name())) {
//            return ApiResponse.<BookingResponse>builder()
//                    .message("Thanh toán thất bại")
//                    .result(response)
//                    .build();
//        }
//        return ApiResponse.<BookingResponse>builder()
//                .message("Thanh toán thành công")
//                .result(response)
//                .build();
//    }

    @GetMapping("/vnpay-return")
    public void paymentReturn(HttpServletRequest request, HttpServletResponse response) throws IOException {

        BookingResponse booking = vnPayService.handleVNPayReturn(request);

        String redirectUrl;

        if (!booking.getPaymentStatus().equals(PaymentStatus.PAID.name())) {
            redirectUrl = "http://localhost:5500/bookings.html?bookingCode="
                    + booking.getBookingCode()
                    + "&status=fail";
        } else {
            redirectUrl = "http://localhost:5500/bookings.html?bookingCode="
                    + booking.getBookingCode()
                    + "&status=success";
        }

        response.sendRedirect(redirectUrl);
    }
}