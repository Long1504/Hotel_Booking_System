package com.hotel_booking_system.service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.hotel_booking_system.dto.request.CreateRoomRequest;
import com.hotel_booking_system.dto.request.UpdateRoomRequest;
import com.hotel_booking_system.dto.response.RoomAvailableResponse;
import com.hotel_booking_system.dto.response.RoomResponse;
import com.hotel_booking_system.dto.response.RoomSummaryAvailableResponse;
import com.hotel_booking_system.dto.response.RoomSummaryResponse;
import com.hotel_booking_system.entity.*;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.RoomMapper;
import com.hotel_booking_system.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomService {
    private final RoomRepository roomRepository;
    private final PriceRuleRepository priceRuleRepository;
    private final RoomImageRepository roomImageRepository;
    private final RoomTypeRepository roomTypeRepository;
    private final AmenityRepository amenityRepository;
    private final ViewRepository viewRepository;
    private final RoomMapper roomMapper;
    private final Cloudinary cloudinary;

    // Admin
    public Page<RoomSummaryResponse> getAllRooms(String roomTypeId,
                                                 String viewId,
                                                 String roomStatus,
                                                 String roomName,
                                                 Pageable pageable) {
        return roomRepository.findAll(roomTypeId, viewId, roomStatus, roomName, pageable)
                .map(room -> roomMapper.toRoomSummaryResponse(room));
    }

    // Admin
    public RoomResponse getRoom(String roomId) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_NOT_FOUND));
        return roomMapper.toRoomResponse(room);
    }

    @Transactional
    public RoomResponse createRoom(CreateRoomRequest request,
                                   MultipartFile mainImage,
                                   List<MultipartFile> subImages) {
        if (mainImage == null || mainImage.isEmpty()) {
            throw new AppException(ErrorCode.MAIN_IMAGE_REQUIRED);
        }

        if (subImages != null && subImages.size() > 5) {
            throw new AppException(ErrorCode.TOO_MANY_SUB_IMAGES);
        }

        RoomType roomType = roomTypeRepository.findById(request.getRoomTypeId())
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_TYPE_NOT_FOUND));

        View view = viewRepository.findById(request.getViewId())
                .orElseThrow(() -> new AppException(ErrorCode.VIEW_NOT_FOUND));

        if (roomRepository.existsRoomByRoomNumber(request.getRoomNumber())) {
            throw new AppException(ErrorCode.ROOM_NUMBER_ALREADY_EXISTS);
        }

        Set<Amenity> amenities = new HashSet<>();

        if (request.getAmenityIds() != null && !request.getAmenityIds().isEmpty()) {
            amenities = new HashSet<>(amenityRepository.findAllById(request.getAmenityIds()));
        }

        Room room = Room.builder()
                .roomName(request.getRoomName())
                .roomNumber(request.getRoomNumber())
                .floor(request.getFloor())
                .basePrice(request.getBasePrice())
                .maxAdults(request.getMaxAdults())
                .maxChildren(request.getMaxChildren())
                .area(request.getArea())
                .description(request.getDescription())
                .roomStatus(request.getRoomStatus())
                .roomType(roomType)
                .view(view)
                .amenities(amenities)
                .build();

        room = roomRepository.save(room);

        uploadImage(mainImage, room, true);

        for (MultipartFile subImage : subImages) {
            if (!subImage.isEmpty()) {
                uploadImage(subImage, room, false);
            }
        }

        return roomMapper.toRoomResponse(room);
    }

    @Transactional
    public RoomResponse updateRoom(String roomId,
                                   UpdateRoomRequest request,
                                   MultipartFile mainImage,
                                   List<MultipartFile> subImages) {

        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_NOT_FOUND));

        if (!room.getRoomNumber().equals(request.getRoomNumber()) && roomRepository.existsRoomByRoomNumber(request.getRoomNumber())) {
            throw new AppException(ErrorCode.ROOM_NUMBER_ALREADY_EXISTS);
        }

        RoomType roomType = roomTypeRepository.findById(request.getRoomTypeId())
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_TYPE_NOT_FOUND));

        View view = viewRepository.findById(request.getViewId())
                .orElseThrow(() -> new AppException(ErrorCode.VIEW_NOT_FOUND));

        room.setRoomName(request.getRoomName());
        room.setRoomNumber(request.getRoomNumber());
        room.setFloor(request.getFloor());
        room.setBasePrice(request.getBasePrice());
        room.setMaxAdults(request.getMaxAdults());
        room.setMaxChildren(request.getMaxChildren());
        room.setArea(request.getArea());
        room.setDescription(request.getDescription());
        room.setRoomStatus(request.getRoomStatus());
        room.setRoomType(roomType);
        room.setView(view);

        if (request.getAmenityIds() != null) {
            Set<Amenity> amenities = new HashSet<>(amenityRepository.findAllById(request.getAmenityIds()));
            room.setAmenities(amenities);
        }

        if (request.getDeleteImageIds() != null && !request.getDeleteImageIds().isEmpty()) {
            for (String imageId : request.getDeleteImageIds()) {
                roomImageRepository.findById(imageId).ifPresent(this::deleteImageFromCloudinary);
            }
        }

        if (mainImage != null && !mainImage.isEmpty()) {
            roomImageRepository.findByRoomAndIsMainTrue(room)
                    .ifPresent(this::deleteImageFromCloudinary);
            uploadImage(mainImage, room, true);
        }

        if (subImages != null && !subImages.isEmpty()) {
//            long currentSubImagesCount = roomImageRepository.countByRoomAndIsMainFalse(room);
//            if (currentSubImagesCount + subImages.size() > 5) {
//                throw new AppException(ErrorCode.TOO_MANY_SUB_IMAGES);
//            }

            for (MultipartFile subImage : subImages) {
                if (!subImage.isEmpty()) {
                    uploadImage(subImage, room, false);
                }
            }
        }

        return roomMapper.toRoomResponse(roomRepository.save(room));
    }

    // Hàm hỗ trợ xóa ảnh trên Cloudinary và Database
    private void deleteImageFromCloudinary(RoomImage image) {
        try {
            if (image.getPublicId() != null && !image.getPublicId().isBlank()) {
                cloudinary.uploader().destroy(
                        image.getPublicId(),
                        ObjectUtils.emptyMap()
                );
            }
            roomImageRepository.delete(image);
//            cloudinary.uploader().destroy(image.getPublicId(), ObjectUtils.emptyMap());
//            roomImageRepository.delete(image);
        } catch (IOException e) {
            throw new AppException(ErrorCode.DELETE_IMAGE_FAILED);
        }
    }

    private void uploadImage(MultipartFile file, Room room, boolean isMain) {
        try {
            if (file.getContentType() == null || !file.getContentType().startsWith("image/")) {
                throw new AppException(ErrorCode.INVALID_IMAGE_FILE);
            }

            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();

            Map uploadResult = cloudinary.uploader().upload(
                    file.getBytes(),
                    ObjectUtils.asMap(
                            "public_id", "rooms/" + room.getRoomId() + "/" + fileName
                    )
            );

            RoomImage image = RoomImage.builder()
                    .imageUrl(uploadResult.get("secure_url").toString())
                    .publicId(uploadResult.get("public_id").toString())
                    .isMain(isMain)
                    .room(room)
                    .build();

            roomImageRepository.save(image);

        } catch (IOException e) {
            throw new AppException(ErrorCode.UPLOAD_IMAGE_FAILED);
        }
    }

    // Customer, Receptionist
    public Page<RoomSummaryAvailableResponse> getAllAvailableRooms(LocalDate checkInDate,
                                                                   LocalDate checkOutDate,
                                                                   Integer adults,
                                                                   Integer children,
                                                                   String roomTypeId,
                                                                   String viewId,
                                                                   Pageable pageable) {
        if (!checkOutDate.isAfter(checkInDate)) {
            throw new AppException(ErrorCode.INVALID_DATE_RANGE);
        }

        Page<Room> roomPage = roomRepository.findAllAvailableRooms(
                checkInDate,
                checkOutDate,
                adults,
                children,
                roomTypeId,
                viewId,
                pageable
        );

        long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);

        Map<LocalDate, BigDecimal> priceMap = buildPriceMap(checkInDate, checkOutDate);

        return roomPage.map(room -> {
            BigDecimal totalPrice = calculateTotalPrice(room.getBasePrice(), checkInDate, checkOutDate, priceMap);

            RoomSummaryAvailableResponse response = roomMapper.toRoomSummaryDisplayResponse(room);

            response.setNights(nights);
            response.setFinalPrice(totalPrice);

            return response;
        });
    }

    public RoomAvailableResponse getRoomAvailable(String roomId,
                                                  LocalDate checkInDate,
                                                  LocalDate checkOutDate) {
        if (!checkOutDate.isAfter(checkInDate)) {
            throw new AppException(ErrorCode.INVALID_DATE_RANGE);
        }

        Room room = roomRepository.findAvailableRoomById(roomId, checkInDate, checkOutDate)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_NOT_AVAILABLE));

        long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);

        Map<LocalDate, BigDecimal> priceMap = buildPriceMap(checkInDate, checkOutDate);

        BigDecimal totalPrice = calculateTotalPrice(
                room.getBasePrice(),
                checkInDate,
                checkOutDate,
                priceMap
        );

        RoomAvailableResponse response = roomMapper.toRoomAvailableResponse(room);

        response.setNights(nights);
        response.setFinalPrice(totalPrice);

        return response;
    }

    public RoomResponse deleteRoom(String roomId) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_NOT_FOUND));

        room.setDeletedAt(LocalDateTime.now());

        room = roomRepository.save(room);

        return roomMapper.toRoomResponse(room);
    }

    private Map<LocalDate, BigDecimal> buildPriceMap(LocalDate checkInDate, LocalDate checkOutDate) {
        List<PriceRule> rules = priceRuleRepository.findRulesInRange(checkInDate, checkOutDate);

        Map<LocalDate, BigDecimal> priceMap = new HashMap<>();

        for (PriceRule rule : rules) {
            LocalDate startDate = rule.getStartDate().isBefore(checkInDate)
                    ? checkInDate
                    : rule.getStartDate();

            LocalDate endDate = rule.getEndDate().isAfter(checkOutDate)
                    ? checkOutDate.minusDays(1)
                    : rule.getEndDate();

            LocalDate date = startDate;

            while (!date.isAfter(endDate)) {
                priceMap.put(date, rule.getPriceMultiplier());
                date = date.plusDays(1);
            }
        }

        return priceMap;
    }

    private BigDecimal calculateTotalPrice(BigDecimal basePrice,
                                           LocalDate checkInDate,
                                           LocalDate checkOutDate,
                                           Map<LocalDate, BigDecimal> priceMap) {
        BigDecimal totalPrice = BigDecimal.ZERO;

        LocalDate date = checkInDate;

        while (date.isBefore(checkOutDate)) {
            BigDecimal multiplier = priceMap.getOrDefault(date, BigDecimal.ONE);

            totalPrice = totalPrice.add(basePrice.multiply(multiplier));

            date = date.plusDays(1);
        }

        return totalPrice;
    }
}
