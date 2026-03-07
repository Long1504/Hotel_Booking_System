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
    public List<RoomSummaryAvailableResponse> getAllAvailableRooms(LocalDate checkInDate, LocalDate checkOutDate) {
        if (!checkOutDate.isAfter(checkInDate)) {
            throw new IllegalArgumentException("Check-out must be after check-in");
        }

        List<Room> rooms = roomRepository.findAllAvailableRooms(checkInDate, checkOutDate);

        List<PriceRule> rules = priceRuleRepository.findRulesInRange(checkInDate, checkOutDate);

        long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);

        Map<LocalDate, BigDecimal> priceMap = new HashMap<>();

        for (PriceRule rule : rules) {
            LocalDate date = rule.getStartDate().isBefore(checkInDate)
                    ? checkInDate
                    : rule.getStartDate();

            LocalDate end = rule.getEndDate().isAfter(checkOutDate)
                    ? checkOutDate.minusDays(1)
                    : rule.getEndDate();

            while (!date.isAfter(end)) {
                priceMap.put(date, rule.getPriceMultiplier());
                date = date.plusDays(1);
            }
        }

        List<RoomSummaryAvailableResponse> results = new ArrayList<>();

        for (Room room : rooms) {
            BigDecimal basePrice = room.getBasePrice();
            BigDecimal totalPrice = BigDecimal.ZERO;

            LocalDate date = checkInDate;

            while (date.isBefore(checkOutDate)) {
                BigDecimal multiplier = priceMap.getOrDefault(date, BigDecimal.ONE);

                BigDecimal dailyPrice = basePrice.multiply(multiplier);
                totalPrice = totalPrice.add(dailyPrice);

                date = date.plusDays(1);
            }

            RoomSummaryAvailableResponse response = roomMapper.toRoomSummaryDisplayResponse(room);

            response.setNights(nights);
            response.setFinalPrice(totalPrice);

            results.add(response);
        }

        return results;
    }

    public RoomAvailableResponse getRoomAvailable(String roomId, LocalDate checkInDate, LocalDate checkOutDate) {
        if (!checkOutDate.isAfter(checkInDate)) {
            throw new IllegalArgumentException("Check-out must be after check-in");
        }

        Room room = roomRepository.findAvailableRoomById(roomId, checkInDate, checkOutDate)
                .orElseThrow(() -> new RuntimeException("Room not available"));

        List<PriceRule> rules = priceRuleRepository.findRulesInRange(checkInDate, checkOutDate);

        long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);

        Map<LocalDate, BigDecimal> priceMap = new HashMap<>();

        for (PriceRule rule : rules) {
            LocalDate date = rule.getStartDate().isBefore(checkInDate)
                    ? checkInDate
                    : rule.getStartDate();

            LocalDate end = rule.getEndDate().isAfter(checkOutDate)
                    ? checkOutDate.minusDays(1)
                    : rule.getEndDate();

            while (!date.isAfter(end)) {
                priceMap.put(date, rule.getPriceMultiplier());
                date = date.plusDays(1);
            }
        }

        BigDecimal basePrice = room.getBasePrice();
        BigDecimal totalPrice = BigDecimal.ZERO;

        LocalDate date = checkInDate;

        while (date.isBefore(checkOutDate)) {
            BigDecimal multiplier = priceMap.getOrDefault(date, BigDecimal.ONE);

            totalPrice = totalPrice.add(basePrice.multiply(multiplier));

            date = date.plusDays(1);
        }

        RoomAvailableResponse response = roomMapper.toRoomAvailableResponse(room);

        response.setNights(nights);
        response.setFinalPrice(totalPrice);

        return response;
    }
}
