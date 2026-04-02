package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ServiceRepository extends JpaRepository<Service, String> {
    List<Service> findAllByDeletedAtIsNull();

    boolean existsByServiceName(String serviceName);

    @Query("""
        SELECT s FROM Service s
        WHERE s.deletedAt IS NULL
        AND (:serviceName IS NULL OR s.serviceName LIKE %:serviceName%)
    """)
    Page<Service> findAll(String serviceName, Pageable pageable);
}
