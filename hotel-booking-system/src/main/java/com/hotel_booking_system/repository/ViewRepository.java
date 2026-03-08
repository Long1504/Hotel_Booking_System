package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.entity.View;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewRepository extends JpaRepository<View, String> {
    List<View> findAllByDeletedAtIsNull();
}
