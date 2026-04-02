let currentPage = 0;
let pageSize = 10;
let currentKeyword = "";

let updateServiceId = null;
let deleteServiceId = null;

// Load dữ liệu
async function loadServices(page = 0, keyword = "") {
  try {
    const endpoint = `/services?serviceName=${keyword}&page=${page}&size=${pageSize}&sort=serviceName,asc`;
    const response = await callAPIWithAuth(endpoint);

    const data = response.result;
    renderTable(data.content);
    renderPagination(data);

  } catch (error) {
    console.error("Lỗi khi load services:", error);
  }
}

// Render bảng
function renderTable(services) {
  const tbody = document.getElementById("service-table-body");
  tbody.innerHTML = "";

  // Không có dữ liệu
  if (!services || services.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="4" class="text-center text-secondary">
          Không có dịch vụ phù hợp.
        </td>
      </tr>
    `;
    return;
  }

  // Có dữ liệu
  services.forEach(service => {
    const row = `
      <tr>
        <td class="align-content-center">${service.serviceName}</td>
        <td class="align-content-center text-truncate" style="max-width: 900px;" title="${service.description}">
          ${service.description}
        </td>
        <td class="align-content-center">${formatPrice(service.basePrice)}</td>
        <td class="align-content-center text-center">
          <button class="btn btn-sm btn-primary text-white"
            title="Sửa"
            onclick="openUpdateService(event, '${service.serviceId}')">
            <i class="bx bxs-pencil"></i>
          </button>
          <button class="btn btn-sm btn-danger text-white"
            title="Xóa"
            onclick="openDeleteService(event, '${service.serviceId}')">
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
  loadServices(currentPage, currentKeyword);
}

// Search (debounce nhẹ)
document.getElementById("service-name-search").addEventListener("input", function () {
  currentKeyword = this.value;
  currentPage = 0;
  loadServices(currentPage, currentKeyword);
});

document.getElementById("add-service-form").addEventListener("submit", async function (e) {
  e.preventDefault();

  const name = document.getElementById("add-service-name").value.trim();
  const description = document.getElementById("add-description").value.trim();
  const basePrice = document.getElementById("add-base-price").value;

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    serviceName: name,
    description: description,
    basePrice: basePrice
  };

  try {
    const response = await callAPIWithAuth("/services", "POST", data);

    if (response.code === 1000) {
      showAlert("Thêm dịch vụ thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("add-service-modal")
      );
      modal.hide();

      document.getElementById("add-service-form").reset();

      loadServices(0, currentKeyword);
    } else {
      showAlert(response.message || "Thêm dịch vụ thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi thêm dịch vụ:", error);
    showAlert("Không thể thêm dịch vụ", "danger");
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

function openUpdateService(event, serviceId) {
  updateServiceId = serviceId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;
  const description = row.children[1].innerText;
  const basePriceText = row.children[2].innerText;
  const basePrice = basePriceText.replace(/[^\d]/g, "");

  document.getElementById("update-service-name").value = name;
  document.getElementById("update-base-price").value = basePrice;
  document.getElementById("update-description").value = description;

  const modal = new bootstrap.Modal(
    document.getElementById("update-service-modal")
  );

  modal.show();
}

async function updateService(event) {
  event.preventDefault();

  const name = document.getElementById("update-service-name").value.trim();
  const description = document.getElementById("update-description").value.trim();
  const basePrice = document.getElementById("update-base-price").value;

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    serviceName: name,
    description: description,
    basePrice: basePrice
  };

  try {
    const response = await callAPIWithAuth(
      `/services/${updateServiceId}`,
      "PUT",
      data
    );

    // Thành công
    if (response.code === 1000) {
      showAlert("Cập nhật dịch vụ thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("update-service-modal")
      );

      modal.hide();

      loadServices(currentPage, currentKeyword);
    }
    // Trùng tên
    else if (response.code === 4002) {
      showAlert("Dịch vụ đã tồn tại", "warning");
    }
    // Lỗi khác
    else {
      showAlert(response.message || "Cập nhật dịch vụ thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi cập nhật dịch vụ:", error);
    showAlert("Không thể cập nhật dịch vụ", "danger");
  }
}

function openDeleteService(event, serviceId) {
  deleteServiceId = serviceId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;

  const modalBody = document.querySelector(
    "#delete-service-modal .modal-body"
  );

  modalBody.innerHTML = `
    Bạn có chắc chắn muốn xóa dịch vụ <b>${name}</b> không?
  `;

  const modal = new bootstrap.Modal(
    document.getElementById("delete-service-modal")
  );

  modal.show();
}

async function deleteService() {
  try {
    const response = await callAPIWithAuth(
      `/services/${deleteServiceId}`,
      "DELETE"
    );

    if (response.code === 1000) {
      showAlert(`Đã xóa dịch vụ "${response.result.serviceName}"`, "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("delete-service-modal")
      );

      modal.hide();

      loadServices(currentPage, currentKeyword);
    } else {
      showAlert(response.message || "Xóa thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi xóa dịch vụ:", error);
    showAlert("Không thể xóa dịch vụ", "danger");
  }
}

function formatPrice(price) {
  if (!price) return "0đ";
  return price.toLocaleString("vi-VN") + "đ";
}

// Load lần đầu
document.addEventListener("DOMContentLoaded", function () {
  loadServices();

  document
    .getElementById("update-service-form")
    .addEventListener("submit", updateService);

  document
    .getElementById("confirm-delete-service")
    .addEventListener("click", deleteService);
});