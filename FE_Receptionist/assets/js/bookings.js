if (!localStorage.getItem("tokenHotelBookingReceptionist")) {
  window.location.href = "login.html";
}

let currentPage = 0;
let pageSize = 10;

let currentBookingId = null;

let highlightBookingCode = null;

let currentBooking = null;

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
    tr.querySelector("button").addEventListener("click", () =>
      showBookingDetail(b),
    );

    tbody.appendChild(tr);

    // Nếu có highlightBookingCode
    if (highlightBookingCode && b.bookingCode === highlightBookingCode) {
      setTimeout(() => showBookingDetail(b), 300);
    }
  });
}

function renderBookingDetail(booking) {
  currentBooking = booking;

  document.getElementById("booking-code").innerText = booking.bookingCode;
  document.getElementById("check-in-out-date").innerText =
    formatDate(booking.checkInDate) + " - " + formatDate(booking.checkOutDate);

  document.getElementById("guest-name").innerText = booking.guestName;
  document.getElementById("guest-phone").innerText = booking.guestPhone;
  document.getElementById("guest-email").innerText = booking.guestEmail;

  document.getElementById("identity-card-input").value =
    booking.identityCard || "";

  document.getElementById("adults-children").innerText =
    booking.adults + " người lớn - " + booking.children + " trẻ em";

  document.getElementById("note").innerText = booking.note || "";
  document.getElementById("room-price").innerText = formatCurrency(
    booking.roomPrice,
  );
  document.getElementById("service-price").innerText = formatCurrency(
    calculateServicePrice(booking),
  );

  document.getElementById("extra-price").innerText = formatCurrency(
    calculateExtraPrice(booking),
  );

  document.getElementById("createdAt").innerText = formatDateTime(
    booking.createdAt,
  );

  document.getElementById("total-price").innerText = formatCurrency(
    booking.totalPrice,
  );

  currentBookingId = booking.bookingId;

  document.getElementById("modal-booking-status").innerHTML =
    bookingStatusOptions(booking.bookingStatus);

  document.getElementById("modal-payment-status").innerHTML =
    paymentStatusOptions(booking.paymentStatus);

  const paymentMethodSelect = document.getElementById("modal-payment-method");
  paymentMethodSelect.value = booking.paymentMethod || "CASH";
  paymentMethodSelect.setAttribute("data-old", paymentMethodSelect.value);

  toggleVNPayButton();

  document.getElementById("room-name").innerText = booking.room.roomName;
  document.getElementById("room-number").innerText = booking.room.roomNumber;
  document.getElementById("floor").innerText = booking.room.floor;
  document.getElementById("area").innerText = booking.room.area + " m²";
  document.getElementById("room-type").innerText = booking.room.roomTypeName;
  document.getElementById("view").innerText = booking.room.viewName;

  document.getElementById("main-image").src = booking.room.mainImageUrl;

  loadServicesForModal(booking.bookingServices);
  renderExtras(booking.extras || []);
}

function showBookingDetail(booking) {
  renderBookingDetail(booking);

  const modal = new bootstrap.Modal(document.getElementById("booking-detail"));
  modal.show();
}

function calculateServicePrice(booking) {
  if (!booking.bookingServices || booking.bookingServices.length === 0) {
    return 0;
  }

  return booking.bookingServices.reduce((total, service) => {
    return total + (service.totalPrice || 0);
  }, 0);
}

function calculateExtraPrice(booking) {
  if (!booking.extras || booking.extras.length === 0) return 0;

  return booking.extras.reduce((sum, e) => sum + (e.amount || 0), 0);
}

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

function toggleVNPayButton() {
  const method = document.getElementById("modal-payment-method").value;
  const btn = document.getElementById("btn-vnpay");

  if (method === "VNPAY") {
    btn.classList.remove("d-none");
  } else {
    btn.classList.add("d-none");
  }
}

let allServices = [];

async function loadServicesForModal(bookingServices = []) {
  try {
    const res = await fetch(
      API_BASE + "/services/summary",
    );
    const data = await res.json();

    allServices = data.result;

    renderServiceList(bookingServices);
  } catch (e) {
    console.error("Lỗi load services:", e);
  }
}

