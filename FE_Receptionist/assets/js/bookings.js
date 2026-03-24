if (!localStorage.getItem("tokenHotelBooking")) {
  window.location.href = "login.html";
}

let currentPage = 0;
let pageSize = 10;

let currentBookingId = null;

let highlightBookingCode = null;

async function loadBookings() {
  const bookingStatus = document.getElementById("booking-status-filter").value;
  const paymentStatus = document.getElementById("payment-status-filter").value;
  const sortOption = document.getElementById("sort-by").selectedIndex;
  const keyword = document.getElementById("search-by-booking-code").value;

  let sort = "createdAt,desc";
  if (sortOption === 1) {
    sort = "createdAt,asc";
  }

  let endpoint = `/bookings?page=${currentPage}&size=${pageSize}&sort=${sort}`;

  if (bookingStatus) {
    endpoint += `&bookingStatus=${bookingStatus}`;
  }

  if (paymentStatus) {
    endpoint += `&paymentStatus=${paymentStatus}`;
  }

  if (keyword) {
    endpoint += `&bookingCode=${keyword}`;
  }

  try {
    const response = await callAPIWithAuth(endpoint);

    const bookings = response.result.content;
    const totalPages = response.result.totalPages;

    renderBookings(bookings);
    renderPagination(totalPages);
  } catch (error) {
    console.error("Lỗi khi tải danh sách đặt phòng:", error);
  }
}

function renderBookings(bookings) {
  const tbody = document.querySelector("table tbody");
  tbody.innerHTML = "";

  if (!bookings || bookings.length === 0) {
    const tr = document.createElement("tr");
    tr.innerHTML = `<td colspan="10" class="text-center text-muted">Không có đặt phòng phù hợp</td>`;
    tbody.appendChild(tr);
    return;
  }

  bookings.forEach((b) => {
    const tr = document.createElement("tr");

    tr.innerHTML = `
      <td class="align-content-center">${b.bookingCode}</td>
      <td class="align-content-center">${formatDate(b.checkInDate)}</td>
      <td class="align-content-center">${formatDate(b.checkOutDate)}</td>
      <td class="align-content-center">${b.guestName}</td>
      <td class="align-content-center">${b.guestPhone}</td>
      <td class="align-content-center">${formatCurrency(b.totalPrice)}</td>
      <td class="align-content-center">${formatDateTime(b.createdAt)}</td>
      <td class="align-content-center">
        <span class="w-100 rounded-pill p-1 badge 
          ${b.bookingStatus === "PENDING" ? "bg-warning" : ""}
          ${b.bookingStatus === "CONFIRMED" ? "bg-success" : ""}
          ${b.bookingStatus === "CHECKED_IN" ? "bg-primary" : ""}
          ${b.bookingStatus === "CHECKED_OUT" ? "bg-secondary" : ""}
          ${b.bookingStatus === "CANCELLED" ? "bg-danger" : ""}">
          ${translateBookingStatus(b.bookingStatus)}
        </span>
      </td>
      <td class="align-content-center">
        <span class="w-100 rounded-pill p-1 badge 
          ${b.paymentStatus === "UNPAID" ? "bg-danger" : ""}
          ${b.paymentStatus === "PAID" ? "bg-success" : ""}">
          ${translatePaymentStatus(b.paymentStatus)}
        </span>
      </td>
      <td class="align-content-center">
        <button class="btn btn-sm btn-primary"><i class="bx bx-info-circle"></i></button>
      </td>
    `;

    // Thêm sự kiện show modal cho nút chi tiết
    tr.querySelector("button").addEventListener("click", () => showBookingDetail(b));

    tbody.appendChild(tr);

    // Nếu có highlightBookingCode
    if (highlightBookingCode && b.bookingCode === highlightBookingCode) {
      setTimeout(() => showBookingDetail(b), 300);
    }
  });
}

function showBookingDetail(booking) {
  document.getElementById("booking-code").innerText = booking.bookingCode;
  document.getElementById("check-in-date").innerText = formatDate(
    booking.checkInDate,
  );
  document.getElementById("check-out-date").innerText = formatDate(
    booking.checkOutDate,
  );
  document.getElementById("guest-name").innerText = booking.guestName;
  document.getElementById("guest-phone").innerText = booking.guestPhone;
  document.getElementById("guest-email").innerText = booking.guestEmail;

  const cccdInput = document.getElementById("identity-card-input");
  cccdInput.value = booking.identityCard || "";

  document.getElementById("adults").innerText = booking.adults;
  document.getElementById("children").innerText = booking.children;
  document.getElementById("note").innerText = booking.note || "";
  document.getElementById("totalPrice").innerText = formatCurrency(
    booking.totalPrice,
  );
  document.getElementById("createdAt").innerText = formatDateTime(
    booking.createdAt,
  );

  currentBookingId = booking.bookingId;

  // Booking status
  document.getElementById("modal-booking-status").innerHTML =
    bookingStatusOptions(booking.bookingStatus);

  // Payment status
  document.getElementById("modal-payment-status").innerHTML =
    paymentStatusOptions(booking.paymentStatus);

  // Payment method
  const paymentMethodSelect = document.getElementById("modal-payment-method");

  paymentMethodSelect.value = booking.paymentMethod || "CASH";

  paymentMethodSelect.setAttribute("data-old", paymentMethodSelect.value);

  // Hiện nút VNPAY nếu chọn VNPAY
  toggleVNPayButton();

  document.getElementById("room-name").innerText = booking.room.roomName;
  document.getElementById("room-number").innerText = booking.room.roomNumber;
  document.getElementById("floor").innerText = booking.room.floor;
  document.getElementById("area").innerText = booking.room.area + " m²";
  document.getElementById("room-type").innerText = booking.room.roomTypeName;
  document.getElementById("view").innerText = booking.room.viewName;

  document.getElementById("main-image").src = booking.room.mainImageUrl;

  const modal = new bootstrap.Modal(document.getElementById("booking-detail"));
  modal.show();
}

