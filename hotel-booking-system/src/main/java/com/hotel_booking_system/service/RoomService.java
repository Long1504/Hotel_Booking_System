package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.response.RoomAvailableResponse;
import com.hotel_booking_system.dto.response.RoomResponse;
import com.hotel_booking_system.dto.response.RoomSummaryAvailableResponse;
import com.hotel_booking_system.dto.response.RoomSummaryResponse;
import com.hotel_booking_system.entity.PriceRule;
import com.hotel_booking_system.entity.Room;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.RoomMapper;
import com.hotel_booking_system.repository.PriceRuleRepository;
import com.hotel_booking_system.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoomService {
    private final RoomRepository roomRepository;
    private final PriceRuleRepository priceRuleRepository;
    private final RoomMapper roomMapper;

    // Admin
    public Page<RoomSummaryResponse> getAllRooms(Pageable pageable) {
        return roomRepository.findAllByDeletedAtIsNull(pageable)
                .map(room -> roomMapper.toRoomSummaryResponse(room));
    }

    // Admin
    public RoomResponse getRoom(String roomId) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new AppException(ErrorCode.ROOM_NOT_FOUND));
        return roomMapper.toRoomResponse(room);
    }

    // Customer
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
