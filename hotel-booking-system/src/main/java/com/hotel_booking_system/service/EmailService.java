package com.hotel_booking_system.service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailService {
    private final JavaMailSender mailSender;

    @Async
    public void sendEmail(String toEmail,
                          String bookingCode,
                          LocalDate checkInDate,
                          LocalDate checkOutDate,
                          String guestName,
                          String guestPhone,
                          String guestEmail,
                          Integer adults,
                          Integer children,
                          BigDecimal totalPrice,
                          LocalDateTime createdAt,
                          String bookingStatus,
                          String paymentMethod,
                          String paymentStatus,
                          String roomName,
                          Integer floor,
                          String roomNumber,
                          BigDecimal area,
                          String roomTypeName,
                          String viewName,
                          String mainImageUrl) {
        try {
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            String checkIn = checkInDate.format(dateFormatter);
            String checkOut = checkOutDate.format(dateFormatter);
            String createdDate = createdAt.format(dateTimeFormatter);

            NumberFormat priceFormatter = NumberFormat.getInstance(new Locale("vi", "VN"));

            String price = priceFormatter.format(totalPrice);

            MimeMessage message = mailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            String subject = "Khách sạn Azure - Thông tin đặt phòng [" + bookingCode + "]";

            helper.setTo(toEmail);
            helper.setSubject(subject);

            String htmlContent =
                            "<div style='font-family:Arial,Helvetica,sans-serif;background:#f4f6f8;padding:20px'>" +

                            "<div style='max-width:700px;margin:auto;background:#ffffff;border-radius:8px;overflow:hidden'>" +

                            "<div style='background:#2c3e50;color:white;padding:20px;text-align:center'>" +
                            "<h2 style='margin:0'>THÔNG TIN ĐẶT PHÒNG</h2>" +
                            "</div>" +

                            "<div style='padding:24px'>" +

                            "<p>Xin chào <b>" + guestName + "</b>,</p>" +
                            "<p>Cảm ơn bạn đã đặt phòng tại <b>Khách sạn Azure</b>. Dưới đây là thông tin chi tiết đặt phòng của bạn.</p>" +

                            "<h3 style='color:#2c3e50;margin-top:24px'>Thông tin đặt phòng</h3>" +

                            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Mã đặt phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'><b>" + bookingCode + "</b></td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Ngày nhận phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + checkIn + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Ngày trả phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + checkOut + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Thời gian đặt</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + createdDate + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Trạng thái đặt phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + bookingStatus + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Phương thức thanh toán</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + paymentMethod + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Trạng thái thanh toán</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + paymentStatus + "</td>" +
                            "</tr>" +

                            "</table>" +

                            "<h3 style='color:#2c3e50;margin-top:28px'>Thông tin khách</h3>" +

                            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tên khách</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + guestName + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số điện thoại</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + guestPhone + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Email</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + guestEmail + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số người lớn</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + adults + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số trẻ em</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + children + "</td>" +
                            "</tr>" +

                            "</table>" +

                            "<h3 style='color:#2c3e50;margin-top:28px'>Thông tin phòng</h3>" +

                            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tên phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + roomName + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tầng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + floor + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + roomNumber + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Diện tích</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + area + " m²</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Loại phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + roomTypeName + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>View</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + viewName + "</td>" +
                            "</tr>" +

                            "</table>" +

                            "<div style='margin-top:24px;text-align:center'>" +
                            "<img src='" + mainImageUrl + "' style='max-width:100%;border-radius:8px'>" +
                            "</div>" +

                            "<div style='margin-top:24px;padding:16px;background:#f1f5f9;border-radius:6px;text-align:center'>" +
                            "<h2 style='color:#e74c3c;margin:0'>Tổng tiền: " + price + " VND</h2>" +
                            "</div>" +

                            "<p style='margin-top:24px'>Chúng tôi rất mong được đón tiếp bạn!</p>" +
                            "<p><b>Khách sạn Azure</b></p>" +

                            "</div>" +

                            "<div style='background:#ecf0f1;padding:14px;text-align:center;font-size:12px;color:#555'>" +
                            "Email này được gửi tự động từ hệ thống đặt phòng của Khách sạn Azure." +
                            "</div>" +

                            "</div>" +
                            "</div>";

            helper.setText(htmlContent, true);

            mailSender.send(message);

            log.info("Email booking sent to {}", toEmail);

        } catch (Exception e) {

            log.error("Lỗi khi gửi email: ", e);

        }

    }

}