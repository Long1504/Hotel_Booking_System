package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.response.BookingResponse;
import com.hotel_booking_system.entity.Booking;
import com.hotel_booking_system.enums.BookingStatus;
import com.hotel_booking_system.enums.PaymentStatus;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.BookingMapper;
import com.hotel_booking_system.repository.BookingRepository;
import com.hotel_booking_system.util.VNPayUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class VNPayService {
    @Value("${vnpay.tmnCode}")
    private String vnp_TmnCode;

    @Value("${vnpay.hashSecret}")
    private String vnp_HashSecret;

    @Value("${vnpay.payUrl}")
    private String vnp_PayUrl;

    @Value("${vnpay.returnUrl}")
    private String vnp_ReturnUrl;

    private final EmailService emailService;

    private final BookingRepository bookingRepository;

    private final BookingMapper bookingMapper;

    public String createPaymentUrl(String bookingCode, BigDecimal amount) {
        try {
            Map<String, String> params = new HashMap<>();

            params.put("vnp_Version", "2.1.0");
            params.put("vnp_Command", "pay");
            params.put("vnp_TmnCode", vnp_TmnCode);

            params.put("vnp_Amount", String.valueOf(amount.multiply(BigDecimal.valueOf(100)).longValue()));

            params.put("vnp_CurrCode", "VND");

            params.put("vnp_TxnRef", bookingCode);
            params.put("vnp_OrderInfo", "Thanh toan dat phong");
            params.put("vnp_OrderType", "other");

            params.put("vnp_Locale", "vn");

            params.put("vnp_ReturnUrl", vnp_ReturnUrl);

            params.put("vnp_IpAddr", "127.0.0.1");

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));

            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            params.put("vnp_CreateDate", formatter.format(cld.getTime()));

            Calendar expire = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            expire.add(Calendar.MINUTE, 15);

            params.put("vnp_ExpireDate", formatter.format(expire.getTime()));

            List<String> fieldNames = new ArrayList<>(params.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();

            for (Iterator<String> it = fieldNames.iterator(); it.hasNext();) {
                String field = it.next();
                String value = params.get(field);

                if (value != null && !value.isEmpty()) {

                    String encodedValue = URLEncoder.encode(value, StandardCharsets.UTF_8);

                    hashData.append(field).append("=").append(encodedValue);
                    query.append(field).append("=").append(encodedValue);

                    if (it.hasNext()) {
                        hashData.append("&");
                        query.append("&");
                    }
                }
            }

            String secureHash = VNPayUtil.hmacSHA512(vnp_HashSecret, hashData.toString());

            query.append("&vnp_SecureHash=").append(secureHash);

            return vnp_PayUrl + "?" + query;

        } catch (Exception e) {
            throw new RuntimeException("VNPay create url error");
        }
    }

    public BookingResponse handleVNPayReturn(HttpServletRequest request) {
        Map<String, String> fields = new HashMap<>();

        Enumeration<String> paramNames = request.getParameterNames();

        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);

            if (paramValue != null && !paramValue.isEmpty()) {
                fields.put(paramName, paramValue);
            }
        }

        String secureHash = fields.remove("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");

        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();

        for (Iterator<String> it = fieldNames.iterator(); it.hasNext();) {
            String field = it.next();

            String value = URLEncoder.encode(fields.get(field), StandardCharsets.UTF_8);

            hashData.append(field).append("=").append(value);

            if (it.hasNext()) {
                hashData.append("&");
            }
        }

        String signValue = VNPayUtil.hmacSHA512(vnp_HashSecret, hashData.toString());

        if (!signValue.equals(secureHash)) {
            throw new AppException(ErrorCode.INVALID_VNPAY_SIGNATURE);
        }

        String responseCode = request.getParameter("vnp_ResponseCode");
        String bookingCode = request.getParameter("vnp_TxnRef");

        Booking booking = bookingRepository.findByBookingCode(bookingCode)
                .orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_FOUND));

        String vnpAmount = request.getParameter("vnp_Amount");

        BigDecimal amountFromVNPay = new BigDecimal(vnpAmount)
                .divide(BigDecimal.valueOf(100));

        if (booking.getTotalPrice().compareTo(amountFromVNPay) != 0) {
            throw new AppException(ErrorCode.INVALID_PAYMENT_AMOUNT);
        }

        if ("00".equals(responseCode)) {
            if (!PaymentStatus.PAID.name().equals(booking.getPaymentStatus())) {
                booking.setPaymentStatus(PaymentStatus.PAID.name());
                booking.setBookingStatus(BookingStatus.CONFIRMED.name());
                booking.setPaidAt(LocalDateTime.now());

                bookingRepository.save(booking);

                emailService.sendEmail(bookingMapper.toSendBookingEmailRequest(booking));
            }
            return bookingMapper.toBookingResponse(booking);
        }
        throw new AppException(ErrorCode.PAYMENT_FAILED);
    }
}
