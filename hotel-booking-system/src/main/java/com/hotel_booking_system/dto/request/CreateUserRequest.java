package com.hotel_booking_system.dto.request;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateUserRequest {
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String gender;
    private String email;
    private String phone;
    private Set<String> roles;
}
