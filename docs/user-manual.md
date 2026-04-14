# USER MANUAL  
## HỆ THỐNG ĐẶT PHÒNG KHÁCH SẠN

---

# 1. Giới thiệu

Tài liệu này hướng dẫn sử dụng hệ thống đặt phòng khách sạn cho 3 nhóm người dùng:

- Khách hàng
- Nhân viên lễ tân
- Quản trị viên

# 2. KHÁCH HÀNG (CUSTOMER)

---

## 2.1. Đăng ký tài khoản

### Bước thực hiện
1. Chọn **Đăng ký**
2. Nhập:
   - Họ, tên
   - Giới tính
   - Email
   - Số điện thoại
   - Tên đăng nhập
   - Mật khẩu
3. Nhấn **Đăng ký**

### Kết quả
- Hiển thị: `Đăng ký tài khoản thành công`

### Lỗi
- Thiếu thông tin → `Vui lòng nhập đầy đủ thông tin`
- Username tồn tại → `Tên đăng nhập đã tồn tại`
- Email tồn tại → `Email đã tồn tại`
- Mật khẩu không hợp lệ → `Mật khẩu không hợp lệ`
- Lỗi hệ thống → `Lỗi kết nối`

---

## 2.2. Đăng nhập

### Bước thực hiện
1. Chọn **Đăng nhập**
2. Nhập:
   - Tên đăng nhập
   - Mật khẩu
3. Nhấn **Đăng nhập**

### Kết quả
- Đăng nhập thành công, chuyển trang theo quyền

### Lỗi
- Thiếu thông tin → `Vui lòng nhập đầy đủ thông tin`
- Sai tài khoản → `Sai tên đăng nhập hoặc mật khẩu`
- Lỗi hệ thống → `Lỗi kết nối`

---

## 2.3. Quản lý thông tin cá nhân

### Điều kiện
- Đã đăng nhập

### Bước thực hiện
1. Vào **Tài khoản**
2. Hệ thống hiển thị thông tin
3. Chỉnh sửa
4. Nhấn **Lưu thay đổi**

### Kết quả
- `Cập nhật thông tin thành công`

### Lỗi
- Thiếu thông tin
- Email đã tồn tại
- Lỗi kết nối

---

## 2.4. Đổi mật khẩu

### Bước thực hiện
1. Vào **Tài khoản**
2. Nhập:
   - Mật khẩu hiện tại
   - Mật khẩu mới
   - Nhập lại mật khẩu
3. Nhấn **Lưu thay đổi**

### Kết quả
- `Cập nhật mật khẩu thành công`

### Lỗi
- Sai mật khẩu hiện tại
- Mật khẩu mới không hợp lệ
- Không khớp xác nhận

---

## 2.5. Xem danh sách phòng

### Bước thực hiện
1. Chọn **Phòng**

### Hiển thị
- Ảnh phòng
- Tên phòng
- Giá
- Diện tích
- Sức chứa

### Lỗi
- `Lỗi kết nối`

---

## 2.6. Lọc phòng

### Bước thực hiện
1. Nhập:
   - Ngày nhận phòng
   - Ngày trả phòng
   - Số người
2. Chọn:
   - Loại phòng
   - View

### Kết quả
- Hiển thị danh sách phòng phù hợp

---

## 2.7. Xem chi tiết phòng

### Bước thực hiện
1. Chọn phòng bất kỳ

### Hiển thị
- Ảnh
- Loại phòng
- View
- Tiện nghi
- Giá

---

## 2.8. Đặt phòng

### Bước thực hiện
1. Nhấn **Đặt phòng**
2. Nhập:
   - Ngày nhận / trả
   - Số người
   - Tên
   - Email
   - SĐT
   - Ghi chú (tuỳ chọn)
3. Nhấn **Đặt phòng**

### Kết quả
- Trạng thái: `Đang xử lý`

### Lỗi
- Thiếu thông tin → `Vui lòng nhập đầy đủ thông tin`
- Lỗi kết nối

