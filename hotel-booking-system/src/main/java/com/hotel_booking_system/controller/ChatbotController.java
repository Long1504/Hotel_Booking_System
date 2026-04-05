package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.ChatbotRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.ChatbotResponse;
import com.hotel_booking_system.service.ChatbotService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/chatbot")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class ChatbotController {
    private final ChatbotService chatbotService;

    @PostMapping()
    public ApiResponse<String> chat(@RequestBody ChatbotRequest request, HttpSession session) {
        return ApiResponse.<String>builder()
                .result(chatbotService.chat(request, session))
                .build();
    }

    @GetMapping("/history")
    public ApiResponse<List<ChatbotResponse>> history(HttpSession session) {
        return ApiResponse.<List<ChatbotResponse>>builder()
                .result(chatbotService.getConversation(session))
                .build();
    }
}