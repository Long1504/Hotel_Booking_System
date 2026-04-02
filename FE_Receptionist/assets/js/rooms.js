if (!localStorage.getItem("tokenHotelBookingReceptionist")) {
  window.location.href = "login.html";
}

// Load danh sách loại phòng và điền vào select filter
async function loadRoomTypes() {
  try {
    const data = await callAPI("/room-types/summary");
    const select = document.getElementById("room-type-filter");
    if (select) {
      select.innerHTML = '<option value="">Tất cả</option>';
      data.result.forEach((roomType) => {
        const option = document.createElement("option");
        option.value = roomType.roomTypeId;
        option.textContent = roomType.roomTypeName;
        select.appendChild(option);
      });
    }
  } catch (error) {
    console.error("Lỗi khi tải loại phòng:", error);
  }
}

// Load danh sách view và điền vào select filter
async function loadViews() {
  try {
    const data = await callAPI("/views/summary");
    const select = document.getElementById("view-filter");
    if (select) {
      select.innerHTML = '<option value="">Tất cả</option>';
      data.result.forEach((view) => {
        const option = document.createElement("option");
        option.value = view.viewId;
        option.textContent = view.viewName;
        select.appendChild(option);
      });
    }
  } catch (error) {
    console.error("Lỗi khi tải view:", error);
  }
}

let roomMap = {};

// Load danh sách phòng trống
async function loadRooms(page = 0) {
  try {
    // Lấy giá trị từ filters
    let checkInDate = document.getElementById("check-in-date-filter").value;
    let checkOutDate = document.getElementById("check-out-date-filter").value;
    let adults = parseInt(document.getElementById("adults-filter").value) || 1;
    let children = parseInt(document.getElementById("children-filter").value) || 0;
    const roomTypeId = document.getElementById("room-type-filter").value;
    const viewId = document.getElementById("view-filter").value;
    const sortBy = document.getElementById("sort-by").value;

    // Set default dates nếu rỗng
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);
    if (!checkInDate) checkInDate = today.toISOString().split("T")[0];
    if (!checkOutDate) checkOutDate = tomorrow.toISOString().split("T")[0];

    // Build query params
    const params = new URLSearchParams({
      checkInDate,
      checkOutDate,
      adults,
      children,
      page,
      size: 10,
      sort: sortBy === "Giá: Thấp đến Cao" ? "basePrice,asc" : "basePrice,desc",
    });
    if (roomTypeId) params.append("roomTypeId", roomTypeId);
    if (viewId) params.append("viewId", viewId);

    const data = await callAPI(`/rooms/available?${params.toString()}`);

    // Lưu map để show modal chi tiết
    roomMap = {};
    data.result.content.forEach((room) => {
      roomMap[room.roomId] = room;
    });

    const tbody = document.querySelector("#rooms-table tbody");
    if (tbody) {
      tbody.innerHTML = ""; // Clear existing rows
      if (data.result.content.length === 0) {
        tbody.innerHTML =
          '<tr><td colspan="10" class="text-center">Không có phòng trống phù hợp.</td></tr>';
      } else {
        data.result.content.forEach((room, index) => {
          const row = document.createElement("tr");
          row.innerHTML = `
                        <td class="align-content-center"><img src="${room.mainImageUrl}" style="height: 60px; width: 100px; object-fit: cover; border-radius: 8px;" alt="${room.roomName}"></td>
                        <td class="align-content-center">${room.roomName}</td>
                        <td class="align-content-center">${room.floor}</td>
                        <td class="align-content-center">${room.roomNumber}</td>
                        <td class="align-content-center">${room.maxAdults} người lớn - ${room.maxChildren} trẻ em</td>
                        <td class="align-content-center">${room.area}m²</td>
                        <td class="align-content-center">${room.roomTypeName}</td>
                        <td class="align-content-center">${room.viewName}</td>
                        <td class="align-content-center">${room.finalPrice.toLocaleString("vi-VN")}đ / ${room.nights} đêm</td>
                        <td class="align-content-center">
                            <button class="btn btn-sm btn-primary text-white" data-bs-toggle="modal" data-bs-target="#room-detail" onclick="showRoomDetail('${room.roomId}')">
                              <i class="bx bx-info-circle"></i>
                            </button>
                            <button class="btn btn-sm btn-success text-white" data-bs-toggle="modal" data-bs-target="#booking" onclick="prepareBooking('${room.roomId}', '${room.roomName}', ${room.floor}, '${room.roomNumber}', ${room.finalPrice}, ${room.nights})">
                              <i class="bx bx-calendar-check"></i>
                            </button>
                        </td>
                    `;
          tbody.appendChild(row);
        });
      }
    }

    // Render pagination
    renderPagination(data.result.totalPages, data.result.number);
  } catch (error) {
    console.error("Lỗi khi tải phòng:", error);
    // Hiển thị thông báo lỗi
    const tbody = document.querySelector("table.table tbody");
    if (tbody) {
      tbody.innerHTML =
        '<tr><td colspan="10" class="text-center text-danger">Lỗi khi tải danh sách phòng. Vui lòng thử lại.</td></tr>';
    }
  }
}

