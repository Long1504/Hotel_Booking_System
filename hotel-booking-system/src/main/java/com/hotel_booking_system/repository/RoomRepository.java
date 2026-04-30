package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Room;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface RoomRepository extends JpaRepository<Room, String> {
    boolean existsRoomByRoomNumber(String roomNumber);

    List<Room> findAllByDeletedAtIsNull();

    @EntityGraph(attributePaths = "roomImages")
    @Query("""
        SELECT r
        FROM Room r
        WHERE r.deletedAt IS NULL
          AND (:roomTypeId IS NULL OR r.roomType.roomTypeId = :roomTypeId)
          AND (:viewId IS NULL OR r.view.viewId = :viewId)
          AND (:roomStatus IS NULL OR r.roomStatus = :roomStatus)
          AND (:roomName IS NULL OR r.roomName LIKE %:roomName%)
    """)
    Page<Room> findAll(String roomTypeId,
                       String viewId,
                       String roomStatus,
                       String roomName,
                       Pageable pageable);

    @EntityGraph(attributePaths = "roomImages")
    @Query("""
        SELECT r
        FROM Room r
        LEFT JOIN r.roomImages ri
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
            AND b.bookingStatus <> 'CANCELLED'
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
        AND NOT EXISTS (
            SELECT 1
            FROM Booking b
            WHERE b.room = r
            AND b.bookingStatus <> 'CANCELLED'
            AND b.checkInDate < :checkOutDate
            AND b.checkOutDate > :checkInDate
        )
    """)
    Optional<Room> findAvailableRoomById(String roomId, LocalDate checkInDate, LocalDate checkOutDate);

    @Query("""
        SELECT NOT EXISTS (
            SELECT 1
            FROM Booking b
            WHERE b.room.roomId = :roomId
            AND b.bookingStatus <> 'CANCELLED'
            AND b.checkInDate < :checkOutDate
            AND b.checkOutDate > :checkInDate
        )
    """)
    boolean isRoomAvailable(String roomId, LocalDate checkInDate, LocalDate checkOutDate);

    @Query("SELECT COUNT(r) FROM Room r WHERE r.deletedAt IS NULL")
    long countActiveRooms();
}
