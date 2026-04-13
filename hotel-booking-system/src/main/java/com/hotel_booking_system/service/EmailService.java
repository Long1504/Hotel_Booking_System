package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.SendBookingEmailRequest;
import com.hotel_booking_system.dto.response.BookingServiceResponse;
import com.hotel_booking_system.dto.response.ExtraResponse;
import com.hotel_booking_system.enums.BookingStatus;
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
import java.util.List;
import java.util.Locale;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailService {
    private final JavaMailSender mailSender;

    @Async
    public void sendEmailBookingInfo(SendBookingEmailRequest request) {
        try {
            String checkIn = formatDate(request.getCheckInDate());
            String checkOut = formatDate(request.getCheckOutDate());
            String createdDate = formatDateTime(request.getCreatedAt());
            String roomPrice = formatPrice(request.getRoomPrice());
            String bookingStatus = formatBookingStatus(request.getBookingStatus());
            String paymentMethod = formatPaymentMethod(request.getPaymentMethod());
            String paymentInfo = formatPaymentInfo(request.getPaymentStatus(), request.getPaidAt());

            MimeMessage message = mailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            String subject = "Khách sạn Azure - Thông tin đặt phòng [" + request.getBookingCode() + "]";

            if (request.getBookingStatus().equals(BookingStatus.PENDING.name())) {
                subject = "Khách sạn Azure - Thông tin đặt phòng [" + request.getBookingCode() + "]";
            } else if (request.getBookingStatus().equals(BookingStatus.CONFIRMED.name())) {
                subject = "Khách sạn Azure - Đã xác nhận đặt phòng [" + request.getBookingCode() + "]";
            } else if (request.getBookingStatus().equals(BookingStatus.CHECKED_IN.name())) {
                subject = "Khách sạn Azure - Đã nhận phòng [" + request.getBookingCode() + "]";
            } else if (request.getBookingStatus().equals(BookingStatus.CHECKED_OUT.name())) {
                subject = "Khách sạn Azure - Đã trả phòng [" + request.getBookingCode() + "]";

            } else if (request.getBookingStatus().equals(BookingStatus.CANCELLED.name())) {
                subject = "Khách sạn Azure - Đã hủy phòng [" + request.getBookingCode() + "]";
            }

            String servicesHtml = "";
            String extrasHtml = "";
            boolean isCheckedOut = BookingStatus.CHECKED_OUT.name().equals(request.getBookingStatus());
            if (isCheckedOut) {
                servicesHtml = formatServices(request.getBookingServices());
                extrasHtml = formatExtras(request.getExtras());
            }

            String totalPrice = formatPrice(request.getTotalPrice());

            helper.setTo(request.getGuestEmail());
            helper.setSubject(subject);

            String htmlContent =
                            "<div style='font-family:Arial,Helvetica,sans-serif;background:#f4f6f8;padding:20px'>" +

                            "<div style='max-width:700px;margin:auto;background:#ffffff;border-radius:8px;overflow:hidden'>" +

                            "<div style='background:#2c3e50;color:white;padding:20px;text-align:center'>" +
                            "<h2 style='margin:0'>THÔNG TIN ĐẶT PHÒNG</h2>" +
                            "</div>" +

                            "<div style='padding:24px'>" +

                            "<p>Xin chào <b>" + request.getGuestName() + "</b>,</p>" +
                            "<p>Cảm ơn bạn đã đặt phòng tại <b>Khách sạn Azure</b>. Dưới đây là thông tin chi tiết đặt phòng của bạn.</p>" +

                            "<h3 style='color:#2c3e50;margin-top:24px'>Thông tin đặt phòng</h3>" +

                            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Mã đặt phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'><b>" + request.getBookingCode() + "</b></td>" +
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
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + paymentInfo + "</td>" +
                            "</tr>" +

                            "</table>" +

                            "<h3 style='color:#2c3e50;margin-top:28px'>Thông tin khách</h3>" +

                            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tên khách</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getGuestName() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số điện thoại</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getGuestPhone() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Email</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getGuestEmail() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số người lớn</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getAdults() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số trẻ em</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getChildren() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Ghi chú</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getNote() + "</td>" +
                            "</tr>" +

                            "</table>" +

                            "<h3 style='color:#2c3e50;margin-top:28px'>Thông tin phòng</h3>" +

                            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tên phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getRoom().getRoomName() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tầng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getRoom().getFloor() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Số phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getRoom().getRoomNumber() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Diện tích</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getRoom().getArea() + "m²</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Loại phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getRoom().getRoomTypeName() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>View</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + request.getRoom().getViewName() + "</td>" +
                            "</tr>" +

                            "<tr>" +
                            "<td width='180' style='padding:8px;border-bottom:1px solid #eee;font-weight:500'>Tiền phòng</td>" +
                            "<td style='padding:8px;border-bottom:1px solid #eee'>" + roomPrice + " VNĐ</td>" +
                            "</tr>" +

                            "</table>" +

                            "<div style='margin-top:24px;text-align:center'>" +
                            "<img src='" + request.getRoom().getMainImageUrl() + "' style='max-width:100%;border-radius:8px'>" +
                            "</div>" +

                            (isCheckedOut
                                ?
                                "<h3 style='color:#2c3e50;margin-top:28px'>Dịch vụ sử dụng</h3>" + servicesHtml +

                                "<h3 style='color:#2c3e50;margin-top:28px'>Phụ phí phát sinh</h3>" + extrasHtml +

                                "<div style='margin-top:24px;padding:16px;background:#f1f5f9;border-radius:6px;text-align:center'>" +
                                "<h2 style='color:#e74c3c;margin:0'>Tổng tiền: " + totalPrice + " VNĐ</h2>" +
                                "</div>"
                                :
                                "") +

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

            log.info("Email booking sent to {}", request.getGuestEmail());

        } catch (Exception e) {

            log.error("Lỗi khi gửi email: ", e);

        }

    }

    private String formatDate(LocalDate date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return date != null ? date.format(formatter) : "";
    }

    private String formatDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");
        return dateTime != null ? dateTime.format(formatter) : "";
    }

    private String formatPrice(BigDecimal price) {
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return price != null ? formatter.format(price) : "0";
    }

    private String formatBookingStatus(String status) {
        return switch (status) {
            case "PENDING" -> "Chờ xác nhận";
            case "CONFIRMED" -> "Đã xác nhận";
            case "CANCELLED" -> "Đã hủy";
            case "CHECKED_IN" -> "Đã nhận phòng";
            case "CHECKED_OUT" -> "Đã trả phòng";
            default -> "Không xác định";
        };
    }

    private String formatPaymentMethod(String status) {
        return switch (status) {
            case "CASH" -> "Tiền mặt";
            case "VNPAY" -> "VNPay";
            default -> "Không xác định";
        };
    }

    private String formatPaymentInfo(String status, LocalDateTime paidAt) {
        String statusText = switch (status) {
            case "PAID" -> "Đã thanh toán";
            case "UNPAID" -> "Chưa thanh toán";
            default -> "Không xác định";
        };

        if ("PAID".equals(status) && paidAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");
            return statusText + " (" + paidAt.format(formatter) + ")";
        }

        return statusText;
    }

    private String formatServices(List<BookingServiceResponse> bookingServices) {
        if (bookingServices == null || bookingServices.isEmpty()) {
            return "<p>Không có dịch vụ sử dụng</p>";
        }

        BigDecimal servicePrice = BigDecimal.ZERO;

        StringBuilder sb = new StringBuilder();

        sb
                .append("<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>")
                .append("<tr>")
                .append("<th style='padding:8px;border-bottom:1px solid #eee;font-weight:500;text-align:left;background:#f9fafb'>Dịch vụ</th>")
                .append("<th style='padding:8px;border-bottom:1px solid #eee;font-weight:500;text-align:center;background:#f9fafb'>SL</th>")
                .append("<th style='padding:8px;border-bottom:1px solid #eee;font-weight:500;text-align:right;background:#f9fafb'>Đơn giá</th>")
                .append("<th style='padding:8px;border-bottom:1px solid #eee;font-weight:500;text-align:right;background:#f9fafb'>Thành tiền</th>")
                .append("</tr>");

        for (var bs : bookingServices) {
            servicePrice = servicePrice.add(bs.getTotalPrice());

            sb
                    .append("<tr>")
                    .append("<td style='padding:8px;border-bottom:1px solid #eee'>").append(bs.getServiceName()).append("</td>")
                    .append("<td style='padding:8px;border-bottom:1px solid #eee;text-align:center'>").append(bs.getQuantity()).append("</td>")
                    .append("<td style='padding:8px;border-bottom:1px solid #eee;text-align:right'>").append(formatPrice(bs.getUnitPrice())).append("</td>")
                    .append("<td style='padding:8px;border-bottom:1px solid #eee;text-align:right'>").append(formatPrice(bs.getTotalPrice())).append("</td>")
                    .append("</tr>");
        }

        sb.append("</table>");

        sb.append("<div style='margin-top:8px;text-align:right;font-weight:600;color:#e74c3c'>")
                .append("Tổng dịch vụ: ")
                .append(formatPrice(servicePrice))
                .append(" VNĐ</div>");

        return sb.toString();
    }

    private String formatExtras(List<ExtraResponse> extras) {
        if (extras == null || extras.isEmpty()) {
            return "<p>Không có phụ phí</p>";
        }

        BigDecimal extraPrice = BigDecimal.ZERO;

        StringBuilder sb = new StringBuilder();

        sb
                .append("<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse'>")
                .append("<tr>")
                .append("<th style='padding:8px;border-bottom:1px solid #eee;font-weight:500;text-align:left;background:#f9fafb'>Nội dung</th>")
                .append("<th style='padding:8px;border-bottom:1px solid #eee;font-weight:500;text-align:right;background:#f9fafb'>Số tiền</th>")
                .append("</tr>");

        for (var e : extras) {
            extraPrice = extraPrice.add(e.getAmount());

            sb
                    .append("<tr>")
                    .append("<td style='padding:8px;border-bottom:1px solid #eee'>")
                    .append(e.getNote() == null ? "Không có ghi chú" : e.getNote())
                    .append("</td>")
                    .append("<td style='padding:8px;border-bottom:1px solid #eee;text-align:right'>")
                    .append(formatPrice(e.getAmount()))
                    .append("</td>")
                    .append("</tr>");
        }

        sb.append("</table>");

        sb.append("</table>");

        sb.append("<div style='margin-top:8px;text-align:right;font-weight:600;color:#e74c3c'>")
                .append("Tổng phụ phí: ")
                .append(formatPrice(extraPrice))
                .append(" VNĐ</div>");

        return sb.toString();
    }

}