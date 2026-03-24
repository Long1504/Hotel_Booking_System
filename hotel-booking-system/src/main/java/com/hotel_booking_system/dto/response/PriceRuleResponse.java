package com.hotel_booking_system.dto.response;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PriceRuleResponse {
    private String priceRuleId;
    private String priceRuleName;
    private LocalDate startDate;
    private LocalDate endDate;
    private BigDecimal priceMultiplier;
    private Boolean isActive;
}
