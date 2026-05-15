// format tiền
function formatPrice(price) {
  return price.toLocaleString("vi-VN") + "đ";
}

// ngày hiện tại + ngày mai
function getTodayAndTomorrow() {
  const today = new Date();
  const tomorrow = new Date();
  tomorrow.setDate(today.getDate() + 1);

  const format = (d) => d.toISOString().split("T")[0];

  return {
    checkIn: format(today),
    checkOut: format(tomorrow)
  };
}

const { checkIn, checkOut } = getTodayAndTomorrow();

// load dữ liệu
async function loadRoomsHome() {
  try {

    const res = await callAPI(
      `/rooms/available?checkInDate=${checkIn}&checkOutDate=${checkOut}`
    );

    const rooms = res.result.content;

    if (!rooms || rooms.length === 0) return;

    // ===== HERO =====
    renderHeroRoom(rooms[0]);

    // ===== STANDARD (3 phòng tiếp theo) =====
    renderStandardRooms(rooms.slice(1, 4));

    // ===== MINIMAL (4 phòng tiếp theo) =====
    renderMinimalRooms(rooms.slice(4, 8));

  } catch (e) {
    console.error("Lỗi load phòng:", e);
  }
}

// ===== HERO =====
function renderHeroRoom(room) {
  const container = document.querySelector(".hero-room-showcase");

  container.innerHTML = `
    <div class="showcase-image-container">
      <img src="${room.mainImageUrl}" alt="${room.roomName}" class="img-fluid">
      <div class="room-category-badge">
        <span>${room.roomTypeName}</span>
      </div>
      <div class="room-details-overlay">
        <div class="room-specs">
          <span class="spec-item">
            <i class="bi bi-people"></i>
            <span>${room.maxAdults + room.maxChildren} khách</span>
          </span>
          <span class="spec-item">
            <i class="bi bi-house"></i>
            <span>${room.area}m²</span>
          </span>
          <span class="spec-item">
            <i class="bi bi-geo-alt"></i>
            <span>Tầng ${room.floor}</span>
          </span>
        </div>
      </div>
    </div>

    <div class="showcase-content">
      <div class="room-title-section">
        <h2 class="fw-normal">${room.roomName}</h2>
      </div>
      <p class="room-description" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${room.description}</p>
      <div class="booking-section">
        <div class="price-display">
          <span class="amount fw-light">${formatPrice(room.finalPrice)}</span>
          <span class="period"> / đêm</span>
        </div>
        <a href="room-details.html?roomId=${room.roomId}&checkInDate=${checkIn}&checkOutDate=${checkOut}" class="primary-booking-btn">Xem phòng</a>
      </div>
    </div>
  `;
}

// ===== STANDARD =====
function renderStandardRooms(rooms) {
  const container = document.querySelector(".room-list-container");

  container.innerHTML = rooms.map((room) => `
    <div class="standard-room-card">
      <div class="card-image">
        <img src="${room.mainImageUrl}" class="img-fluid">
      </div>
      <div class="card-content">
        <h4>${room.roomName}</h4>
        <p style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${room.description}</p>
        <div class="features-list">
          <span><i class="bi bi-people"></i>Người lớn: ${room.maxAdults}</span>
          <span><i class="bi bi-people"></i>Trẻ em: ${room.maxChildren}</span>
          <span><i class="bi bi-layers"></i>Tầng ${room.floor}</span>
        </div>
        <div class="booking-row">
          <div class="price">${formatPrice(room.finalPrice)}<small> / đêm</small></div>
          <a href="room-details.html?roomId=${room.roomId}&checkInDate=${checkIn}&checkOutDate=${checkOut}" class="book-link">Xem phòng</a>
        </div>
      </div>
    </div>
  `).join("");
}

// ===== MINIMAL =====
function renderMinimalRooms(rooms) {
  const container = document.querySelector(".row.mt-6");

  container.innerHTML = rooms.map((room) => `
    <div class="col-lg-3 col-sm-6">
      <div class="minimal-room-card">
        <div class="room-image">
          <img src="${room.mainImageUrl}" class="img-fluid">
          <div class="hover-overlay">
            <a href="room-details.html?roomId=${room.roomId}&checkInDate=${checkIn}&checkOutDate=${checkOut}" class="view-room">
              <i class="bi bi-eye"></i>
            </a>
          </div>
        </div>
        <div class="room-summary">
          <h5>${room.roomName}</h5>
          <div class="price-tag">${formatPrice(room.finalPrice)}<span> / đêm</span></div>
        </div>
      </div>
    </div>
  `).join("");
}

// chạy khi load trang
document.addEventListener("DOMContentLoaded", loadRoomsHome);