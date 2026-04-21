package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatbotResponse {
    private String type;
    private String content;
    private LocalDateTime timestamp;
    private String conversationId;
}
