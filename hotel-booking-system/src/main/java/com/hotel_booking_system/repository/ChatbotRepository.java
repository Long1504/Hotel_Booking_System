package com.hotel_booking_system.repository;

import com.hotel_booking_system.dto.response.ChatbotResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.entity.Service;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class ChatbotRepository {

    private final JdbcTemplate jdbcTemplate;

    // Chat memory
    public List<ChatbotResponse> findByConversationId(String conversationId) {

        String sql = """
            SELECT type, content
            FROM spring_ai_chat_memory
            WHERE conversation_id = ?
            ORDER BY timestamp ASC
        """;

        return jdbcTemplate.query(sql,
                (rs, rowNum) -> ChatbotResponse.builder()
                        .type(rs.getString("type"))
                        .content(rs.getString("content"))
                        .build(),
                conversationId
        );
    }
}