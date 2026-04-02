package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.CreateServiceRequest;
import com.hotel_booking_system.dto.request.UpdateAmenityRequest;
import com.hotel_booking_system.dto.request.UpdateServiceRequest;
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

    @PostMapping
    public ApiResponse<ServiceResponse> createService(@RequestBody CreateServiceRequest request) {
        return ApiResponse.<ServiceResponse>builder()
                .message("Thêm mới dịch vụ thành công")
                .result(serviceService.createService(request))
                .build();
    }

    @PutMapping("/{serviceId}")
    public ApiResponse<ServiceResponse> updateService(@PathVariable String serviceId,
                                                      @RequestBody UpdateServiceRequest request) {
        return ApiResponse.<ServiceResponse>builder()
                .message("Cập nhật thông tin dịch vụ thành công")
                .result(serviceService.updateService(serviceId, request))
                .build();
    }

    @DeleteMapping("/{serviceId}")
    public ApiResponse<ServiceResponse> deleteAmenity(@PathVariable String serviceId) {
        return ApiResponse.<ServiceResponse>builder()
                .message("Xóa dịch vụ thành công")
                .result(serviceService.deleteService(serviceId))
                .build();
    }
}
