let currentPage = 0;
let pageSize = 10;

document.addEventListener("DOMContentLoaded", () => {
  loadCustomers();

  document
    .getElementById("user-status-filter")
    .addEventListener("change", () => {
      currentPage = 0;
      loadCustomers();
    });

  document.getElementById("username-search").addEventListener("keyup", () => {
    currentPage = 0;
    loadCustomers();
  });

  document
    .getElementById("sort-by-last-name")
    .addEventListener("change", () => {
      currentPage = 0;
      loadCustomers();
    });
});

async function loadCustomers(page = 0) {
  currentPage = page;

  const status = document.getElementById("user-status-filter").value;
  const username = document.getElementById("username-search").value;
  const sortOption = document.getElementById("sort-by-last-name").value;

  let sort = "lastName,asc";

  if (sortOption === "Tên: Z - A") {
    sort = "lastName,desc";
  }

  let endpoint = `/users?roleName=CUSTOMER&page=${currentPage}&size=${pageSize}&sort=${sort}`;

  if (status) {
    endpoint += `&userStatus=${status}`;
  }

  if (username) {
    endpoint += `&username=${username}`;
  }

  try {
    const response = await callAPIWithAuth(endpoint);
    const pageData = response.result;

    renderTable(pageData.content);
    renderPagination(pageData);
  } catch (error) {
    console.error("Lỗi tải danh sách khách hàng:", error);
  }
}

function renderTable(customers) {
  const tbody = document.querySelector("table tbody");
  tbody.innerHTML = "";

  if (!customers || customers.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="9" class="text-center text-muted">
          Không có tài khoản khách hàng phù hợp
        </td>
      </tr>
    `;
    return;
  }

  customers.forEach((user) => {
    const gender = user.gender === "MALE" ? "Nam" : "Nữ";

    const status =
      user.userStatus === "ACTIVE"
        ? `<span class="text-success">HOẠT ĐỘNG</span>`
        : `<span class="text-warning">KHÓA</span>`;

    const button =
      user.userStatus === "ACTIVE"
        ? `
        <button 
          class="btn btn-sm btn-warning text-white"
          onclick="toggleUserStatus('${user.userId}','${user.userStatus}')">
          <i class="bx bxs-lock-open"></i>
        </button>`
        : `
        <button 
          class="btn btn-sm btn-warning text-white"
          onclick="toggleUserStatus('${user.userId}','${user.userStatus}')">
          <i class="bx bxs-lock"></i>
        </button>`;

    const createdAt = formatDate(user.createdAt);

    tbody.innerHTML += `
      <tr>
        <td class="align-content-center">${user.username}</td>
        <td class="align-content-center">${user.firstName}</td>
        <td class="align-content-center">${user.lastName}</td>
        <td class="align-content-center">${gender}</td>
        <td class="align-content-center">${user.email}</td>
        <td class="align-content-center">${user.phone}</td>
        <td class="align-content-center">${status}</td>
        <td class="align-content-center">${createdAt}</td>
        <td class="align-content-center">${button}</td>
      </tr>
    `;
  });
}

function renderPagination(pageData) {
  const pagination = document.querySelector(".pagination");
  pagination.innerHTML = "";

  const totalPages = pageData.totalPages;
  const pageNumber = pageData.number;

  pagination.innerHTML += `
    <li class="page-item ${pageNumber === 0 ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="event.preventDefault(); loadCustomers(${pageNumber - 1})">&laquo;</a>
    </li>
  `;

  for (let i = 0; i < totalPages; i++) {
    pagination.innerHTML += `
      <li class="page-item ${i === pageNumber ? "active" : ""}">
        <a class="page-link" href="#" onclick="event.preventDefault(); loadCustomers(${i})">${i + 1}</a>
      </li>
    `;
  }

  pagination.innerHTML += `
    <li class="page-item ${pageNumber === totalPages - 1 ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="event.preventDefault(); loadCustomers(${pageNumber + 1})">&raquo;</a>
    </li>
  `;
}

function formatDate(dateString) {
  if (!dateString) return "";

  const date = new Date(dateString);

  const day = String(date.getDate()).padStart(2, "0");
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const year = date.getFullYear();

  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  return `${day}/${month}/${year} - ${hours}:${minutes}:${seconds}`;
}

async function toggleUserStatus(userId, currentStatus) {
  const actionText = currentStatus === "ACTIVE" ? "Khóa" : "Mở khóa";

  // const confirmAction = confirm(
  //   `Bạn có chắc muốn ${actionText} tài khoản này không?`,
  // );

  // if (!confirmAction) return;

  try {
    const response = await callAPIWithAuth(`/users/${userId}/status`, "PUT");

    if (response.code === 1000) {
      showAlert(`${actionText} tài khoản thành công`, "success");

      loadCustomers(currentPage);
    } else {
      alert("Có lỗi xảy ra");
    }
  } catch (error) {
    console.error("Lỗi cập nhật trạng thái:", error);
    alert("Không thể cập nhật trạng thái");
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
