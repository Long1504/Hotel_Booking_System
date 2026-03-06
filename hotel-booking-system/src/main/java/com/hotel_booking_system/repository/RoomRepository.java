package com.hotel_booking_system.repository;

import com.hotel_booking_system.dto.response.RoomResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Room;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Repository
public interface RoomRepository extends JpaRepository<Room, String> {

}
