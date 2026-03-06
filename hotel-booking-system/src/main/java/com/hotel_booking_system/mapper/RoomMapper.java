package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.response.RoomImageResponse;
import com.hotel_booking_system.dto.response.RoomResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.entity.RoomImage;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
public interface RoomMapper {
    @Mapping(source = "roomType.roomTypeName", target = "roomTypeName")
    @Mapping(source = "view.viewName", target = "viewName")
    @Mapping(source = "amenities", target = "amenities", qualifiedByName = "mapAmenities")
    RoomResponse toRoomResponse(Room room);
    @Named("mapAmenities")
    default Set<String> mapAmenities(Set<Amenity> amenities) {
        if (amenities == null)
            return null;
        return amenities.stream()
                .map(amenity -> amenity.getAmenityName())
                .collect(Collectors.toSet());
    }
}
