package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    Optional<User> findByUsername(String username);

    Page<User> findAllByRolesRoleNameAndDeletedAtIsNull(String roleName, Pageable pageable);

    @Query("""
        SELECT u FROM User u
        JOIN u.roles r    
        WHERE r.roleName = :roleName
        AND u.deletedAt IS NULL    
        AND (:userStatus IS NULL OR u.userStatus = :userStatus)
        AND (:username IS NULL OR u.username LIKE %:username%)
    """)
    Page<User> findAll(String roleName, String userStatus, String username, Pageable pageable);
}
