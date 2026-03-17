package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.entity.View;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewRepository extends JpaRepository<View, String> {

    boolean existsByViewName(String viewName);

    List<View> findAllByDeletedAtIsNull();

    @Query("""
        SELECT v FROM View v
        WHERE v.deletedAt IS NULL
        AND (:viewName IS NULL OR v.viewName LIKE %:viewName%)
    """)
    Page<View> findAll(String viewName, Pageable pageable);
}
