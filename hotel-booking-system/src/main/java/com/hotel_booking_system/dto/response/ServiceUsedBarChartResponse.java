package com.hotel_booking_system.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ServiceUsedBarChartResponse {
    private String serviceName;
    private Long usedCount;
}
