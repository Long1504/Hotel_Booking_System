package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.ServiceSummaryResponse;
import com.hotel_booking_system.entity.Service;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ServiceMapper {
    ServiceSummaryResponse toServiceSummaryResponse(Service service);
}
