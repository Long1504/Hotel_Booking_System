package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.*;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.dto.response.ExtraResponse;
import com.hotel_booking_system.service.BookingService;
import com.hotel_booking_system.service.BookingServiceService;
import com.hotel_booking_system.service.ExtraService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/bookings")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class BookingController {
    private final BookingService bookingService;
    private final BookingServiceService bookingServiceService;
    private final ExtraService extraService;

    @GetMapping
    public ApiResponse<Page<BookingResponse>> getAllBookings(@RequestParam(required = false) String bookingStatus,
                                                             @RequestParam(required = false) String paymentStatus,
                                                             @RequestParam(required = false) String bookingCode,
                                                             Pageable pageable) {
        return ApiResponse.<Page<BookingResponse>>builder()
                .message("Lấy danh sách đặt phòng thành công")
                .result(bookingService.findAllBookings(bookingStatus, paymentStatus, bookingCode, pageable))
                .build();
    }

    @GetMapping("/{bookingId}")
    public ApiResponse<BookingResponse> getBooking(@PathVariable String bookingId) {
        return ApiResponse.<BookingResponse>builder()
                .message("Lấy thông tin đặt phòng thành công")
                .result(bookingService.getBookingById(bookingId))
                .build();
    }

    @PostMapping
    public ApiResponse<BookingResponse> createBooking(@RequestBody CreateBookingRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Đặt phòng thành công")
                .result(bookingService.createBooking(request))
                .build();
    }

    @PutMapping("/{bookingId}/identity-card")
    public ApiResponse<BookingResponse> updateIdentityCard(@PathVariable String bookingId, @RequestBody UpdateIdentityCardRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật thông tin CCCD thành công")
                .result(bookingService.updateIdentityCard(bookingId, request.getIdentityCard()))
                .build();
    }

    @PutMapping("/{bookingId}/booking-status")
    public ApiResponse<BookingResponse> updateBookingStatus(@PathVariable String bookingId,
                                                            @RequestBody UpdateBookingStatusRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật trạng thái đặt phòng thành công")
                .result(bookingService.updateBookingStatus(bookingId, request.getNewBookingStatus()))
                .build();
    }

    @PutMapping("/{bookingId}/payment-method")
    public ApiResponse<BookingResponse> updatePaymentMethod(@PathVariable String bookingId,
                                                            @RequestBody UpdatePaymentMethodRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật phương thức thanh toán thành công")
                .result(bookingService.updatePaymentMethod(bookingId, request.getNewPaymentMethod()))
                .build();
    }

    @PutMapping("/{bookingId}/payment-status")
    public ApiResponse<BookingResponse> updatePaymentStatus(@PathVariable String bookingId,
                                                            @RequestBody UpdatePaymentStatusRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật trạng thái thanh toán thành công")
                .result(bookingService.updatePaymentStatus(bookingId, request.getNewPaymentStatus()))
                .build();
    }

    @PostMapping("/{bookingId}/services")
    public ApiResponse<BookingResponse> createBookingService(@PathVariable String bookingId,
                                                   @RequestBody CreateBookingServiceRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Thêm dịch vụ thành công")
                .result(bookingServiceService.createBookingService(bookingId, request))
                .build();
    }

    @DeleteMapping("/{bookingId}/services/{bookingServiceId}")
    public ApiResponse<BookingResponse> deleteBookingService(@PathVariable String bookingId,
                                                      @PathVariable String bookingServiceId) {
        return ApiResponse.<BookingResponse>builder()
                .message("Xóa dịch vụ thành công")
                .result(bookingServiceService.deleteBookingService(bookingId, bookingServiceId))
                .build();
    }

    @PutMapping("/{bookingId}/services/{bookingServiceId}")
    public ApiResponse<BookingResponse> updateBookingServiceQuantity(@PathVariable String bookingId,
                                                      @PathVariable String bookingServiceId,
                                                      @RequestBody UpdateBookingServiceRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Cập nhật dịch vụ thành công")
                .result(bookingServiceService.updateBookingServiceQuantity(bookingId, bookingServiceId, request.getQuantity()))
                .build();
    }

    @PostMapping("/{bookingId}/extras")
    public ApiResponse<BookingResponse> createExtra(@PathVariable String bookingId,
                                                    @RequestBody CreateExtraRequest request) {
        return ApiResponse.<BookingResponse>builder()
                .message("Thêm phụ phí thành công")
                .result(extraService.createExtra(bookingId, request))
                .build();
    }

    @GetMapping("/{bookingId}/extras")
    public ApiResponse<List<ExtraResponse>> getAllExtras(@PathVariable String bookingId) {
        return ApiResponse.<List<ExtraResponse>>builder()
                .message("Lấy danh sách phụ phí thành công")
                .result(extraService.getAllExtras(bookingId))
                .build();
    }

    @DeleteMapping("/{bookingId}/extras/{extraId}")
    public ApiResponse<BookingResponse> deleteExtra(@PathVariable String bookingId,
                                                    @PathVariable String extraId) {
        return ApiResponse.<BookingResponse>builder()
                .message("Xóa phụ phí thành công")
                .result(extraService.deleteExtra(bookingId, extraId))
                .build();
    }
}
