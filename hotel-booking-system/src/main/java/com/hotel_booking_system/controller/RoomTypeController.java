package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.service.RoomTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/room-types")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class RoomTypeController {
    private final RoomTypeService roomTypeService;

    @GetMapping
    public ApiResponse<List<RoomTypeResponse>> getAllRoomTypes() {
        return ApiResponse.<List<RoomTypeResponse>>builder()
                .message("Lấy danh sách loại phòng thành công")
                .result(roomTypeService.getAllRoomTypes())
                .build();
    }
}
