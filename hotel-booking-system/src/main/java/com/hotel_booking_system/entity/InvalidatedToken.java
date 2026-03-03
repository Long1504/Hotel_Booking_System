package com.hotel_booking_system.entity;

import jakarta.persistence.Id;
import lombok.Builder;

import java.util.Date;

@Builder
public class InvalidatedToken {
    @Id
    private String id;
    private Date expiryTime;
}
