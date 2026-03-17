package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateAmenityRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.AmenityMapper;
import com.hotel_booking_system.mapper.RoomTypeMapper;
import com.hotel_booking_system.repository.AmenityRepository;
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
public class AmenityService {
    private final AmenityRepository amenityRepository;
    private final AmenityMapper amenityMapper;

    public Page<AmenityResponse> getAllAmenities(String amenityName, Pageable pageable) {
        return amenityRepository.findAll(amenityName, pageable)
                .map(amenity -> amenityMapper.toAmenityResponse(amenity));
    }

    public AmenityResponse createAmenity(CreateAmenityRequest request) {
        if (amenityRepository.existsByAmenityName(request.getAmenityName())) {
            throw new AppException(ErrorCode.AMENITY_ALREADY_EXISTS);
        }

        Amenity amenity = amenityMapper.toAmenity(request);

        amenity = amenityRepository.save(amenity);

        return amenityMapper.toAmenityResponse(amenity);
    }

    @Transactional
    public AmenityResponse updateAmenity(String amenityId, UpdateAmenityRequest request) {
        Amenity amenity = amenityRepository.findById(amenityId)
                .orElseThrow(() -> new AppException(ErrorCode.AMENITY_NOT_FOUND));

        if (!amenity.getAmenityName().equals(request.getAmenityName()) && amenityRepository.existsByAmenityName(request.getAmenityName())) {
            throw new AppException(ErrorCode.AMENITY_ALREADY_EXISTS);
        }

        amenity.setAmenityName(request.getAmenityName());
        amenity.setDescription(request.getDescription());

        amenity = amenityRepository.save(amenity);

        return amenityMapper.toAmenityResponse(amenity);
    }

    public AmenityResponse deleteAmenity(String amenityId) {
        Amenity amenity = amenityRepository.findById(amenityId)
                .orElseThrow(() -> new AppException(ErrorCode.AMENITY_NOT_FOUND));

        amenity.setDeletedAt(LocalDateTime.now());

        amenity = amenityRepository.save(amenity);

        return amenityMapper.toAmenityResponse(amenity);
    }
}
