package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.response.ConversationResponse;
import com.hotel_booking_system.dto.response.MessageResponse;
import com.hotel_booking_system.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/chat")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class ChatRestController {
    private final ChatService chatService;

    private final SimpMessagingTemplate messagingTemplate;

    @PreAuthorize("hasRole('CUSTOMER')")
    @PostMapping("/conversations")
    public ConversationResponse create() {
        return chatService.getOrCreateConversation();
    }

    @PutMapping("/conversations/{conversationId}/read")
    public void markRead(@PathVariable String conversationId) {
        chatService.markAsRead(conversationId);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        messagingTemplate.convertAndSendToUser(
                username,
                "/topic/conversations",
                chatService.getConversationsForUser(username)
        );
    }

    @PutMapping("/conversations/{conversationId}/close")
    @PreAuthorize("hasRole('RECEPTIONIST')")
    public void close(@PathVariable String conversationId) {
        chatService.closeConversation(conversationId);
    }

    @GetMapping("/conversations")
    public List<ConversationResponse> getConversations() {
        return chatService.getConversations();
    }

    @GetMapping("/conversations/{conversationId}/messages")
    public List<MessageResponse> history(@PathVariable String conversationId) {
        return chatService.getMessages(conversationId);
    }
}