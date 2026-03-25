package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreatePriceRuleRequest;
import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdatePriceRuleRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.PriceRuleResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.service.PriceRuleService;
import com.hotel_booking_system.service.RoomTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/price-rules")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class PriceRuleController {
    private final PriceRuleService priceRuleService;

    @GetMapping
    public ApiResponse<Page<PriceRuleResponse>> getAllPriceRules(@RequestParam(required = false) Boolean isActive,
                                                    @RequestParam(required = false) String priceRuleName,
                                                    Pageable pageable) {
        return ApiResponse.<Page<PriceRuleResponse>>builder()
                .message("Lấy danh sách ngày lễ thành công")
                .result(priceRuleService.getAllPriceRules(isActive, priceRuleName, pageable))
                .build();
    }

    @PostMapping
    public ApiResponse<PriceRuleResponse> createPriceRule(@RequestBody CreatePriceRuleRequest request) {
        return ApiResponse.<PriceRuleResponse>builder()
                .message("Thêm mới ngày lễ thành công")
                .result(priceRuleService.createPriceRule(request))
                .build();
    }

    @PutMapping("/{priceRuleId}")
    public ApiResponse<PriceRuleResponse> updatePriceRule(@PathVariable String priceRuleId,
                                                          @RequestBody UpdatePriceRuleRequest request) {
        return ApiResponse.<PriceRuleResponse>builder()
                .message("Cập nhật thông tin ngày lễ thành công")
                .result(priceRuleService.updatePriceRule(priceRuleId, request))
                .build();
    }

    @DeleteMapping("/{priceRuleId}")
    public ApiResponse<Void> deletePriceRule(@PathVariable String priceRuleId) {
        priceRuleService.deletePriceRule(priceRuleId);
        return ApiResponse.<Void>builder()
                .message("Xóa ngày lễ thành công")
                .build();
    }

    @PutMapping("/{priceRuleId}/toggle")
    public ApiResponse<PriceRuleResponse> togglePriceRule(@PathVariable String priceRuleId) {
        return ApiResponse.<PriceRuleResponse>builder()
                .message("Cập nhật trạng thái thành công")
                .result(priceRuleService.togglePriceRule(priceRuleId))
                .build();
    }
}
