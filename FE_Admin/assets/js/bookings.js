if (!localStorage.getItem("tokenHotelBookingAdmin")) {
  window.location.href = "login.html";
}

let currentPage = 0;
let pageSize = 10;

// ================== LOAD DATA ==================
async function loadBookings() {
  const bookingStatus = document.getElementById("booking-status-filter").value;
  const paymentStatus = document.getElementById("payment-status-filter").value;
  const keyword = document.getElementById("search-by-booking-code").value;
  const sortOption = document.getElementById("sort-by").selectedIndex;

  let sort = "createdAt,desc";

  if (sortOption === 1) {
    sort = "createdAt,asc";
  }

  let endpoint = `/bookings?page=${currentPage}&size=${pageSize}&sort=${sort}`;

  if (bookingStatus) endpoint += `&bookingStatus=${bookingStatus}`;
  if (paymentStatus) endpoint += `&paymentStatus=${paymentStatus}`;
  if (keyword) endpoint += `&bookingCode=${keyword}`;

  try {
    const response = await callAPIWithAuth(endpoint);

    const bookings = response.result.content;
    const totalPages = response.result.totalPages;

    renderBookings(bookings);
    renderPagination(totalPages);
  } catch (error) {
    console.error("Lỗi load bookings:", error);
  }
}

// ================== RENDER TABLE ==================
function renderBookings(bookings) {
  const tbody = document.querySelector("table tbody");
  tbody.innerHTML = "";

  if (!bookings || bookings.length === 0) {
    tbody.innerHTML = `<tr><td colspan="10" class="text-center">Không có dữ liệu</td></tr>`;
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
        ${getBookingBadge(b.bookingStatus)}
      </td>

      <td class="align-content-center">
        ${getPaymentBadge(b.paymentStatus)}
      </td>

      <td class="align-content-center">
        <button 
          type="button"
          class="btn btn-sm btn-primary text-white"
          title="Chi tiết"
          data-bs-toggle="modal"
          data-bs-target="#booking-detail">
          <i class="bx bx-info-circle"></i>
        </button>
      </td>
    `;

    // Gán dữ liệu trước khi mở modal
    tr.querySelector("button").addEventListener("click", () => {
      showBookingDetail(b);
    });

    tbody.appendChild(tr);
  });
}

// ================== BADGE ==================
function getBookingBadge(status) {
  const map = {
    PENDING: "bg-warning",
    CONFIRMED: "bg-success",
    CHECKED_IN: "bg-primary",
    CHECKED_OUT: "bg-secondary",
    CANCELLED: "bg-danger",
  };

  return `<span class="w-100 p-1 badge rounded-pill ${map[status] || ""}">
            ${translateBookingStatus(status)}
          </span>`;
}

function getPaymentBadge(status) {
  const map = {
    PAID: "bg-success",
    UNPAID: "bg-danger",
  };

  return `<span class="w-100 p-1 badge rounded-pill ${map[status] || ""}">
            ${translatePaymentStatus(status)}
          </span>`;
}

// ================== MODAL ==================
function showBookingDetail(b) {
  document.getElementById("booking-code").innerText = b.bookingCode;
  document.getElementById("check-in-date").innerText = formatDate(b.checkInDate);
  document.getElementById("check-out-date").innerText = formatDate(b.checkOutDate);
  document.getElementById("guest-name").innerText = b.guestName;
  document.getElementById("guest-phone").innerText = b.guestPhone;
  document.getElementById("guest-email").innerText = b.guestEmail;

  document.getElementById("adults").innerText = b.adults;
  document.getElementById("children").innerText = b.children;
  document.getElementById("note").innerText = b.note || "";
  document.getElementById("total-price").innerText = formatCurrency(b.totalPrice);
  document.getElementById("created-at").innerText = formatDateTime(b.createdAt);

  renderStatusHistory(b.bookingStatusHistories);

  document.getElementById("payment-status").innerText =
    translatePaymentStatus(b.paymentStatus);

  document.getElementById("payment-method").innerText = b.paymentMethod;

  document.getElementById("room-name").innerText = b.room.roomName;
  document.getElementById("room-number").innerText = b.room.roomNumber;
  document.getElementById("floor").innerText = b.room.floor;
  document.getElementById("area").innerText = b.room.area + " m²";
  document.getElementById("room-type").innerText = b.room.roomTypeName;
  document.getElementById("view").innerText = b.room.viewName;

  document.getElementById("main-image").src = b.room.mainImageUrl;
}

// ================== PAGINATION ==================
function renderPagination(totalPages) {
  const pagination = document.querySelector(".pagination");
  pagination.innerHTML = "";

  // Prev
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

  // Pages
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

  // Next
  const next = document.createElement("li");
  next.className = `page-item ${
    currentPage === totalPages - 1 ? "disabled" : ""
  }`;
  next.innerHTML = `<a class="page-link" href="#">&raquo;</a>`;
  next.onclick = () => {
    if (currentPage < totalPages - 1) {
      currentPage++;
      loadBookings();
    }
  };

  pagination.appendChild(next);
}

// ================== UTIL ==================
function formatDate(date) {
  return new Date(date).toLocaleDateString("vi-VN");
}

function formatDateTime(date) {
  const d = new Date(date);
  return (
    d.toLocaleDateString("vi-VN") +
    " - " +
    d.toLocaleTimeString("vi-VN", {
      hour: "2-digit",
      minute: "2-digit",
    })
  );
}

function formatCurrency(value) {
  return value.toLocaleString("vi-VN") + "đ";
}

function translateBookingStatus(status) {
  return {
    PENDING: "Đang xử lý",
    CONFIRMED: "Đã xác nhận",
    CHECKED_IN: "Đã nhận phòng",
    CHECKED_OUT: "Đã trả phòng",
    CANCELLED: "Đã hủy",
  }[status] || status;
}

function translatePaymentStatus(status) {
  return {
    PAID: "Đã thanh toán",
    UNPAID: "Chưa thanh toán",
  }[status] || status;
}

function renderStatusHistory(histories) {
  const container = document.getElementById("booking-status-history");

  if (!histories || histories.length === 0) {
    container.innerHTML = "Không có dữ liệu";
    return;
  }

  const sorted = [...histories].sort(
    (a, b) => new Date(a.changedAt) - new Date(b.changedAt)
  );

  container.innerHTML = sorted
    .map((h) => {
      return `
        <div class="mb-3">
          <span class="${getStatusColor(h.status)}">${translateBookingStatus(h.status)}</span>
          ${h.changedBy ? `- Cập nhật bởi <b>${h.changedBy}</b>` : ""}
          (${formatDateTime(h.changedAt)})
        </div>
      `;
    })
    .join("");
}

function getStatusColor(status) {
  const map = {
    PENDING: "text-warning",
    CONFIRMED: "text-success",
    CHECKED_IN: "text-primary",
    CHECKED_OUT: "text-secondary",
    CANCELLED: "text-danger",
  };

  return map[status] || "bg-light";
}

// ================== EVENTS ==================
document.addEventListener("DOMContentLoaded", () => {
  loadBookings();

  document.getElementById("booking-status-filter").onchange = () => {
    currentPage = 0;
    loadBookings();
  };

  document.getElementById("payment-status-filter").onchange = () => {
    currentPage = 0;
    loadBookings();
  };

  document.getElementById("sort-by").onchange = () => {
    currentPage = 0;
    loadBookings();
  };

  document.getElementById("search-by-booking-code").onkeyup = () => {
    currentPage = 0;
    loadBookings();
  };
});