function formatDate(date) {
  const d = new Date(date);
  return d.toLocaleDateString("vi-VN");
}

function formatDateTime(date) {
  const d = new Date(date);

  const day = d.toLocaleDateString("vi-VN");
  const time = d.toLocaleTimeString("vi-VN", {
    hour: "2-digit",
    minute: "2-digit",
  });

  return `${day} - ${time}`;
}

function formatCurrency(value) {
  return value.toLocaleString("vi-VN") + "đ";
}

function translateBookingStatus(status) {
  const map = {
    PENDING: "Đang xử lý",
    CONFIRMED: "Đã xác nhận",
    CHECKED_IN: "Đã nhận phòng",
    CHECKED_OUT: "Đã trả phòng",
    CANCELLED: "Đã hủy",
  };
  return map[status] || status;
}

function translatePaymentStatus(status) {
  const map = {
    PAID: "Đã thanh toán",
    UNPAID: "Chưa thanh toán",
  };
  return map[status] || status;
}

function renderPagination(totalPages) {
  const pagination = document.querySelector(".pagination");
  pagination.innerHTML = "";

  const prev = document.createElement("li");
  prev.className = `page-item ${currentPage === 0 ? "disabled" : ""}`;
  prev.innerHTML = `<a class="page-link" href="#">&laquo;</a>`;
  prev.onclick = () => {
    if (currentPage > 0) {
      currentPage--;
      loadBookings();
    }
  };

  pagination.appendChild(prev);

  for (let i = 0; i < totalPages; i++) {
    const li = document.createElement("li");
    li.className = `page-item ${i === currentPage ? "active" : ""}`;

    li.innerHTML = `<a class="page-link" href="#">${i + 1}</a>`;

    li.onclick = () => {
      currentPage = i;
      loadBookings();
    };

    pagination.appendChild(li);
  }

  const next = document.createElement("li");
  next.className = `page-item ${currentPage === totalPages - 1 ? "disabled" : ""}`;
  next.innerHTML = `<a class="page-link" href="#">&raquo;</a>`;
  next.onclick = () => {
    if (currentPage < totalPages - 1) {
      currentPage++;
      loadBookings();
    }
  };

  pagination.appendChild(next);
}

function bookingStatusOptions(current) {
  const statuses = [
    "PENDING",
    "CONFIRMED",
    "CHECKED_IN",
    "CHECKED_OUT",
    "CANCELLED",
  ];

  const allowed = {
    PENDING: ["PENDING", "CONFIRMED", "CANCELLED"],
    CONFIRMED: ["CONFIRMED", "CHECKED_IN", "CANCELLED"],
    CHECKED_IN: ["CHECKED_IN", "CHECKED_OUT"],
    CHECKED_OUT: ["CHECKED_OUT"],
    CANCELLED: ["CANCELLED"],
  };

  return statuses
    .map((s) => {
      const disabled = !allowed[current].includes(s) ? "disabled" : "";
      const selected = current === s ? "selected" : "";

      return `<option value="${s}" ${selected} ${disabled}>
            ${translateBookingStatus(s)}
            </option>`;
    })
    .join("");
}

function paymentStatusOptions(current) {
  const statuses = ["UNPAID", "PAID"];

  return statuses
    .map((s) => {
      const disabled = current === "PAID" && s === "UNPAID" ? "disabled" : "";
      const selected = current === s ? "selected" : "";

      return `<option value="${s}" ${selected} ${disabled}>
            ${translatePaymentStatus(s)}
            </option>`;
    })
    .join("");
}

async function updateBookingStatus(bookingId, status) {
  if (!confirm(`Bạn có chắc muốn thay đổi trạng thái sang ${status}?`)) return;

  try {
    await callAPIWithAuth(`/bookings/${bookingId}/booking-status`, "PUT", {
      newBookingStatus: status,
    });

    loadBookings();
  } catch (error) {
    console.error("Lỗi cập nhật trạng thái booking:", error);
    alert("Không thể cập nhật trạng thái đặt phòng");
  }
}

