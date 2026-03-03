package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

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
    private String imageUrl;
    private LocalDateTime deletedAt;
}
