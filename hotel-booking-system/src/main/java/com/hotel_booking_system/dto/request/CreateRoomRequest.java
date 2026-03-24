package com.hotel_booking_system.dto.request;

import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.RoomImage;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.entity.View;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateRoomRequest {
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
}
