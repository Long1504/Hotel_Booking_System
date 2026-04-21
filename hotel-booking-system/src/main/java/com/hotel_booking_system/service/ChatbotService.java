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
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ChatbotService {
    private final ChatClient chatClient;

    private final ChatbotRepository chatbotRepository;

    public ChatbotService(ChatClient.Builder builder,
                          JdbcChatMemoryRepository jdbcChatMemoryRepository,
                          ChatbotRepository chatbotRepository) {

        this.chatbotRepository = chatbotRepository;

        ChatMemory chatMemory = MessageWindowChatMemory.builder()
                .chatMemoryRepository(jdbcChatMemoryRepository)
                .maxMessages(10) // Mặc định là 20 (lưu lịch sử chat vào db để chatbot nhớ)
                .build();

        chatClient = builder
                .defaultAdvisors(MessageChatMemoryAdvisor.builder(chatMemory).build())
                .build();
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
            String intent = detectIntentFast(question);

            if (intent == null) {
                intent = normalizeIntent(detectIntentWithAI(question, conversationId));
            }

            log.info("INTENT          : {}", intent);

            // Retrieve context from DB
            String context = retrieveContext(intent, question, username);
            context = trimContext(context);

            if (context == null || context.isBlank()) {
                context = "Không có dữ liệu liên quan.";
            }

            if (context.contains("Không có dữ liệu")) {
                context += "\n\n" + fallbackAnswer(question);
            }

            log.info("CONTEXT (RAG)   : {}", context);

            // Build prompt AI
            SystemMessage systemMessage = new SystemMessage("""
                Bạn là chatbot của Azure Hotel.
    
                QUY TẮC:
                - Hiểu câu hỏi người dùng theo ngữ nghĩa tự nhiên.
                - Trả lời chính xác dựa trên CONTEXT.
                - Không được bịa thông tin.
                - Nếu có dữ liệu thì trả lời cụ thể.
                - Nếu không thì nói không có thông tin.
                - Gợi ý thêm cho user nếu cần.
                - Trả lới ngắn gọn, dễ hiểu.
                - Nếu có nhiều kết quả thì ưu tiên gợi ý tốt nhất trước.
                - Dùng bullet point nếu có danh sách.
    
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

    private String trimContext(String context) {
        if (context == null) return "";

        // giới hạn ~1500–2000 ký tự
        if (context.length() > 1500) {
            return context.substring(0, 1500) + "\n...(rút gọn)";
        }

        return context;
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
    private String detectIntentFast(String question) {
        String q = question.toLowerCase();

        Map<String, List<String>> intentKeywords = Map.of(
                "ROOM_SEARCH", List.of(
                        "phòng", "còn phòng", "phòng trống", "giá phòng",
                        "phòng vip", "đặt phòng", "phòng rẻ", "phòng tốt nhất"
                ),
                "BOOKING_QUERY", List.of(
                        "booking", "đặt", "lịch sử", "hủy", "xem đặt"
                ),
                "SERVICE_QUERY", List.of(
                        "dịch vụ", "spa", "giặt", "ăn"
                ),
                "AMENITY_QUERY", List.of(
                        "tiện nghi", "wifi", "bể bơi", "gym"
                )
        );

        String bestIntent = null;
        int bestScore = 0;

        for (var entry : intentKeywords.entrySet()) {
            int score = 0;

            for (String keyword : entry.getValue()) {

                if (q.equals(keyword)) {
                    score += 5;
                }

                if (q.contains(keyword)) {
                    score += 2;
                }

                if (q.replace(" ", "").contains(keyword.replace(" ", ""))) {
                    score += 1;
                }
            }

            if (entry.getKey().equals("ROOM_SEARCH")) {
                if (q.contains("cho") && q.contains("người")) score += 2;
                if (q.contains("rẻ nhất")) score += 3;
                if (q.contains("phù hợp")) score += 2;
            }

            if (score > bestScore) {
                bestScore = score;
                bestIntent = entry.getKey();
            }
        }

        return bestScore > 0 ? bestIntent : null;
    }

    private String detectIntentWithAI(String question, String conversationId) {
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
                
                Câu hỏi: %s
            """.formatted(question);

            String result = chatClient
                    .prompt(prompt)
                    .advisors(a -> a.param(ChatMemory.CONVERSATION_ID, conversationId))
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

        String cleaned = raw.toUpperCase().trim();

        cleaned = cleaned.replaceAll("[^A-Z_ ]", "");

        if (cleaned.contains("ROOM")) return "ROOM_SEARCH";
        if (cleaned.contains("BOOK")) return "BOOKING_QUERY";
        if (cleaned.contains("SERVICE")) return "SERVICE_QUERY";
        if (cleaned.contains("AMENITY")) return "AMENITY_QUERY";

        return "GENERAL";
    }

    private String fallbackAnswer(String question) {
        return """
            Mình chưa tìm thấy thông tin phù hợp.

            Bạn có thể thử:
            - "Phòng dưới 1 triệu"
            - "Phòng cho 2 người"
            - "Dịch vụ khách sạn"
            - "Booking của tôi"
        """;
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

        // sort thông minh
        String q = question.toLowerCase();

        // hiểu ý giá rẻ
        boolean wantCheap = q.contains("rẻ") || q.contains("giá thấp") || q.contains("tiết kiệm");

        // hiểu ý cao cấp
        boolean wantLuxury = q.contains("vip") || q.contains("cao cấp") || q.contains("đắt");

        // hiểu ý phù hợp gia đình
        boolean family = q.contains("gia đình") || q.contains("family") || q.contains("nhiều người");

        if (wantCheap) {
            rooms = rooms.stream()
                    .sorted((a, b) -> a.getBasePrice().compareTo(b.getBasePrice()))
                    .toList();
        }

        if (wantLuxury) {
            rooms = rooms.stream()
                    .sorted((a, b) -> b.getBasePrice().compareTo(a.getBasePrice()))
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
            String q = question.toLowerCase();

            // xử lý 1,5 triệu
            if (q.contains("triệu")) {
                String num = q.replaceAll("[^0-9.,]", "");
                if (!num.isEmpty()) {
                    num = num.replace(",", ".");
                    return Double.parseDouble(num) * 1_000_000;
                }
            }

            // 1tr, 2tr
            if (q.contains("tr")) {
                String num = q.replaceAll("[^0-9]", "");
                if (!num.isEmpty()) {
                    return Double.parseDouble(num) * 100_000;
                }
            }

            return -1;

        } catch (Exception e) {
            return -1;
        }
    }

    private int extractAdults(String question) {
        try {
            String q = question.toLowerCase();

            // số rõ ràng
            String num = q.replaceAll("[^0-9]", "");
            if (!num.isEmpty() && (q.contains("người") || q.contains("khách"))) {
                return Integer.parseInt(num);
            }

            // xử lý chữ thường gặp
            if (q.contains("hai người")) return 2;
            if (q.contains("ba người")) return 3;
            if (q.contains("bốn người")) return 4;

            return -1;

        } catch (Exception e) {
            return -1;
        }
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
                .map(b -> "%s | %s | %s → %s"
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
