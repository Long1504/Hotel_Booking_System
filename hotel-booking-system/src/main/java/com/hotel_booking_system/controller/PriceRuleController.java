package com.hotel_booking_system.controller;

import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.ApiResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.service.RoomTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/price-rules")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class PriceRuleController {
    private final RoomTypeService roomTypeService;

    
}
