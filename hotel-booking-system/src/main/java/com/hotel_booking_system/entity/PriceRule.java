package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "price_rules")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PriceRule {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String priceRuleId;

    @Column(nullable = false, unique = true)
    private String priceRuleName;
    @Column(nullable = false)
    private LocalDate startDate;
    @Column(nullable = false)
    private LocalDate endDate;
    @Column(nullable = false)
    private BigDecimal priceMultiplier;
    @Column(nullable = false)
    private Boolean isActive;
}