// Render pagination
function renderPagination(totalPages, currentPage) {
  const ul = document.getElementById("pagination-controls");
  if (!ul) return;

  ul.innerHTML = "";

  // Prev button
  const prevLi = document.createElement("li");
  prevLi.className = `page-item ${currentPage === 0 ? "disabled" : ""}`;
  prevLi.innerHTML = `<a class="page-link" href="#" onclick="if(${currentPage} > 0) loadRooms(${currentPage - 1})">&laquo;</a>`;
  ul.appendChild(prevLi);

  // Page numbers
  const startPage = Math.max(0, currentPage - 2);
  const endPage = Math.min(totalPages - 1, currentPage + 2);

  for (let i = startPage; i <= endPage; i++) {
    const li = document.createElement("li");
    li.className = `page-item ${i === currentPage ? "active" : ""}`;
    li.innerHTML = `<a class="page-link" href="#" onclick="loadRooms(${i})">${i + 1}</a>`;
    ul.appendChild(li);
  }

  // Next button
  const nextLi = document.createElement("li");
  nextLi.className = `page-item ${currentPage === totalPages - 1 ? "disabled" : ""}`;
  nextLi.innerHTML = `<a class="page-link" href="#" onclick="if(${currentPage} < ${totalPages - 1}) loadRooms(${currentPage + 1})">&raquo;</a>`;
  ul.appendChild(nextLi);
}

// Load chi tiết phòng - Fetch từ API với filter dates
async function showRoomDetail(roomId) {
  try {
    // Get filter dates từ input fields
    const checkInDate = document.getElementById("check-in-date-filter").value;
    const checkOutDate = document.getElementById("check-out-date-filter").value;

    // Fetch room detail từ API
    const data = await callAPI(
      `/rooms/available/${roomId}?checkInDate=${checkInDate}&checkOutDate=${checkOutDate}`,
    );

    const room = data.result;
    if (!room) return;

    const setText = (id, value) => {
      const el = document.getElementById(id);
      if (el) el.innerText = value ?? "";
    };

    setText("detail-room-name", room.roomName);
    setText("detail-floor", room.floor);
    setText("detail-room-number", room.roomNumber);
    setText(
      "detail-total-price",
      `${room.finalPrice.toLocaleString("vi-VN")}đ / ${room.nights} đêm`,
    );
    setText("detail-area", `${room.area}m²`);
    setText(
      "detail-capacity",
      `${room.maxAdults} người lớn - ${room.maxChildren} trẻ em`,
    );
    setText("detail-room-type", room.roomTypeName || "");
    setText("detail-view", room.viewName || "");
    setText("detail-description", room.description || "");

    // Update ảnh trong modal (dựa trên room.roomImages)
    const imagesContainer = document.getElementById("detail-room-images");
    if (imagesContainer) {
      imagesContainer.innerHTML = "";
      (room.roomImages || []).forEach((img) => {
        const col = document.createElement("div");
        col.className = "col-2";
        col.innerHTML = `<img src="${img.imageUrl}" style="height: 70px; width: 100px; object-fit: cover; border-radius: 8px;" alt="${room.roomName}">`;
        imagesContainer.appendChild(col);
      });
    }

    // Update tiện nghi
    const amenitiesEl = document.getElementById("detail-amenities");
    if (amenitiesEl) {
      amenitiesEl.innerText = (room.amenities || []).join(", ");
    }
  } catch (error) {
    console.error("Lỗi khi tải chi tiết phòng:", error);
  }
}

function prepareBooking(
  roomId,
  roomName,
  floor,
  roomNumber,
  finalPrice,
  nights,
) {
  // Pre-fill room info
  document.getElementById("room-name").value = roomName;
  document.getElementById("floor").value = floor;
  document.getElementById("room-number").value = roomNumber;
  document.getElementById("total-price").value = `${finalPrice.toLocaleString("vi-VN")}đ / ${nights} đêm`;
  document.getElementById("room-id").value = roomId;

  // Pre-fill dates from filters
  document.getElementById("check-in-date").value = document.getElementById("check-in-date-filter",).value;
  document.getElementById("check-out-date").value = document.getElementById("check-out-date-filter",).value;

  // Pre-fill guests from filters
  document.getElementById("adults").value = document.getElementById("adults-filter").value || 1;
  document.getElementById("children").value = document.getElementById("children-filter").value || 0;

  console.log("Prepare booking for room:", roomId);
}

