let currentPage = 0;
let pageSize = 10;
let currentKeyword = "";
let currentStatus = "";

let updatePriceRuleId = null;
let deletePriceRuleId = null;

// ================= LOAD =================
async function loadPriceRules(page = 0, keyword = "", status = "") {
  try {
    const endpoint = `/price-rules?isActive=${status}&priceRuleName=${keyword}&page=${page}&size=${pageSize}&sort=startDate,asc`;

    const response = await callAPIWithAuth(endpoint);
    const data = response.result;

    renderTable(data.content);
    renderPagination(data);

  } catch (error) {
    console.error("Lỗi load:", error);
    showAlert("Không thể tải dữ liệu", "danger");
  }
}

// ================= TABLE =================
function renderTable(list) {
  const tbody = document.querySelector("tbody");
  tbody.innerHTML = "";

  if (!list || list.length === 0) {
    tbody.innerHTML = `
      <tr>
        <td colspan="6" class="text-center text-secondary">
          Không có dữ liệu.
        </td>
      </tr>
    `;
    return;
  }

  list.forEach(item => {
    const statusText = item.isActive ? "HOẠT ĐỘNG" : "KHÔNG HOẠT ĐỘNG";
    const statusClass = item.isActive ? "text-success" : "text-danger";

    const row = `
      <tr>
        <td class="align-content-center">${item.priceRuleName}</td>
        <td class="align-content-center text-center">${formatDate(item.startDate)}</td>
        <td class="align-content-center text-center">${formatDate(item.endDate)}</td>
        <td class="align-content-center text-center">${item.priceMultiplier}</td>
        <td class="align-content-center text-center ${statusClass}">${statusText}</td>
        <td class="align-content-center text-center text-center">
          <button class="btn btn-sm btn-warning text-white"
            onclick="toggleStatus('${item.priceRuleId}')">
            <i class="bx ${item.isActive ? "bxs-lock-open" : "bxs-lock"}"></i>
          </button>

          <button class="btn btn-sm btn-primary text-white"
            onclick="openUpdate(
              '${item.priceRuleId}',
              '${item.priceRuleName}',
              '${item.startDate}',
              '${item.endDate}',
              ${item.priceMultiplier},
              ${item.isActive}
            )">
            <i class="bx bxs-pencil"></i>
          </button>

          <button class="btn btn-sm btn-danger text-white"
            onclick="openDelete(event, '${item.priceRuleId}')">
            <i class="bx bxs-trash"></i>
          </button>
        </td>
      </tr>
    `;

    tbody.innerHTML += row;
  });
}

// ================= PAGINATION =================
function renderPagination(data) {
  const pagination = document.querySelector(".pagination");
  pagination.innerHTML = "";

  pagination.innerHTML += `
    <li class="page-item ${data.first ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="changePage(${data.number - 1})">&laquo;</a>
    </li>
  `;

  for (let i = 0; i < data.totalPages; i++) {
    pagination.innerHTML += `
      <li class="page-item ${i === data.number ? "active" : ""}">
        <a class="page-link" href="#" onclick="changePage(${i})">${i + 1}</a>
      </li>
    `;
  }

  pagination.innerHTML += `
    <li class="page-item ${data.last ? "disabled" : ""}">
      <a class="page-link" href="#" onclick="changePage(${data.number + 1})">&raquo;</a>
    </li>
  `;
}

function changePage(page) {
  if (page < 0) return;
  currentPage = page;
  loadPriceRules(currentPage, currentKeyword, currentStatus);
}

// ================= FILTER =================
document.getElementById("price-rule-name-search")
  .addEventListener("input", function () {
    currentKeyword = this.value;
    currentPage = 0;
    loadPriceRules(0, currentKeyword, currentStatus);
  });

document.getElementById("price-rule-status-filter")
  .addEventListener("change", function () {
    currentStatus = this.value;
    currentPage = 0;
    loadPriceRules(0, currentKeyword, currentStatus);
  });

// ================= VALIDATE =================
function validateForm(name, startDate, endDate, multiplier) {
  if (!name || !startDate || !endDate) {
    showAlert("Vui lòng nhập đầy đủ thông tin", "warning");
    return false;
  }

  if (multiplier <= 0) {
    showAlert("Hệ số giá phải lớn hơn 0", "warning");
    return false;
  }

  if (new Date(endDate) < new Date(startDate)) {
    showAlert("Ngày kết thúc phải >= ngày bắt đầu", "warning");
    return false;
  }

  return true;
}

