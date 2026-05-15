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

    public String findUserIdByUsername(String username) {
        String sql = """
            SELECT user_id
            FROM users
            WHERE username = ?
            LIMIT 1
        """;

        try {
            return jdbcTemplate.queryForObject(sql, String.class, username);
        } catch (Exception e) {
            return null;
        }
    }

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

    // Bookings
    public List<Booking> findBookingsByUserId(String userId) {

        String sql = """
            SELECT *
            FROM bookings
            WHERE user_id = ?
            ORDER BY created_at DESC
        """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapBooking(rs), userId);
    }

    // Services
    public List<Service> findAllServices() {

        String sql = """
            SELECT *
            FROM services
            WHERE deleted_at IS NULL
        """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapService(rs));
    }

    // Amenities
    public List<Amenity> findAllAmenities() {

        String sql = """
            SELECT *
            FROM amenities
            WHERE deleted_at IS NULL
        """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> mapAmenity(rs));
    }

    private Room mapRoom(ResultSet rs) throws SQLException {
        return Room.builder()
                .roomId(rs.getString("room_id"))
                .roomName(rs.getString("room_name"))
                .roomNumber(rs.getString("room_number"))
                .floor(rs.getInt("floor"))
                .basePrice(rs.getBigDecimal("base_price"))
                .maxAdults(rs.getInt("max_adults"))
                .maxChildren(rs.getInt("max_children"))
                .area(rs.getBigDecimal("area"))
                .description(rs.getString("description"))
                .roomStatus(rs.getString("room_status"))
                .build();
    }

    private Booking mapBooking(ResultSet rs) throws SQLException {
        return Booking.builder()
                .bookingId(rs.getString("booking_id"))
                .bookingCode(rs.getString("booking_code"))
                .checkInDate(rs.getDate("check_in_date").toLocalDate())
                .checkOutDate(rs.getDate("check_out_date").toLocalDate())
                .guestName(rs.getString("guest_name"))
                .guestPhone(rs.getString("guest_phone"))
                .guestEmail(rs.getString("guest_email"))
                .adults(rs.getInt("adults"))
                .children(rs.getInt("children"))
                .bookingStatus(rs.getString("booking_status"))
                //.roomId(rs.getString("room_id"))
                //.userId(rs.getString("user_id"))
                .build();
    }

    private Service mapService(ResultSet rs) throws SQLException {
        return Service.builder()
                .serviceId(rs.getString("service_id"))
                .serviceName(rs.getString("service_name"))
                .description(rs.getString("description"))
                .basePrice(rs.getBigDecimal("base_price"))
                .build();
    }

    private Amenity mapAmenity(ResultSet rs) throws SQLException {
        return Amenity.builder()
                .amenityId(rs.getString("amenity_id"))
                .amenityName(rs.getString("amenity_name"))
                .description(rs.getString("description"))
                .build();
    }
}