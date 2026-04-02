package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "services")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String serviceId;

    @Column(nullable = false, unique = true)
    private String serviceName;
    private String description;
    @Column(nullable = false)
    private BigDecimal basePrice;
    private LocalDateTime deletedAt;

    @OneToMany(mappedBy = "service")
    private List<BookingService> bookingServices; // mới
}
