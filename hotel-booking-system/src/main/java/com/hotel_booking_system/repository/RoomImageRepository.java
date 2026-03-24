package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.entity.RoomImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoomImageRepository extends JpaRepository<RoomImage, String> {
    Optional<RoomImage> findByRoomAndIsMainTrue(Room room);

    long countByRoomAndIsMainFalse(Room room);
}
