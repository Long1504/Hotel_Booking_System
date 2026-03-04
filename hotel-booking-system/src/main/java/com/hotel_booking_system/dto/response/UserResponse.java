package com.hotel_booking_system.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserResponse {
    private String userId;
    private String username;
    private String firstName;
    private String lastName;
    private String gender;
    private String email;
    private String phone;
    private String userStatus;
    private LocalDateTime createdAt;
    private LocalDateTime deletedAt;
    private Set<String> roles;
}
