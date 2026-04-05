package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.ChatbotRequest;
import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.UpdateAmenityRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.dto.response.ChatbotResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.AmenityMapper;
import com.hotel_booking_system.repository.AmenityRepository;
import com.hotel_booking_system.repository.ChatbotRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.MessageChatMemoryAdvisor;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.memory.MessageWindowChatMemory;
import org.springframework.ai.chat.memory.repository.jdbc.JdbcChatMemoryRepository;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ChatbotService {
    private final ChatClient chatClient;
    private final JdbcChatMemoryRepository jdbcChatMemoryRepository;

    private final ChatbotRepository chatbotRepository;

    public ChatbotService(ChatClient.Builder builder,
                          JdbcChatMemoryRepository jdbcChatMemoryRepository,
                          ChatbotRepository chatbotRepository) {

        this.jdbcChatMemoryRepository = jdbcChatMemoryRepository;
        this.chatbotRepository = chatbotRepository;

        ChatMemory chatMemory = MessageWindowChatMemory.builder()
                .chatMemoryRepository(jdbcChatMemoryRepository)
                .maxMessages(30) // Mặc định là 20 (lưu lịch sử chat vào db để chatbot nhớ)
                .build();

        chatClient = builder
                .defaultAdvisors(MessageChatMemoryAdvisor.builder(chatMemory).build())
                .build();
    }

    public String chat(ChatbotRequest request, HttpSession session) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        String conversationId = (username != null && !"anonymousUser".equals(username))
                ? "user-" + username
                : "guest-" + session.getId().substring(0, 8);

        String question = request.getMessage();

        // Detect intent
        String intent = detectIntent(question);

        // Retrieve context from DB
        String context = retrieveContext(intent, question, username);

        // Build prompt AI
        SystemMessage systemMessage = new SystemMessage("""
            Bạn là trợ lý AI của Aruze Hotel.
    
            CONTEXT:
            %s
    
            RULES:
            - Chỉ trả lời dựa trên CONTEXT.
            - Nếu CONTEXT không đủ, hãy hỏi lại người dùng.
            - Không tự suy đoán thông tin không có trong CONTEXT.
            - Trả lời ngắn gọn, rõ ràng.
            - Khi có danh sách, hãy trình bày dạng gạch đầu dòng.
            - Có thể trả lời một cách hài hước, thân thiện và gần gũi
        """.formatted(context));

        UserMessage userMessage = new UserMessage(question);

        Prompt prompt = new Prompt(systemMessage, userMessage);

        return chatClient
                .prompt(prompt)
                .advisors(advisor -> advisor.param(ChatMemory.CONVERSATION_ID, conversationId))
                .call()
                .content();
    }

    public List<ChatbotResponse> getConversation(HttpSession session) {

        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        String conversationId = (username != null && !"anonymousUser".equals(username))
                ? "user-" + username
                : "guest-" + session.getId().substring(0, 8);

        return chatbotRepository.findByConversationId(conversationId);
    }

    private String detectIntent(String question) {
        String q = question.toLowerCase();

        if (q.contains("phòng") || q.contains("room")) return "ROOM_SEARCH";
        if (q.contains("đặt") || q.contains("booking") || q.contains("đơn")) return "BOOKING_QUERY";
        if (q.contains("dịch vụ") || q.contains("service")) return "SERVICE_QUERY";
        if (q.contains("tiện nghi") || q.contains("amenity")) return "AMENITY_QUERY";

        return "GENERAL";
    }

    private String retrieveContext(String intent, String question, String username) {

        return switch (intent) {
            case "ROOM_SEARCH" -> getRoomContext();
            case "BOOKING_QUERY" -> getBookingContext(username);
            case "SERVICE_QUERY" -> getServiceContext();
            case "AMENITY_QUERY" -> getAmenityContext();
            default -> "Không có dữ liệu DB liên quan.";
        };
    }

    private String getRoomContext() {
        List<Room> rooms = chatbotRepository.findAvailableRooms();

        return rooms.stream()
                .map(r -> """
                        Room name: %s
                        Room number: %s
                        Floor: %s
                        Base price: %s
                        Max adults: %s
                        Max children: %s
                        Area: %s
                        Room status: %s
                        """.formatted(
                        r.getRoomName(),
                        r.getRoomNumber(),
                        r.getFloor(),
                        r.getBasePrice(),
                        r.getMaxAdults(),
                        r.getMaxChildren(),
                        r.getArea(),
                        r.getRoomStatus()
                ))
                .collect(Collectors.joining("\n"));
    }

    private String getBookingContext(String username) {

        if (username == null || "anonymousUser".equals(username)) {
            return "Người dùng chưa đăng nhập.";
        }

        String userId = chatbotRepository.findUserIdByUsername(username);

        if (userId == null) {
            return "Không tìm thấy user.";
        }

        List<Booking> bookings = chatbotRepository.findBookingsByUserId(userId);

        if (bookings.isEmpty()) {
            return "Không có booking nào.";
        }

        return bookings.stream()
                .map(b -> """
                        Booking code: %s
                        Booking status: %s
                        Check in date: %s
                        Check out date: %s
                        Guest name: %s
                        Guest phone: %s
                        Guest email: %s
                        Adults: %s
                        Children: %s
                        """.formatted(
                        b.getBookingCode(),
                        b.getBookingStatus(),
                        b.getCheckInDate(),
                        b.getCheckOutDate(),
                        b.getGuestName(),
                        b.getGuestPhone(),
                        b.getGuestEmail(),
                        b.getAdults(),
                        b.getChildren()
                ))
                .collect(Collectors.joining("\n"));
    }

    private String getServiceContext() {
        List<com.hotel_booking_system.entity.Service> services = chatbotRepository.findAllServices();

        return services.stream()
                .map(s -> """
                Service name: %s
                Base price: %s
                """.formatted(
                        s.getServiceName(),
                        s.getBasePrice()
                ))
                .collect(Collectors.joining("\n"));
    }

    private String getAmenityContext() {
        List<Amenity> amenities = chatbotRepository.findAllAmenities();

        return amenities.stream()
                .map(Amenity::getAmenityName)
                .collect(Collectors.joining(", "));
    }
}
