package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.CreatePriceRuleRequest;
import com.hotel_booking_system.dto.request.CreateRoomTypeRequest;
import com.hotel_booking_system.dto.request.UpdatePriceRuleRequest;
import com.hotel_booking_system.dto.request.UpdateRoomTypeRequest;
import com.hotel_booking_system.dto.response.PriceRuleResponse;
import com.hotel_booking_system.dto.response.RoomTypeResponse;
import com.hotel_booking_system.entity.PriceRule;
import com.hotel_booking_system.entity.RoomType;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.PriceRuleMapper;
import com.hotel_booking_system.mapper.RoomTypeMapper;
import com.hotel_booking_system.repository.PriceRuleRepository;
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
public class PriceRuleService {
    private final PriceRuleRepository priceRuleRepository;
    private final PriceRuleMapper priceRuleMapper;

    public Page<PriceRuleResponse> getAllPriceRules(Boolean isActive, String priceRuleName, Pageable pageable) {
        return priceRuleRepository.findAll(isActive, priceRuleName, pageable)
                .map(priceRule -> priceRuleMapper.toPriceRuleResponse(priceRule));
    }

    public PriceRuleResponse createPriceRule(CreatePriceRuleRequest request) {
        if (priceRuleRepository.existsByPriceRuleName(request.getPriceRuleName())) {
            throw new AppException(ErrorCode.PRICE_RULE_ALREADY_EXISTS);
        }

        if (request.getStartDate().isAfter(request.getEndDate())) {
            throw new AppException(ErrorCode.INVALID_DATE_RANGE);
        }

        if (priceRuleRepository.existsOverlappingDate(request.getStartDate(), request.getEndDate())) {
            throw new AppException(ErrorCode.PRICE_RULE_DATE_OVERLAP);
        }

        PriceRule priceRule = priceRuleMapper.toPriceRule(request);

        priceRule = priceRuleRepository.save(priceRule);

        return priceRuleMapper.toPriceRuleResponse(priceRule);
    }

    public PriceRuleResponse updatePriceRule(String priceRuleId, UpdatePriceRuleRequest request) {

        PriceRule priceRule = priceRuleRepository.findById(priceRuleId)
                .orElseThrow(() -> new AppException(ErrorCode.PRICE_RULE_NOT_FOUND));

        if (priceRuleRepository.existsByPriceRuleName(request.getPriceRuleName())
                && !priceRule.getPriceRuleName().equals(request.getPriceRuleName())) {
            throw new AppException(ErrorCode.PRICE_RULE_ALREADY_EXISTS);
        }

        if (request.getStartDate().isAfter(request.getEndDate())) {
            throw new AppException(ErrorCode.INVALID_DATE_RANGE);
        }

        boolean isDateChanged =
                !priceRule.getStartDate().equals(request.getStartDate()) ||
                        !priceRule.getEndDate().equals(request.getEndDate());

        if (isDateChanged && priceRuleRepository.existsOverlappingDate(request.getStartDate(), request.getEndDate())) {
            throw new AppException(ErrorCode.PRICE_RULE_DATE_OVERLAP);
        }

        priceRule.setPriceRuleName(request.getPriceRuleName());
        priceRule.setStartDate(request.getStartDate());
        priceRule.setEndDate(request.getEndDate());
        priceRule.setPriceMultiplier(request.getPriceMultiplier());
        priceRule.setIsActive(request.getIsActive());

        priceRule = priceRuleRepository.save(priceRule);

        return priceRuleMapper.toPriceRuleResponse(priceRule);
    }

    public void deletePriceRule(String priceRuleId) {
        PriceRule priceRule = priceRuleRepository.findById(priceRuleId)
                .orElseThrow(() -> new AppException(ErrorCode.PRICE_RULE_NOT_FOUND));

        priceRuleRepository.delete(priceRule);
    }

    public PriceRuleResponse togglePriceRule(String priceRuleId) {

        PriceRule priceRule = priceRuleRepository.findById(priceRuleId)
                .orElseThrow(() -> new AppException(ErrorCode.PRICE_RULE_NOT_FOUND));

        priceRule.setIsActive(!priceRule.getIsActive());

        priceRule = priceRuleRepository.save(priceRule);

        return priceRuleMapper.toPriceRuleResponse(priceRule);
    }
}
