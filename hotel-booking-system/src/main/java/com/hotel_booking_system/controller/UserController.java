package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateUserRequest;
import com.hotel_booking_system.dto.request.UpdatePasswordRequest;
import com.hotel_booking_system.dto.request.UpdateUserRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.UserResponse;
import com.hotel_booking_system.enums.RoleName;
import com.hotel_booking_system.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public ApiResponse<UserResponse> register(@RequestBody CreateUserRequest request) {
        return ApiResponse.<UserResponse>builder()
                .message("Tạo tài khoản thành công")
                .result(userService.createUser(request, RoleName.CUSTOMER.name()))
                .build();
    }

    @PostMapping
    public ApiResponse<UserResponse> createReceptionist(@RequestBody CreateUserRequest request) {
        return ApiResponse.<UserResponse>builder()
                .message("Tạo tài khoản lễ tân thành công")
                .result(userService.createUser(request, RoleName.RECEPTIONIST.name()))
                .build();
    }

    @GetMapping
    public ApiResponse<Page<UserResponse>> getAllUsersByRoleName(@RequestParam String roleName, Pageable pageable) {
        return  ApiResponse.<Page<UserResponse>>builder()
                .message("Lấy danh sách người dùng thành công")
                .result(userService.getAllUsersByRoleName(roleName, pageable))
                .build();
    }

    @GetMapping("/{userId}")
    public ApiResponse<UserResponse> getUser(@PathVariable String userId) {
        return ApiResponse.<UserResponse>builder()
                .message("Lấy thông tin người dùng thành công")
                .result(userService.getUser(userId))
                .build();
    }

    @GetMapping("/my-info")
    public ApiResponse<UserResponse> getMyInfo() {
        return ApiResponse.<UserResponse>builder()
                .message("Lấy thông tin cá nhân thành công")
                .result(userService.getMyInfo())
                .build();
    }

    @PutMapping("/{userId}")
    public ApiResponse<UserResponse> updateUser(@PathVariable String userId,
                                                @RequestBody UpdateUserRequest request) {
        return ApiResponse.<UserResponse>builder()
                .message("Cập nhật thông tin thành công")
                .result(userService.updateUser(userId, request))
                .build();
    }

    @PutMapping("/my-info")
    public ApiResponse<UserResponse> updateMyInfo(@RequestBody UpdateUserRequest request) {
        return ApiResponse.<UserResponse>builder()
                .message("Cập nhật thông tin cá nhân thành công")
                .result(userService.updateMyInfo(request))
                .build();
    }

    @PutMapping("/password")
    public ApiResponse<UserResponse> updatePassword(@RequestBody UpdatePasswordRequest request) {
        return ApiResponse.<UserResponse>builder()
                .message("Cập nhật mật khẩu thành công")
                .result(userService.updatePassword(request))
                .build();
    }

    @PutMapping("/{userId}/status")
    public ApiResponse<UserResponse> changeUserStatus(@PathVariable String userId) {
        return ApiResponse.<UserResponse>builder()
                .message("Cập nhật trạng thái tài khoản thành công")
                .result(userService.changeUserStatus(userId))
                .build();
    }

    @DeleteMapping("/{userId}")
    public ApiResponse<UserResponse> deleteUser(@PathVariable String userId) {
        return ApiResponse.<UserResponse>builder()
                .message("Xóa tài khoản thành công")
                .result(userService.deleteUser(userId))
                .build();
    }
}
