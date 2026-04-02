document.addEventListener("DOMContentLoaded", async () => {

  // CHECK TOKEN
  const token = localStorage.getItem("tokenHotelBookingCustomer");
  if (!token) {
    window.location.href = "index.html";
    return;
  }

  // LOAD THÔNG TIN CÁ NHÂN
  async function loadUserInfo() {
    try {
      const res = await callAPIWithAuth("/users/my-info", "GET");

      if (res.code === 1000) {
        const user = res.result;
        document.getElementById("customer-name").innerText = user.firstName + " " + user.lastName;

      } else {
        alert(res.message);
      }

    } catch (error) {
      console.error(error);
      alert("Không thể tải thông tin người dùng!");
    }
  }

  loadUserInfo();

  const container = document.getElementById("booking-list-container");

  await loadBookingHistory();

  async function loadBookingHistory() {
    try {
      const res = await callAPIWithAuth("/bookings/my-bookings");

      if (res.code !== 1000) {
        showEmpty("Không thể tải dữ liệu");
        return;
      }

      const bookings = res.result;

      document.getElementById("booking-count").textContent = bookings.length;

      if (!bookings || bookings.length === 0) {
        showEmpty("Chưa có đặt phòng nào");
        return;
      }

      renderBookings(bookings);
    } catch (error) {
      console.error(error);
      showEmpty("Lỗi khi tải dữ liệu");
    }
  }

  function showEmpty(message) {
    container.innerHTML = `
      <div class="text-center py-5">
        <i class="bi bi-calendar-x fs-1 text-muted"></i>
        <p class="mt-3 text-muted">${message}</p>
      </div>
    `;
  }

  function renderBookings(bookings) {
    container.innerHTML = `
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="fw-bold mb-0 fs-4">Lịch sử đặt phòng</h3>
      </div>
      <div id="booking-list"></div>
    `;

    const list = document.getElementById("booking-list");

    bookings.forEach((b, index) => {
      const collapseId = `booking-${index}`;

      const canCancel = b.bookingStatus === "PENDING";

      const html = `
        <div class="booking-card card border-0 shadow-lg mb-4">
          <div class="card-header bg-transparent d-flex justify-content-between align-items-center py-3">
            <span class="text-muted small">
              Mã đặt phòng: 
              <span class="text-dark fw-medium">#${b.bookingCode}</span>
            </span>

            <div>
              <span class="text-muted small">
                ${formatDateTime(b.createdAt)}
              </span>

              ${
                canCancel
                  ? `<button class="btn btn-sm btn-outline-danger ms-2"
                        onclick="cancelBooking('${b.bookingId}')">
                        Hủy đặt phòng
                     </button>`
                  : ""
              }
            </div>
          </div>

          <div class="card-body">
            <div class="d-flex align-items-center">
              <div class="room-img-container me-4">
                <img src="${b.room.mainImageUrl}" class="rounded">
              </div>

              <div class="room-info flex-grow-1">
                <h6 class="fw-bold">${b.room.roomName}</h6>

                <div class="d-flex justify-content-between align-items-end">
                  <div class="d-flex align-items-center">
                    <span class="text-muted small me-2">Trạng thái:</span>
                    ${renderStatus(b.bookingStatus)}
                  </div>

                  <div class="text-end">
                    <span class="text-muted small d-block">Tổng tiền</span>
                    <strong class="fs-5 fw-semibold">
                      ${formatMoney(b.totalPrice)}
                    </strong>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer bg-light border-0 py-2 text-center">
            <a data-bs-toggle="collapse" href="#${collapseId}" class="text-dark-emphasis text-decoration-none small fw-medium d-block py-1">
              Chi tiết đặt phòng <i class="bi bi-chevron-down ms-1 toggle-icon"></i>
            </a>
          </div>

          <div class="collapse" id="${collapseId}">
            <div class="card-body bg-white px-4 mt-2">

              <div class="row mb-4 pb-4 border-bottom">
                <div class="col-md-6 border-end pe-md-4">
                  <h6 class="detail-label mb-3">Thông tin khách hàng</h6>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Người đại diện:</span>
                    <span class="fw-medium guest-name">${b.guestName}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>SĐT:</span>
                    <span class="fw-medium guest-phone">${b.guestPhone}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Email:</span>
                    <span class="fw-medium guest-email">${b.guestEmail}</span>
                  </div>
                </div>

                <div class="col-md-6 ps-md-4 mt-4 mt-md-0">
                  <h6 class="detail-label mb-3">Thông tin lưu trú</h6>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Ngày nhận phòng:</span>
                    <span class="fw-medium check-in-date">${formatDate(b.checkInDate)}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Ngày trả phòng:</span>
                    <span class="fw-medium check-out-date">${formatDate(b.checkOutDate)}</span>
                  </div>
                  <div class="d-flex justify-content-between small">
                    <span>Số khách:</span>
                    <span class="fw-medium adults-children">${b.adults} người lớn - ${b.children} trẻ em</span>
                  </div>
                </div>
              </div>

              <div class="row mb-3">
                <div class="col-md-6 border-end pe-md-4">
                  <h6 class="detail-label mb-3">Thông tin phòng</h6>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Loại phòng:</span>
                    <span class="fw-medium room-type-name">${b.room.roomTypeName}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>View:</span>
                    <span class="fw-medium view-name">${b.room.viewName}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Tầng:</span>
                    <span class="fw-medium floor">${b.room.floor}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Số phòng:</span>
                    <span class="fw-medium room-number">${b.room.roomNumber}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Diện tích:</span>
                    <span class="fw-medium area">${b.room.area}m²</span>
                  </div>
                </div>

                <div class="col-md-6 ps-md-4 mt-4 mt-md-0">
                  <h6 class="detail-label mb-3">Thông tin thanh toán</h6>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Phương thức thanh toán:</span>
                    <span class="fw-medium payment-method">${formatPaymentMethod(b.paymentMethod)}</span>
                  </div>
                  <div class="d-flex justify-content-between mb-1 small">
                    <span>Trạng thái thanh toán:</span>
                    <span class="fw-medium payment-status">${formatPaymentStatus(b.paymentStatus, b.paidAt)}</span></span>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-12 bg-light p-3 rounded-2 border-start border-secondary border-3">
                  <p class="mb-0 small"><strong>Ghi chú: </strong><span class="note">${b.note || "Không có"}</span></p>
                </div>
              </div>

            </div>
          </div>
        </div>
      `;

      list.innerHTML += html;
    });
  }

  function renderStatus(status) {
    switch (status) {
      case "PENDING":
        return `<span class="badge bg-warning-subtle text-warning border border-warning-subtle booking-status">Chờ xác nhận</span>`;
      case "CONFIRMED":
        return `<span class="badge bg-primary-subtle text-primary border border-primary-subtle booking-status">Đã xác nhận</span>`;
      case "CANCELLED":
        return `<span class="badge bg-danger-subtle text-danger border border-danger-subtle booking-status">Đã hủy</span>`;
      case "CHECKED_IN":
        return `<span class="badge bg-info-subtle text-info border border-info-subtle booking-status">Đã nhận phòng</span>`;
      case "CHECKED_OUT":
        return `<span class="badge bg-success-subtle text-success border border-success-subtle booking-status">Đã trả phòng</span>`;
      default:
        return `<span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle booking-status">${status}</span>`;
    }
  }
});

