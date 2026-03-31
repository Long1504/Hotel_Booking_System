package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.BookingService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookingServiceRepository extends JpaRepository<BookingService, String> {
}
