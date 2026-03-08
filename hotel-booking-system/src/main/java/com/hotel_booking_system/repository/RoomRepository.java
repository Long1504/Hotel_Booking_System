package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Room;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface RoomRepository extends JpaRepository<Room, String> {
    Page<Room> findAllByDeletedAtIsNull(Pageable pageable);

//    @Query("""
//        SELECT DISTINCT r
//        FROM Room r
//        LEFT JOIN FETCH r.roomImages
//        WHERE r.deletedAt IS NULL
//        AND r.roomStatus = 'AVAILABLE'
//        AND r.roomId NOT IN (
//            SELECT b.room.roomId
//            FROM Booking b
//            WHERE b.checkInDate < :checkOutDate
//            AND b.checkOutDate > :checkInDate
//        )
//    """)
//    List<Room> findAllAvailableRooms(LocalDate checkInDate, LocalDate checkOutDate);

    @Query("""
        SELECT r
        FROM Room r
        LEFT JOIN FETCH r.roomImages ri
        WHERE r.deletedAt IS NULL
        AND r.roomStatus = 'AVAILABLE'
        AND (ri IS NULL OR ri.isMain = true)
            
        AND (:adults IS NULL OR r.maxAdults >= :adults)
        AND (:children IS NULL OR r.maxChildren >= :children)
    
        AND (:roomTypeId IS NULL OR r.roomType.roomTypeId = :roomTypeId)
        AND (:viewId IS NULL OR r.view.viewId = :viewId)
    
        AND NOT EXISTS (
            SELECT 1
            FROM Booking b
            WHERE b.room = r
            AND b.checkInDate < :checkOutDate
            AND b.checkOutDate > :checkInDate
        )
    """)
    Page<Room> findAllAvailableRooms(
            LocalDate checkInDate,
            LocalDate checkOutDate,
            Integer adults,
            Integer children,
            String roomTypeId,
            String viewId,
            Pageable pageable
    );

    @Query("""
        SELECT r
        FROM Room r
        LEFT JOIN FETCH r.roomImages
        WHERE r.roomId = :roomId
        AND r.deletedAt IS NULL
        AND r.roomStatus = 'AVAILABLE'
        AND r.roomId NOT IN (
            SELECT b.room.roomId
            FROM Booking b
            WHERE b.checkInDate < :checkOutDate
            AND b.checkOutDate > :checkInDate
        )
    """)
    Optional<Room> findAvailableRoomById(String roomId, LocalDate checkInDate, LocalDate checkOutDate);
}
