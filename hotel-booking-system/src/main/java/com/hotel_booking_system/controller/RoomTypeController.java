package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.service.RoomTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/room-types")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class RoomTypeController {
    private final RoomTypeService roomTypeService;

    @GetMapping("/summary")
    public ApiResponse<List<RoomTypeResponse>> getAllSummaryRoomTypes() {
        return ApiResponse.<List<RoomTypeResponse>>builder()
                .message("Lấy danh sách loại phòng thành công")
                .result(roomTypeService.getAllSummaryRoomTypes())
                .build();
    }

    @GetMapping
    public ApiResponse<Page<RoomTypeResponse>> getAllRoomTypes(@RequestParam(required = false) String roomTypeName,
                                                               Pageable pageable) {
        return ApiResponse.<Page<RoomTypeResponse>>builder()
                .message("Lấy danh sách loại phòng thành công")
                .result(roomTypeService.getAllRoomTypes(roomTypeName, pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<RoomTypeResponse> createRoomType(@RequestBody CreateRoomTypeRequest request) {
        return ApiResponse.<RoomTypeResponse>builder()
                .message("Thêm mới loại phòng thành công")
                .result(roomTypeService.createRoomType(request))
                .build();
    }

    @PutMapping("/{roomTypeId}")
    public ApiResponse<RoomTypeResponse> updateRoomType(@PathVariable String roomTypeId,
                                                        @RequestBody UpdateRoomTypeRequest request) {
        return ApiResponse.<RoomTypeResponse>builder()
                .message("Cập nhật thông tin loại phòng thành công")
                .result(roomTypeService.updateRoomType(roomTypeId, request))
                .build();
    }

    @DeleteMapping("/{roomTypeId}")
    public ApiResponse<RoomTypeResponse> deleteRoomType(@PathVariable String roomTypeId) {
        return ApiResponse.<RoomTypeResponse>builder()
                .message("Xóa loại phòng thành công")
                .result(roomTypeService.deleteRoomType(roomTypeId))
                .build();
    }
}
