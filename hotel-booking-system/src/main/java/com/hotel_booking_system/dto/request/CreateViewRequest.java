package com.hotel_booking_system.dto.request;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateViewRequest {
    private String viewName;
    private String description;
}
