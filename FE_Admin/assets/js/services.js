let currentPage = 0;
let pageSize = 10;
let currentKeyword = "";

let updateAmenityId = null;
let deleteAmenityId = null;

// Load dữ liệu
async function loadAmenities(page = 0, keyword = "") {
  try {
    const endpoint = `/amenities?amenityName=${keyword}&page=${page}&size=${pageSize}&sort=amenityName,asc`;
    const response = await callAPIWithAuth(endpoint);

    const data = response.result;
    renderTable(data.content);
    renderPagination(data);

  } catch (error) {
    console.error("Lỗi khi load amenities:", error);
  }
}

// Render bảng
function renderTable(amenities) {
  const tbody = document.getElementById("amenity-table-body");
  tbody.innerHTML = "";

  // Không có dữ liệu
  if (!amenities || amenities.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="3" class="text-center text-secondary">
          Không có tiện nghi phù hợp.
        </td>
      </tr>
    `;
    return;
  }

  // Có dữ liệu
  amenities.forEach(amenity => {
    const row = `
      <tr>
        <td class="align-content-center">${amenity.amenityName}</td>
        <td class="align-content-center text-truncate" style="max-width: 900px;" title="${amenity.description}">
          ${amenity.description}
        </td>
        <td class="align-content-center text-center">
          <button class="btn btn-sm btn-primary text-white"
            title="Sửa"
            onclick="openUpdateAmenity(event, '${amenity.amenityId}')">
            <i class="bx bxs-pencil"></i>
          </button>
          <button class="btn btn-sm btn-danger text-white"
            title="Xóa"
            onclick="openDeleteAmenity(event, '${amenity.amenityId}')">
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
  loadAmenities(currentPage, currentKeyword);
}

// Search (debounce nhẹ)
document.getElementById("amenity-name-search").addEventListener("input", function () {
  currentKeyword = this.value;
  currentPage = 0;
  loadAmenities(currentPage, currentKeyword);
});

document.getElementById("add-amenity-form").addEventListener("submit", async function (e) {
  e.preventDefault();

  const name = document.getElementById("add-amenity-name").value.trim();
  const description = document.getElementById("add-description").value.trim();

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    amenityName: name,
    description: description
  };

  try {
    const response = await callAPIWithAuth("/amenities", "POST", data);

    if (response.code === 1000) {
      showAlert("Thêm tiện nghi thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("add-amenity-modal")
      );
      modal.hide();

      document.getElementById("add-amenity-form").reset();

      loadAmenities(0, currentKeyword);
    } else {
      showAlert(response.message || "Thêm tiện nghi thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi thêm tiện nghi:", error);
    showAlert("Không thể thêm tiện nghi", "danger");
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

function openUpdateAmenity(event, amenityId) {
  updateAmenityId = amenityId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;
  const description = row.children[1].innerText;

  document.getElementById("update-amenity").value = name;
  document.getElementById("update-description").value = description;

  const modal = new bootstrap.Modal(
    document.getElementById("update-amenity-modal")
  );

  modal.show();
}

async function updateAmenity(event) {
  event.preventDefault();

  const name = document.getElementById("update-amenity").value.trim();
  const description = document.getElementById("update-description").value.trim();

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    amenityName: name,
    description: description
  };

  try {
    const response = await callAPIWithAuth(
      `/amenities/${updateAmenityId}`,
      "PUT",
      data
    );

    // Thành công
    if (response.code === 1000) {
      showAlert("Cập nhật tiện nghi thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("update-amenity-modal")
      );

      modal.hide();

      loadAmenities(currentPage, currentKeyword);
    }
    // Trùng tên
    else if (response.code === 4002) {
      showAlert("Tiện nghi đã tồn tại", "warning");
    }
    // Lỗi khác
    else {
      showAlert(response.message || "Cập nhật tiện nghi thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi cập nhật tiện nghi:", error);
    showAlert("Không thể cập nhật tiện nghi", "danger");
  }
}

function openDeleteAmenity(event, amenityId) {
  deleteAmenityId = amenityId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;

  const modalBody = document.querySelector(
    "#delete-amenity-modal .modal-body"
  );

  modalBody.innerHTML = `
    Bạn có chắc chắn muốn xóa tiện nghi <b>${name}</b> không?
  `;

  const modal = new bootstrap.Modal(
    document.getElementById("delete-amenity-modal")
  );

  modal.show();
}

async function deleteAmenity() {
  try {
    const response = await callAPIWithAuth(
      `/amenities/${deleteAmenityId}`,
      "DELETE"
    );

    if (response.code === 1000) {
      showAlert(`Đã xóa tiện nghi "${response.result.amenityName}"`, "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("delete-amenity-modal")
      );

      modal.hide();

      loadAmenities(currentPage, currentKeyword);
    } else {
      showAlert(response.message || "Xóa thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi xóa tiện nghi:", error);
    showAlert("Không thể xóa tiện nghi", "danger");
  }
}

// Load lần đầu
document.addEventListener("DOMContentLoaded", function () {
  loadAmenities();

  document
    .getElementById("update-amenity-form")
    .addEventListener("submit", updateAmenity);

  document
    .getElementById("confirm-delete-amenity")
    .addEventListener("click", deleteAmenity);
});