document.addEventListener("DOMContentLoaded", async () => {
  const params = new URLSearchParams(window.location.search);

  const roomId = params.get("roomId");
  const checkInDate = params.get("checkInDate");
  const checkOutDate = params.get("checkOutDate");

  if (!roomId || !checkInDate || !checkOutDate) {
    console.error("Thiếu tham số URL");
    return;
  }

  try {
    const endpoint = `/rooms/available/${roomId}?checkInDate=${checkInDate}&checkOutDate=${checkOutDate}`;
    const response = await callAPI(endpoint);

    const room = response.result;

    renderRoomDetails(room);
  } catch (error) {
    console.error("Lỗi khi tải chi tiết phòng:", error);
  }
});

function renderRoomDetails(room) {
  // Tên phòng
  document.querySelectorAll(".room-name").forEach((e) => {
    e.textContent = room.roomName;
  });

  // Loại phòng
  const roomType = document.querySelector(".room-type-name");
  if (roomType) roomType.textContent = room.roomTypeName;

  // View
  const viewName = document.querySelector(".view-name");
  if (viewName) viewName.textContent = room.viewName;

  // Mô tả
  const description = document.querySelector(".description");
  if (description) description.textContent = room.description;

  // Giá phòng
  const price = Number(room.finalPrice).toLocaleString("vi-VN") + "đ";

  document.querySelectorAll(".final-price").forEach((e) => {
    e.textContent = price;
  });

  document.querySelectorAll(".nights").forEach((e) => {
    e.textContent = `/ ${room.nights} đêm`;
  });

  // Sức chứa
  const capacity = document.querySelector(".adults-children");
  if (capacity) {
    capacity.textContent = `Tối đa ${room.maxAdults} người lớn và ${room.maxChildren} trẻ em`;
  }

  // Tầng
  const floor = document.querySelector(".floor");
  if (floor) {
    floor.textContent = `Tầng ${room.floor}`;
  }

  // Diện tích
  const area = document.querySelector(".area");
  if (area) {
    area.textContent = `Diện tích ${room.area}m²`;
  }

  // Tiện nghi
  const amenitiesList = document.querySelector(".room-amenities ul");

  if (amenitiesList) {
    amenitiesList.innerHTML = "";

    room.amenities.forEach((a) => {
      const li = document.createElement("li");
      li.className = "col-md-2";

      li.innerHTML = `<i class="bi bi-check2 me-1"></i>${a}`;

      amenitiesList.appendChild(li);
    });
  }

  // Hình ảnh
  if (room.roomImages && room.roomImages.length > 0) {
    // Ảnh header (isMain = true)
    const headerImage = room.roomImages.find((img) => img.isMain);

    // 5 ảnh gallery (isMain = false)
    const galleryImages = room.roomImages
      .filter((img) => !img.isMain)
      .slice(0, 5);

    // Ảnh header
    const headerImg = document.querySelector(".room-header-image img");

    if (headerImg && headerImage) {
      headerImg.src = headerImage.imageUrl;
      headerImg.alt = room.roomName;
    }

    // 5 ảnh gallery
    const galleryGrid = document.querySelector(".gallery-grid");

    if (galleryGrid && galleryImages.length > 0) {
      const galleryMain = galleryImages[0]; // 1 ảnh lớn
      const thumbnails = galleryImages.slice(1); // 4 ảnh nhỏ

      galleryGrid.innerHTML = `
        <div class="gallery-main">
          <a href="${galleryMain.imageUrl}" class="glightbox">
            <img src="${galleryMain.imageUrl}" alt="${room.roomName}" class="img-fluid">
          </a>
        </div>

        <div class="gallery-thumbnails">
          ${thumbnails.map((img) => `
            <a href="${img.imageUrl}" class="glightbox">
              <img src="${img.imageUrl}" alt="${room.roomName}" class="img-fluid">
            </a>
          `,).join("")}
        </div>
      `;

      if (typeof GLightbox !== "undefined") {
        GLightbox({
          selector: ".glightbox",
        });
      }
    }
  }
}
