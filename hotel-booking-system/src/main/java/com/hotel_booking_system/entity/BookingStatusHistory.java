package com.hotel_booking_system.entity;

import com.hotel_booking_system.enums.UserStatus;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "booking_status_histories")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BookingStatusHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String bookingStatusHistoryId;

    @Column(nullable = false)
    private String status;
    @Column(nullable = false)
    private LocalDateTime changedAt;

    @ManyToOne
    @JoinColumn(name = "changed_by")
    private User changedBy;

    @ManyToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private Booking booking;

    @PrePersist
    protected void onCreate() {
        changedAt = LocalDateTime.now();
    }
}
