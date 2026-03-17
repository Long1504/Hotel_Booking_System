package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.entity.Amenity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface AmenityMapper {
    Amenity toAmenity(CreateAmenityRequest createAmenityRequest);

    AmenityResponse toAmenityResponse(Amenity amenity);
}
