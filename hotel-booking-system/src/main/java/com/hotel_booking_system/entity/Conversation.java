package com.hotel_booking_system.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "conversations")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Conversation {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String conversationId;
    private String customerUsername; // Chat Owner
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
}