// ================= ADD =================
document.getElementById("add-price-rule-form")
  .addEventListener("submit", async function (e) {
    e.preventDefault();

    const name = document.getElementById("add-price-rule-name").value.trim();
    const startDate = document.getElementById("add-start-date").value;
    const endDate = document.getElementById("add-end-date").value;
    const multiplier = parseFloat(document.getElementById("add-price-multiplier").value);

    if (!validateForm(name, startDate, endDate, multiplier)) return;

    const data = {
      priceRuleName: name,
      startDate,
      endDate,
      priceMultiplier: multiplier,
      isActive: document.getElementById("add-price-rule-status").value === "true"
    };

    try {
      const res = await callAPIWithAuth("/price-rules", "POST", data);

      if (res.code === 1000) {
        showAlert("Thêm thành công", "success");

        bootstrap.Modal.getInstance(
          document.getElementById("add-price-rule-modal")
        ).hide();

        this.reset();
        loadPriceRules(0, currentKeyword, currentStatus);
      } else {
        showAlert(res.message, "danger");
      }

    } catch {
      showAlert("Lỗi thêm", "danger");
    }
  });

// ================= UPDATE =================
function openUpdate(id, name, startDate, endDate, multiplier, isActive) {
  updatePriceRuleId = id;

  document.getElementById("update-price-rule-name").value = name;
  document.getElementById("update-start-date").value = startDate;
  document.getElementById("update-end-date").value = endDate;
  document.getElementById("update-price-multiplier").value = multiplier;
  document.getElementById("update-price-rule-status").value = isActive.toString();

  new bootstrap.Modal(
    document.getElementById("update-price-rule-modal")
  ).show();
}

document.getElementById("update-price-rule-form")
  .addEventListener("submit", async function (e) {
    e.preventDefault();

    const name = document.getElementById("update-price-rule-name").value.trim();
    const startDate = document.getElementById("update-start-date").value;
    const endDate = document.getElementById("update-end-date").value;
    const multiplier = parseFloat(document.getElementById("update-price-multiplier").value);

    if (!validateForm(name, startDate, endDate, multiplier)) return;

    const data = {
      priceRuleName: name,
      startDate,
      endDate,
      priceMultiplier: multiplier,
      isActive: document.getElementById("update-price-rule-status").value === "true"
    };

    try {
      const res = await callAPIWithAuth(
        `/price-rules/${updatePriceRuleId}`,
        "PUT",
        data
      );

      if (res.code === 1000) {
        showAlert("Cập nhật thành công", "success");

        bootstrap.Modal.getInstance(
          document.getElementById("update-price-rule-modal")
        ).hide();

        loadPriceRules(currentPage, currentKeyword, currentStatus);
      } else {
        showAlert(res.message, "danger");
      }

    } catch {
      showAlert("Lỗi cập nhật", "danger");
    }
  });

// ================= DELETE =================
function openDelete(event, id) {
  deletePriceRuleId = id;

  const name = event.target.closest("tr").children[0].innerText;

  document.querySelector("#delete-price-rule-modal .modal-body").innerHTML =
    `Bạn có chắc chắn muốn xóa <b>${name}</b> không?`;

  new bootstrap.Modal(
    document.getElementById("delete-price-rule-modal")
  ).show();
}

document.getElementById("confirm-delete-price-rule")
  .addEventListener("click", async function () {
    try {
      const res = await callAPIWithAuth(
        `/price-rules/${deletePriceRuleId}`,
        "DELETE"
      );

      if (res.code === 1000) {
        showAlert("Xóa thành công", "success");

        bootstrap.Modal.getInstance(
          document.getElementById("delete-price-rule-modal")
        ).hide();

        loadPriceRules(currentPage, currentKeyword, currentStatus);
      } else {
        showAlert(res.message, "danger");
      }

    } catch {
      showAlert("Lỗi xóa", "danger");
    }
  });

// ================= TOGGLE =================
async function toggleStatus(id) {
  try {
    const res = await callAPIWithAuth(
      `/price-rules/${id}/toggle`,
      "PUT"
    );

    if (res.code === 1000) {
      showAlert("Cập nhật trạng thái thành công", "success");
      loadPriceRules(currentPage, currentKeyword, currentStatus);
    } else {
      showAlert(res.message, "danger");
    }

  } catch {
    showAlert("Lỗi cập nhật trạng thái", "danger");
  }
}

// ================= UTIL =================
function formatDate(dateStr) {
  if (!dateStr) return "";

  const [year, month, day] = dateStr.split("-");
  return `${day}/${month}/${year}`;
}

function toInputDate(dateStr) {
  const [day, month, year] = dateStr.split("/");
  return `${year}-${month}-${day}`;
}

// ================= ALERT =================
function showAlert(message, type = "success") {
  const container = document.getElementById("alert-container");

  const alert = document.createElement("div");
  alert.className = `alert alert-${type} alert-dismissible fade show small shadow`;

  alert.innerHTML = `
    ${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  `;

  container.appendChild(alert);

  setTimeout(() => {
    alert.classList.remove("show");
    setTimeout(() => alert.remove(), 300);
  }, 3000);
}

// ================= INIT =================
document.addEventListener("DOMContentLoaded", () => {
  loadPriceRules();
});