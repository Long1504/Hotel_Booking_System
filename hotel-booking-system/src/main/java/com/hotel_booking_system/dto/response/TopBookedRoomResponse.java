package com.hotel_booking_system.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TopBookedRoomResponse {
    private RoomSummaryResponse room;
    private Long bookingCount;
    private BigDecimal revenue;
}