function renderServiceList(bookingServices = []) {
  const container = document.getElementById("service-list");
  container.innerHTML = "";

  allServices.forEach((service) => {
    const selected = bookingServices.find(
      (bs) => bs.serviceId === service.serviceId,
    );

    const isChecked = !!selected;
    const quantity = selected ? selected.quantity : 1;

    const col = document.createElement("div");
    col.className = "col-6 mb-2";

    col.innerHTML = `
      <div class="form-check border rounded ps-2 pe-2 pt-1 pb-1 d-flex align-items-center">
        <input class="form-check-input service-checkbox m-0 me-2"
          type="checkbox"
          value="${service.serviceId}"
          id="service-${service.serviceId}"
          ${isChecked ? "checked" : ""}>

        <div class="flex-grow-1">
          <label class="form-check-label fw-semibold" for="service-${service.serviceId}">
            ${service.serviceName}
          </label>

          <div class="text-muted small">
            Đơn giá: ${service.basePrice.toLocaleString()}đ
          </div>
        </div>

        <input type="number"
          class="form-control form-control-sm service-qty"
          style="width: 50px;"
          min="1"
          value="${quantity}"
          data-id="${service.serviceId}"
          ${isChecked ? "" : "disabled"}>
      </div>
    `;

    container.appendChild(col);
  });

  // enable/disable quantity
  document.querySelectorAll(".service-checkbox").forEach((cb) => {
    cb.addEventListener("change", function () {
      const qtyInput =
        this.closest(".form-check").querySelector(".service-qty");
      qtyInput.disabled = !this.checked;
    });
  });
}

function getSelectedServicesFromUI() {
  const result = [];

  document.querySelectorAll(".service-checkbox").forEach((cb) => {
    const serviceId = cb.value;
    const qtyInput = cb.closest(".form-check").querySelector(".service-qty");

    if (cb.checked) {
      result.push({
        serviceId: serviceId,
        quantity: parseInt(qtyInput.value),
      });
    }
  });

  return result;
}

function diffServices(original, current) {
  const toAdd = [];
  const toUpdate = [];
  const toDelete = [];

  console.log("Original Map:", original);
  console.log("Current Map:", current);

  const originalMap = new Map();
  original.forEach((s) => originalMap.set(s.serviceId, s));

  const currentMap = new Map();
  current.forEach((s) => currentMap.set(s.serviceId, s));

  // ADD + UPDATE
  current.forEach((s) => {
    if (!originalMap.has(s.serviceId)) {
      toAdd.push(s);
    } else {
      const old = originalMap.get(s.serviceId);
      if (old.quantity !== s.quantity) {
        toUpdate.push({
          bookingServiceId: old.bookingServiceId,
          quantity: s.quantity,
        });
      }
    }
  });

  // DELETE
  original.forEach((s) => {
    if (!currentMap.has(s.serviceId)) {
      toDelete.push(s.bookingServiceId);
    }
  });

  return { toAdd, toUpdate, toDelete };
}

async function addService(bookingId, data) {
  return callAPIWithAuth(`/bookings/${bookingId}/services`, "POST", data);
}

async function updateService(bookingId, bookingServiceId, quantity) {
  return callAPIWithAuth(
    `/bookings/${bookingId}/services/${bookingServiceId}`,
    "PUT",
    { quantity },
  );
}

async function deleteService(bookingId, bookingServiceId) {
  return callAPIWithAuth(
    `/bookings/${bookingId}/services/${bookingServiceId}`,
    "DELETE",
  );
}

async function saveServices() {
  if (!currentBooking || !currentBookingId) return;

  const current = getSelectedServicesFromUI();
  const { toAdd, toUpdate, toDelete } = diffServices(
    currentBooking.bookingServices,
    current,
  );

  try {
    // ADD
    for (const s of toAdd) {
      await addService(currentBookingId, s);
    }

    // UPDATE
    for (const s of toUpdate) {
      await updateService(currentBookingId, s.bookingServiceId, s.quantity);
    }

    // DELETE
    for (const id of toDelete) {
      await deleteService(currentBookingId, id);
    }

    alert("Cập nhật dịch vụ thành công");

    await reloadCurrentBooking();
    loadBookings();
  } catch (e) {
    console.error(e);
    alert("Lỗi cập nhật dịch vụ");
  }
}

