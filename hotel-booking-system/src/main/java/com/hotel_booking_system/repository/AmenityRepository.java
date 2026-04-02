package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Amenity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AmenityRepository extends JpaRepository<Amenity, String> {
    boolean existsByAmenityName(String amenityName);

    List<Amenity> findAllByDeletedAtIsNull();

    @Query("""
        SELECT a FROM Amenity a
        WHERE a.deletedAt IS NULL
        AND (:amenityName IS NULL OR a.amenityName LIKE %:amenityName%)
    """)
    Page<Amenity> findAll(String amenityName, Pageable pageable);
}
