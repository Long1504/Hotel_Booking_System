package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.dto.response.ViewResponse;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.entity.View;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ViewMapper {
    ViewResponse toViewResponse(View view);
}
