package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.BookingService;
import com.hotel_booking_system.entity.Extra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExtraRepository extends JpaRepository<Extra, String> {
    List<Extra> findByBookingBookingId(String bookingId);
}
