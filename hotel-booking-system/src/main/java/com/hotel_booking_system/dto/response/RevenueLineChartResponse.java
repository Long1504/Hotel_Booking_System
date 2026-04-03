package com.hotel_booking_system.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RevenueLineChartResponse {
    private List<LocalDateTime> times;
    private List<BigDecimal> totalPrices;
    private List<BigDecimal> roomPrices;
    private List<BigDecimal> servicePrices;
    private List<BigDecimal> extraPrices;
}
