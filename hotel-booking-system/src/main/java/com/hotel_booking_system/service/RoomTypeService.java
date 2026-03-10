package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.mapper.RoomTypeMapper;
import com.hotel_booking_system.repository.RoomTypeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomTypeService {
    private final RoomTypeRepository roomTypeRepository;
    private final RoomTypeMapper roomTypeMapper;
    // Customer
    public List<RoomTypeResponse> getAllRoomTypes() {
        return roomTypeRepository.findAllByDeletedAtIsNull()
                .stream()
                .map(roomType -> roomTypeMapper.toRoomTypeResponse(roomType))
                .toList();
    }
}
