let currentPage = 0;
let pageSize = 10;
let totalPages = 0;

let currentUpdateRoomId = null;

let currentDeleteRoomId = null;

let selectedSubFiles = []; // Lưu trữ file ảnh phụ thực tế

let selectedUpdateSubFiles = []; // Lưu trữ file ảnh phụ mới cho modal update

let deletedImageIds = []; // Lưu ID của các ảnh cũ người dùng bấm Xóa

document.addEventListener("DOMContentLoaded", async () => {
  await loadRoomTypes();
  await loadViews();
  await loadAmenities();
  await loadRooms(0);

  document
    .getElementById("room-type-filter")
    .addEventListener("change", () => loadRooms(0));
  document
    .getElementById("view-filter")
    .addEventListener("change", () => loadRooms(0));
  document
    .getElementById("room-status-filter")
    .addEventListener("change", () => loadRooms(0));

  let timeout;
  document.getElementById("room-name-search").addEventListener("input", () => {
    clearTimeout(timeout);
    timeout = setTimeout(() => loadRooms(0), 500);
  });

  const addRoomForm = document.getElementById("add-room-form");
  if (addRoomForm) {
    addRoomForm.addEventListener("submit", createRoom);
  }

  document
    .getElementById("update-room-form")
    .addEventListener("submit", updateRoom);

  // Sự kiện khi chọn ảnh chính
  document
    .getElementById("main-image")
    .addEventListener("change", handleMainImagePreview);

  // Sự kiện khi chọn ảnh phụ
  document
    .getElementById("sub-images")
    .addEventListener("change", handleSubImagesPreview);

  document
    .getElementById("update-main-image")
    .addEventListener("change", handleUpdateMainPreview);
  document
    .getElementById("update-sub-images")
    .addEventListener("change", handleUpdateSubPreview);

  document
    .getElementById("confirm-delete-room")
    .addEventListener("click", deleteRoom);
});

// Load room types
async function loadRoomTypes() {
  try {
    const res = await callAPI("/room-types/summary");

    if (res.code !== 1000) {
      console.error("Lỗi lấy room type");
      return;
    }

    const roomTypes = res.result;

    const filterSelect = document.getElementById("room-type-filter");
    const addSelect = document.getElementById("add-room-type");
    const updateSelect = document.getElementById("update-room-type");

    filterSelect.innerHTML = `<option value="">Tất cả</option>`;

    roomTypes.forEach((rt) => {
      // Filter
      const option1 = document.createElement("option");
      option1.value = rt.roomTypeId;
      option1.textContent = rt.roomTypeName;
      filterSelect.appendChild(option1);

      // Form add
      const option2 = document.createElement("option");
      option2.value = rt.roomTypeId;
      option2.textContent = rt.roomTypeName;
      addSelect.appendChild(option2);

      // Form update
      const option3 = document.createElement("option");
      option3.value = rt.roomTypeId;
      option3.textContent = rt.roomTypeName;
      updateSelect.appendChild(option3);
    });
  } catch (error) {
    console.error("Lỗi API room types:", error);
  }
}

// Load views
async function loadViews() {
  try {
    const res = await callAPI("/views/summary");

    if (res.code !== 1000) {
      console.error("Lỗi lấy view");
      return;
    }

    const views = res.result;

    const filterSelect = document.getElementById("view-filter");
    const addSelect = document.getElementById("add-view");
    const updateSelect = document.getElementById("update-view");

    // Reset
    filterSelect.innerHTML = `<option value="">Tất cả</option>`;

    views.forEach((v) => {
      // Filter
      const option1 = document.createElement("option");
      option1.value = v.viewId;
      option1.textContent = v.viewName;
      filterSelect.appendChild(option1);

      // Form add
      const option2 = document.createElement("option");
      option2.value = v.viewId;
      option2.textContent = v.viewName;
      addSelect.appendChild(option2);

      // Form update
      const option3 = document.createElement("option");
      option3.value = v.viewId;
      option3.textContent = v.viewName;
      updateSelect.appendChild(option3);
    });
  } catch (error) {
    console.error("Lỗi API views:", error);
  }
}

