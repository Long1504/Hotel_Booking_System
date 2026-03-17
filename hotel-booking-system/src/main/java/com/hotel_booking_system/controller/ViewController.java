package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.CreateViewRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateViewRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.dto.response.ViewResponse;
import com.hotel_booking_system.service.ViewService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/views")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class ViewController {
    private final ViewService viewService;

    // Customer
    @GetMapping("/summary")
    public ApiResponse<List<ViewResponse>> getAllSummaryViews() {
        return ApiResponse.<List<ViewResponse>>builder()
                .message("Lấy danh sách view thành công")
                .result(viewService.getAllSummaryViews())
                .build();
    }

    @GetMapping
    public ApiResponse<Page<ViewResponse>> getAllViews(@RequestParam(required = false) String viewName,
                                                           Pageable pageable) {
        return ApiResponse.<Page<ViewResponse>>builder()
                .message("Lấy danh sách view thành công")
                .result(viewService.getAllViews(viewName, pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<ViewResponse> createView(@RequestBody CreateViewRequest request) {
        return ApiResponse.<ViewResponse>builder()
                .message("Thêm mới view thành công")
                .result(viewService.createView(request))
                .build();
    }

    @PutMapping("/{viewId}")
    public ApiResponse<ViewResponse> updateView(@PathVariable String viewId,
                                                @RequestBody UpdateViewRequest request) {
        return ApiResponse.<ViewResponse>builder()
                .message("Cập nhật thông tin view phòng thành công")
                .result(viewService.updateView(viewId, request))
                .build();
    }

    @DeleteMapping("/{viewId}")
    public ApiResponse<ViewResponse> deleteRoomType(@PathVariable String viewId) {
        return ApiResponse.<ViewResponse>builder()
                .message("Xóa loại phòng thành công")
                .result(viewService.deleteView(viewId))
                .build();
    }
}
