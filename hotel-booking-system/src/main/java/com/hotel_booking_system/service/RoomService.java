package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.response.RoomResponse;
import com.hotel_booking_system.mapper.RoomMapper;
import com.hotel_booking_system.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomService {
    private final RoomRepository roomRepository;
    private final RoomMapper roomMapper;

    public Page<RoomResponse> getAllRooms(Pageable pageable) {
        return roomRepository.findAll(pageable)
                .map(room -> roomMapper.toRoomResponse(room));
    }
}
