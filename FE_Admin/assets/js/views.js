let currentPage = 0;
let pageSize = 10;
let currentKeyword = "";

let updateViewId = null;
let deleteViewId = null;

// Load dữ liệu
async function loadViews(page = 0, keyword = "") {
  try {
    const endpoint = `/views?viewName=${keyword}&page=${page}&size=${pageSize}&sort=viewName,asc`;
    const response = await callAPIWithAuth(endpoint);

    const data = response.result;
    renderTable(data.content);
    renderPagination(data);

  } catch (error) {
    console.error("Lỗi khi load views:", error);
  }
}

// Render bảng
function renderTable(views) {
  const tbody = document.getElementById("view-table-body");
  tbody.innerHTML = "";

  // Không có dữ liệu
  if (!views || views.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="3" class="text-center text-secondary">
          Không có view phù hợp.
        </td>
      </tr>
    `;
    return;
  }

  // Có dữ liệu
  views.forEach(view => {
    const row = `
      <tr>
        <td class="align-content-center">${view.viewName}</td>
        <td class="align-content-center text-truncate" style="max-width: 900px;" title="${view.description}">
          ${view.description}
        </td>
        <td class="align-content-center text-center">
          <button class="btn btn-sm btn-primary text-white"
            title="Sửa"
            onclick="openUpdateView(event, '${view.viewId}')">
            <i class="bx bxs-pencil"></i>
          </button>
          <button class="btn btn-sm btn-danger text-white"
            title="Xóa"
            onclick="openDeleteView(event, '${view.viewId}')">
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
  loadViews(currentPage, currentKeyword);
}

// Search (debounce nhẹ)
document.getElementById("view-name-search").addEventListener("input", function () {
  currentKeyword = this.value;
  currentPage = 0;
  loadViews(currentPage, currentKeyword);
});

document.getElementById("add-view-form").addEventListener("submit", async function (e) {
  e.preventDefault();

  const name = document.getElementById("add-view-name").value.trim();
  const description = document.getElementById("add-description").value.trim();

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    viewName: name,
    description: description
  };

  try {
    const response = await callAPIWithAuth("/views", "POST", data);

    if (response.code === 1000) {
      showAlert("Thêm view thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("add-view-modal")
      );
      modal.hide();

      document.getElementById("add-view-form").reset();

      loadViews(0, currentKeyword);
    } else {
      showAlert(response.message || "Thêm view thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi thêm view:", error);
    showAlert("Không thể thêm view", "danger");
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

function openUpdateView(event, viewId) {
  updateViewId = viewId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;
  const description = row.children[1].innerText;

  document.getElementById("update-view").value = name;
  document.getElementById("update-description").value = description;

  const modal = new bootstrap.Modal(
    document.getElementById("update-view-modal")
  );

  modal.show();
}

async function updateView(event) {
  event.preventDefault();

  const name = document.getElementById("update-view").value.trim();
  const description = document.getElementById("update-description").value.trim();

  if (!name || !description) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return;
  }

  const data = {
    viewName: name,
    description: description
  };

  try {
    const response = await callAPIWithAuth(
      `/views/${updateViewId}`,
      "PUT",
      data
    );

    // Thành công
    if (response.code === 1000) {
      showAlert("Cập nhật view thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("update-view-modal")
      );

      modal.hide();

      loadViews(currentPage, currentKeyword);
    }
    // Trùng tên
    else if (response.code === 4002) {
      showAlert("View đã tồn tại", "warning");
    }
    // Lỗi khác
    else {
      showAlert(response.message || "Cập nhật thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi cập nhật view:", error);
    showAlert("Không thể cập nhật view", "danger");
  }
}

function openDeleteView(event, viewId) {
  deleteViewId = viewId;

  const row = event.target.closest("tr");

  const name = row.children[0].innerText;

  const modalBody = document.querySelector(
    "#delete-view-modal .modal-body"
  );

  modalBody.innerHTML = `
    Bạn có chắc chắn muốn xóa view <b>${name}</b> không?
  `;

  const modal = new bootstrap.Modal(
    document.getElementById("delete-view-modal")
  );

  modal.show();
}

async function deleteView() {
  try {
    const response = await callAPIWithAuth(
      `/views/${deleteViewId}`,
      "DELETE"
    );

    if (response.code === 1000) {
      showAlert(`Đã xóa view "${response.result.viewName}"`, "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("delete-view-modal")
      );

      modal.hide();

      loadViews(currentPage, currentKeyword);
    } else {
      showAlert(response.message || "Xóa thất bại", "danger");
    }

  } catch (error) {
    console.error("Lỗi xóa view:", error);
    showAlert("Không thể xóa view", "danger");
  }
}

// Load lần đầu
document.addEventListener("DOMContentLoaded", function () {
  loadViews();

  document
    .getElementById("update-view-form")
    .addEventListener("submit", updateView);

  document
    .getElementById("confirm-delete-view")
    .addEventListener("click", deleteView);
});