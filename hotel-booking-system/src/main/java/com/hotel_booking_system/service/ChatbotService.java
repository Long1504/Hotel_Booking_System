package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.ChatbotRequest;
import com.hotel_booking_system.dto.response.ChatbotResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.repository.ChatbotRepository;
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

    public ChatbotService(ChatClient.Builder builder,
                          JdbcChatMemoryRepository jdbcChatMemoryRepository,
                          ChatbotRepository chatbotRepository) {

        this.chatbotRepository = chatbotRepository;

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

        log.info("\n================ CHAT REQUEST ================");
        log.info("USER            : {}", username);
        log.info("CONVERSATION_ID : {}", conversationId);
        log.info("QUESTION        : {}", question);

        try {
            // Detect intent
            String intent = detectIntentWithAI(question);

            log.info("INTENT          : {}", intent);

            // Retrieve context from DB
            String context = retrieveContext(intent, question, username);

            log.info("CONTEXT (RAG)   : {}", context);

            // Build prompt AI
            SystemMessage systemMessage = new SystemMessage("""
                Bạn là chatbot của Azure Hotel.
    
                QUY TẮC:
                - Trả lời chính xác dựa trên CONTEXT.
                - Không được bịa thông tin.
                - Nếu không có dữ liệu thì nói không có thông tin.
                - Gợi ý thêm cho người hỏi nếu cần.
                - Gợi ý câu hỏi cho người hỏi khi không đủ thông tin.
                - Trả lời ngắn gọn, dễ hiểu.
                - Tránh dùng ký tự *
    
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

            log.info("RESPONSE        : {}", answer);

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
            default -> "Không có dữ liệu liên quan.";
        };
    }

    // ================= ROOM =================
    private String getRoomContext(String question) {

        List<Room> rooms = chatbotRepository.findAvailableRooms();

        double price = extractPrice(question);
        int adults = extractAdults(question);

        // filter số người
        if (adults > 0) {
            rooms = rooms.stream()
                    .filter(r -> r.getMaxAdults() >= adults)
                    .toList();
        }

        // filter giá
        if (price > 0) {
            rooms = rooms.stream()
                    .filter(r -> r.getBasePrice().doubleValue() <= price)
                    .toList();
        }

        if (rooms.isEmpty()) {
            return "Không có phòng phù hợp.";
        }

        return """
        DANH SÁCH PHÒNG:
        %s
        """.formatted(
                rooms.stream()
                        .map(r -> "%s | %s VND | %s người lớn | %s trẻ em | tầng %s"
                                .formatted(
                                        r.getRoomName(),
                                        r.getBasePrice(),
                                        r.getMaxAdults(),
                                        r.getMaxChildren(),
                                        r.getFloor()
                                        ))
                        .collect(Collectors.joining("\n"))
        );
    }

    private double extractPrice(String question) {
        try {
            Pattern pattern = Pattern.compile("(\\d+[.,]?\\d*)\\s*(triệu|tr)");
            Matcher matcher = pattern.matcher(question.toLowerCase());

            if (matcher.find()) {
                String number = matcher.group(1).replace(",", ".");
                return Double.parseDouble(number) * 1_000_000;
            }

        } catch (Exception ignored) {}

        return -1;
    }

    private int extractAdults(String question) {
        try {
            Pattern pattern = Pattern.compile("(\\d+)\\s*(người|khách)");
            Matcher matcher = pattern.matcher(question.toLowerCase());

            if (matcher.find()) {
                return Integer.parseInt(matcher.group(1));
            }

            String q = question.toLowerCase();

            if (q.contains("hai người")) return 2;
            if (q.contains("ba người")) return 3;
            if (q.contains("bốn người")) return 4;

        } catch (Exception ignored) {}

        return -1;
    }

    // ================= BOOKING =================
    private String getBookingContext(String username) {
        if (username == null || "anonymousUser".equals(username)) {
            return "Bạn chưa đăng nhập.";
        }

        String userId = chatbotRepository.findUserIdByUsername(username);

        if (userId == null) {
            return "Không tìm thấy người dùng.";
        }

        List<Booking> bookings = chatbotRepository.findBookingsByUserId(userId);

        if (bookings.isEmpty()) {
            return """
                Bạn chưa có booking nào.
                Gợi ý: Hỏi "Cho tôi xem phòng trống" để đặt phòng.
            """;
        }

        return bookings.stream()
                .map(b -> "%s | %s | %s - %s"
                        .formatted(
                                b.getBookingCode(),
                                b.getBookingStatus(),
                                b.getCheckInDate(),
                                b.getCheckOutDate()
                        ))
                .collect(Collectors.joining("\n"));
    }

    // ================= SERVICE =================
    private String getServiceContext() {
        List<com.hotel_booking_system.entity.Service> services = chatbotRepository.findAllServices();

        if (services.isEmpty()) {
            return "Hiện chưa có dịch vụ nào.";
        }

        return services.stream()
                .map(s -> "%s | %s VND"
                        .formatted(s.getServiceName(), s.getBasePrice()))
                .collect(Collectors.joining("\n"));
    }

    // ================= AMENITY =================
    private String getAmenityContext() {
        List<Amenity> amenities = chatbotRepository.findAllAmenities();

        if (amenities.isEmpty()) {
            return "Không có tiện nghi.";
        }

        return amenities.stream()
                .limit(10)
                .map(Amenity::getAmenityName)
                .collect(Collectors.joining(", "));
    }
}
