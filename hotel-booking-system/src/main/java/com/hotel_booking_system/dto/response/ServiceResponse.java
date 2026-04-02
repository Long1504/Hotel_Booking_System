package com.hotel_booking_system.dto.response;

import com.hotel_booking_system.entity.BookingService;
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
public class ServiceResponse {
    private String serviceId;
    private String serviceName;
    private String description;
    private BigDecimal basePrice;
    private LocalDateTime deletedAt;
}