// Set default dates và validation
function setDefaultDates() {
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);

  const checkInInput = document.getElementById("check-in-date-filter");
  const checkOutInput = document.getElementById("check-out-date-filter");

  // Set min cho check-in là today
  checkInInput.min = today.toISOString().split("T")[0];

  // Set default check-in nếu rỗng
  if (!checkInInput.value) {
    checkInInput.value = today.toISOString().split("T")[0];
  }

  // Set default check-out nếu rỗng hoặc invalid
  if (
    !checkOutInput.value ||
    new Date(checkOutInput.value) <= new Date(checkInInput.value)
  ) {
    checkOutInput.value = tomorrow.toISOString().split("T")[0];
  }

  // Set min cho check-out là check-in + 1
  const minCheckOut = new Date(checkInInput.value);
  minCheckOut.setDate(minCheckOut.getDate() + 1);
  checkOutInput.min = minCheckOut.toISOString().split("T")[0];
}

// Event listener cho check-in change
document
  .getElementById("check-in-date-filter")
  .addEventListener("change", function () {
    const checkInDate = new Date(this.value);
    const checkOutInput = document.getElementById("check-out-date-filter");
    const checkOutDate = new Date(checkOutInput.value);

    // Nếu check-out <= check-in, set check-out = check-in + 1
    if (checkOutDate <= checkInDate) {
      const newCheckOut = new Date(checkInDate);
      newCheckOut.setDate(newCheckOut.getDate() + 1);
      checkOutInput.value = newCheckOut.toISOString().split("T")[0];
    }

    // Update min cho check-out
    const minCheckOut = new Date(checkInDate);
    minCheckOut.setDate(minCheckOut.getDate() + 1);
    checkOutInput.min = minCheckOut.toISOString().split("T")[0];

    // Reload rooms
    loadRooms();
  });

document.addEventListener("DOMContentLoaded", async () => {
  setDefaultDates();
  await loadRoomTypes();
  await loadViews();
  loadRooms(0);

  // Reload rooms khi filters thay đổi (trừ check-in vì đã handle riêng)
  const filters = [
    "check-out-date-filter",
    "adults-filter",
    "children-filter",
    "room-type-filter",
    "view-filter",
    "sort-by",
  ];
  filters.forEach((id) => {
    document.getElementById(id).addEventListener("change", loadRooms);
  });
});

// Đặt phòng
document
  .getElementById("booking-form")
  .addEventListener("submit", async function (e) {
    e.preventDefault();

    try {
      const data = {
        checkInDate: document.getElementById("check-in-date").value,
        checkOutDate: document.getElementById("check-out-date").value,
        guestName: document.getElementById("guest-name").value,
        guestPhone: document.getElementById("phone").value,
        guestEmail: document.getElementById("email").value,
        identityCard: document.getElementById("identity-card").value,
        adults: parseInt(document.getElementById("adults").value),
        children: parseInt(document.getElementById("children").value),
        note: document.getElementById("note").value,
        roomId: document.getElementById("room-id").value,
      };

      const response = await callAPI("/bookings", "POST", data);

      if (response.code === 1000) {
        const result = response.result;

        // Đóng modal booking
        const bookingModal = bootstrap.Modal.getInstance(
          document.getElementById("booking"),
        );
        bookingModal.hide();

        document.getElementById("booking-form").reset();

        loadRooms();

        // Điền dữ liệu vào modal booking-info
        fillBookingInfo(result);

        // Mở modal thông tin
        const infoModal = new bootstrap.Modal(
          document.getElementById("booking-info"),
        );
        infoModal.show();
      } else {
        alert(response.message || "Đặt phòng thất bại");
      }
    } catch (error) {
      console.error("Booking error:", error);
      alert("Lỗi khi đặt phòng");
    }
  });

function fillBookingInfo(booking) {
  const setValue = (id, value) => {
    const el = document.querySelector(`#booking-info #${id}`);
    if (el) el.value = value ?? "";
  };

  setValue("booking-code", booking.bookingCode);
  setValue("check-in-date", booking.checkInDate);
  setValue("check-out-date", booking.checkOutDate);
  setValue("guest-name", booking.guestName);
  setValue("email", booking.guestEmail);
  setValue("phone", booking.guestPhone);
  setValue("identity-card", booking.identityCard);
  setValue("adults", booking.adults);
  setValue("children", booking.children);
  setValue("note", booking.note);

  if (booking.room) {
    setValue("room-name", booking.room.roomName);
    setValue("floor", booking.room.floor);
    setValue("room-number", booking.room.roomNumber);
  }

  const totalPrice = booking.totalPrice?.toLocaleString("vi-VN") + "đ";
  setValue("total-price", totalPrice);
}
