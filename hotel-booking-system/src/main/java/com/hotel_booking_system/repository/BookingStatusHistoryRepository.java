package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.BookingStatusHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookingStatusHistoryRepository extends JpaRepository<BookingStatusHistory, String> {

}
