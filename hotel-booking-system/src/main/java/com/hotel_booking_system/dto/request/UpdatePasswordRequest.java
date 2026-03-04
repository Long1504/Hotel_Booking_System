package com.hotel_booking_system.dto.request;

import lombok.*;

import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdatePasswordRequest {
    private String currentPassword;
    private String newPassword;
}
