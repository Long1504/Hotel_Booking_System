package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageResponse {
    private String messageId;
    private String conversationId;
    private String senderUsername;
    private String content;
    private LocalDateTime createdAt;
}
