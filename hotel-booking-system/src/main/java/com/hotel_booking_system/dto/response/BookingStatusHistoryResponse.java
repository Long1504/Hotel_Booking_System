package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookingStatusHistoryResponse {
    private String bookingStatusHistoryId;
    private String status;
    private LocalDateTime changedAt;
    private String changedBy;
}
