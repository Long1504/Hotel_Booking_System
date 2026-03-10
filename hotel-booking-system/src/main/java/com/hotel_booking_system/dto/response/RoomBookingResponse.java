package com.hotel_booking_system.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomBookingResponse {
    private String roomId;
    private String roomName;
    private String roomNumber;
    private Integer floor;
    private BigDecimal area;
    private String roomTypeName;
    private String viewName;
    private String mainImageUrl;
}
