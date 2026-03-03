package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "room_images")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RoomImage {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String roomImageId;

    @Column(nullable = false)
    private String imageUrl;
    @Column(nullable = false)
    private Boolean isMain;

    @ManyToOne
    @JoinColumn(name = "room_id", nullable = false)
    private Room room;
}
