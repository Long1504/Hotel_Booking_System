package com.hotel_booking_system.entity;

import com.hotel_booking_system.enums.BookingStatus;
import com.hotel_booking_system.enums.UserStatus;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "bookings")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String bookingId;

    @Column(nullable = false, unique = true)
    private String bookingCode;
    @Column(nullable = false)
    private LocalDate checkInDate;
    @Column(nullable = false)
    private LocalDate checkOutDate;
    @Column(nullable = false)
    private String guestName;
    @Column(nullable = false)
    private String guestPhone;
    @Column(nullable = false)
    private String guestEmail;
    @Column(nullable = false)
    private Integer adults;
    @Column(nullable = false)
    private Integer children;
    private String note;
    @Column(nullable = false)
    private BigDecimal totalPrice;
    @Column(nullable = false)
    private LocalDateTime createdAt;
    @Column(nullable = false)
    private String bookingStatus;
    @Column(nullable = false)
    private String paymentMethod;
    @Column(nullable = false)
    private String paymentStatus;
    private LocalDateTime paidAt;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "room_id", nullable = false)
    private Room room;

    @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BookingStatusHistory> bookingStatusHistories;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        bookingStatus = BookingStatus.PENDING.name();
    }
}
