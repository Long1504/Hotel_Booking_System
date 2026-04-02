package com.hotel_booking_system.dto.response;

import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.Service;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookingServiceResponse {
    private String bookingServiceId;
    private String serviceId;
    private String serviceName;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
}
