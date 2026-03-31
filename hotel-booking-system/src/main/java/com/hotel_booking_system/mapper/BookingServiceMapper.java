package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.request.SendBookingEmailRequest;
import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.dto.response.BookingServiceResponse;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.entity.BookingService;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BookingServiceMapper {
    @Mapping(source = "service.serviceName", target = "serviceName")
    @Mapping(source = "service.serviceId", target = "serviceId")
    BookingServiceResponse toBookingServiceResponse(BookingService bookingService);
}
