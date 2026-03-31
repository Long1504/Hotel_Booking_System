package com.hotel_booking_system.dto.request;

import lombok.*;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateExtraRequest {
    private BigDecimal amount;
    private String note;
}
