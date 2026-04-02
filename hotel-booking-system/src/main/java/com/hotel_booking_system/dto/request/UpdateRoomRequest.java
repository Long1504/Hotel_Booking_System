package com.hotel_booking_system.dto.request;

import lombok.*;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateRoomRequest {
    private String roomName;
    private String roomNumber;
    private Integer floor;
    private BigDecimal basePrice;
    private Integer maxAdults;
    private Integer maxChildren;
    private BigDecimal area;
    private String description;
    private String roomStatus;
    private String roomTypeId;
    private String viewId;
    private List<String> amenityIds;

    private List<String> deleteImageIds;
}
