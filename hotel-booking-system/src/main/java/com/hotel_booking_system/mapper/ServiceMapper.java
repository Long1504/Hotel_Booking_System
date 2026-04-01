package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.CreateServiceRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.dto.response.ServiceResponse;
import com.hotel_booking_system.dto.response.ServiceSummaryResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Service;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ServiceMapper {
    ServiceSummaryResponse toServiceSummaryResponse(Service service);

    ServiceResponse toServiceResponse(Service service);


    Service toService(CreateServiceRequest createServiceRequest);
}
