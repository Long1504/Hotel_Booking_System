package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.dto.response.ViewResponse;
import com.hotel_booking_system.service.RoomTypeService;
import com.hotel_booking_system.service.ViewService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/views")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class ViewController {
    private final ViewService viewService;

    // Customer
    @GetMapping
    public ApiResponse<List<ViewResponse>> getAllViews() {
        return ApiResponse.<List<ViewResponse>>builder()
                .message("Lấy danh sách view thành công")
                .result(viewService.getAllViews())
                .build();
    }
}
