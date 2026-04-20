package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.MessageResponse;
import com.hotel_booking_system.entity.Message;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface MessageMapper {
    MessageResponse toMessageResponse(Message message);

    List<MessageResponse> toMessageResponses(List<Message> messages);
}