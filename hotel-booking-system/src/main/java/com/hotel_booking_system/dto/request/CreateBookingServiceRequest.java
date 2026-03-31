package com.hotel_booking_system.dto.request;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateBookingServiceRequest {
    private String serviceId;
    private Integer quantity;
}
