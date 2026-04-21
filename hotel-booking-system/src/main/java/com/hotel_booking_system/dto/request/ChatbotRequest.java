package com.hotel_booking_system.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatbotRequest {
    @NotBlank(message = "Message không được để trống")
    @Size(min = 1, max = 5000, message = "Message phải từ 1 đến 5000 ký tự")
    private String message;
}
