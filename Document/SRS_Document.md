# TÀI LIỆU ĐẶC TẢ YÊU CẦU PHẦN MỀM
# XÂY DỰNG HỆ THỐNG ĐẶT PHÒNG KHÁCH SẠN
# 1. Giới thiệu
## 1.1. Tổng quan

Tài liệu này được viết dựa theo chuẩn của Tài liệu đặc tả yêu cầu phần mềm (Software Requirements Specifications - SRS) được giải thích trong "IEEE Recommended Practice for Software Requirements Specifications" và "IEEE Guide for Developing System Requirements Specifications".

Cấu trúc tài liệu được chia làm ... phần:
- Phần 1
- Phần 2
- Phần 3
- Phần 4

## 1.2. Mục đích

Mục đích của tài liệu đặc tả yêu cầu phần mềm này là cung cấp một cái nhìn tổng quan, dễ hiểu về các yêu cầu và thành phần của dự án.

Tài liệu này được cung cấp như một tài liệu tham khảo cho người trực tiếp tham gia phát triển dự án. Ngoài ra, trong môi trường thực tế bên ngoài, tài liệu này còn phục vụ cho:

- Nhà phát triển phần mềm
- Kiểm thử viên
- Nhà quản lý dự án
- Các bên liên quan

## 1.3. Phạm vi

Tài liệu đặc tả yêu cầu phần mềm này được xây dựng nhằm phục vụ cho dự án:

**Xây dựng Hệ thống đặt phòng khách sạn (Hotel Booking System).**

## 1.4. Thuật ngữ

**Bảng 1.1: Từ điển thuật ngữ**

| Thuật ngữ | Ý nghĩa |
|----------|--------|
|          |        |
|          |        |
|          |        |
|          |        |

## 1.5. Tài liệu tham khảo

[1]  
[2]  
[3]  
[4]  
[5]

---

# 2. Mô tả tổng quan

## 2.1. Tổng quan sản phẩm

...

## 2.2. Các tác nhân

- Khách hàng
- Lễ tân
- Quản trị



Các chức năng của sản phẩm
Khách hàng:
Đăng ký.
Đăng nhập.
Quản lý thông tin cá nhân.
Đổi mật khẩu.
Tìm kiếm phòng.
Lọc phòng (loại, view, giá).
Xem danh sách phòng.
Xem chi tiết phòng (bao gồm 360).
Đặt phòng.
Hủy đặt phòng (trong 24h kể từ lúc đặt).
Xem lịch sử đặt phòng (mail).
Đánh giá (xem xét).
Nhân viên lễ tân:
Đăng nhập.
Xem sách đặt phòng.
Xem danh sách phòng.
Đặt phòng.
Cập nhật trạng thái đặt phòng (xác nhận, check-in, check-out, hủy).
Xuất hóa đơn (bill).
Quản trị viên:
Đăng nhập.
Quản lý khách hàng (xem, khóa/mở). xxx
Quản lý nhân viên (xem, thêm, sửa, xóa, khóa/mở).
Quản lý loại phòng (xem, thêm, sửa, xóa).
Quản lý phòng (xem, thêm, sửa, xóa).
Quản lý tiện nghi.
Quản lý mã giảm giá (cân nhắc).
Xem báo cáo thống kê (cân nhắc).
Hệ thống:
Tăng giá phòng tự động.
Biểu đồ use case tổng quan

Biểu đồ use case phân rã

