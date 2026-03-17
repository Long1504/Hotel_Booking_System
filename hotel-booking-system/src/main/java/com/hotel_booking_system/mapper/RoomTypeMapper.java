package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.entity.RoomType;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RoomTypeMapper {
    RoomType toRoomType(CreateRoomTypeRequest createRoomTypeRequest);

    RoomTypeResponse toRoomTypeResponse(RoomType roomType);
}
