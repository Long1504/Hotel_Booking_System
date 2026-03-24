package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateAmenityRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.service.AmenityService;
import com.hotel_booking_system.service.RoomTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/amenities")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class AmenityController {
    private final AmenityService amenityService;

    @GetMapping("/summary")
    public ApiResponse<List<AmenityResponse>> getAllSummaryAmenities() {
        return ApiResponse.<List<AmenityResponse>>builder()
                .message("Lấy danh sách tiện nghi thành công")
                .result(amenityService.getAllSummaryAmenities())
                .build();
    }

    @GetMapping
    public ApiResponse<Page<AmenityResponse>> getAllAmenities(@RequestParam(required = false) String amenityName,
                                                              Pageable pageable) {
        return ApiResponse.<Page<AmenityResponse>>builder()
                .message("Lấy danh sách tiện nghi thành công")
                .result(amenityService.getAllAmenities(amenityName, pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<AmenityResponse> createAmenity(@RequestBody CreateAmenityRequest request) {
        return ApiResponse.<AmenityResponse>builder()
                .message("Thêm mới tiện nghi thành công")
                .result(amenityService.createAmenity(request))
                .build();
    }

    @PutMapping("/{amenityId}")
    public ApiResponse<AmenityResponse> updateAmenity(@PathVariable String amenityId,
                                                      @RequestBody UpdateAmenityRequest request) {
        return ApiResponse.<AmenityResponse>builder()
                .message("Cập nhật thông tin tiện nghi thành công")
                .result(amenityService.updateAmenity(amenityId, request))
                .build();
    }

    @DeleteMapping("/{amenityId}")
    public ApiResponse<AmenityResponse> deleteAmenity(@PathVariable String amenityId) {
        return ApiResponse.<AmenityResponse>builder()
                .message("Xóa tiện nghi thành công")
                .result(amenityService.deleteAmenity(amenityId))
                .build();
    }
}
