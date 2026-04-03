package com.hotel_booking_system.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomTypePieChartResponse {
    private String roomTypeName;
    private Long roomCount;
}
