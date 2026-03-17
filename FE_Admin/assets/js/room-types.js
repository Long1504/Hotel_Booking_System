let currentPage = 0;
let pageSize = 10;
let currentKeyword = "";

let updateRoomTypeId = null;
let deleteRoomTypeId = null;

// Load dữ liệu
async function loadRoomTypes(page = 0, keyword = "") {
  try {
    const endpoint = `/room-types?roomTypeName=${keyword}&page=${page}&size=${pageSize}&sort=roomTypeName,asc`;
    const response = await callAPIWithAuth(endpoint);

    const data = response.result;
    renderTable(data.content);
    renderPagination(data);

  } catch (error) {
    console.error("Lỗi khi load room types:", error);
  }
}

// Render bảng
function renderTable(roomTypes) {
  const tbody = document.getElementById("room-type-table-body");
  tbody.innerHTML = "";

  // Không có dữ liệu
  if (!roomTypes || roomTypes.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="3" class="text-center text-secondary">
          Không có loại phòng phù hợp.
        </td>
      </tr>
    `;
    return;
  }

  // Có dữ liệu
  roomTypes.forEach(rt => {
    const row = `
      <tr>
        <td class="align-content-center">${rt.roomTypeName}</td>
        <td class="align-content-center text-truncate" style="max-width: 900px;" title="${rt.description}">
          ${rt.description}
        </td>
        <td class="align-content-center text-center">
          <button class="btn btn-sm btn-primary text-white"
            onclick="openUpdateRoomType(event, '${rt.roomTypeId}')">
            <i class="bx bxs-pencil"></i>
          </button>
          <button class="btn btn-sm btn-danger text-white"
            onclick="openDeleteRoomType(event, '${rt.roomTypeId}')">
            <i class="bx bxs-trash"></i>
          </button>
        </td>
      </tr>
    `;
    tbody.innerHTML += row;
  });
}

// Render phân trang
function renderPagination(data) {
  const pagination = document.querySelector(".pagination");
  pagination.innerHTML = "";

  // Prev
  pagination.innerHTML += `
    <li class="page-item ${data.first ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="changePage(${data.number - 1})">&laquo;</a>
    </li>
  `;

  // Page numbers
  for (let i = 0; i < data.totalPages; i++) {
    pagination.innerHTML += `
      <li class="page-item ${i === data.number ? "active" : ""}">
        <a class="page-link" href="#" onclick="changePage(${i})">${i + 1}</a>
      </li>
    `;
  }

  // Next
  pagination.innerHTML += `
    <li class="page-item ${data.last ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="changePage(${data.number + 1})">&raquo;</a>
    </li>
  `;
}

// Đổi trang
function changePage(page) {
  if (page < 0) return;
  currentPage = page;
  loadRoomTypes(currentPage, currentKeyword);
}

// Search (debounce nhẹ)
document.getElementById("room-type-name-search").addEventListener("input", function () {
  currentKeyword = this.value;
  currentPage = 0;
  loadRoomTypes(currentPage, currentKeyword);
});

document.getElementById("add-room-type-form").addEventListener("submit", async function (e) {
  e.preventDefault();

  const name = document.getElementById("add-room-type-name").value.trim();
  const description = document.getElementById("add-description").value.trim();

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    roomTypeName: name,
    description: description
  };

  try {
    const response = await callAPIWithAuth("/room-types", "POST", data);

    if (response.code === 1000) {
      showAlert("Thêm loại phòng thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("add-room-type-modal")
      );
      modal.hide();

      document.getElementById("add-room-type-form").reset();

      loadRoomTypes(0, currentKeyword);
    } else {
      showAlert(response.message || "Thêm thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi thêm loại phòng:", error);
    showAlert("Không thể thêm loại phòng", "danger");
  }
});

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

function openUpdateRoomType(event, roomTypeId) {
  updateRoomTypeId = roomTypeId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;
  const description = row.children[1].innerText;

  document.getElementById("update-room-type").value = name;
  document.getElementById("update-description").value = description;

  const modal = new bootstrap.Modal(
    document.getElementById("update-room-type-modal")
  );

  modal.show();
}

async function updateRoomType(event) {
  event.preventDefault();

  const name = document.getElementById("update-room-type").value.trim();
  const description = document.getElementById("update-description").value.trim();

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    roomTypeName: name,
    description: description
  };

  try {
    const response = await callAPIWithAuth(
      `/room-types/${updateRoomTypeId}`,
      "PUT",
      data
    );

    // Thành công
    if (response.code === 1000) {
      showAlert("Cập nhật loại phòng thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("update-room-type-modal")
      );

      modal.hide();

      loadRoomTypes(currentPage, currentKeyword);
    }
    // Trùng tên
    else if (response.code === 4002) {
      showAlert("Loại phòng đã tồn tại", "warning");
    }
    // Lỗi khác
    else {
      showAlert(response.message || "Cập nhật thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi cập nhật loại phòng:", error);
    showAlert("Không thể cập nhật loại phòng", "danger");
  }
}

function openDeleteRoomType(event, roomTypeId) {
  deleteRoomTypeId = roomTypeId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;

  const modalBody = document.querySelector(
    "#delete-room-type-modal .modal-body"
  );

  modalBody.innerHTML = `
    Bạn có chắc chắn muốn xóa loại phòng <b>${name}</b> không?
  `;

  const modal = new bootstrap.Modal(
    document.getElementById("delete-room-type-modal")
  );

  modal.show();
}

async function deleteRoomType() {
  try {
    const response = await callAPIWithAuth(
      `/room-types/${deleteRoomTypeId}`,
      "DELETE"
    );

    if (response.code === 1000) {
      showAlert(`Đã xóa loại phòng "${response.result.roomTypeName}"`, "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("delete-room-type-modal")
      );

      modal.hide();

      loadRoomTypes(currentPage, currentKeyword);
    } else {
      showAlert(response.message || "Xóa thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi xóa loại phòng:", error);
    showAlert("Không thể xóa loại phòng", "danger");
  }
}

// Load lần đầu
document.addEventListener("DOMContentLoaded", function () {
  loadRoomTypes();

  document
    .getElementById("update-room-type-form")
    .addEventListener("submit", updateRoomType);

  document
    .getElementById("confirm-delete-room-type")
    .addEventListener("click", deleteRoomType);
});