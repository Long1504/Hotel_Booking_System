package com.hotel_booking_system.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
public enum ErrorCode {
    // System
    INTERNAL_SERVER_ERROR(9999, "Lỗi hệ thống", HttpStatus.INTERNAL_SERVER_ERROR),

    // Auth
    UNAUTHENTICATED(1000, "Chưa xác thực", HttpStatus.UNAUTHORIZED),
    UNAUTHORIZED(1001, "Không có quyền truy cập", HttpStatus.FORBIDDEN),
    INVALID_TOKEN(1002, "Token không hợp lệ", HttpStatus.UNAUTHORIZED),
    ACCOUNT_LOCKED(1003, "Tài khoản đã bị khóa", HttpStatus.FORBIDDEN),
    INVALID_CREDENTIALS(1004, "Tên đăng nhập hoặc mật khẩu không đúng", HttpStatus.UNAUTHORIZED),

    // Role
    ROLE_NOT_FOUND(2001, "Không tìm thấy vai trò", HttpStatus.NOT_FOUND),
    ROLE_ALREADY_EXISTS(2002, "Vai trò đã tồn tại", HttpStatus.CONFLICT),

    // User
    USER_NOT_FOUND(3001, "Không tìm thấy người dùng", HttpStatus.NOT_FOUND),
    USER_ALREADY_EXISTS(3002, "Người dùng đã tồn tại", HttpStatus.CONFLICT),
    USERNAME_ALREADY_EXISTS(3003, "Tên đăng nhập đã tồn tại", HttpStatus.CONFLICT),
    EMAIL_ALREADY_EXISTS(3004, "Email đã tồn tại", HttpStatus.CONFLICT),
    INVALID_PASSWORD(3005, "Mật khẩu không hợp lệ", HttpStatus.BAD_REQUEST),
    USER_DELETED(3006, "Tài khoản đã bị xóa", HttpStatus.GONE),

    // RoomType
    ROOM_TYPE_NOT_FOUND(4001, "Không tìm thấy loại phòng", HttpStatus.NOT_FOUND),
    ROOM_TYPE_ALREADY_EXISTS(4002, "Loại phòng đã tồn tại", HttpStatus.CONFLICT),

    // View
    VIEW_NOT_FOUND(5001, "Không tìm thấy view", HttpStatus.NOT_FOUND),
    VIEW_ALREADY_EXISTS(5002, "View đã tồn tại", HttpStatus.CONFLICT),

    // Amenity
    AMENITY_NOT_FOUND(6001, "Không tìm thấy tiện nghi", HttpStatus.NOT_FOUND),
    AMENITY_ALREADY_EXISTS(6002, "Tiện nghi đã tồn tại", HttpStatus.CONFLICT),

    // Room
    ROOM_NOT_FOUND(7001, "Không tìm thấy phòng", HttpStatus.NOT_FOUND),
    ROOM_ALREADY_EXISTS(7002, "Phòng đã tồn tại", HttpStatus.CONFLICT),
    ROOM_NOT_AVAILABLE(7003, "Phòng không khả dụng trong khoảng thời gian đã chọn", HttpStatus.BAD_REQUEST),
    INVALID_DATE_RANGE(7004, "Khoảng thời gian không hợp lệ", HttpStatus.BAD_REQUEST),
    ROOM_NUMBER_ALREADY_EXISTS(7005, "Số phòng đã tồn tại", HttpStatus.CONFLICT),

    // Booking
    BOOKING_NOT_FOUND(8001, "Không tìm thấy đặt phòng", HttpStatus.NOT_FOUND),
    INVALID_PAYMENT_METHOD(8002, "Phương thức thanh toán không hợp lệ", HttpStatus.BAD_REQUEST),
    INVALID_BOOKING_STATUS_TRANSITION(8003, "Chuyển đổi trạng thái đặt phòng không hợp lệ", HttpStatus.BAD_REQUEST),
    INVALID_BOOKING_STATUS(8004, "Trạng thái đặt phòng không hợp lệ", HttpStatus.BAD_REQUEST),
    INVALID_PAYMENT_STATUS(8005, "Trạng thái thanh toán không hợp lệ", HttpStatus.BAD_REQUEST),
    BOOKING_ALREADY_PAID(8006, "Đơn đặt phòng đã thanh toán", HttpStatus.CONFLICT),

    // VNPay
    INVALID_VNPAY_SIGNATURE(9001, "Chữ ký VNPay không hợp lệ", HttpStatus.BAD_REQUEST),
    PAYMENT_FAILED(9002, "Thanh toán thất bại", HttpStatus.BAD_REQUEST),
    INVALID_PAYMENT_AMOUNT(9003, "Số tiền thanh toán không hợp lệ", HttpStatus.BAD_REQUEST),

    // Image
    IMAGE_CAN_NOT_EMPTY(10001, "Phải có 5 ảnh", HttpStatus.BAD_REQUEST),
    INVALID_IMAGE_FILE(10002, "File ảnh không hợp lệ", HttpStatus.BAD_REQUEST),
    UPLOAD_IMAGE_FAILED(10003, "Upload ảnh thất bại", HttpStatus.BAD_REQUEST),
    MAIN_IMAGE_REQUIRED(10004, "Cần có ảnh chính", HttpStatus.BAD_REQUEST),
    TOO_MANY_SUB_IMAGES(10005, "Cần đúng 5 ảnh chính", HttpStatus.BAD_REQUEST),
    DELETE_IMAGE_FAILED(10006, "Xóa ảnh thất bại", HttpStatus.BAD_REQUEST),
    ;

    private int code;
    private String message;
    private HttpStatusCode statusCode;

    ErrorCode(int code, String message, HttpStatusCode statusCode) {
        this.code = code;
        this.message = message;
        this.statusCode = statusCode;
    }
}
