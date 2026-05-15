package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.ChatbotRequest;
import com.hotel_booking_system.dto.response.ChatbotResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.entity.User;
import com.hotel_booking_system.repository.*;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.MessageChatMemoryAdvisor;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.memory.MessageWindowChatMemory;
import org.springframework.ai.chat.memory.repository.jdbc.JdbcChatMemoryRepository;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ChatbotService {
    private final ChatClient chatClient;
    private final ChatClient classifyClient;

    private final ChatbotRepository chatbotRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;
    private final BookingRepository bookingRepository;
    private final ServiceRepository serviceRepository;
    private final AmenityRepository amenityRepository;

    public ChatbotService(ChatClient.Builder builder,
                          JdbcChatMemoryRepository jdbcChatMemoryRepository,
                          ChatbotRepository chatbotRepository, UserRepository userRepository, RoomRepository roomRepository, BookingRepository bookingRepository, ServiceRepository serviceRepository, AmenityRepository amenityRepository) {

        this.chatbotRepository = chatbotRepository;
        this.userRepository = userRepository;
        this.roomRepository = roomRepository;
        this.bookingRepository = bookingRepository;
        this.serviceRepository = serviceRepository;
        this.amenityRepository = amenityRepository;

        ChatMemory chatMemory = MessageWindowChatMemory.builder()
                .chatMemoryRepository(jdbcChatMemoryRepository)
                .maxMessages(20) // Mặc định là 20 (lưu lịch sử chat vào db để chatbot nhớ)
                .build();

        this.chatClient = builder
                .defaultAdvisors(MessageChatMemoryAdvisor.builder(chatMemory).build())
                .build();

        this.classifyClient = builder.build();
    }

    // ================= MAIN CHAT =================
    public String chat(ChatbotRequest request, HttpSession session) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        String conversationId = (username != null && !"anonymousUser".equals(username))
                ? "user-" + username
                : "guest-" + session.getId().substring(0, 8);

        String question = request.getMessage();

        log.info(
                "\n================ CHAT REQUEST ================" +
                "\nUSER            : " + username +
                "\nCONVERSATION_ID : " + conversationId +
                "\nQUESTION        : " + question
        );

        try {
            // Detect intent
            String intent = detectIntentWithAI(question);

            log.info("\nINTENT          : {}", intent);

            // Retrieve context from DB
            String context = retrieveContext(intent, question, username);

            log.info("\nCONTEXT (RAG)   : {}", context);

            // Build prompt AI
            SystemMessage systemMessage = new SystemMessage("""
                Bạn là trợ lý tư vấn khách sạn chuyên nghiệp của Azure Hotel
                
                MỤC TIÊU:
                - Hỗ trợ khách hàng tìm phòng phù hợp
                - Tư vấn theo nhu cầu thực tế
                - Trả lời thân thiện và chuyên nghiệp như nhân viên lễ tân
    
                QUY TẮC:
                - Chỉ trả lời dựa trên CONTEXT
                - Không bịa thông tin
                - Nếu thiếu dữ liệu hãy hỏi thêm khách
                - Luôn cố gắng gợi ý phù hợp hơn
                - Gợi ý câu hỏi cho người hỏi khi không đủ thông tin
                - Trả lời ngắn gọn, dễ hiểu
                - Không dùng markdown hoặc ký tự *
                
                VÍ DỤ:
                - Nếu khách hỏi phòng cho gia đình => Gợi ý phòng rộng
                - Nếu khách hỏi giá rẻ => Ưu tiên phòng giá thấp
                - Nếu khách chưa rõ => Hỏi thêm số người, ngân sách, ...
    
                CONTEXT:
                %s
            """.formatted(context));

            UserMessage userMessage = new UserMessage(question);

            Prompt prompt = new Prompt(systemMessage, userMessage);

            String answer = chatClient
                    .prompt(prompt)
                    .advisors(advisor -> advisor.param(ChatMemory.CONVERSATION_ID, conversationId))
                    .call()
                    .content();

            log.info("\nRESPONSE        : {}", answer);

            return answer;
        } catch (Exception e) {
            log.error("CHATBOT ERROR - user: {}, question: {}", username, question, e);
            return "Xin lỗi, hệ thống chatbot đang gặp lỗi.";
        }
    }

    // ================= GET HISTORY =================
    public List<ChatbotResponse> getConversation(HttpSession session) {

        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        String conversationId = (username != null && !"anonymousUser".equals(username))
                ? "user-" + username
                : "guest-" + session.getId().substring(0, 8);

        return chatbotRepository.findByConversationId(conversationId);
    }

    // ================= AI INTENT =================
    private String detectIntentWithAI(String question) {
        try {
            String prompt = """
                Bạn là bộ phân loại intent cho chatbot khách sạn.
                
                CHỈ TRẢ VỀ 1 TRONG 5 GIÁ TRỊ SAU (VIẾT HOA):
                - ROOM_SEARCH
                - BOOKING_QUERY
                - SERVICE_QUERY
                - AMENITY_QUERY
                - GENERAL
                
                QUY TẮC:
                - Không giải thích
                - Không xuống dòng
                - Không ký tự đặc biệt
                - Nếu không chắc trả về GENERAL
                
                CÂU HỎI: %s
            """.formatted(question);

            String result = classifyClient
                    .prompt(prompt)
                    .call()
                    .content();

            return normalizeIntent(result);

        } catch (Exception e) {
            log.error("Detect intent error", e);
            return "GENERAL";
        }
    }

    private String normalizeIntent(String raw) {
        if (raw == null) return "GENERAL";

        String cleaned = raw
                .trim()
                .toUpperCase()
                .replaceAll("[^A-Z_ ]", "");

        if (cleaned.contains("ROOM")) return "ROOM_SEARCH";
        if (cleaned.contains("BOOK")) return "BOOKING_QUERY";
        if (cleaned.contains("SERVICE")) return "SERVICE_QUERY";
        if (cleaned.contains("AMENITY")) return "AMENITY_QUERY";

        return "GENERAL";
    }

    // ================= CONTEXT ROUTER =================
    private String retrieveContext(String intent, String question, String username) {
        return switch (intent) {
            case "ROOM_SEARCH" -> getRoomContext(question);
            case "BOOKING_QUERY" -> getBookingContext(username);
            case "SERVICE_QUERY" -> getServiceContext();
            case "AMENITY_QUERY" -> getAmenityContext();
            default -> "Không có dữ liệu liên quan";
        };
    }

    // ================= ROOM =================
    private String getRoomContext(String question) {

        List<Room> rooms = roomRepository.findAllByDeletedAtIsNull();

        if (rooms.isEmpty()) {
            return "Không có phòng phù hợp.";
        }

        return """
        DANH SÁCH PHÒNG:
        %s
        """.formatted(
                rooms.stream()
                        .map(r -> "[ Tên phòng: %s | Tầng: %s | Đơn giá (VNĐ/đêm): %s | Số người lớn tối đa: %s | Số trẻ em tối đa: %s | Diện tích: %s | Loại phòng: %s | View: %s ]"
                                .formatted(
                                        r.getRoomName(),
                                        r.getFloor(),
                                        r.getBasePrice(),
                                        r.getMaxAdults(),
                                        r.getMaxChildren(),
                                        r.getArea(),
                                        r.getRoomType().getRoomTypeName(),
                                        r.getView().getViewName()
                                        ))
                        .collect(Collectors.joining("\n"))
        );
    }

    // ================= BOOKING =================
    private String getBookingContext(String username) {
        if (username == null || "anonymousUser".equals(username)) {
            return "Chưa đăng nhập";
        }

        User user = userRepository.findByUsername(username).orElse(null);

        if (user == null) {
            return "Không tìm thấy người dùng";
        }

        List<Booking> bookings = bookingRepository.findAllByUserOrderByCreatedAtDesc(user);

        if (bookings.isEmpty()) {
            return "Chưa có booking";
        }

        return """
        DANH SÁCH BOOKING:
        %s
        """.formatted(
                bookings.stream()
                        .map(b -> "[ Mã đặt phòng: %s | Thời gian đặt: %s | Ngày nhận - trả phòng: %s - %s | Người đại diện: %s | Số người lớn: %s | Số trẻ em: %s | Tổng tiền: %s | Trạng thái đặt phòng: %s | Trạng thái thanh toán: %s ]"
                                .formatted(
                                        b.getBookingCode(),
                                        b.getCreatedAt(),
                                        b.getCheckInDate(),
                                        b.getCheckOutDate(),
                                        b.getGuestName(),
                                        b.getAdults(),
                                        b.getChildren(),
                                        b.getTotalPrice(),
                                        b.getBookingStatus(),
                                        b.getPaymentStatus()
                                ))
                        .collect(Collectors.joining("\n"))
        );
    }

    // ================= SERVICE =================
    private String getServiceContext() {
        List<com.hotel_booking_system.entity.Service> services = serviceRepository.findAllByDeletedAtIsNull();

        if (services.isEmpty()) {
            return "Hiện chưa có dịch vụ nào";
        }

        return """
        DANH SÁCH DỊCH VỤ:
        %s
        """.formatted(
                services.stream()
                        .map(s -> "[ Tên dịch vụ: %s | Đơn giá (VNĐ): %s ]"
                                .formatted(
                                        s.getServiceName(),
                                        s.getBasePrice()
                                ))
                        .collect(Collectors.joining("\n"))
        );
    }

    // ================= AMENITY =================
    private String getAmenityContext() {
        List<Amenity> amenities = amenityRepository.findAllByDeletedAtIsNull();

        if (amenities.isEmpty()) {
            return "Hiện chưa có tiện nghi nào";
        }

        return """
        DANH SÁCH TIỆN NGHI: %s
        """.formatted(
                amenities.stream()
                        .map(Amenity::getAmenityName)
                        .collect(Collectors.joining(", "))
        );
    }
}
