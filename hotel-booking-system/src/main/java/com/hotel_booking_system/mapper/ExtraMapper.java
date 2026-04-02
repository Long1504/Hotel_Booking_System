package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.BookingServiceResponse;
import com.hotel_booking_system.dto.response.ExtraResponse;
import com.hotel_booking_system.entity.BookingService;
import com.hotel_booking_system.entity.Extra;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ExtraMapper {
    ExtraResponse toExtraResponse(Extra extra);
}
