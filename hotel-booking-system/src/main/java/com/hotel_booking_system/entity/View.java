package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "views")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class View {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String viewId;

    private String viewName;
    private String description;
    private LocalDateTime deletedAt;

    @OneToMany(mappedBy = "view")
    private List<Room> rooms;
}
