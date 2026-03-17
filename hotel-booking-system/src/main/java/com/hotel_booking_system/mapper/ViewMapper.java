package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.request.CreateViewRequest;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.dto.response.ViewResponse;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.entity.View;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ViewMapper {

    View toView(CreateViewRequest createViewRequest);

    ViewResponse toViewResponse(View view);
}
