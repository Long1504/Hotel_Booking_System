package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.response.*;
import com.hotel_booking_system.entity.*;
import com.hotel_booking_system.entity.BookingService;
import com.hotel_booking_system.enums.PaymentStatus;
import com.hotel_booking_system.mapper.RoomMapper;
import com.hotel_booking_system.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final RoomRepository roomRepository;
    private final BookingRepository bookingRepository;
    private final BookingServiceRepository bookingServiceRepository;
    private final ServiceRepository serviceRepository;
    private final RoomTypeRepository roomTypeRepository;

    private final RoomMapper roomMapper;

    public long getRoomCount() {
        return roomRepository.countActiveRooms();
    }

    public long getBookingCount(String type, LocalDate startDate, LocalDate endDate) {
        LocalDateTimeRange range = resolveDateTimeRange(type, startDate, endDate);

        return bookingRepository.countByCreatedAtBetween(range.start, range.end);
    }

    public double getOccupancyRate(String type, LocalDate startDate, LocalDate endDate) {

        LocalDateRange range = resolveDateRange(type, startDate, endDate);

        long totalRooms = roomRepository.countActiveRooms();
        if (totalRooms == 0) return 0.0;

        List<Booking> bookings = bookingRepository.findBookingsOverlap(range.start, range.end);

        long bookedRoomDays = calculateBookedRoomDays(bookings, range.start, range.end);

        long totalRoomDays = totalRooms * (range.end.toEpochDay() - range.start.toEpochDay() + 1);

        // Tỉ lệ lấp đầy = Số ngày phòng được sử dụng / Tổng số ngày * 100
        double rate = (double) bookedRoomDays / totalRoomDays * 100;

        return BigDecimal.valueOf(rate)
                .setScale(2, RoundingMode.HALF_UP)
                .doubleValue();
    }

    public BigDecimal getRevenue(String type, LocalDate startDate, LocalDate endDate) {
        LocalDateTimeRange range = resolveDateTimeRange(type, startDate, endDate);

        List<Booking> bookings = bookingRepository.findAllByCreatedAtBetweenAndPaymentStatus(
                range.start,
                range.end,
                PaymentStatus.PAID.name()
        );

        BigDecimal total = bookings.stream()
                .map(Booking::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return total;
    }

    public RevenueLineChartResponse getRevenueLineChart(String type, LocalDate startDate, LocalDate endDate) {

        LocalDateRange range = resolveDateRange(type, startDate, endDate);

        LocalDateTime start = range.start.atStartOfDay();
        LocalDateTime end = range.end.atTime(LocalTime.MAX);

        List<Booking> bookings = bookingRepository.findAllPaidBookings(start, end);

        long days = ChronoUnit.DAYS.between(range.start, range.end);

        boolean isHour = false;
        boolean isDay = false;
        boolean isMonth = false;
        boolean isQuarter = false;
        boolean isYear = false;

        if ("today".equals(type)) {
            isHour = true;
        } else if ("7days".equals(type) || "30days".equals(type) || "month".equals(type)) {
            isDay = true;
        } else if ("year".equals(type)) {
            isMonth = true;
        } else {
            if (days <= 2) {
                isHour = true;
            } else if (days <= 31) {
                isDay = true;
            } else if (days <= 365) {
                isMonth = true;
            } else if (days <= 730) {
                isQuarter = true;
            } else {
                isYear = true;
            }
        }

        Map<LocalDateTime, BigDecimal> totalMap = new HashMap<>();
        Map<LocalDateTime, BigDecimal> roomMap = new HashMap<>();
        Map<LocalDateTime, BigDecimal> serviceMap = new HashMap<>();
        Map<LocalDateTime, BigDecimal> extraMap = new HashMap<>();

        // Gom nhóm dữ liệu
        for (Booking b : bookings) {
            if (b.getPaidAt() == null) continue;

            LocalDateTime bucket = b.getPaidAt();

            if (isHour) {
                bucket = bucket.withMinute(0).withSecond(0).withNano(0);

            } else if (isDay) {
                bucket = bucket.toLocalDate().atStartOfDay();

            } else if (isMonth) {
                bucket = bucket.withDayOfMonth(1).toLocalDate().atStartOfDay();

            }  else if (isQuarter) {
                int month = bucket.getMonthValue();
                int startMonthOfQuarter = ((month - 1) / 3) * 3 + 1;

                bucket = bucket
                        .withMonth(startMonthOfQuarter)
                        .withDayOfMonth(1)
                        .toLocalDate()
                        .atStartOfDay();

            } else if (isYear) {
                bucket = bucket.withDayOfYear(1).toLocalDate().atStartOfDay();
            }

            BigDecimal roomPrice = b.getRoomPrice() != null ? b.getRoomPrice() : BigDecimal.ZERO;

            BigDecimal servicePrice = b.getBookingServices() == null
                    ? BigDecimal.ZERO
                    : b.getBookingServices().stream()
                    .map(bs -> bs.getTotalPrice() != null ? bs.getTotalPrice() : BigDecimal.ZERO)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            BigDecimal extraPrice = b.getExtras() == null
                    ? BigDecimal.ZERO
                    : b.getExtras().stream()
                    .map(e -> e.getAmount() != null ? e.getAmount() : BigDecimal.ZERO)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            BigDecimal totalPrice = roomPrice.add(servicePrice).add(extraPrice);

            totalMap.merge(bucket, totalPrice, BigDecimal::add);
            roomMap.merge(bucket, roomPrice, BigDecimal::add);
            serviceMap.merge(bucket, servicePrice, BigDecimal::add);
            extraMap.merge(bucket, extraPrice, BigDecimal::add);
        }

        // Kết quả
        List<LocalDateTime> times = new ArrayList<>();
        List<BigDecimal> totalPrices = new ArrayList<>();
        List<BigDecimal> roomPrices = new ArrayList<>();
        List<BigDecimal> servicePrices = new ArrayList<>();
        List<BigDecimal> extraPrices = new ArrayList<>();

        LocalDateTime current = start;

        while (!current.isAfter(end)) {

            LocalDateTime key = null;

            if (isHour) {
                key = current.withMinute(0).withSecond(0).withNano(0);
                current = current.plusHours(1);

            } else if (isDay) {
                key = current.toLocalDate().atStartOfDay();
                current = current.plusDays(1);

            } else if (isMonth) {
                key = current.withDayOfMonth(1).toLocalDate().atStartOfDay();
                current = current.plusMonths(1);

            } else if (isQuarter) {
                int month = current.getMonthValue();
                int startMonthOfQuarter = ((month - 1) / 3) * 3 + 1;

                key = current.withMonth(startMonthOfQuarter)
                        .withDayOfMonth(1)
                        .toLocalDate()
                        .atStartOfDay();

                current = current.plusMonths(3);

            } else if (isYear) {
                key = current.withDayOfYear(1).toLocalDate().atStartOfDay();
                current = current.plusYears(1);
            }

            times.add(key);

            totalPrices.add(totalMap.getOrDefault(key, BigDecimal.ZERO));
            roomPrices.add(roomMap.getOrDefault(key, BigDecimal.ZERO));
            servicePrices.add(serviceMap.getOrDefault(key, BigDecimal.ZERO));
            extraPrices.add(extraMap.getOrDefault(key, BigDecimal.ZERO));
        }

        return RevenueLineChartResponse.builder()
                .times(times)
                .totalPrices(totalPrices)
                .roomPrices(roomPrices)
                .servicePrices(servicePrices)
                .extraPrices(extraPrices)
                .build();
    }

    public BookingCountBarChartResponse getBookingCountBarChart(String type, LocalDate startDate, LocalDate endDate) {

        LocalDateRange range = resolveDateRange(type, startDate, endDate);

        LocalDateTime start = range.start.atStartOfDay();
        LocalDateTime end = range.end.atTime(LocalTime.MAX);

        List<Booking> bookings = bookingRepository.findAllByCreatedAtBetween(start, end);

        long days = ChronoUnit.DAYS.between(range.start, range.end);

        boolean isHour = false;
        boolean isDay = false;
        boolean isMonth = false;
        boolean isQuarter = false;
        boolean isYear = false;

        if ("today".equals(type)) {
            isHour = true;
        } else if ("7days".equals(type) || "30days".equals(type) || "month".equals(type)) {
            isDay = true;
        } else if ("year".equals(type)) {
            isMonth = true;
        } else {
            if (days <= 2) {
                isHour = true;
            } else if (days <= 31) {
                isDay = true;
            } else if (days <= 365) {
                isMonth = true;
            } else if (days <= 730) {
                isQuarter = true;
            } else {
                isYear = true;
            }
        }

        Map<LocalDateTime, Long> countMap = new HashMap<>();

        for (Booking b : bookings) {
            LocalDateTime bucket = b.getCreatedAt();

            if (bucket == null) continue;

            if (isHour) {
                bucket = bucket.withMinute(0).withSecond(0).withNano(0);

            } else if (isDay) {
                bucket = bucket.toLocalDate().atStartOfDay();

            } else if (isMonth) {
                bucket = bucket.withDayOfMonth(1).toLocalDate().atStartOfDay();

            } else if (isQuarter) {
                int month = bucket.getMonthValue();
                int startMonthOfQuarter = ((month - 1) / 3) * 3 + 1;

                bucket = bucket.withMonth(startMonthOfQuarter)
                        .withDayOfMonth(1)
                        .toLocalDate()
                        .atStartOfDay();

            } else if (isYear) {
                bucket = bucket.withDayOfYear(1).toLocalDate().atStartOfDay();
            }

            countMap.merge(bucket, 1L, Long::sum);
        }

        List<LocalDateTime> times = new ArrayList<>();
        List<Long> counts = new ArrayList<>();

        LocalDateTime current = start;

        if (isQuarter) {
            int month = current.getMonthValue();
            int startMonthOfQuarter = ((month - 1) / 3) * 3 + 1;
            current = current.withMonth(startMonthOfQuarter)
                    .withDayOfMonth(1)
                    .toLocalDate()
                    .atStartOfDay();
        } else if (isYear) {
            current = current.withDayOfYear(1).toLocalDate().atStartOfDay();
        }

        while (!current.isAfter(end)) {

            LocalDateTime key;

            if (isHour) {
                key = current.withMinute(0).withSecond(0).withNano(0);
                current = current.plusHours(1);

            } else if (isDay) {
                key = current.toLocalDate().atStartOfDay();
                current = current.plusDays(1);

            } else if (isMonth) {
                key = current.withDayOfMonth(1).toLocalDate().atStartOfDay();
                current = current.plusMonths(1);

            } else if (isQuarter) {
                int month = current.getMonthValue();
                int startMonthOfQuarter = ((month - 1) / 3) * 3 + 1;

                key = current.withMonth(startMonthOfQuarter)
                        .withDayOfMonth(1)
                        .toLocalDate()
                        .atStartOfDay();

                current = current.plusMonths(3);

            } else { // year
                key = current.withDayOfYear(1).toLocalDate().atStartOfDay();
                current = current.plusYears(1);
            }

            times.add(key);
            counts.add(countMap.getOrDefault(key, 0L));
        }

        return BookingCountBarChartResponse.builder()
                .times(times)
                .bookingCounts(counts)
                .build();
    }

    public List<TopBookedRoomResponse> getTopBookedRooms(String type, LocalDate startDate, LocalDate endDate, int limit) {

        LocalDateRange range = resolveDateRange(type, startDate, endDate);

        LocalDateTime start = range.start.atStartOfDay();
        LocalDateTime end = range.end.atTime(LocalTime.MAX);

        // Lấy tất cả booking trong khoảng thời gian
        List<Booking> bookings = bookingRepository.findAllByCreatedAtBetween(start, end);

        // Gom nhóm theo roomId
        Map<String, TopBookedRoomResponse> map = new HashMap<>();
        for (Booking b : bookings) {

            String roomId = b.getRoom().getRoomId();

            // Khởi tạo lần đầu nếu room này chưa tồn tại trong map
            TopBookedRoomResponse data = map.get(roomId);
            if (data == null) {
                data = TopBookedRoomResponse.builder()
                        .room(roomMapper.toRoomSummaryResponse(b.getRoom()))
                        .bookingCount(0L)
                        .revenue(BigDecimal.ZERO)
                        .build();
            }

            data.setBookingCount(data.getBookingCount() + 1);

            // Chỉ cộng revenue nếu đã thanh toán
            if (b.getPaidAt() != null) {
                BigDecimal roomPrice = b.getRoomPrice() != null
                        ? b.getRoomPrice()
                        : BigDecimal.ZERO;

                data.setRevenue(data.getRevenue().add(roomPrice));
            }

            map.put(roomId, data);
        }

        return map.values().stream()
                .sorted((a, b) -> b.getBookingCount().compareTo(a.getBookingCount()))
                .limit(limit)
                .toList();
    }

    public List<BookingStatusPieChartResponse> getBookingStatusPieChart(String type, LocalDate startDate, LocalDate endDate) {

        LocalDateRange range = resolveDateRange(type, startDate, endDate);

        LocalDateTime start = range.start.atStartOfDay();
        LocalDateTime end = range.end.atTime(LocalTime.MAX);

        List<Booking> bookings = bookingRepository.findAllByCreatedAtBetween(start, end);

        // Gom nhóm theo status
        Map<String, Long> bookingStatusMap = new HashMap<>();

        for (Booking b : bookings) {

            String status = b.getBookingStatus();

            bookingStatusMap.put(status, bookingStatusMap.getOrDefault(status, 0L) + 1);
        }

        List<String> allStatuses = List.of(
                "PENDING",
                "CONFIRMED",
                "CANCELLED",
                "CHECKED_IN",
                "CHECKED_OUT"
        );

        // Build response đủ tất cả status
        return allStatuses.stream()
                .map(status -> BookingStatusPieChartResponse.builder()
                        .status(status)
                        .count(bookingStatusMap.getOrDefault(status, 0L))
                        .build())
                .toList();
    }

    public List<ServiceUsedBarChartResponse> getServiceUsedBarChart(String type, LocalDate startDate, LocalDate endDate) {

        LocalDateRange range = resolveDateRange(type, startDate, endDate);

        LocalDateTime start = range.start.atStartOfDay();
        LocalDateTime end = range.end.atTime(LocalTime.MAX);

        List<BookingService> bookingServices = bookingServiceRepository.findAllByCreatedAtBetween(start, end);

        Map<String, Long> map = new HashMap<>();

        for (BookingService bs : bookingServices) {

            String serviceName = bs.getService().getServiceName();

            int quantity = bs.getQuantity() != null ? bs.getQuantity() : 0;

            map.put(serviceName, map.getOrDefault(serviceName, 0L) + quantity);
        }

        List<com.hotel_booking_system.entity.Service> allServices = serviceRepository.findAllByDeletedAtIsNull();

        return allServices.stream()
                .map(s -> ServiceUsedBarChartResponse.builder()
                        .serviceName(s.getServiceName())
                        .usedCount(map.getOrDefault(s.getServiceName(), 0L))
                        .build())
                .sorted((a, b) -> b.getUsedCount().compareTo(a.getUsedCount()))
                .toList();
    }

    public List<RoomTypePieChartResponse> getRoomTypePieChart() {

        List<Room> rooms = roomRepository.findAll();
        List<RoomType> roomTypes = roomTypeRepository.findAllByDeletedAtIsNull();

        Map<String, Long> map = new HashMap<>();

        // Đếm số phòng theo loại
        for (Room r : rooms) {

            String roomTypeId = r.getRoomType().getRoomTypeId();

            map.put(roomTypeId, map.getOrDefault(roomTypeId, 0L) + 1);
        }

        return roomTypes.stream()
                .map(rt -> RoomTypePieChartResponse.builder()
                        .roomTypeName(rt.getRoomTypeName())
                        .roomCount(map.getOrDefault(rt.getRoomTypeId(), 0L))
                        .build())
                .toList();
    }

    // Tính tổng số ngày mà phòng đã được sử dụng
    private long calculateBookedRoomDays(List<Booking> bookings, LocalDate start, LocalDate end) {
        long total = 0;

        for (Booking b : bookings) {
            LocalDate checkIn = b.getCheckInDate();
            LocalDate checkOut = b.getCheckOutDate();

            // Lấy ngày thực tế mà phòng được sử dụng trong phạm vi thống kê
            LocalDate effectiveStart = checkIn.isBefore(start) ? start : checkIn;
            LocalDate effectiveEnd = checkOut.isAfter(end) ? end : checkOut;

            // Số ngày phòng được sử dụng
            long days = effectiveStart.until(effectiveEnd).getDays();

            if (days > 0) {
                total += days;
            }
        }

        return total;
    }

    private LocalDateTimeRange resolveDateTimeRange(String type, LocalDate startDate, LocalDate endDate) {
        LocalDate today = LocalDate.now();
        LocalDate start;
        LocalDate end;

        switch (type.toLowerCase()) {
            case "today":
                start = today;
                end = today;
                break;
            case "7days":
                start = today.minusDays(7);
                end = today;
                break;
            case "30days":
                start = today.minusDays(30);
                end = today;
                break;
            case "month":
                start = today.withDayOfMonth(1);
                end = today;
                break;
            case "year":
                start = today.withDayOfYear(1);
                end = today;
                break;
            case "custom":
                start = startDate;
                end = endDate;
                break;
            default:
                throw new IllegalArgumentException("Invalid type");
        }

        return new LocalDateTimeRange(start.atStartOfDay(), end.atTime(LocalTime.MAX));
    }

    private LocalDateRange resolveDateRange(String type, LocalDate startDate, LocalDate endDate) {
        LocalDate today = LocalDate.now();
        LocalDate start;
        LocalDate end;

        switch (type.toLowerCase()) {
            case "today":
                start = today;
                end = today;
                break;
            case "7days":
                start = today.minusDays(7);
                end = today;
                break;
            case "30days":
                start = today.minusDays(30);
                end = today;
                break;
            case "month":
                start = today.withDayOfMonth(1);
                end = today;
                break;
            case "year":
                start = today.withDayOfYear(1);
                end = today;
                break;
            case "custom":
                start = startDate;
                end = endDate;
                break;
            default:
                throw new IllegalArgumentException("Invalid type");
        }

        return new LocalDateRange(start, end);
    }

    private static class LocalDateTimeRange {
        LocalDateTime start;
        LocalDateTime end;

        public LocalDateTimeRange(LocalDateTime start, LocalDateTime end) {
            this.start = start;
            this.end = end;
        }
    }

    private static class LocalDateRange {
        LocalDate start;
        LocalDate end;

        public LocalDateRange(LocalDate start, LocalDate end) {
            this.start = start;
            this.end = end;
        }
    }
}