package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookingCountBarChartResponse {
    private List<LocalDateTime> times;
    private List<Long> bookingCounts;
}