async function updatePaymentStatus(bookingId, status) {
  if (!confirm(`Bạn có chắc muốn thay đổi trạng thái sang ${status}?`)) return;

  try {
    await callAPIWithAuth(`/bookings/${bookingId}/payment-status`, "PUT", {
      newPaymentStatus: status,
    });

    loadBookings();
  } catch (error) {
    console.error("Lỗi cập nhật trạng thái thanh toán:", error);
    alert("Không thể cập nhật trạng thái thanh toán");
  }
}

function toggleVNPayButton() {
  const method = document.getElementById("modal-payment-method").value;
  const btn = document.getElementById("btn-vnpay");

  if (method === "VNPAY") {
    btn.classList.remove("d-none");
  } else {
    btn.classList.add("d-none");
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const params = new URLSearchParams(window.location.search);

  highlightBookingCode = params.get("bookingCode");
  const status = params.get("status");

  if (status === "success") {
    alert("Thanh toán thành công!");
  }

  loadBookings();

  // Xóa param khỏi URL
  window.history.replaceState({}, document.title, "bookings.html");

  document
    .getElementById("booking-status-filter")
    .addEventListener("change", () => {
      currentPage = 0;
      loadBookings();
    });

  document
    .getElementById("payment-status-filter")
    .addEventListener("change", () => {
      currentPage = 0;
      loadBookings();
    });

  document.getElementById("sort-by").addEventListener("change", () => {
    currentPage = 0;
    loadBookings();
  });

  document
    .getElementById("search-by-booking-code")
    .addEventListener("keyup", () => {
      currentPage = 0;
      loadBookings();
    });

  document
    .getElementById("modal-payment-method")
    .addEventListener("change", async function () {
      const method = this.value;
      const oldValue = this.getAttribute("data-old");

      if (!confirm("Cập nhật phương thức thanh toán?")) {
        this.value = oldValue;
        return;
      }

      this.disabled = true;

      try {
        await callAPIWithAuth(
          `/bookings/${currentBookingId}/payment-method`,
          "PUT",
          {
            newPaymentMethod: method,
          },
        );

        // lưu lại giá trị mới
        this.setAttribute("data-old", method);

        // cập nhật UI nút VNPay
        toggleVNPayButton();

        // reload bảng
        loadBookings();
      } catch (e) {
        alert("Lỗi cập nhật phương thức thanh toán");

        // rollback lại value cũ
        this.value = oldValue;
      }

      this.disabled = false;
    });

  document
    .getElementById("modal-booking-status")
    .addEventListener("change", async function () {
      const status = this.value;

      if (!confirm("Cập nhật trạng thái đặt phòng?")) return;

      try {
        await callAPIWithAuth(
          `/bookings/${currentBookingId}/booking-status`,
          "PUT",
          { newBookingStatus: status },
        );

        loadBookings();
      } catch (e) {
        alert("Lỗi cập nhật!");
      }
    });

  document
    .getElementById("modal-payment-status")
    .addEventListener("change", async function () {
      const status = this.value;

      if (!confirm("Cập nhật trạng thái thanh toán?")) return;

      try {
        await callAPIWithAuth(
          `/bookings/${currentBookingId}/payment-status`,
          "PUT",
          { newPaymentStatus: status },
        );

        loadBookings();
      } catch (e) {
        alert("Lỗi cập nhật!");
      }
    });

  document.getElementById("btn-vnpay").addEventListener("click", async () => {
    if (!currentBookingId) return;

    try {
      // Gọi API thanh toán VNPay
      const res = await callAPIWithAuth(
        `/payments/vnpay/${currentBookingId}`,
        "POST",
      );

      // res.result là link VNPay
      if (res && res.result) {
        window.location.href = res.result; // redirect sang VNPay
      } else {
        alert(res.message);
      }
    } catch (e) {
      console.error("Lỗi khi tạo thanh toán VNPay:", e);
      alert("Không tạo được thanh toán VNPay");
    }
  });

  // Sự kiện cập nhật CCCD
  document.getElementById("btn-update-cccd").addEventListener("click", async () => {
    const newCCCD = document.getElementById("identity-card-input").value.trim();
    if (!newCCCD || !currentBookingId) return alert("Vui lòng nhập CCCD");

    if (!confirm("Bạn có chắc muốn cập nhật số CCCD?")) return;

    try {
      const res = await callAPIWithAuth(`/bookings/${currentBookingId}/identity-card`, "PUT", { identityCard: newCCCD });
      if (res.code === 1000 && res.result) {
        alert("Cập nhật CCCD thành công!");

        document.getElementById("identity-card-input").value = res.result.identityCard;
      } else {
        alert(res.message || "Cập nhật CCCD thất bại");
      }
    } catch (e) {
      console.error("Lỗi cập nhật CCCD:", e);
      alert("Không thể cập nhật CCCD");
    }
  });
});
