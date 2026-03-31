package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.UpdateAmenityRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.ServiceResponse;
import com.hotel_booking_system.dto.response.ServiceSummaryResponse;
import com.hotel_booking_system.service.AmenityService;
import com.hotel_booking_system.service.ServiceService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/services")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class ServiceController {
    private final ServiceService serviceService;

    @GetMapping("/summary")
    public ApiResponse<List<ServiceSummaryResponse>> getAllSummaryServices() {
        return ApiResponse.<List<ServiceSummaryResponse>>builder()
                .message("Lấy danh sách dịch vụ thành công")
                .result(serviceService.getAllSummaryServices())
                .build();
    }

    @GetMapping
    public ApiResponse<Page<ServiceResponse>> getAllServices(@RequestParam(required = false) String serviceName,
                                                             Pageable pageable) {
        return ApiResponse.<Page<ServiceResponse>>builder()
                .message("Lấy danh sách dịch vụ thành công")
                .result(serviceService.getAllServices(serviceName, pageable))
                .build();
    }
//
//    @PostMapping
//    public ApiResponse<AmenityResponse> createAmenity(@RequestBody CreateAmenityRequest request) {
//        return ApiResponse.<AmenityResponse>builder()
//                .message("Thêm mới tiện nghi thành công")
//                .result(amenityService.createAmenity(request))
//                .build();
//    }
//
//    @PutMapping("/{amenityId}")
//    public ApiResponse<AmenityResponse> updateAmenity(@PathVariable String amenityId,
//                                                      @RequestBody UpdateAmenityRequest request) {
//        return ApiResponse.<AmenityResponse>builder()
//                .message("Cập nhật thông tin tiện nghi thành công")
//                .result(amenityService.updateAmenity(amenityId, request))
//                .build();
//    }
//
//    @DeleteMapping("/{amenityId}")
//    public ApiResponse<AmenityResponse> deleteAmenity(@PathVariable String amenityId) {
//        return ApiResponse.<AmenityResponse>builder()
//                .message("Xóa tiện nghi thành công")
//                .result(amenityService.deleteAmenity(amenityId))
//                .build();
//    }
}
