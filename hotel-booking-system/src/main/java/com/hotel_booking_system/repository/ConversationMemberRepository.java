package com.hotel_booking_system.repository;

import com.hotel_booking_system.entity.ConversationMember;
import com.hotel_booking_system.entity.ConversationMemberId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ConversationMemberRepository extends JpaRepository<ConversationMember, ConversationMemberId> {
    boolean existsByConversationIdAndUsername(String conversationId, String userId);

    boolean existsByConversationIdAndRole(String conversationId, String role);

    List<ConversationMember> findAllByConversationId(String conversationId);

    @Modifying
    @Query("""
        UPDATE ConversationMember cm
        SET cm.lastReadAt = :time
        WHERE cm.conversationId = :conversationId
        AND cm.username = :username
    """)
    void updateLastRead(String conversationId, String username, LocalDateTime time);
}