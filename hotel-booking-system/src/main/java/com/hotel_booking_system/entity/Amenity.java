package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(name = "amenities")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Amenity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String amenityId;

    private String amenityName;
    private String description;
    private LocalDateTime deletedAt;

    @ManyToMany(mappedBy = "amenities")
    private Set<Room> rooms;
}
