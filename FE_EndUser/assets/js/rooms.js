document.addEventListener("DOMContentLoaded", () => {
  const checkIn = document.getElementById("check-in-date");
  const checkOut = document.getElementById("check-out-date");
  const adultsInput = document.getElementById("adults");
  const childrenInput = document.getElementById("children");
  const roomTypeSelect = document.getElementById("room-type-id");
  const viewSelect = document.getElementById("view-id");
  const sortBySelect = document.getElementById("sort-by");

  const today = new Date();
  const tomorrow = new Date();
  tomorrow.setDate(today.getDate() + 1);

  function formatDate(date) {
    return date.toISOString().split("T")[0];
  }

  // default value
  checkIn.value = formatDate(today);
  checkOut.value = formatDate(tomorrow);

  // min date
  checkIn.min = formatDate(today);
  checkOut.min = formatDate(tomorrow);

  checkIn.addEventListener("change", () => {
    const checkInDate = new Date(checkIn.value);
    const nextDay = new Date(checkInDate);
    nextDay.setDate(checkInDate.getDate() + 1);

    checkOut.min = formatDate(nextDay);

    const checkOutDate = new Date(checkOut.value);

    if (checkOutDate <= checkInDate) {
      checkOut.value = formatDate(nextDay);
    }
  });

  // load room types
  async function loadRoomTypes() {
    try {
      const response = await callAPI("/room-types");
      const roomTypes = response.result || response;
      const select = document.getElementById("room-type-id");
      select.innerHTML = '<option value="">Tất cả</option>';
      roomTypes.forEach((roomType) => {
        const option = document.createElement("option");
        option.value = roomType.roomTypeId;
        option.textContent = roomType.roomTypeName;
        select.appendChild(option);
      });
    } catch (error) {
      console.error("Failed to load room types:", error);
    }
  }

  // load views
  async function loadViews() {
    try {
      const response = await callAPI("/views");
      const views = response.result || response;
      const select = document.getElementById("view-id");
      select.innerHTML = '<option value="">Tất cả</option>';
      views.forEach((view) => {
        const option = document.createElement("option");
        option.value = view.viewId;
        option.textContent = view.viewName;
        select.appendChild(option);
      });
    } catch (error) {
      console.error("Failed to load views:", error);
    }
  }

  // Load available rooms
  async function loadAvailableRooms() {
    try {
      // Build query parameters
      let endpoint = "/rooms/available?";
      const params = new URLSearchParams();

      params.append("checkInDate", checkIn.value);
      params.append("checkOutDate", checkOut.value);
      params.append("adults", adultsInput.value || 0);
      params.append("children", childrenInput.value || 0);

      // Add optional filters
      if (roomTypeSelect.value) {
        params.append("roomTypeId", roomTypeSelect.value);
      }

      if (viewSelect.value) {
        params.append("viewId", viewSelect.value);
      }

      // Handle sort
      const sortValue = sortBySelect.value;
      if (sortValue === "Giá: Cao đến Thấp") {
        params.append("sort", "basePrice,desc");
      } else {
        params.append("sort", "basePrice,asc");
      }

      endpoint += params.toString();

      const response = await callAPI(endpoint);
      const rooms = response.result?.content || response.content || [];

      // Render rooms
      renderRooms(rooms);
    } catch (error) {
      console.error("Failed to load available rooms:", error);
      const roomsGrid = document.querySelector(".rooms-grid .row");
      roomsGrid.innerHTML =
        '<div class="col-12"><p class="text-center text-danger">Lỗi khi tải phòng. Vui lòng thử lại.</p></div>';
    }
  }

  // Render rooms dynamically
  function renderRooms(rooms) {
    const roomsGrid = document.querySelector(".rooms-grid .row");

    if (!rooms || rooms.length === 0) {
      roomsGrid.innerHTML =
        '<div class="col-12"><p class="text-center">Không tìm thấy phòng trống. Vui lòng thử lại với tiêu chí khác.</p></div>';
      return;
    }

    roomsGrid.innerHTML = "";

    rooms.forEach((room) => {
      const roomCard = document.createElement("div");
      roomCard.className = "col-xl-4 col-lg-6";
      roomCard.innerHTML = `
        <div class="room-card">
          <div class="room-image">
            <img src="${room.mainImageUrl || "assets/img/hotel/room-1.webp"}" alt="${room.roomName}" class="img-fluid main-image">
            <div class="room-features">
              <span class="feature-badge city view-name">${room.viewName}</span>
            </div>
          </div>
          <div class="room-content">
            <div class="room-header">
              <h3 class="room-name">${room.roomName}</h3>
            </div>
            <p class="room-description">${room.description}</p>
            <div class="room-amenities">
              <span class="adults"><i class="bi bi-people"></i>Số người lớn: ${room.maxAdults}</span>
              <span class="children"><i class="bi bi-people"></i>Số trẻ em: ${room.maxChildren}</span>
              <span class="floor"><i class="bi bi-layers"></i>Tầng ${room.floor}</span>
            </div>
            <div class="room-footer">
              <div class="room-price">
                <span class="price-from">Chỉ từ</span>
                <span class="price-amount final-price">${room.finalPrice.toLocaleString("vi-VN")}đ</span>
                <span class="price-period nights">/ ${room.nights} đêm</span>
              </div>
              <a href="room-details.html?roomId=${room.roomId}&checkInDate=${checkIn.value}&checkOutDate=${checkOut.value}" class="btn-room-details">Xem chi tiết</a>
            </div>
          </div>
        </div>
      `;
      roomsGrid.appendChild(roomCard);
    });
  }

  // Add event listeners for filter changes
  checkIn.addEventListener("change", loadAvailableRooms);
  checkOut.addEventListener("change", loadAvailableRooms);
  adultsInput.addEventListener("change", loadAvailableRooms);
  childrenInput.addEventListener("change", loadAvailableRooms);
  roomTypeSelect.addEventListener("change", loadAvailableRooms);
  viewSelect.addEventListener("change", loadAvailableRooms);
  sortBySelect.addEventListener("change", loadAvailableRooms);

  // Initialize: load dropdowns first, then load rooms
  Promise.all([loadRoomTypes(), loadViews()]).then(() => {
    loadAvailableRooms();
  });
});
