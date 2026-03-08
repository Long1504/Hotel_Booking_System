package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ViewResponse {
    private String viewId;
    private String viewName;
    private String description;
    private LocalDateTime deletedAt;
}
