package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, String> {
    Optional<Booking> findByBookingCode(String bookingCode);

    List<Booking> findAllByUserOrderByCreatedAtDesc(User user);

    @Query("""
        SELECT b FROM Booking b
        WHERE (:bookingStatus IS NULL OR b.bookingStatus = :bookingStatus)
        AND (:paymentStatus IS NULL OR b.paymentStatus = :paymentStatus)
        AND (:bookingCode IS NULL OR b.bookingCode LIKE %:bookingCode%)
    """)
    Page<Booking> findAll(String bookingStatus, String paymentStatus, String bookingCode, Pageable pageable);
}
