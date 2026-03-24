package com.hotel_booking_system.controller;

import com.cloudinary.Api;
import com.hotel_booking_system.dto.request.CreateRoomRequest;
import com.hotel_booking_system.dto.request.UpdateRoomRequest;
import com.hotel_booking_system.dto.response.*;
import com.hotel_booking_system.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/v1/rooms")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class RoomController {
    private final RoomService roomService;

    @GetMapping
    public ApiResponse<Page<RoomSummaryResponse>> getAllRooms(@RequestParam(required = false) String roomTypeId,
                                                              @RequestParam(required = false) String viewId,
                                                              @RequestParam(required = false) String roomStatus,
                                                              @RequestParam(required = false) String roomName,
                                                              Pageable pageable) {
        return ApiResponse.<Page<RoomSummaryResponse>>builder()
                .message("Lấy danh sách phòng thành công")
                .result(roomService.getAllRooms(roomTypeId, viewId, roomStatus, roomName, pageable))
                .build();
    }

    @GetMapping("/{roomId}")
    public ApiResponse<RoomResponse> getRoom(@PathVariable String roomId) {
        return ApiResponse.<RoomResponse>builder()
                .message("Lấy thông tin chi tiết phòng thành công")
                .result(roomService.getRoom(roomId))
                .build();
    }

    @GetMapping("/available")
    public ApiResponse<Page<RoomSummaryAvailableResponse>> getAllAvailableRooms(@RequestParam LocalDate checkInDate,
                                                                                @RequestParam LocalDate checkOutDate,
                                                                                @RequestParam(required = false) Integer adults,
                                                                                @RequestParam(required = false) Integer children,
                                                                                @RequestParam(required = false) String roomTypeId,
                                                                                @RequestParam(required = false) String viewId,
                                                                                Pageable pageable) {
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

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ApiResponse<RoomResponse> createRoom(@RequestPart CreateRoomRequest request,
                                                @RequestPart MultipartFile mainImage,
                                                @RequestPart List<MultipartFile> subImages) {
        System.out.println("Số ảnh phụ: " + subImages.size());
        return ApiResponse.<RoomResponse>builder()
                .message("Thêm phòng thành công")
                .result(roomService.createRoom(request, mainImage, subImages))
                .build();
    }

    @PutMapping(value = "/{roomId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ApiResponse<RoomResponse> updateRoom(@PathVariable String roomId,
                                                @RequestPart UpdateRoomRequest request,
                                                @RequestPart(required = false) MultipartFile mainImage,
                                                @RequestPart(required = false) List<MultipartFile> subImages) {
        System.out.println("Số ảnh phụ: " + (subImages != null ? subImages.size() : 0));
        return ApiResponse.<RoomResponse>builder()
                .message("Cập nhật phòng thành công")
                .result(roomService.updateRoom(roomId, request, mainImage, subImages))
                .build();
    }

    @DeleteMapping("/{roomId}")
    public ApiResponse<RoomResponse> deleteRoom(@PathVariable String roomId) {
        return ApiResponse.<RoomResponse>builder()
                .message("Xóa phòng thành công")
                .result(roomService.deleteRoom(roomId))
                .build();
    }
}