// Load amenities
async function loadAmenities() {
  try {
    const res = await callAPI("/amenities/summary");

    if (res.code !== 1000) {
      console.error("Lỗi lấy danh sách tiện nghi");
      return;
    }

    const amenities = res.result;
    const container = document.getElementById("add-amenities-container");
    container.innerHTML = ""; // Xóa nội dung cũ

    amenities.forEach((a) => {
      const col = document.createElement("div");
      col.className = "col-lg-3 col-md-4 col-6 mb-2";
      col.innerHTML = `
        <div class="form-check">
          <input class="form-check-input amenity-checkbox" type="checkbox" 
            value="${a.amenityId}" id="amenity-${a.amenityId}">
          <label class="form-check-label small" for="amenity-${a.amenityId}">
            ${a.amenityName}
          </label>
        </div>
      `;
      container.appendChild(col);
    });
  } catch (error) {
    console.error("Lỗi API amenities:", error);
    document.getElementById("add-amenities-container").innerHTML =
      "<span class='text-danger small'>Không thể tải danh sách tiện nghi</span>";
  }
}

// Load rooms
async function loadRooms(page = 0) {
  try {
    currentPage = page;

    const roomTypeId = document.getElementById("room-type-filter").value;
    const viewId = document.getElementById("view-filter").value;
    const roomStatus = document.getElementById("room-status-filter").value;
    const roomName = document.getElementById("room-name-search").value;

    let query = `?page=${page}&size=${pageSize}&sort=roomName,asc`;

    if (roomTypeId) query += `&roomTypeId=${roomTypeId}`;
    if (viewId) query += `&viewId=${viewId}`;
    if (roomStatus) query += `&roomStatus=${roomStatus}`;
    if (roomName) query += `&roomName=${encodeURIComponent(roomName)}`;

    const res = await callAPIWithAuth(`/rooms${query}`);

    if (res.code !== 1000) return;

    const data = res.result;

    renderRoomTable(data.content);
    renderPagination(data);
  } catch (error) {
    console.error("Lỗi load rooms:", error);
  }
}

