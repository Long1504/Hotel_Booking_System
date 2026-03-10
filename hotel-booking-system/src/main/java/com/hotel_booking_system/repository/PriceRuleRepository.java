package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.PriceRule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PriceRuleRepository extends JpaRepository<PriceRule, String> {
    @Query("""
        SELECT pr
        FROM PriceRule pr
        WHERE pr.isActive = true
        AND pr.startDate <= :checkOutDate
        AND pr.endDate >= :checkInDate
    """)
    List<PriceRule> findRulesInRange(LocalDate checkInDate, LocalDate checkOutDate);
}
