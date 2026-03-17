package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.CreateViewRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdateViewRequest;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.dto.response.ViewResponse;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.entity.View;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.ViewMapper;
import com.hotel_booking_system.repository.ViewRepository;
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
public class ViewService {
    private final ViewRepository viewRepository;
    private final ViewMapper viewMapper;
    // Customer
    public List<ViewResponse> getAllSummaryViews() {
        return viewRepository.findAllByDeletedAtIsNull()
                .stream()
                .map(view -> viewMapper.toViewResponse(view))
                .toList();
    }

    public Page<ViewResponse> getAllViews(String viewName, Pageable pageable) {
        return  viewRepository.findAll(viewName, pageable)
                .map(view -> viewMapper.toViewResponse(view));
    }

    public ViewResponse createView(CreateViewRequest request) {
        if (viewRepository.existsByViewName(request.getViewName())) {
            throw new AppException(ErrorCode.VIEW_ALREADY_EXISTS);
        }

        View view = viewMapper.toView(request);

        view = viewRepository.save(view);

        return viewMapper.toViewResponse(view);
    }

    @Transactional
    public ViewResponse updateView(String viewId, UpdateViewRequest request) {
        View view = viewRepository.findById(viewId)
                .orElseThrow(() -> new AppException(ErrorCode.VIEW_NOT_FOUND));

        if (!view.getViewName().equals(request.getViewName()) && viewRepository.existsByViewName(request.getViewName())) {
            throw new AppException(ErrorCode.VIEW_ALREADY_EXISTS);
        }

        view.setViewName(request.getViewName());
        view.setDescription(request.getDescription());

        view = viewRepository.save(view);

        return viewMapper.toViewResponse(view);
    }

    public ViewResponse deleteView(String viewId) {
        View view = viewRepository.findById(viewId)
                .orElseThrow(() -> new AppException(ErrorCode.VIEW_NOT_FOUND));

        view.setDeletedAt(LocalDateTime.now());

        view = viewRepository.save(view);

        return viewMapper.toViewResponse(view);
    }
}
