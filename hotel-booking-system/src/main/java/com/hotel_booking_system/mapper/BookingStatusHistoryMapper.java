package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.BookingStatusHistoryResponse;
import com.hotel_booking_system.entity.BookingStatusHistory;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BookingStatusHistoryMapper {
    @Mapping(source = "changedBy.username", target = "changedBy")
    BookingStatusHistoryResponse toBookingStatusHistoryResponse(BookingStatusHistory bookingStatusHistory);
}
