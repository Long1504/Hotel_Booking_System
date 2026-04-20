package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.ConversationResponse;
import com.hotel_booking_system.entity.Conversation;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ConversationMapper {
    @Mapping(target = "lastMessage", ignore = true)
    @Mapping(target = "lastMessageTime", ignore = true)
    @Mapping(target = "hasNewMessage", ignore = true)
    ConversationResponse toConversationResponse(Conversation conversation);
}
