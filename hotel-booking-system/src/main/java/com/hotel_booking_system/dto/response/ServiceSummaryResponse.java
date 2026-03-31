package com.hotel_booking_system.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ServiceSummaryResponse {
    private String serviceId;
    private String serviceName;
    private String description;
    private BigDecimal basePrice;
}
