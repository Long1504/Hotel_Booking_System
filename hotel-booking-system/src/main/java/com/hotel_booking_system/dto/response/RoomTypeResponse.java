package com.hotel_booking_system.dto.response;

import com.hotel_booking_system.entity.Room;
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
public class RoomTypeResponse {
    private String roomTypeId;
    private String roomTypeName;
    private String description;
    private LocalDateTime deletedAt;
}