function renderRoomTable(rooms) {
  const tbody = document.getElementById("room-table-body");
  tbody.innerHTML = "";

  // Không có dữ liệu
  if (!rooms || rooms.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="11" class="text-center text-muted">
          Không có phòng phù hợp
        </td>
      </tr>
    `;
    return;
  }

  rooms.forEach((room) => {
    const row = document.createElement("tr");

    row.innerHTML = `
      <td class="align-content-center">
        <img style="height:60px;width:90px;object-fit:cover;border-radius:8px;"
          src="${room.mainImageUrl || "https://via.placeholder.com/100"}">
      </td>
      <td class="align-content-center">${room.roomName}</td>
      <td class="align-content-center">${room.floor}</td>
      <td class="align-content-center">${room.roomNumber}</td>
      <td class="align-content-center">${formatPrice(room.basePrice)}</td>
      <td class="align-content-center">${room.maxAdults} người lớn - ${room.maxChildren} trẻ em</td>
      <td class="align-content-center">${room.area}m²</td>
      <td class="align-content-center">${room.roomTypeName}</td>
      <td class="align-content-center">${room.viewName}</td>
      <td class="align-content-center">${formatStatus(room.roomStatus)}</td>
      <td class="align-content-center">
        <button class="btn btn-sm btn-primary text-white" onclick="openUpdateModal('${room.roomId}')">
          <i class="bx bxs-pencil"></i>
        </button>
        <button class="btn btn-sm btn-danger text-white" onclick="openDeleteModal('${room.roomId}', '${room.roomName}')">
          <i class="bx bxs-trash"></i>
        </button>
      </td>
    `;

    tbody.appendChild(row);
  });
}

function renderPagination(pageData) {
  const pagination = document.querySelector(".pagination");
  pagination.innerHTML = "";

  totalPages = pageData.totalPages;

  // Nút <<
  const prevLi = document.createElement("li");
  prevLi.className = `page-item ${pageData.first ? "disabled" : ""}`;
  prevLi.innerHTML = `<a class="page-link" href="#">&laquo;</a>`;
  prevLi.onclick = (e) => {
    e.preventDefault();
    if (!pageData.first) loadRooms(currentPage - 1);
  };
  pagination.appendChild(prevLi);

  // Các trang
  for (let i = 0; i < totalPages; i++) {
    const li = document.createElement("li");
    li.className = `page-item ${i === currentPage ? "active" : ""}`;
    li.innerHTML = `<a class="page-link" href="#">${i + 1}</a>`;

    li.onclick = (e) => {
      e.preventDefault();
      loadRooms(i);
    };

    pagination.appendChild(li);
  }

  // Nút >>
  const nextLi = document.createElement("li");
  nextLi.className = `page-item ${pageData.last ? "disabled" : ""}`;
  nextLi.innerHTML = `<a class="page-link" href="#">&raquo;</a>`;
  nextLi.onclick = (e) => {
    e.preventDefault();
    if (!pageData.last) loadRooms(currentPage + 1);
  };
  pagination.appendChild(nextLi);
}

function formatPrice(price) {
  if (!price) return "0đ";
  return price.toLocaleString("vi-VN") + "đ";
}

function formatStatus(status) {
  switch (status) {
    case "AVAILABLE":
      return "Hoạt động";
    case "MAINTENANCE":
      return "Bảo trì";
    default:
      return status;
  }
}

// Preview ảnh chính
function handleMainImagePreview(e) {
  const file = e.target.files[0];
  const container = document.getElementById("main-image-preview");
  if (file) {
    container.querySelector("img").src = URL.createObjectURL(file);
    container.classList.remove("d-none");
  }
}

// Preview ảnh phụ
function handleSubImagesPreview(e) {
  const files = Array.from(e.target.files);

  // Cộng dồn file mới vào mảng tạm
  selectedSubFiles = [...selectedSubFiles, ...files];
  renderSubPreview();

  // Reset input để người dùng có thể chọn lại chính file đó nếu lỡ xóa
  e.target.value = "";
}

// Render lại danh sách ảnh phụ
function renderSubPreview() {
  const container = document.getElementById("sub-images-preview");
  container.innerHTML = "";

  selectedSubFiles.forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = (event) => {
      const div = document.createElement("div");
      div.className = "preview-item";
      div.innerHTML = `
                <img src="${event.target.result}">
                <button type="button" class="btn-remove-img" onclick="removeSubImage(${index})">&times;</button>
            `;
      container.appendChild(div);
    };
    reader.readAsDataURL(file);
  });
}

// Xóa ảnh khỏi mảng tạm
function removeSubImage(index) {
  selectedSubFiles.splice(index, 1);
  renderSubPreview();
}

// Thêm Phòng
async function createRoom(e) {
  e.preventDefault();

  const mainImg = document.getElementById("main-image").files[0];
  if (!mainImg) {
    showAlert("Vui lòng chọn ảnh chính!", "warning");
    return;
  }
  if (selectedSubFiles.length === 0) {
    showAlert("Vui lòng chọn ít nhất một ảnh phụ!", "warning");
    return;
  }

  toggleLoading(true);

  const selectedAmenityIds = Array.from(
    document.querySelectorAll(".amenity-checkbox:checked"),
  ).map((cb) => cb.value);

  const roomRequest = {
    roomName: document.getElementById("add-room-name").value,
    roomNumber: document.getElementById("add-room-number").value,
    floor: parseInt(document.getElementById("add-floor").value),
    basePrice: parseFloat(document.getElementById("add-base-price").value),
    maxAdults: parseInt(document.getElementById("add-max-adults").value),
    maxChildren: parseInt(document.getElementById("add-max-children").value),
    area: parseFloat(document.getElementById("add-area").value),
    description: document.getElementById("add-description").value,
    roomStatus: document.getElementById("add-room-status").value,
    roomTypeId: document.getElementById("add-room-type").value,
    viewId: document.getElementById("add-view").value,
    amenityIds: selectedAmenityIds,
  };

  const formData = new FormData();
  formData.append(
    "request",
    new Blob([JSON.stringify(roomRequest)], { type: "application/json" }),
  );
  formData.append("mainImage", mainImg);
  selectedSubFiles.forEach((file) => formData.append("subImages", file));

  try {
    const token = localStorage.getItem("tokenHotelBooking");
    const response = await fetch(
      "http://localhost:8080/hotel-booking/api/v1/rooms",
      {
        method: "POST",
        headers: { Authorization: `Bearer ${token}` },
        body: formData,
      },
    );

    const res = await response.json();

    if (res.code === 1000) {
      showAlert("Thêm phòng thành công!", "success");

      // Reset dữ liệu
      selectedSubFiles = [];
      document.getElementById("sub-images-preview").innerHTML = "";
      document.getElementById("main-image-preview").classList.add("d-none");
      e.target.reset();

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("add-room-modal"),
      );
      if (modal) modal.hide();

      loadRooms(0);
    } else {
      showAlert(res.message || "Thêm phòng thất bại", "danger");
    }
  } catch (err) {
    console.error("Lỗi:", err);
    showAlert("Không thể kết nối đến máy chủ", "danger");
  } finally {
    toggleLoading(false);
  }
}

function showAlert(message, type = "success") {
  const container = document.getElementById("alert-container");

  const icons = {
    success: "bi-check-circle",
    danger: "bi-x-circle",
    warning: "bi-exclamation-triangle",
  };

  const icon = icons[type] || "bi-info-circle";

  const alert = document.createElement("div");

  alert.className = `alert alert-${type} alert-dismissible fade show small shadow`;
  alert.role = "alert";

  alert.innerHTML = `
    <i class="bi ${icon} me-2"></i>${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  `;

  container.appendChild(alert);

  setTimeout(() => {
    alert.classList.remove("show");
    setTimeout(() => alert.remove(), 300);
  }, 3000);
}

function toggleLoading(isLoading) {
  const btn = document.getElementById("btn-submit-room");
  const btnText = document.getElementById("btn-text");
  const btnLoader = document.getElementById("btn-loader");

  if (isLoading) {
    btn.disabled = true;
    btnText.innerText = "Đang xử lý...";
    btnLoader.classList.remove("d-none");
  } else {
    btn.disabled = false;
    btnText.innerText = "Thêm";
    btnLoader.classList.add("d-none");
  }
}

async function openUpdateModal(roomId) {
  currentUpdateRoomId = roomId;

  selectedUpdateSubFiles = [];
  deletedImageIds = [];

  document.getElementById("update-new-sub-preview").innerHTML = "";
  document.getElementById("update-main-image-preview").classList.add("d-none");
  document.getElementById("update-sub-images").value = "";
  document.getElementById("update-main-image").value = "";

  try {
    const res = await callAPIWithAuth(`/rooms/${roomId}`);
    if (res.code === 1000) {
      const room = res.result;

      document.getElementById("update-room-name").value = room.roomName;
      document.getElementById("update-room-number").value = room.roomNumber;
      document.getElementById("update-floor").value = room.floor;
      document.getElementById("update-base-price").value = room.basePrice;
      document.getElementById("update-area").value = room.area;
      document.getElementById("update-max-adults").value = room.maxAdults;
      document.getElementById("update-max-children").value = room.maxChildren;
      document.getElementById("update-description").value = room.description;
      document.getElementById("update-room-status").value = room.roomStatus;

      document.getElementById("update-room-type").value =
        room.roomType.roomTypeId;
      document.getElementById("update-view").value = room.view.viewId;

      const mainImgContainer = document.getElementById("current-main-image");
      const mainImg = room.roomImages.find((img) => img.isMain === true);
      mainImgContainer.src = mainImg
        ? mainImg.imageUrl
        : "assets/img/no-image.png";

      const subImgsContainer = document.getElementById(
        "update-sub-images-preview",
      );
      subImgsContainer.innerHTML = "";
      deletedImageIds = []; // Reset danh sách xóa mỗi khi mở modal mới

      room.roomImages
        .filter((img) => !img.isMain)
        .forEach((img) => {
          const div = document.createElement("div");
          div.className = "preview-item";
          div.id = `old-img-${img.roomImageId}`;
          div.innerHTML = `
          <img src="${img.imageUrl}" style="height: 80px; width: 120px; object-fit: cover; border-radius: 4px;">
          <button type="button" class="btn-remove-img" onclick="markOldImageForDeletion('${img.roomImageId}')">&times;</button>
          <span class="badge bg-secondary position-absolute bottom-0 start-0 w-100 opacity-75" style="font-size: 10px;">Ảnh cũ</span>
        `;
          div.style.position = "relative";
          subImgsContainer.appendChild(div);
        });

      const currentAmenityIds = room.amenities.map((a) => a.amenityId);
      await renderUpdateAmenities(currentAmenityIds);

      const modal = new bootstrap.Modal(
        document.getElementById("update-room-modal"),
      );
      modal.show();
    }
  } catch (error) {
    console.error("Lỗi khi mở modal update:", error);
    showAlert("Không thể tải thông tin phòng", "danger");
  }
}

// Render tiện nghi cho modal sửa và tích chọn các cái đã có
async function renderUpdateAmenities(selectedIds) {
  try {
    const res = await callAPIWithAuth("/amenities/summary");
    const container = document.getElementById("update-amenities-container");
    container.innerHTML = "";

    if (res.code === 1000) {
      res.result.forEach((amenity) => {
        const isChecked = selectedIds.includes(amenity.amenityId)
          ? "checked"
          : "";

        const col = document.createElement("div");
        col.className = "col-lg-3 col-md-4 col-6 mb-2";
        col.innerHTML = `
          <div class="form-check">
            <input class="form-check-input update-amenity-checkbox" type="checkbox" 
                   value="${amenity.amenityId}" 
                   id="up-amenity-${amenity.amenityId}" ${isChecked}>
            <label class="form-check-label small" for="up-amenity-${amenity.amenityId}">
              ${amenity.amenityName}
            </label>
          </div>
        `;
        container.appendChild(col);
      });
    }
  } catch (error) {
    console.error("Lỗi render tiện nghi:", error);
  }
}

async function updateRoom(e) {
  e.preventDefault();

  toggleUpdateLoading(true);

  const formData = new FormData();
  const selectedAmenityIds = Array.from(
    document.querySelectorAll(".update-amenity-checkbox:checked"),
  ).map((cb) => cb.value);

  const updateRequest = {
    roomName: document.getElementById("update-room-name").value,
    roomNumber: document.getElementById("update-room-number").value,
    floor: parseInt(document.getElementById("update-floor").value),
    basePrice: parseFloat(document.getElementById("update-base-price").value),
    maxAdults: parseInt(document.getElementById("update-max-adults").value),
    maxChildren: parseInt(document.getElementById("update-max-children").value),
    area: parseFloat(document.getElementById("update-area").value),
    description: document.getElementById("update-description").value,
    roomStatus: document.getElementById("update-room-status").value,
    roomTypeId: document.getElementById("update-room-type").value,
    viewId: document.getElementById("update-view").value,
    amenityIds: selectedAmenityIds,
    deleteImageIds: deletedImageIds,
  };

  formData.append(
    "request",
    new Blob([JSON.stringify(updateRequest)], { type: "application/json" }),
  );

  const mainImgFile = document.getElementById("update-main-image").files[0];
  if (mainImgFile) {
    formData.append("mainImage", mainImgFile);
  }

  selectedUpdateSubFiles.forEach((file) => {
    formData.append("subImages", file);
  });

  try {
    const token = localStorage.getItem("tokenHotelBooking");
    const response = await fetch(
      `http://localhost:8080/hotel-booking/api/v1/rooms/${currentUpdateRoomId}`,
      {
        method: "PUT",
        headers: { Authorization: `Bearer ${token}` },
        body: formData,
      },
    );

    const res = await response.json();
    if (res.code === 1000) {
      showAlert("Cập nhật phòng thành công", "success");

      selectedUpdateSubFiles = [];
      document.getElementById("update-new-sub-preview").innerHTML = "";
      document
        .getElementById("update-main-image-preview")
        .classList.add("d-none");

      bootstrap.Modal.getInstance(
        document.getElementById("update-room-modal"),
      ).hide();
      loadRooms(currentPage);
    } else {
      showAlert(res.message || "Cập nhật thất bại", "danger");
    }
  } catch (error) {
    console.error("Error:", error);
    showAlert("Lỗi kết nối server", "danger");
  } finally {
    toggleUpdateLoading(false);
  }
}

