package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.RoomImageResponse;
import com.hotel_booking_system.entity.RoomImage;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RoomImageMapper {
    RoomImageResponse toRoomImageResponse(RoomImage roomImage);
}
