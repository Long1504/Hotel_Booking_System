package com.hotel_booking_system.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomImageResponse {
    private String roomImageId;
    private String imageUrl;
    private Boolean isMain;
}