function handleUpdateMainPreview(e) {
  const file = e.target.files[0];
  const container = document.getElementById("update-main-image-preview");
  if (file) {
    container.querySelector("img").src = URL.createObjectURL(file);
    container.classList.remove("d-none");
  }
}

function handleUpdateSubPreview(e) {
  const files = Array.from(e.target.files);
  selectedUpdateSubFiles = [...selectedUpdateSubFiles, ...files];
  renderUpdateSubPreview();
  e.target.value = "";
}

function renderUpdateSubPreview() {
  const container = document.getElementById("update-new-sub-preview");
  container.innerHTML = "";
  selectedUpdateSubFiles.forEach((file, index) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const div = document.createElement("div");
      div.className = "preview-item";
      div.innerHTML = `
                <img src="${e.target.result}" style="height: 80px; width: 120px; object-fit: cover;">
                <button type="button" class="btn-remove-img" onclick="removeUpdateSubImage(${index})">&times;</button>
                <span class="badge bg-primary position-absolute bottom-0 start-0 w-100 opacity-75" style="font-size: 10px;">Mới</span>
            `;
      div.style.position = "relative";
      container.appendChild(div);
    };
    reader.readAsDataURL(file);
  });
}

function removeUpdateSubImage(index) {
  selectedUpdateSubFiles.splice(index, 1);
  renderUpdateSubPreview();
}