---

## 2.9. Xem lịch sử đặt phòng

### Bước thực hiện
1. Vào **Lịch sử đặt phòng**

### Hiển thị
- Mã đơn
- Trạng thái
- Tổng tiền

### Chi tiết
- Nhấn **Chi tiết đặt phòng**

### Lỗi
- Không có dữ liệu → `Bạn chưa có đơn đặt phòng nào`

---

## 2.10. Hủy đặt phòng

### Bước thực hiện
1. Nhấn **Hủy đặt phòng**

### Điều kiện
- Trạng thái: `Đang xử lý`
- Trong vòng 24 giờ

### Kết quả
- `Hủy đặt phòng thành công`

### Lỗi
- `Hủy đặt phòng thất bại`

---

# 3. NHÂN VIÊN LỄ TÂN (RECEPTIONIST)

---

## 3.1. Xem phòng trống

### Bước thực hiện
1. Vào **Phòng**
2. Nhập:
   - Ngày nhận / trả
   - Số người

### Kết quả
- Hiển thị phòng phù hợp

### Lỗi
- `Không có phòng phù hợp`

---

## 3.2. Đặt phòng tại quầy

### Bước thực hiện
1. Chọn phòng
2. Nhấn **Đặt phòng**
3. Nhập:
   - Tên khách
   - Email
   - SĐT
   - CCCD
   - Số người
4. Nhấn xác nhận

### Lỗi
- `Phòng không khả dụng`

---

## 3.3. Xem danh sách đặt phòng

### Bước thực hiện
1. Vào **Đặt phòng**
2. Lọc theo:
   - Trạng thái
   - Thanh toán
   - Thời gian

---

## 3.4. Xem chi tiết đặt phòng

### Hiển thị
- Thông tin khách
- Dịch vụ
- Phụ phí
- Tổng tiền

---

## 3.5. Cập nhật trạng thái

### Trạng thái
- Đang xử lý
- Đã xác nhận
- Đã nhận phòng
- Đã trả phòng
- Đã hủy

---

## 3.6. Quản lý dịch vụ

- Thêm dịch vụ
- Cập nhật số lượng
- Xóa dịch vụ

---

## 3.7. Quản lý phụ phí

- Thêm phụ phí
- Xóa phụ phí

---

## 3.8. Thanh toán

### Tiền mặt
1. Chọn phương thức
2. Xác nhận `Đã thanh toán`

### VNPay
1. Chọn VNPay
2. Nhấn **Thanh toán**
3. Hệ thống xử lý

---

# 4. QUẢN TRỊ VIÊN (ADMIN)

---

## 4.1. Quản lý tài khoản khách hàng
- Xem danh sách
- Khóa / mở tài khoản

---

## 4.2. Quản lý tài khoản lễ tân
- Thêm
- Sửa
- Xóa
- Cấp lại mật khẩu
- Khóa / mở

---

## 4.3. Quản lý loại phòng / view / tiện nghi

### Thao tác
- Thêm
- Sửa
- Xóa

### Lỗi
- Trùng dữ liệu
- Thiếu thông tin

---

## 4.4. Quản lý phòng
- Thêm phòng
- Sửa phòng
- Xóa phòng

---

## 4.5. Quản lý dịch vụ
- Thêm
- Sửa
- Xóa

---

## 4.6. Quản lý ngày lễ
- Thêm ngày lễ
- Sửa
- Đóng / mở
- Xóa

---

## 4.7. Báo cáo thống kê

### Chức năng
- Xem theo:
  - Ngày
  - Tháng
  - Năm

### Hiển thị
- Doanh thu
- Lượt đặt phòng
- Biểu đồ

---

# 5. Lưu ý chung

- Hệ thống yêu cầu kết nối cơ sở dữ liệu
- Mật khẩu được mã hóa
- Phân quyền rõ ràng theo vai trò
- Không chia sẻ tài khoản