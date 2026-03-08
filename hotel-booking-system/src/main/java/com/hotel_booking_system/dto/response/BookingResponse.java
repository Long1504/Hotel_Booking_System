package com.hotel_booking_system.dto.response;

import com.hotel_booking_system.entity.BookingStatusHistory;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.entity.User;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookingResponse {
    private String bookingId;
    private String bookingCode;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private String guestName;
    private String guestPhone;
    private String guestEmail;
    private Integer adults;
    private Integer children;
    private String note;
    private BigDecimal totalPrice;
    private LocalDateTime createdAt;
    private String bookingStatus;
    private RoomBookingResponse roomBooking;

    private List<BookingStatusHistory> bookingStatusHistories;
}