// ===== Helpers =====

function formatDate(date) {
  const d = new Date(date);

  const day = String(d.getDate()).padStart(2, "0");
  const month = String(d.getMonth() + 1).padStart(2, "0");
  const year = d.getFullYear();

  return `${day}/${month}/${year}`;
}

function formatDateTime(date) {
  const d = new Date(date);

  const day = String(d.getDate()).padStart(2, "0");
  const month = String(d.getMonth() + 1).padStart(2, "0");
  const year = d.getFullYear();

  const hours = String(d.getHours()).padStart(2, "0");
  const minutes = String(d.getMinutes()).padStart(2, "0");

  return `${day}/${month}/${year} - ${hours}:${minutes}`;
}

function formatMoney(amount) {
  return new Intl.NumberFormat("vi-VN").format(amount) + "đ";
}

function formatPaymentMethod(paymentMethod) {
  switch (paymentMethod) {
    case "CASH":
      return "Tiền mặt";
    default:
      return paymentMethod;
  }
}

function formatPaymentStatus(paymentStatus, paidAt) {
  if (paymentStatus === "PAID") {
    return `Đã thanh toán 
      <span class="fw-normal">(${formatDateTime(paidAt)})</span>`;
  }

  if (paymentStatus === "UNPAID") {
    return "Chưa thanh toán";
  }

  return paymentStatus;
}

// ===== Cancel Booking =====
async function cancelBooking(bookingId) {
  const confirmCancel = confirm("Bạn có chắc muốn hủy đặt phòng này?");
  if (!confirmCancel) return;

  try {
    const res = await callAPIWithAuth(
      `/bookings/${bookingId}/cancel`,
      "PUT"
    );

    if (res.code !== 1000) {
      alert(res.message || "Hủy thất bại");
      return;
    }

    alert("Hủy đặt phòng thành công");

    // reload lại danh sách
    location.reload();

  } catch (error) {
    console.error(error);
    alert("Có lỗi xảy ra khi hủy");
  }
}