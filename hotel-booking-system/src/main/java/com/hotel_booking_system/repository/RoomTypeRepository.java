package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.RoomType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomTypeRepository extends JpaRepository<RoomType, String> {
    boolean existsByRoomTypeName(String roomTypeName);

    List<RoomType> findAllByDeletedAtIsNull();

    @Query("""
        SELECT rt FROM RoomType rt
        WHERE rt.deletedAt IS NULL
        AND (:roomTypeName IS NULL OR rt.roomTypeName LIKE %:roomTypeName%)
    """)
    Page<RoomType> findAll(String roomTypeName, Pageable pageable);
}
