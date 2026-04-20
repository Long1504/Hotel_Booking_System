package com.hotel_booking_system.repository;

import com.hotel_booking_system.dto.response.ConversationResponse;
import com.hotel_booking_system.entity.Conversation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ConversationRepository extends JpaRepository<Conversation, String> {

    Optional<Conversation> findByCustomerUsernameAndStatus(String customerId, String status);


    @Query("""
    SELECT new com.hotel_booking_system.dto.response.ConversationResponse(
        c.conversationId,
        c.customerUsername,
        c.status,
        c.createdAt,
        c.closedAt,

        m.content,
        m.createdAt,

        CASE
            WHEN cm.lastReadAt IS NULL THEN true
            WHEN m.createdAt > cm.lastReadAt THEN true
            ELSE false
        END
    )
    FROM Conversation c
    JOIN ConversationMember cm
        ON cm.conversationId = c.conversationId
        AND cm.username = :username

    LEFT JOIN Message m ON m.messageId = (
        SELECT m2.messageId
        FROM Message m2
        WHERE m2.conversationId = c.conversationId
        ORDER BY m2.createdAt DESC
        LIMIT 1
    )
    ORDER BY m.createdAt DESC
    """)
    List<ConversationResponse> getConversationSummaries(@Param("username") String username);
}
