package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.*;
import com.hotel_booking_system.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/v1/dashboard")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class DashboardController {
    private final DashboardService dashboardService;

    @GetMapping("/rooms/count")
    public ApiResponse<Long> getRoomCount() {
        return ApiResponse.<Long>builder()
                .message("Lấy số lượng phòng thành công")
                .result(dashboardService.getRoomCount())
                .build();
    }

    @GetMapping("/bookings/count")
    public ApiResponse<Long> getBookingCount(@RequestParam String type,
                                             @RequestParam(required = false) LocalDate startDate,
                                             @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<Long>builder()
                .message("Lấy số lượng đặt phòng thành công")
                .result(dashboardService.getBookingCount(type, startDate, endDate))
                .build();
    }

    @GetMapping("/occupancy-rate")
    public ApiResponse<Double> getOccupancyRate(@RequestParam String type,
                                                @RequestParam(required = false) LocalDate startDate,
                                                @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<Double>builder()
                .message("Lấy tỉ lệ lấp đầy phòng thành công")
                .result(dashboardService.getOccupancyRate(type, startDate, endDate))
                .build();
    }

    @GetMapping("/revenue")
    public ApiResponse<BigDecimal> getRevenue(@RequestParam String type,
                                              @RequestParam(required = false) LocalDate startDate,
                                              @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<BigDecimal>builder()
                .message("Lấy doanh thu thành công")
                .result(dashboardService.getRevenue(type, startDate, endDate))
                .build();
    }

    @GetMapping("/revenue/chart")
    public ApiResponse<RevenueLineChartResponse> getRevenueLineChart(@RequestParam String type,
                                                                     @RequestParam(required = false) LocalDate startDate,
                                                                     @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<RevenueLineChartResponse>builder()
                .message("Lấy dữ liệu doanh thu biểu đồ thành công")
                .result(dashboardService.getRevenueLineChart(type, startDate, endDate))
                .build();
    }

    @GetMapping("/bookings/count/chart")
    public ApiResponse<BookingCountBarChartResponse> getBookingCountBarChart(@RequestParam String type,
                                                                             @RequestParam(required = false) LocalDate startDate,
                                                                             @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<BookingCountBarChartResponse>builder()
                .message("Lấy dữ liệu lượng đặt phòng biểu đồ thành công")
                .result(dashboardService.getBookingCountBarChart(type, startDate, endDate))
                .build();
    }

    @GetMapping("/top-booked-rooms")
    public ApiResponse<List<TopBookedRoomResponse>> getTopBookedRooms(@RequestParam String type,
                                                                      @RequestParam(required = false) LocalDate startDate,
                                                                      @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<List<TopBookedRoomResponse>>builder()
                .message("Lấy danh sách phòng được đặt nhiều nhất thành công")
                .result(dashboardService.getTopBookedRooms(type, startDate, endDate, 10))
                .build();
    }

    @GetMapping("/bookings/status/chart")
    public ApiResponse<List<BookingStatusPieChartResponse>> getBookingStatusPieChart(@RequestParam String type,
                                                                                     @RequestParam(required = false) LocalDate startDate,
                                                                                     @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<List<BookingStatusPieChartResponse>>builder()
                .message("Lấy dữ liệu trạng thái đặt phòng biểu đồ thành công")
                .result(dashboardService.getBookingStatusPieChart(type, startDate, endDate))
                .build();
    }

    @GetMapping("/services/used/chart") ApiResponse<List<ServiceUsedBarChartResponse>> getServiceUsedBarChart(@RequestParam String type,
                                                                                                              @RequestParam(required = false) LocalDate startDate,
                                                                                                              @RequestParam(required = false) LocalDate endDate) {
        return ApiResponse.<List<ServiceUsedBarChartResponse>>builder()
                .message("Lấy dữ liệu sử dụng dịch vụ biểu đồ thành công")
                .result(dashboardService.getServiceUsedBarChart(type, startDate, endDate))
                .build();
    }

    @GetMapping("/room-types/chart")
    public ApiResponse<List<RoomTypePieChartResponse>> getRoomTypePieChart() {
        return ApiResponse.<List<RoomTypePieChartResponse>>builder()
                .message("Lấy dữ liệu loại phòng biểu đồ thành công")
                .result(dashboardService.getRoomTypePieChart())
                .build();
    }
}
