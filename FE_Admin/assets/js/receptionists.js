let currentPage = 0;
let pageSize = 10;

let updateUserId = null;
let resetUserId = null;
let deleteUserId = null;

document.addEventListener("DOMContentLoaded", () => {
  loadReceptionists();

  document
    .getElementById("user-status-filter")
    .addEventListener("change", () => {
      currentPage = 0;
      loadReceptionists();
    });

  document.getElementById("username-search").addEventListener("keyup", () => {
    currentPage = 0;
    loadReceptionists();
  });

  document
    .getElementById("sort-by-last-name")
    .addEventListener("change", () => {
      currentPage = 0;
      loadReceptionists();
    });

  document
    .getElementById("add-receptionist-form")
    .addEventListener("submit", addReceptionist);

  document
    .getElementById("update-receptionist-form")
    .addEventListener("submit", updateReceptionist);

  document
    .getElementById("reset-password-form")
    .addEventListener("submit", resetPassword);

  document
    .getElementById("confirm-delete-receptionist")
    .addEventListener("click", deleteReceptionist);
});

async function loadReceptionists(page = 0) {
  currentPage = page;

  const status = document.getElementById("user-status-filter").value;
  const username = document.getElementById("username-search").value;
  const sortOption = document.getElementById("sort-by-last-name").value;

  let sort = "lastName,asc";

  if (sortOption === "Tên: Z - A") {
    sort = "lastName,desc";
  }

  let endpoint = `/users?roleName=RECEPTIONIST&page=${currentPage}&size=${pageSize}&sort=${sort}`;

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
          Không có tài khoản lễ tân phù hợp
        </td>
      </tr>
    `;
    return;
  }

  customers.forEach((user) => {
    let gender = "Khác";

    if (user.gender === "MALE") gender = "Nam";
    else if (user.gender === "FEMALE") gender = "Nữ";

    const status = user.userStatus === "ACTIVE"
      ? `<span class="text-success">HOẠT ĐỘNG</span>`
      : `<span class="text-warning">KHÓA</span>`;

    const lockButton = user.userStatus === "ACTIVE"
      ? `
      <button class="btn btn-sm btn-warning text-white"
        title="Khóa"
        onclick="toggleUserStatus('${user.userId}','${user.userStatus}')">
        <i class="bx bxs-lock-open"></i>
      </button>`
      : `
      <button class="btn btn-sm btn-warning text-white"
        title="Mở"
        onclick="toggleUserStatus('${user.userId}','${user.userStatus}')">
        <i class="bx bxs-lock"></i>
      </button>
    `;

    const editButton = `
      <button class="btn btn-sm btn-primary text-white"
        title="Sửa"
        onclick="openUpdateReceptionist(event, '${user.userId}')">
        <i class="bx bxs-pencil"></i>
      </button>
    `;

    const resetPasswordButton = `
      <button class="btn btn-sm btn-secondary text-white"
        title="Cấp lại mật khẩu"
        onclick="openResetPassword(event, '${user.userId}')">
        <i class="bx bx-reset"></i>
      </button>
    `;

    const deleteButton = `
      <button class="btn btn-sm btn-danger text-white"
        title="Xóa"
        onclick="openDeleteReceptionist(event, '${user.userId}')">
        <i class="bx bxs-trash"></i>
      </button>
    `;

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
        <td class="align-content-center text-center">
          ${lockButton}
          ${editButton}
          ${resetPasswordButton}
          ${deleteButton}
        </td>
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
      <a class="page-link" href="#" onclick="event.preventDefault(); loadReceptionists(${pageNumber - 1})">&laquo;</a>
    </li>
  `;

  for (let i = 0; i < totalPages; i++) {
    pagination.innerHTML += `
      <li class="page-item ${i === pageNumber ? "active" : ""}">
        <a class="page-link" href="#" onclick="event.preventDefault(); loadReceptionists(${i})">${i + 1}</a>
      </li>
    `;
  }

  pagination.innerHTML += `
    <li class="page-item ${pageNumber === totalPages - 1 ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="event.preventDefault(); loadReceptionists(${pageNumber + 1})">&raquo;</a>
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

  try {
    const response = await callAPIWithAuth(`/users/${userId}/status`, "PUT");

    if (response.code === 1000) {
      showAlert(`${actionText} tài khoản thành công`, "success");

      loadReceptionists(currentPage);
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

// Hàm thêm lễ tân
async function addReceptionist(event) {
  event.preventDefault();

  const data = {
    username: document.getElementById("add-username").value,
    password: document.getElementById("add-password").value,
    firstName: document.getElementById("add-first-name").value,
    lastName: document.getElementById("add-last-name").value,
    gender: document.getElementById("add-gender").value,
    email: document.getElementById("add-email").value,
    phone: document.getElementById("add-phone").value,
  };

  try {
    const response = await callAPIWithAuth("/users/receptionist", "POST", data);

    if (response.code === 1000) {
      showAlert("Thêm lễ tân thành công", "success");

      // đóng modal
      const modal = bootstrap.Modal.getInstance(
        document.getElementById("add-receptionist-modal"),
      );

      modal.hide();

      // reset form
      document.getElementById("add-receptionist-form").reset();

      // reload danh sách
      loadReceptionists(0);
    } else {
      showAlert(response.message || "Thêm thất bại", "danger");
    }
  } catch (error) {
    console.error("Lỗi thêm lễ tân:", error);
    showAlert("Không thể thêm lễ tân", "danger");
  }
}

// Hàm sửa lễ tân
async function updateReceptionist(event) {
  event.preventDefault();

  const data = {
    firstName: document.getElementById("update-first-name").value,
    lastName: document.getElementById("update-last-name").value,
    gender: document.getElementById("update-gender").value,
    email: document.getElementById("update-email").value,
    phone: document.getElementById("update-phone").value,
  };

  try {
    const response = await callAPIWithAuth(
      `/users/${updateUserId}/info`,
      "PUT",
      data,
    );

    if (response.code === 1000) {
      showAlert("Cập nhật thông tin thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("update-receptionist-modal"),
      );

      modal.hide();

      loadReceptionists(currentPage);
    } else {
      showAlert(response.message || "Cập nhật thất bại", "danger");
    }
  } catch (error) {
    console.error("Lỗi cập nhật lễ tân:", error);
    showAlert("Không thể cập nhật thông tin", "danger");
  }
}

// Hàm cấp lại mật khẩu
async function resetPassword(event) {
  event.preventDefault();

  const newPassword = document.getElementById("reset-new-password").value;
  const confirmPassword = document.getElementById(
    "reset-re-enter-new-password",
  ).value;

  if (newPassword !== confirmPassword) {
    showAlert("Mật khẩu nhập lại không khớp", "warning");
    return;
  }

  if (newPassword.length < 8) {
    showAlert("Mật khẩu phải ít nhất 8 ký tự", "warning");
    return;
  }

  const data = {
    newPassword: newPassword,
  };

  try {
    const response = await callAPIWithAuth(
      `/users/${resetUserId}/password`,
      "PUT",
      data,
    );

    if (response.code === 1000) {
      showAlert("Cấp lại mật khẩu thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("reset-password-receptionist-modal"),
      );

      modal.hide();

      document.getElementById("reset-password-form").reset();
    } else {
      showAlert(response.message || "Cấp lại mật khẩu thất bại", "danger");
    }
  } catch (error) {
    console.error("Lỗi reset password:", error);
    showAlert("Không thể cấp lại mật khẩu", "danger");
  }
}

// Hàm xóa lễ tân
async function deleteReceptionist() {
  try {
    const response = await callAPIWithAuth(`/users/${deleteUserId}`, "DELETE");

    if (response.code === 1000) {
      showAlert("Xóa lễ tân thành công", "success");

      const modal = bootstrap.Modal.getInstance(
        document.getElementById("delete-receptionist-modal"),
      );

      modal.hide();

      loadReceptionists(currentPage);
    } else {
      showAlert(response.message || "Xóa thất bại", "danger");
    }
  } catch (error) {
    console.error("Lỗi xóa lễ tân:", error);
    showAlert("Không thể xóa lễ tân", "danger");
  }
}

function openUpdateReceptionist(event, userId) {
  updateUserId = userId;

  const row = event.target.closest("tr");

  const username = row.children[0].innerText;
  const firstName = row.children[1].innerText;
  const lastName = row.children[2].innerText;
  const gender = row.children[3].innerText;
  const email = row.children[4].innerText;
  const phone = row.children[5].innerText;

  document.getElementById("update-username").value = username;
  document.getElementById("update-first-name").value = firstName;
  document.getElementById("update-last-name").value = lastName;
  document.getElementById("update-email").value = email;
  document.getElementById("update-phone").value = phone;

  if (gender === "Nam") {
    document.getElementById("update-gender").value = "MALE";
  } else if (gender === "Nữ") {
    document.getElementById("update-gender").value = "FEMALE";
  } else {
    document.getElementById("update-gender").value = "OTHER";
  }

  const modal = new bootstrap.Modal(
    document.getElementById("update-receptionist-modal"),
  );

  modal.show();
}

function openResetPassword(event, userId) {
  resetUserId = userId;

  const row = event.target.closest("tr");

  const username = row.children[0].innerText;
  const firstName = row.children[1].innerText;
  const lastName = row.children[2].innerText;

  document.getElementById("reset-username").value = username;
  document.getElementById("reset-first-name").value = firstName;
  document.getElementById("reset-last-name").value = lastName;

  const modal = new bootstrap.Modal(
    document.getElementById("reset-password-receptionist-modal"),
  );

  modal.show();
}

function openDeleteReceptionist(event, userId) {
  deleteUserId = userId;

  const row = event.target.closest("tr");

  const firstName = row.children[1].innerText;
  const lastName = row.children[2].innerText;

  const modalBody = document.querySelector(
    "#delete-receptionist-modal .modal-body",
  );

  modalBody.innerHTML = `
    Bạn có chắc chắn muốn xóa lễ tân <b>${firstName} ${lastName}</b> không?
  `;

  const modal = new bootstrap.Modal(
    document.getElementById("delete-receptionist-modal"),
  );

  modal.show();
}
