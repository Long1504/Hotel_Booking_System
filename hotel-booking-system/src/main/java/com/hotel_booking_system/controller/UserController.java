package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateUserRequest;
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
    public ApiResponse<UserResponse> getUserByUserId(@PathVariable String userId) {
        return ApiResponse.<UserResponse>builder()
                .message("Lấy thông tin người dùng thành công")
                .result(userService.getUserByUserId(userId))
                .build();
    }
}
