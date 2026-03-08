package com.hotel_booking_system.dto.response;

import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.User;
import jakarta.persistence.*;

import java.time.LocalDateTime;

public class BookingStatusHistoryResponse {
    private String bookingStatusHistoryId;
    private String oldStatus;
    private String newStatus;
    private LocalDateTime changedAt;
    private User changedBy;
}
