package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.BookingService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface BookingServiceRepository extends JpaRepository<BookingService, String> {
    @Query("""
        SELECT bs
        FROM BookingService bs
        WHERE bs.booking.createdAt BETWEEN :start AND :end
    """)
    List<BookingService> findAllByCreatedAtBetween(LocalDateTime start, LocalDateTime end);
}
