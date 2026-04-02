package com.hotel_booking_system.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ExtraResponse {
    private String extraId;
    private BigDecimal amount;
    private String note;
}
