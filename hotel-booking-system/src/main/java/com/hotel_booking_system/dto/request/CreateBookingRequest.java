package com.hotel_booking_system.dto.request;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateBookingRequest {
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private String guestName;
    private String guestPhone;
    private String guestEmail;
    private Integer adults;
    private Integer children;
    private String note;
    private String paymentMethod;
//    private String userId;
    private String roomId;
}
