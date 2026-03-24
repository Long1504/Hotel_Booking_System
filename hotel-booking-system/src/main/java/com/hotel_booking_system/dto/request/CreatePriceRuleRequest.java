package com.hotel_booking_system.dto.request;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreatePriceRuleRequest {
    private String priceRuleName;
    private LocalDate startDate;
    private LocalDate endDate;
    private BigDecimal priceMultiplier;
    private Boolean isActive;
}
