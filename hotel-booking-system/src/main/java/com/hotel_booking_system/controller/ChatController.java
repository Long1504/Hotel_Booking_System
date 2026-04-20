package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.SendMessageRequest;
import com.hotel_booking_system.dto.response.ConversationResponse;
import com.hotel_booking_system.dto.response.MessageResponse;
import com.hotel_booking_system.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@Controller
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class ChatController {
    private final ChatService chatService;
    private final SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/chat.send")
    public void sendMessage(SendMessageRequest request) {

        // Lưu tin nhắn
        MessageResponse messageResponse = chatService.saveMessage(request);

        // Gửi tin nhắn realtime vào boxchat (cho những người đang mở boxchat)
        messagingTemplate.convertAndSend(
                "/topic/conversation/" + messageResponse.getConversationId(),
                messageResponse
        );

        // Cập nhật sidebar realtime (chỉ gửi cho những người thuộc hội thoại này)
        List<String> memberUsernames = chatService.getMemberUsernames(request.getConversationId());

        for (String username : memberUsernames) {
            messagingTemplate.convertAndSendToUser(
                    username,
                    "/topic/conversations",
                    chatService.getConversationsForUser(username)
            );
        }
    }
}
