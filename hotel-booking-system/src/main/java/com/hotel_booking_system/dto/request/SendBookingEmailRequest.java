package com.hotel_booking_system.dto.request;

import com.hotel_booking_system.dto.response.RoomBookingResponse;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SendBookingEmailRequest {
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
    private String paymentMethod;
    private String paymentStatus;
    private RoomBookingResponse room;
}
