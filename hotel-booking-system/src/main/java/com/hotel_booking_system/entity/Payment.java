package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String paymentId;

    private String paymentMethod;
    private BigDecimal amount;
    private String paymentStatus;
    private LocalDateTime paidAt;

    @OneToOne
    @JoinColumn(name = "booking_id", nullable = false, unique = true)
    private  Booking booking;
}