function markOldImageForDeletion(imageId) {
  deletedImageIds.push(imageId);
  // Ẩn ảnh trên giao diện
  const imgElement = document.getElementById(`old-img-${imageId}`);
  if (imgElement) imgElement.remove();
}

function toggleUpdateLoading(isLoading) {
  const btn = document.getElementById("btn-update-room");
  const btnText = document.getElementById("btn-update-text");
  const btnLoader = document.getElementById("btn-update-loader");

  if (isLoading) {
    btn.disabled = true;
    btnText.innerText = "Đang lưu...";
    btnLoader.classList.remove("d-none");
  } else {
    btn.disabled = false;
    btnText.innerText = "Lưu thay đổi";
    btnLoader.classList.add("d-none");
  }
}

// Mở modal xóa phòng
function openDeleteModal(roomId, roomName) {
  currentDeleteRoomId = roomId;

  document.getElementById("delete-room-message").innerText =
    `Bạn có chắc chắn muốn xóa "${roomName}" không?`;

  const modal = new bootstrap.Modal(
    document.getElementById("delete-room-modal")
  );
  modal.show();
}

async function deleteRoom() {
  if (!currentDeleteRoomId) return;

  try {
    const token = localStorage.getItem("tokenHotelBooking");

    const response = await fetch(
      `http://localhost:8080/hotel-booking/api/v1/rooms/${currentDeleteRoomId}`,
      {
        method: "DELETE",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );

    const res = await response.json();

    if (res.code === 1000) {
      showAlert("Xóa phòng thành công!", "success");

      // Đóng modal
      const modal = bootstrap.Modal.getInstance(
        document.getElementById("delete-room-modal")
      );
      modal.hide();

      // Reload list
      loadRooms(currentPage);
    } else {
      showAlert(res.message || "Xóa thất bại", "danger");
    }
  } catch (error) {
    console.error("Lỗi xóa:", error);
    showAlert("Không thể kết nối server", "danger");
  }
}