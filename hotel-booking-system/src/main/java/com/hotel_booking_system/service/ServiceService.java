package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreateAmenityRequest;
import com.hotel_booking_system.dto.request.CreateServiceRequest;
import com.hotel_booking_system.dto.request.UpdateAmenityRequest;
import com.hotel_booking_system.dto.request.UpdateServiceRequest;
import com.hotel_booking_system.dto.response.AmenityResponse;
import com.hotel_booking_system.dto.response.ServiceResponse;
import com.hotel_booking_system.dto.response.ServiceSummaryResponse;
import com.hotel_booking_system.entity.Amenity;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.AmenityMapper;
import com.hotel_booking_system.mapper.ServiceMapper;
import com.hotel_booking_system.repository.AmenityRepository;
import com.hotel_booking_system.repository.ServiceRepository;
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
public class ServiceService {
    private final ServiceRepository serviceRepository;
    private final ServiceMapper serviceMapper;

    public List<ServiceSummaryResponse> getAllSummaryServices() {
        return serviceRepository.findAllByDeletedAtIsNull()
                .stream()
                .map(service -> serviceMapper.toServiceSummaryResponse(service))
                .toList();
    }

    public Page<ServiceResponse> getAllServices(String serviceName, Pageable pageable) {
        return serviceRepository.findAll(serviceName, pageable)
                .map(service -> serviceMapper.toServiceResponse(service));
    }

    public ServiceResponse createService(CreateServiceRequest request) {
        if (serviceRepository.existsByServiceName(request.getServiceName())) {
            throw new AppException(ErrorCode.SERVICE_ALREADY_EXISTS);
        }

        com.hotel_booking_system.entity.Service service = serviceMapper.toService(request);

        service = serviceRepository.save(service);

        return serviceMapper.toServiceResponse(service);
    }

    @Transactional
    public ServiceResponse updateService(String serviceId, UpdateServiceRequest request) {
        com.hotel_booking_system.entity.Service service = serviceRepository.findById(serviceId)
                .orElseThrow(() -> new AppException(ErrorCode.SERVICE_NOT_FOUND));

        if (!service.getServiceName().equals(request.getServiceName()) && serviceRepository.existsByServiceName(request.getServiceName())) {
            throw new AppException(ErrorCode.SERVICE_ALREADY_EXISTS);
        }

        service.setServiceName(request.getServiceName());
        service.setDescription(request.getDescription());
        service.setBasePrice(request.getBasePrice());

        service = serviceRepository.save(service);

        return serviceMapper.toServiceResponse(service);
    }

    public ServiceResponse deleteService(String serviceId) {
        com.hotel_booking_system.entity.Service service = serviceRepository.findById(serviceId)
                .orElseThrow(() -> new AppException(ErrorCode.SERVICE_NOT_FOUND));

        service.setDeletedAt(LocalDateTime.now());

        service = serviceRepository.save(service);

        return serviceMapper.toServiceResponse(service);
    }
}
