package com.hotel_booking_system.entity;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ConversationMemberId {
    private String conversationId;
    private String username;
}
