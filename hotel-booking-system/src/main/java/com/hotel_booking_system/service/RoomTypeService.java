package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.RoomTypeMapper;
import com.hotel_booking_system.repository.RoomTypeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomTypeService {
    private final RoomTypeRepository roomTypeRepository;
    private final RoomTypeMapper roomTypeMapper;
    // Customer
    public List<RoomTypeResponse> getAllSummaryRoomTypes() {
        return roomTypeRepository.findAllByDeletedAtIsNull()
                .stream()
                .map(roomType -> roomTypeMapper.toRoomTypeResponse(roomType))
                .toList();
    }

    public Page<RoomTypeResponse> getAllRoomTypes(String roomTypeName, Pageable pageable) {
        return roomTypeRepository.findAll(roomTypeName, pageable)
                .map(roomType -> roomTypeMapper.toRoomTypeResponse(roomType));
    }

    public RoomTypeResponse createRoomType(CreateRoomTypeRequest request) {
        if (roomTypeRepository.existsByRoomTypeName(request.getRoomTypeName())) {
            throw new AppException(ErrorCode.ROOM_TYPE_ALREADY_EXISTS);
        }

        RoomType roomType = roomTypeMapper.toRoomType(request);

        roomType = roomTypeRepository.save(roomType);

        return roomTypeMapper.toRoomTypeResponse(roomType);
    }

    @Transactional
    public RoomTypeResponse updateRoomType(String roomTypeId, UpdateRoomTypeRequest request) {
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_TYPE_NOT_FOUND));

        if (!roomType.getRoomTypeName().equals(request.getRoomTypeName()) && roomTypeRepository.existsByRoomTypeName(request.getRoomTypeName())) {
            throw new AppException(ErrorCode.ROOM_TYPE_ALREADY_EXISTS);
        }

        roomType.setRoomTypeName(request.getRoomTypeName());
        roomType.setDescription(request.getDescription());

        roomType = roomTypeRepository.save(roomType);

        return roomTypeMapper.toRoomTypeResponse(roomType);
    }

    public RoomTypeResponse deleteRoomType(String roomTypeId) {
        RoomType roomType = roomTypeRepository.findById(roomTypeId)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_TYPE_NOT_FOUND));

        roomType.setDeletedAt(LocalDateTime.now());

        roomType = roomTypeRepository.save(roomType);

        return roomTypeMapper.toRoomTypeResponse(roomType);
    }
}
