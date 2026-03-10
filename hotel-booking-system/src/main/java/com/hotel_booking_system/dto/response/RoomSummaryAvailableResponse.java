package com.hotel_booking_system.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomSummaryAvailableResponse {
    private String roomId;
    private String roomName;
    private String roomNumber;
    private Integer floor;
    private BigDecimal basePrice;
    private Long nights;
    private BigDecimal finalPrice;
    private Integer maxAdults;
    private Integer maxChildren;
    private BigDecimal area;
    private String description;
    private String roomStatus;
    private LocalDateTime deletedAt;
    private String roomTypeName;
    private String viewName;
    private String mainImageUrl;
}
