package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "room_types")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RoomType {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String roomTypeId;

    @Column(nullable = false, unique = true)
    private String roomTypeName;
    private String description;
    private LocalDateTime deletedAt;

    @OneToMany(mappedBy = "roomType")
    private List<Room> rooms;
}
