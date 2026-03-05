package com.hotel_booking_system.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
public enum ErrorCode {
    // System
    INTERNAL_SERVER_ERROR(9999, "Internal server error", HttpStatus.INTERNAL_SERVER_ERROR),

    // Auth
    UNAUTHENTICATED(1000, "Unauthenticated", HttpStatus.UNAUTHORIZED),
    UNAUTHORIZED(1001, "Unauthorized", HttpStatus.FORBIDDEN),
    INVALID_TOKEN(1002, "Invalid token", HttpStatus.UNAUTHORIZED),
    ACCOUNT_LOCKED(1003, "Account is locked", HttpStatus.LOCKED),
    INVALID_CREDENTIALS(1004, "Invalid username or password", HttpStatus.UNAUTHORIZED),

    // Role
    ROLE_NOT_FOUND(2001, "Role not found", HttpStatus.NOT_FOUND),
    ROLE_ALREADY_EXISTS(2002, "Role already exists", HttpStatus.CONFLICT),

    // User
    USER_NOT_FOUND(3001, "User not found", HttpStatus.NOT_FOUND),
    USER_ALREADY_EXISTS(3002, "User already exists", HttpStatus.CONFLICT),
    USERNAME_ALREADY_EXISTS(3003, "Username already exists", HttpStatus.CONFLICT),
    EMAIL_ALREADY_EXISTS(3004, "Email already exists", HttpStatus.CONFLICT),
    INVALID_PASSWORD(3005, "Invalid password", HttpStatus.BAD_REQUEST),
    USER_DELETED(3006, "User account has been deleted", HttpStatus.GONE)
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
