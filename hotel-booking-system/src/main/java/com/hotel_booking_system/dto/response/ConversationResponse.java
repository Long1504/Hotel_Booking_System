package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConversationResponse {
    private String conversationId;
    private String customerUsername; // Chat Owner
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;

    private String lastMessage;
    private LocalDateTime lastMessageTime;
    private Boolean hasNewMessage;
}
