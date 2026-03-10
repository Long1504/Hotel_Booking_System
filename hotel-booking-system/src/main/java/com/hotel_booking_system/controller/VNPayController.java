package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.enums.PaymentStatus;
import com.hotel_booking_system.service.VNPayService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
@RequestMapping("/api/v1/payment")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class VNPayController {
    private final VNPayService vnPayService;

    @GetMapping("/vnpay-return")
    public ApiResponse<BookingResponse> paymentReturn(HttpServletRequest request) {
        BookingResponse response = vnPayService.handleVNPayReturn(request);
        if (!response.getPaymentStatus().equals(PaymentStatus.PAID.name())) {
            return ApiResponse.<BookingResponse>builder()
                    .message("Thanh toán thất bại")
                    .result(response)
                    .build();
        }
        return ApiResponse.<BookingResponse>builder()
                .message("Thanh toán thành công")
                .result(response)
                .build();
    }
}