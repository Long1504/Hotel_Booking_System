package com.hotel_booking_system.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookingStatusPieChartResponse {
    private String status;
    private Long count;
}
