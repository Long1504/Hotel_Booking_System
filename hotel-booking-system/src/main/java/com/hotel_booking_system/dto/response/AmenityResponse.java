package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AmenityResponse {
    private String amenityId;
    private String amenityName;
    private String description;
    private LocalDateTime deletedAt;
}