function renderExtras(extras = []) {
  const container = document.getElementById("extra-list");
  container.innerHTML = "";

  // Render data (Nút xóa)
  extras.forEach((e) => createExtraRow(e, false));

  // Dòng cuối (Nút thêm)
  createExtraRow({}, true);
}

function createExtraRow(data = {}, isLast = false) {
  const container = document.getElementById("extra-list");

  const row = document.createElement("div");
  row.className = "row mb-2 extra-row";

  row.innerHTML = `
    <div class="col-md-4">
      <input type="number" placeholder="Số tiền..." class="form-control form-control-sm extra-amount"
        value="${data.amount || ""}">
    </div>
    <div class="col-md-6">
      <input type="text" placeholder="Ghi chú..." class="form-control form-control-sm extra-note"
        value="${data.note || ""}">
    </div>
    <div class="col-md-2">
      ${
        isLast
          ? `<button class="btn btn-success btn-sm w-100 btn-add">Thêm</button>`
          : `<button class="btn btn-danger btn-sm w-100 btn-delete">Xóa</button>`
      }
    </div>
  `;

  container.appendChild(row);

  // ADD
  const btnAdd = row.querySelector(".btn-add");
  if (btnAdd) {
    btnAdd.onclick = async () => {
      const amount = row.querySelector(".extra-amount").value;
      const note = row.querySelector(".extra-note").value;

      if (!amount && !note) {
        return alert("Nhập dữ liệu trước!");
      }

      try {
        await callAPIWithAuth(`/bookings/${currentBookingId}/extras`, "POST", {
          amount: Number(amount),
          note: note,
        });

        alert("Thêm thành công");

        await reloadCurrentBooking();
        loadBookings();
      } catch (e) {
        console.error(e);
        alert("Lỗi thêm phụ phí");
      }
    };
  }

  // DELETE
  const btnDelete = row.querySelector(".btn-delete");
  if (btnDelete) {
    btnDelete.onclick = async () => {
      if (!data.extraId) return;

      if (!confirm("Xóa phụ phí này?")) return;

      try {
        await callAPIWithAuth(
          `/bookings/${currentBookingId}/extras/${data.extraId}`,
          "DELETE",
        );

        alert("Xóa thành công");

        await reloadCurrentBooking();
        loadBookings();
      } catch (e) {
        console.error(e);
        alert("Lỗi xóa");
      }
    };
  }
}

async function reloadCurrentBooking() {
  if (!currentBookingId) return;

  try {
    const res = await callAPIWithAuth(`/bookings/${currentBookingId}`);
    renderBookingDetail(res.result);
  } catch (e) {
    console.error("Lỗi reload booking:", e);
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
        await reloadCurrentBooking();
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

        await reloadCurrentBooking();
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

        await reloadCurrentBooking();
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
        // window.location.href = res.result; // redirect sang VNPay
        const paymentUrl = res.result;

        window.open(paymentUrl, "_blank");
      } else {
        alert(res.message);
      }
    } catch (e) {
      console.error("Lỗi khi tạo thanh toán VNPay:", e);
      alert("Không tạo được thanh toán VNPay");
    }
  });

  // Sự kiện cập nhật CCCD
  document
    .getElementById("btn-update-cccd")
    .addEventListener("click", async () => {
      const newCCCD = document
        .getElementById("identity-card-input")
        .value.trim();
      if (!newCCCD || !currentBookingId) return alert("Vui lòng nhập CCCD");

      if (!confirm("Bạn có chắc muốn cập nhật số CCCD?")) return;

      try {
        const res = await callAPIWithAuth(
          `/bookings/${currentBookingId}/identity-card`,
          "PUT",
          { identityCard: newCCCD },
        );
        if (res.code === 1000 && res.result) {
          alert("Cập nhật CCCD thành công!");

          await reloadCurrentBooking();
          loadBookings();
        } else {
          alert(res.message || "Cập nhật CCCD thất bại");
        }
      } catch (e) {
        console.error("Lỗi cập nhật CCCD:", e);
        alert("Không thể cập nhật CCCD");
      }
    });
});