Các yêu cầu chức năng
Đặc tả use case Đăng ký
| 1. Tên Use Case Đăng ký. 2. Mô tả vắn tắt Use case này cho phép người dùng đăng ký tài khoản mới. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng chọn chức năng “Đăng ký”. Hệ thống hiển thị form yêu cầu nhập các thông tin: username, password, last_name, first_name, gender, email, phone. Người dùng nhập đầy đủ các thông tin yêu cầu và nhấn nút “Đăng ký”. Hệ thống kiểm tra dữ liệu nhập vào, nếu thông tin hợp lệ, hệ thống sẽ lưu thông tin vào bảng USERS, đồng thời tự động gán vai trò tương ứng cho người dùng trong bảng ROLES_USERS. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 2 trong luồng cơ bản, nếu người dùng bỏ trống thông tin đăng ký, hệ thống sẽ hiển thị thông báo “Vui lòng nhập đầy đủ thông tin” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu email đã tồn tại, hệ thống sẽ hiển thị thông báo “Email đã tồn tại” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu tên đăng nhập đã tồn tại, hệ thống sẽ hiển thị thông báo “Tên đăng nhập đã tồn tại” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu mật khẩu không nằm trong khoảng 8 đến 50 ký tự, hệ thống sẽ hiển thị thông báo “Mật khẩu không hợp lệ” và yêu cầu nhập lại. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Không có. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Đăng nhập
| 1. Tên Use Case Đăng nhập. 2. Mô tả vắn tắt Use case này cho phép người dùng đăng nhập vào hệ thống. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng chọn chức năng “Đăng nhập”. Hệ thống hiển thị form yêu cầu người dùng nhập các thông tin bao gồm: tên đăng nhập (username) và mật khẩu (password). Người dùng nhập đầy đủ các thông tin yêu cầu và nhấn nút “Đăng nhập”. Hệ thống tiến hành kiểm tra thông tin trong bảng USERS, thực hiện đối soát tên đăng nhập và mật khẩu. Nếu thông tin chính xác và trạng thái tài khoản (user_status) đang hoạt động, hệ thống sẽ xác thực người dùng, truy vấn quyền hạn từ bảng ROLES thông qua bảng trung gian ROLES_USERS và chuyển người dùng đến giao diện trang chủ hoặc trang quản trị tương ứng. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 2 trong luồng cơ bản, nếu người dùng bỏ trống thông tin đăng nhập, hệ thống sẽ hiển thị thông báo “Vui lòng nhập đầy đủ thông tin” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu tên đăng nhập hoặc mật khẩu sai, hệ thống sẽ hiển thị thông báo “Sai tên đăng nhập hoặc mật khẩu” và yêu cầu nhập lại. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Không có. 6. Hậu điều kiện Nếu đăng nhập thành công, người dùng sẽ được chuyển hướng đến giao diện tương ứng với quyền của mình. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Quản lý thông tin cá nhân
| 1. Tên Use Case Quản lý thông tin cá nhân. 2. Mô tả vắn tắt Use case này cho phép người dùng xem và cập nhật thông tin cá nhân của mình. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng chọn chức năng “Thông tin cá nhân”. Hệ thống dựa vào phiên đăng nhập hiện tại để truy vấn dữ liệu từ bảng USERS bao gồm các thông tin: họ (last_name), tên (first_name), email, số điện thoại (phone) và giới tính (gender), sau đó hiển thị các thông tin này lên form biểu mẫu trên màn hình. Sửa thông tin cá nhân: Người dùng thực hiện chỉnh sửa các thông tin cần thay đổi trên form và nhấn nút “Lưu thay đổi”. Hệ thống tiến hành kiểm tra tính hợp lệ của dữ liệu vừa nhập, nếu tất cả thông tin đều hợp lệ, hệ thống sẽ thực hiện cập nhật các giá trị mới vào bản ghi tương ứng của người dùng trong bảng USERS của cơ sở dữ liệu, sau đó hiển thị thông báo “Cập nhật thông tin thành công” để xác nhận. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 2 trong luồng cơ bản, nếu email không hợp lệ, hệ thống sẽ hiển thị thông báo “Email không hợp lệ” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu email đã tồn tại, hệ thống sẽ hiển thị thông báo “Email đã tồn tại” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu số điện thoại không hợp lệ, hệ thống sẽ hiển thị thông báo “Số điện thoại không hợp lệ” và yêu cầu nhập lại. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Người dùng cần đăng nhập vào hệ thống trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Đổi mật khẩu
| 1. Tên Use Case Đổi mật khẩu. 2. Mô tả vắn tắt Use case này cho phép người dùng thay đổi mật khẩu truy cập hệ thống. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng chọn chức năng “Đổi mật khẩu” trong giao diện quản lý tài khoản. Hệ thống hiển thị một biểu mẫu yêu cầu người dùng nhập các thông tin bao gồm: mật khẩu hiện tại, mật khẩu mới và xác nhận mật khẩu mới. Người dùng nhập đầy đủ các thông tin theo yêu cầu và nhấn nút “Đổi mật khẩu”. Hệ thống thực hiện kiểm tra mật khẩu hiện tại bằng cách đối soát với trường password của người dùng đó trong bảng USERS; đồng thời kiểm tra tính hợp lệ của mật khẩu mới. Nếu các thông tin đều chính xác và khớp nhau, hệ thống sẽ tiến hành cập nhật lại dữ liệu vào bảng USERS trong cơ sở dữ liệu và hiển thị thông báo “Thay đổi mật khẩu thành công”. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 2 trong luồng cơ bản, nếu người dùng bỏ trống bất kỳ trường dữ liệu nào trên form, hệ thống sẽ hiển thị thông báo “Vui lòng nhập đầy đủ thông tin” và yêu cầu nhập lại. Tại bước 2 trong luồng cơ bản, nếu mật khẩu hiện tại nhập vào không chính xác so với mật khẩu đang lưu trữ trong hệ thống, hệ thống sẽ hiển thị thông báo “Mật khẩu hiện tại không đúng” và yêu cầu người dùng nhập lại. Tại bước 2 trong luồng cơ bản, nếu mật khẩu mới và phần xác nhận mật khẩu mới không trùng khớp hoàn toàn với nhau, hệ thống sẽ hiển thị thông báo “Xác nhận mật khẩu mới không khớp” để người dùng điều chỉnh. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Người dùng phải đang trong trạng thái đăng nhập vào hệ thống. 6. Hậu điều kiện Mật khẩu mới của người dùng được cập nhật thành công vào cơ sở dữ liệu và mật khẩu cũ sẽ không còn hiệu lực cho các lần đăng nhập sau. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Tìm kiếm phòng
| 1. Tên Use Case Tìm kiếm phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng tìm kiếm phòng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng nhập từ khóa vào ô tìm kiếm và nhấn biểu tượng “Tìm kiếm”. Hệ thống nhận từ khóa và thực hiện truy vấn trong cơ sở dữ liệu tại các bảng ROOMS, ROOM_TYPES, và VIEWS để lọc ra các bản ghi có thông tin khớp với từ khóa người dùng cung cấp. Hệ thống hiển thị danh sách các phòng phù hợp lên màn hình. Các thông tin hiển thị bao gồm: ảnh đại diện của phòng lấy từ bảng ROOM_IMAGES, tên phòng (room_name), loại phòng (room_type_name), giá phòng (price), hướng nhìn (view_name) và trạng thái phòng hiện tại (room_status).  Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 1 trong luồng cơ bản, nếu không tìm thấy phòng nào có thông tin phù hợp với từ khóa người dùng đã nhập, hệ thống sẽ hiển thị thông báo “Không tìm thấy phòng phù hợp với tiêu chí của bạn”. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối”. Use case kết thúc. 4. Các yêu cầu đặc biệt Việc tìm kiếm không phân biệt chữ hoa thường và tìm kiếm gần đúng với từ khóa được nhập. 5. Tiền điều kiện Không có. 6. Hậu điều kiện Không có. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Lọc phòng
| 1. Tên Use Case Lọc phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng lọc phòng theo các tiêu chí. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng truy cập vào trang danh sách phòng của khách sạn. Hệ thống sẽ hiển thị danh sách các phòng hiện có cùng với các bộ lọc theo tiêu chí ở phía bên cạnh hoặc phía trên, bao gồm: danh sách các loại phòng (từ bảng ROOM_TYPES), các hướng nhìn (từ bảng VIEWS) và các khoảng giá (price từ bảng ROOMS). Người dùng chọn một hoặc nhiều tiêu chí lọc và nhấn nút “Lọc”. Hệ thống tiến hành truy vấn cơ sở dữ liệu từ các bảng ROOMS, ROOM_TYPES, VIEWS và ROOM_IMAGES để lọc ra các bản ghi thỏa mãn đồng thời các điều kiện đã chọn, sau đó hiển thị lại danh sách lên màn hình với các thông tin: ảnh đại diện (image_url), tên phòng (room_name), giá phòng (price), loại phòng và hướng nhìn. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 2 trong luồng cơ bản, nếu không có phòng nào trong cơ sở dữ liệu thỏa mãn tất cả các tiêu chí mà người dùng đã chọn, hệ thống sẽ hiển thị thông báo “Không tìm thấy phòng phù hợp” và có thể gợi ý người dùng xóa bớt tiêu chí lọc. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Không có. 6. Hậu điều kiện Không có. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Xem danh sách phòng
| 1. Tên Use Case Xem danh sách phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng xem toàn bộ danh sách các phòng hiện có. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng chọn chức năng “Danh sách phòng” của hệ thống đặt phòng. Hệ thống thực hiện truy xuất dữ liệu từ các bảng ROOMS, ROOM_TYPES và VIEWS để lấy thông tin tổng quát của tất cả các phòng đang được quản lý. Hệ thống hiển thị danh sách các phòng lên màn hình. Mỗi phòng sẽ bao gồm các thông tin cơ bản: ảnh đại diện chính (lấy từ bảng ROOM_IMAGES), tên phòng (room_name), loại phòng (room_type_name), hướng nhìn (view_name), diện tích (area), sức chứa tối đa (max_adults, max_children) và giá thuê (price). Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bước 1 trong luồng cơ bản, nếu trong cơ sở dữ liệu hiện tại chưa có bất kỳ dữ liệu phòng nào được khởi tạo, hệ thống sẽ hiển thị thông báo “Hiện tại chưa có phòng nào khả dụng” và hiển thị trang trống. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Không có. 6. Hậu điều kiện Không có. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Xem chi tiết phòng
| 1. Tên Use Case Xem chi tiết phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng xem thông tin chi tiết của phòng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng nhấn vào một phòng bất kỳ. Hệ thống lấy thông tin phòng từ các bảng ROOMS, ROOMS_TYPES, VIEWS, REVIEWS, ROOM_AMENTITIES, ROOM_IMAGES, sau đó hiển thị lên màn hình thông tin của phòng (tên phòng, kiểu phòng, View, diện tích, sức chứa, giá gốc, tiện nghi và hình ảnh), tình trạng còn trống. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Không có. 6. Hậu điều kiện Không có. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Đặt phòng
| 1. Tên Use Case Đặt phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng đặt phòng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người dùng nhấn nút “Đặt phòng” tại trang chi tiết phòng. Hệ thống yêu cầu người dùng nhập các thông tin đặt phòng (ngày check-in, check-out, số người lớn và trẻ em, thông tin liên hệ). Hệ thống kiểm tra xem phòng còn trống trong khoảng thời gian yêu cầu dựa vào bảng BOOKINGS và số lượng khách không vượt quá sức chứa của phòng dựa vào bảng ROOMS. Hệ thống tính tổng tiền dựa vào giá cơ bản của phòng (ROOMS.price), áp dụng hệ số giá nếu có (price_multiplier), áp dụng mã giảm giá nếu người dùng nhập (DISCOUNTS), tính tổng tiền lưu trú theo số ngày. Hệ thống hiển thị thông tin xác nhận đặt phòng bao gồm thông tin phòng, thời gian lưu trú, tổng tiền thanh toán. Người dùng xác nhận đặt phòng và chọn phương thức thanh toán. Hệ thống tạo bản ghi mới trong bảng BOOKINGS, lưu trạng thái booking ban đầu, tạo bản ghi trong bảng PAYMENTS và lưu lịch sử trạng thái vào bảng BOOKING_STATUS_HISTORIES. Nếu thanh toán thành công, hệ thống sẽ cập nhật trạng thái thanh toán (payment_status = PAID), cập nhật trạng thái booking (booking_status = CONFIRMED) và gửi thông báo xác nhận đã đặt phòng cho người dùng. Use case kết thúc. 3.2. Các luồng rẽ nhánh Nếu phòng đã được đặt trong khoảng thời gian yêu cầu, hệ thống hiển thị thông báo: “Phòng không còn trống trong thời gian đã chọn”. Use case kết thúc. Nếu số lượng khách vượt quá sức chứa, hệ thống hiển thị thông báo: “Số lượng khách vượt quá sức chứa của phòng” và yêu cầu nhập lại. Use case kết thúc. Nếu mã giảm giá không hợp lệ, hệ thống hiển thị thông báo “Mã giảm giá không hợp lệ hoặc đã hết hạn”. Người dùng có thể tiếp tục mà không áp dụng mã. Use case kết thúc. Nếu thanh toán thất bại, hệ thống cập nhật payment_status = “FAILED”. Cập nhật booking_status = “CANCELLED” hoặc “PENDING” và hiển thị thông báo “Thanh toán thất bại. Vui lòng thử lại”. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Phòng tồn tại trong hệ thống. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Hủy đặt phòng
| 1. Tên Use Case Hủy đặt phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng hủy đặt phòng trong vòng 24 giờ kể từ thời điểm tạo booking. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case bắt đầu khi người dùng đăng nhập và truy cập mục “Lịch sử đặt phòng” và chọn một booking muốn hủy. Hệ thống kiểm tra booking tồn tại trong bảng BOOKINGS, booking thuộc về người dùng hiện tại, trạng thái booking là “PENDING” hoặc “CONFIRMED” và thời gian hiện tại không vượt quá 24 giờ kể từ created_at. Nếu thỏa điều kiện, hệ thống hiển thị xác nhận hủy đặt phòng. Người dùng xác nhận hủy. Hệ thống thực hiện cập nhật booking_status = CANCELLED trong bảng BOOKINGS. Lưu lịch sử thay đổi trạng thái vào bảng BOOKING_STATUS_HISTORIES (old_status = CANCELLED). Nếu booking đã thanh toán thì cập nhật payment_status = REFUNDED trong bảng PAYMENTS và thực hiện hoàn tiền. Use case kết thúc. 3.2. Các luồng rẽ nhánh Nếu thời gian hiện tại lớn hơn created_at + 24h, hệ thống hiển thị thông báo “Không thể hủy đặt phòng sau 24 giờ kể từ lúc đặt”. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Người dùng đã đăng nhập vào hệ thống. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Xem lịch sử đặt phòng
| 1. Tên Use Case Xem lịch sử đặt phòng. 2. Mô tả vắn tắt Use case này cho phép người dùng xem danh sách các phòng đã đặt trước đó, bao gồm thông tin đặt phòng, trạng thái booking và thông tin thanh toán. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case bắt đầu khi người dùng đăng nhập vào hệ thống và chọn mục “Lịch sử đặt phòng”. Hệ thống xác định người dùng hiện tại dựa vào bảng USERS. Hệ thống truy vấn danh sách các booking thuộc về người dùng đó từ bảng BOOKINGS theo user_id. Với mỗi booking, hệ thống lấy thông tin từ các bảng ROOMS, ROOM_TYPES, thông tin thanh toán từ PAYMENTS, lịch sử thay đổi trạng thái từ bảng BOOKING_STATUS_ HISTORIES. Hệ thống hiển thị danh sách lịch sử đặt phòng (Mã đặt phòng, tên phòng, ngày check-in, check-out, tổng tiền, trạng thái booking: Pending, confirmed, cancelled, ngày tạo booking). Người dùng bấm vào lịch sử đặt phòng bất kỳ để xem chi tiết đầy đủ. Use case kết thúc. 3.2. Các luồng rẽ nhánh Nếu người dùng chưa đăng nhập, hệ thống chuyển hướng đến trang đăng nhập. Use case kết thúc. Nếu không có lịch sử đặt phòng, hệ thống hiển thị thông báo “Bạn chưa có lịch sử đặt phòng”. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Người dùng đã đăng nhập vào hệ thống. 6. Hậu điều kiện Không có. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Xem danh sách đặt phòng
| 1. Tên Use Case Xem danh sách đặt phòng. 2. Mô tả vắn tắt Use case này cho phép nhân viên xem danh sách các đặt phòng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case bắt đầu khi nhân viên chọn chức năng “Xem danh sách đặt phòng”. Hệ thống hiển thị danh sách đặt phòng gồm: mã đặt phòng, khách hàng, ngày nhận, ngày trả, trạng thái. Use case kết thúc. 3.2. Các luồng rẽ nhánh Nếu không có đặt phòng nào, hệ thống hiển thị “Không có dữ liệu đặt phòng”. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Nhân viên đã đăng nhập vào hệ thống với vai trò lễ tân. 6. Hậu điều kiện Không có. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Cập nhật trạng thái đặt phòng
| 1. Tên Use Case Cập nhật trạng thái đặt phòng. 2. Mô tả vắn tắt Use case này cho phép nhân viên thay đổi trạng thái của một đặt phòng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case bắt đầu khi nhân viên chọn chức năng “Cập nhật trạng thái”. Hệ thống hiển thị trạng thái hiện tại của đặt phòng. Nhân viên chọn trạng thái mới và nhấn “Cập nhật”. Hệ thống kiểm tra hợp lệ và cập nhật trạng thái trong bảng BOOKING. Use case kết thúc. 3.2. Các luồng rẽ nhánh Nếu trạng thái chuyển không hợp lệ, hệ thống hiển thị “Không thể chuyển sang trạng thái này”. Use case kết thúc. Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Nhân viên đã đăng nhập vào hệ thống với vai trò lễ tân. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Xuất hóa đơn
| 1. Tên Use Case Xuất hóa đơn. 2. Mô tả vắn tắt Use case này cho phép nhân viên tạo và in hóa đơn thanh toán cho khách hàng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case bắt đầu khi nhân viên chọn chức năng “Xuất hóa đơn”. Hệ thống hiển thị thông tin đặt phòng và lựa chọn phương thức thanh toán. Nhân viên chọn phương thức thanh toán và nhấn “In hóa đơn”. Hệ thống tính tổng tiền và lưu thông tin hóa đơn vào bảng. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!”. Use case kết thúc. 4. Các yêu cầu đặc biệt Không có. 5. Tiền điều kiện Nhân viên đã đăng nhập vào hệ thống với vai trò lễ tân. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Quản lý khách hàng
| 1. Tên Use Case Quản lý khách hàng. 2. Mô tả vắn tắt Use case này cho phép người quản trị xem, khóa/mở tài khoản của khách hàng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người quản trị chọn chức năng “Quản lý khách hàng” trên giao diện quản trị. Hệ thống lấy dữ liệu từ bảng USER và hiển thị danh sách khách hàng lên màn hình. Khóa/mở tài khoản: Người quản trị nhấn nút “Khóa/Mở” trên dòng khách hàng muốn khóa/mở. Hệ thống cập nhật trường status trong bảng USER thành LOCKED/ACTIVE, sau đó hiển thị thông báo “Đã cập nhật trạng thái tài khoản”. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!” và use case kết thúc. 4. Các yêu cầu đặc biệt Use case này chỉ cho phép người quản trị thực hiện. 5. Tiền điều kiện Người quản trị cần đăng nhập vào hệ thống với vai trò quản trị trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Quản lý nhân viên
| 1. Tên Use Case Quản lý nhân viên. 2. Mô tả vắn tắt Use case này cho phép người quản trị xem, thêm, sửa, xóa, khóa/mở tài khoản của nhân viên. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người quản trị chọn chức năng “Quản lý nhân viên” trên giao diện quản trị. Hệ thống lấy dữ liệu từ bảng USER và hiển thị danh sách nhân viên lên màn hình. Thêm nhân viên: Người quản trị nhấn nút “Thêm”. Hệ thống hiển thị màn hình yêu cầu nhập thông tin nhân viên (username, password, first_name, last_name, gender, email, phone). Người quản trị nhập đầy đủ thông tin, sau đó nhấn nút “Thêm”. Hệ thống lưu thông tin nhân viên, sau đó hiển thị thông báo “Thêm nhân viên thành công”. Sửa nhân viên: Người quản trị nhấn nút “Sửa” trên dòng nhân viên muốn sửa. Hệ thống hiển thị màn hình thông tin nhân viên. Người quản trị nhập thông tin cần sửa, sau đó nhấn nút “Lưu”. Hệ thống cập nhật thông tin nhân viên trong bảng USER, sau đó hiển thị thông báo “Cập nhật thông tin nhân viên thành công”. Xóa nhân viên: Người quản trị nhấn nút “Xóa” trên dòng nhân viên muốn sửa. Hệ thống hiển thị hộp thoại xác nhận xóa. Người quản trị nhấn “Đồng ý”. Hệ thống cập nhật trường is_deleted trong bảng USER thành TRUE, sau đó hiển thị thông báo “Xóa nhân viên thành công”. Khóa/mở tài khoản: Người quản trị nhấn nút “Khóa/Mở” trên dòng nhân viên muốn khóa/mở. Hệ thống cập nhật trường user_status trong bảng USER thành ACTIVE/LOCKED, sau đó hiển thị thông báo “Khóa/Mở tài khoản thành công”. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!” và use case kết thúc. 4. Các yêu cầu đặc biệt Use case này chỉ cho phép người quản trị thực hiện. 5. Tiền điều kiện Người quản trị cần đăng nhập vào hệ thống với vai trò quản trị trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Quản lý loại phòng
| 1. Tên Use Case Quản lý loại phòng. 2. Mô tả vắn tắt Use case này cho phép người quản trị xem, thêm, sửa, xóa loại phòng. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người quản trị chọn chức năng “Quản lý loại phòng” trên giao diện quản trị. Hệ thống lấy dữ liệu từ bảng ROOM_TYPES và hiển thị danh sách loại phòng lên màn hình. Thêm loại phòng: Người quản trị nhấn nút “Thêm”. Hệ thống hiển thị màn hình yêu cầu nhập thông tin loại phòng (room_type_name, description). Người quản trị nhập đầy đủ thông tin, sau đó nhấn nút “Thêm”. Hệ thống lưu thông tin loại phòng, sau đó hiển thị thông báo “Thêm loại phòng thành công”. Sửa loại phòng: Người quản trị nhấn nút “Sửa” trên dòng loại phòng muốn sửa. Hệ thống hiển thị màn hình thông tin loại phòng. Người quản trị nhập thông tin cần sửa, sau đó nhấn nút “Lưu”. Hệ thống cập nhật thông tin loại phòng trong bảng ROOM_TYPES, sau đó hiển thị thông báo “Cập nhật thông tin loại phòng thành công”. Xóa loại phòng: Người quản trị nhấn nút “Xóa” trên dòng loại phòng muốn xóa. Hệ thống hiển thị hộp thoại xác nhận xóa. Người quản trị nhấn “Đồng ý”. Hệ thống cập xóa loại phòng, sau đó hiển thị thông báo “Xóa loại phòng thành công”. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!” và use case kết thúc. 4. Các yêu cầu đặc biệt Use case này chỉ cho phép người quản trị thực hiện. 5. Tiền điều kiện Người quản trị cần đăng nhập vào hệ thống với vai trò quản trị trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Quản lý tiện nghi
| 1. Tên Use Case Quản lý tiện nghi. 2. Mô tả vắn tắt Use case này cho phép người quản trị xem, thêm, sửa, xóa tiện nghi. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người quản trị chọn chức năng “Quản lý loại phòng” trên giao diện quản trị. Hệ thống lấy dữ liệu từ bảng AMENITIES và hiển thị danh sách tiện nghi lên màn hình. Thêm tiện nghi: Người quản trị nhấn nút “Thêm”. Hệ thống hiển thị màn hình yêu cầu nhập thông tin tiện nghi (aminity _name, description). Người quản trị nhập đầy đủ thông tin, sau đó nhấn nút “Thêm”. Hệ thống lưu thông tin tiện nghi, sau đó hiển thị thông báo “Thêm tiện nghi thành công”. Sửa tiện nghi: Người quản trị nhấn nút “Sửa” trên dòng tiện nghi muốn sửa. Hệ thống hiển thị màn hình thông tin tiện nghi. Người quản trị nhập thông tin cần sửa, sau đó nhấn nút “Lưu”. Hệ thống cập nhật thông tin tiện nghi trong bảng AMENITIES, sau đó hiển thị thông báo “Cập nhật thông tin tiện nghi thành công”. Xóa loại phòng: Người quản trị nhấn nút “Xóa” trên dòng tiện nghi muốn xóa. Hệ thống hiển thị hộp thoại xác nhận xóa. Người quản trị nhấn “Đồng ý”. Hệ thống xóa tiện nghi, sau đó hiển thị thông báo “Xóa tiện nghi thành công”. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!” và use case kết thúc. 4. Các yêu cầu đặc biệt Use case này chỉ cho phép người quản trị thực hiện. 5. Tiền điều kiện Người quản trị cần đăng nhập vào hệ thống với vai trò quản trị trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Quản lý mã giảm giá
| 1. Tên Use Case Quản lý mã giảm giá. 2. Mô tả vắn tắt Use case này cho phép người quản trị xem, thêm, sửa, xóa, khóa/mở mã giảm giá. 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người quản trị chọn chức năng “Quản lý mã giảm giá” trên giao diện quản trị. Hệ thống lấy dữ liệu từ bảng DISCOUNTS và hiển thị danh sách mã giảm giá lên màn hình. Thêm mã giảm giá: Người quản trị nhấn nút “Thêm”. Hệ thống hiển thị màn hình yêu cầu nhập thông tin mã giảm giá (discount_code, description, discout_value, min_booking_amount, max_discount_amount, start_date, end_date, quantity, discount_status). Người quản trị nhập đầy đủ thông tin, sau đó nhấn nút “Thêm”. Hệ thống lưu thông tin mã giảm giá, sau đó hiển thị thông báo “Thêm mã giảm giá thành công”. Sửa mã giảm giá: Người quản trị nhấn nút “Sửa” trên dòng mã giảm giá muốn sửa. Hệ thống hiển thị màn hình thông tin mã giảm giá. Người quản trị nhập thông tin cần sửa, sau đó nhấn nút “Lưu”. Hệ thống cập nhật thông tin mã giảm giá trong bảng DISCOUNTS, sau đó hiển thị thông báo “Cập nhật thông tin mã giảm giá thành công”. Xóa mã giảm giá: Người quản trị nhấn nút “Xóa” trên dòng mã giảm giá muốn xóa. Hệ thống hiển thị hộp thoại xác nhận xóa. Người quản trị nhấn “Đồng ý”. Hệ thống xóa mã giảm giá khỏi bảng DISCOUNTS, sau đó hiển thị thông báo “Xóa mã giảm giá thành công”. Khóa/mở mã giảm giá: Người quản trị nhấn nút “Khóa/Mở” trên dòng mã giảm giá muốn khóa/mở. Hệ thống cập nhật trường discount_status trong bảng DISCOUNT thành ACTIVE/LOCKED, sau đó hiển thị thông báo “Khóa/Mở mã giảm giá thành công”. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!” và use case kết thúc. 4. Các yêu cầu đặc biệt Use case này chỉ cho phép người quản trị thực hiện. 5. Tiền điều kiện Người quản trị cần đăng nhập vào hệ thống với vai trò quản trị trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Đặc tả use case Xem báo cáo thống kê
| 1. Tên Use Case Xem báo cáo thống kê. 2. Mô tả vắn tắt Use case này cho phép người quản trị xem báo cáo thống kê về lượng khách hàng, số phòng, doanh thu, … 3. Luồng các sự kiện 3.1. Luồng cơ bản Use case này bắt đầu khi người quản trị chọn chức năng “Báo cáo thống kê” trên giao diện quản trị. Hệ thống hiển thị báo cáo thống kê dưới dạng số liệu và biểu đồ lên màn hình. Người quản trị chọn lọc theo ngày/tháng/năm. Hệ thống hiển thị báo cáo với số liệu tương ứng. Use case kết thúc. 3.2. Các luồng rẽ nhánh Tại bất kỳ thời điểm nào trong quá trình thực hiện use case, nếu không kết nối được với cơ sở dữ liệu thì hệ thống sẽ hiển thị thông báo “Lỗi kết nối!” và use case kết thúc. 4. Các yêu cầu đặc biệt Use case này chỉ cho phép người quản trị thực hiện. 5. Tiền điều kiện Người quản trị cần đăng nhập vào hệ thống với vai trò quản trị trước khi thực hiện use case. 6. Hậu điều kiện Nếu use case kết thúc thành công, dữ liệu sẽ được cập nhật trong cơ sở dữ liệu. 7. Điểm mở rộng Không có. |
| --- |


Các yêu cầu phi chức năng
Yêu cầu bảo mật
Mật khẩu của người dùng phải được mã hóa trong cơ sở dữ liệu.
Hệ thống cần phân quyền rõ ràng (Khách hàng, Lễ tân, Quản trị).
Yêu cầu giao diện
Giao diện thân thiện, dễ sử dụng.
Thiết kế hiện đại, chuyên nghiệp, phù hợp với lĩnh vực khách sạn.
Bố cục rõ ràng, nhất quán giữa các trang.
Hiển thị tốt trên desktop, tablet, mobile.
Yêu cầu hiệu suất
Thời gian tải trang dưới 3 giây.
Thời gian hiển thị kết quả tìm kiếm dưới 3 giây.
Các thao tác thêm, sửa, xóa dưới 3 giây.