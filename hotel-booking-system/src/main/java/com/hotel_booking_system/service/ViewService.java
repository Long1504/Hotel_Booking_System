package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.response.ViewResponse;
import com.hotel_booking_system.mapper.ViewMapper;
import com.hotel_booking_system.repository.ViewRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ViewService {
    private final ViewRepository viewRepository;
    private final ViewMapper viewMapper;
    // Customer
    public List<ViewResponse> getAllViews() {
        return viewRepository.findAllByDeletedAtIsNull()
                .stream()
                .map(view -> viewMapper.toViewResponse(view))
                .toList();
    }
}
