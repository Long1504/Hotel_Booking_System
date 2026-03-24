package com.hotel_booking_system.controller;

import com.hotel_booking_system.service.CloudinaryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1/upload")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Cho phép FE gọi từ mọi domain
public class UploadController {
    private final CloudinaryService cloudinaryService;

    @PostMapping
    public String upload(@RequestParam("file") MultipartFile file) {
        return cloudinaryService.uploadFile(file);
    }
}
