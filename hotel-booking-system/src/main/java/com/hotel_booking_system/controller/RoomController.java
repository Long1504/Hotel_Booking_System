package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.*;
import com.hotel_booking_system.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/v1/rooms")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class RoomController {
    private final RoomService roomService;

    @GetMapping
    public ApiResponse<Page<RoomSummaryResponse>> getAllRooms(Pageable pageable) {
        return ApiResponse.<Page<RoomSummaryResponse>>builder()
                .message("Lấy danh sách phòng thành công")
                .result(roomService.getAllRooms(pageable))
                .build();
    }

    @GetMapping("/{roomId}")
    public ApiResponse<RoomResponse> getRoom(@PathVariable String roomId) {
        return ApiResponse.<RoomResponse>builder()
                .message("Lấy thông tin phòng thành công")
                .result(roomService.getRoom(roomId))
                .build();
    }

//    @GetMapping("/available")
//    public ApiResponse<List<RoomSummaryAvailableResponse>> getAllAvailableRooms(@RequestParam LocalDate checkInDate,
//                                                                                @RequestParam LocalDate checkOutDate) {
//        return ApiResponse.<List<RoomSummaryAvailableResponse>>builder()
//                .message("Lấy danh sách phòng trống thành công")
//                .result(roomService.getAllAvailableRooms(checkInDate, checkOutDate))
//                .build();
//    }

    @GetMapping("/available")
    public ApiResponse<Page<RoomSummaryAvailableResponse>> getAllAvailableRooms(
            @RequestParam LocalDate checkInDate,
            @RequestParam LocalDate checkOutDate,
            @RequestParam(required = false) Integer adults,
            @RequestParam(required = false) Integer children,
            @RequestParam(required = false) String roomTypeId,
            @RequestParam(required = false) String viewId,
            Pageable pageable
    ) {

        return ApiResponse.<Page<RoomSummaryAvailableResponse>>builder()
                .message("Lấy danh sách phòng trống thành công")
                .result(roomService.getAllAvailableRooms(
                        checkInDate,
                        checkOutDate,
                        adults,
                        children,
                        roomTypeId,
                        viewId,
                        pageable
                ))
                .build();
    }

    @GetMapping("/available/{roomId}")
    public ApiResponse<RoomAvailableResponse> getRoomAvailable(
            @PathVariable String roomId,
            @RequestParam LocalDate checkInDate,
            @RequestParam LocalDate checkOutDate) {

        return ApiResponse.<RoomAvailableResponse>builder()
                .message("Lấy thông tin phòng trống thành công")
                .result(roomService.getRoomAvailable(roomId, checkInDate, checkOutDate))
                .build();
    }
}
