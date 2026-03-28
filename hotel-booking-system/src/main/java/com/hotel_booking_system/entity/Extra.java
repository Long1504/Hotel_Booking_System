package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "extras")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Extra {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String extraId;

    @ManyToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private Booking booking;

    @Column(nullable = false)
    private String extraName;

    @Column(nullable = false)
    private BigDecimal amount;

    private String note;
}