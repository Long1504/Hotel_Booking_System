package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "rooms")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String roomId;

    @Column(nullable = false)
    private String roomName;
    @Column(nullable = false, unique = true)
    private String roomNumber;
    @Column(nullable = false)
    private Integer floor;
    @Column(nullable = false)
    private BigDecimal basePrice;
    @Column(nullable = false)
    private Integer maxAdults;
    @Column(nullable = false)
    private Integer maxChildren;
    @Column(nullable = false)
    private BigDecimal area;
    private String description;
    @Column(nullable = false)
    private String roomStatus;
    private LocalDateTime deletedAt;

    @ManyToOne
    @JoinColumn(name = "room_type_id", nullable = false)
    private RoomType roomType;

    @ManyToOne
    @JoinColumn(name = "view_id", nullable = false)
    private View view;

    @ManyToMany
    @JoinTable(
            name = "rooms_amenities",
            joinColumns = @JoinColumn(name = "room_id"),
            inverseJoinColumns = @JoinColumn(name = "amenity_id")
    )
    private Set<Amenity> amenities;

    @OneToMany(mappedBy = "room")
    private List<RoomImage> roomImages;
}
