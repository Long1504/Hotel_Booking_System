package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.entity.Booking;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = {BookingStatusHistoryMapper.class, RoomMapper.class})
public interface BookingMapper {
    BookingResponse toBookingResponse(Booking booking);
}
