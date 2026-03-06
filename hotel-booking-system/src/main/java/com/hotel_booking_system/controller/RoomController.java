package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomResponse;
import com.hotel_booking_system.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/rooms")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class RoomController {
    private final RoomService roomService;

    @GetMapping
    public ApiResponse<Page<RoomResponse>> getAllRooms(Pageable pageable) {
        return ApiResponse.<Page<RoomResponse>>builder()
                .message("Lấy danh sách phòng thành công")
                .result(roomService.getAllRooms(pageable))
                .build();
    }
}
