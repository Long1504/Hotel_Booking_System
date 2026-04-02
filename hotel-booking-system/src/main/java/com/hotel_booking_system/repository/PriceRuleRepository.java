package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.PriceRule;
import com.hotel_booking_system.entity.View;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PriceRuleRepository extends JpaRepository<PriceRule, String> {

    boolean existsByPriceRuleName(String priceRuleName);

    PriceRule findByPriceRuleName(String priceRuleName);

    @Query("""
        SELECT pr
        FROM PriceRule pr
        WHERE pr.isActive = true
        AND pr.startDate <= :checkOutDate
        AND pr.endDate >= :checkInDate
    """)
    List<PriceRule> findRulesInRange(LocalDate checkInDate, LocalDate checkOutDate);

    @Query("""
        SELECT pr FROM PriceRule pr
        WHERE (:isActive IS NULL OR pr.isActive = :isActive)
        AND (:priceRuleName IS NULL OR pr.priceRuleName LIKE %:priceRuleName%)
    """)
    Page<PriceRule> findAll(Boolean isActive, String priceRuleName, Pageable pageable);

    @Query("""
        SELECT CASE WHEN COUNT(pr) > 0 THEN TRUE ELSE FALSE END
        FROM PriceRule pr
        WHERE pr.isActive = TRUE
        AND pr.startDate <= :endDate
        AND pr.endDate >= :startDate
    """)
    boolean existsOverlappingDate(LocalDate startDate, LocalDate endDate);
}
