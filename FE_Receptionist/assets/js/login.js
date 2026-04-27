document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form.needs-validation");
  const loginMessage = document.getElementById("login-message");
  const loginBtn = document.getElementById("login-btn");
  const loginSpinner = document.getElementById("login-spinner");
  const loginText = document.getElementById("login-text");

  const usernameInput = document.getElementById("username");
  const passwordInput = document.getElementById("password");

  function showMessage(text, type = "danger") {
    loginMessage.textContent = text;
    loginMessage.className = `alert  text-center p-2 small alert-${type}`;
    loginMessage.style.display = "block";
  }

  function hideMessage() {
    loginMessage.style.display = "none";
  }

  form.addEventListener("submit", async (event) => {
    event.preventDefault();
    event.stopPropagation();

    form.classList.add("was-validated");

    if (!form.checkValidity()) {
      return;
    }

    const username = usernameInput.value.trim();
    const password = passwordInput.value;

    if (!username || !password) {
      showMessage("Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.", "danger");
      return;
    }

    try {
      hideMessage();

      loginBtn.disabled = true;
      loginSpinner.classList.remove("d-none");
      loginText.textContent = "Đang đăng nhập...";

      const response = await callAPI("/auth/login", "POST", {
        username,
        password,
      });

      // Nếu login thành công
      if (response.code === 1000 && response.result && response.result.token) {
        // Kiểm tra role (chỉ cho phép RECEPTIONIST)
        if (response.result.role === "RECEPTIONIST") {
          localStorage.setItem("tokenHotelBookingReceptionist", response.result.token);
          showMessage(response.message || "Đăng nhập thành công", "success");

          // redirect sang rooms.html sau 0.5s
          setTimeout(() => {
            window.location.href = "rooms.html";
          }, 300);
        } else {
          showMessage("Tài khoản không có quyền truy cập", "danger");
        }
      } else {
        // Hiển thị message lỗi nếu login không thành công
        showMessage(response.message || "Đã xảy ra lỗi.", "danger");
        usernameInput.focus();
        usernameInput.select();
      }
    } catch (error) {
      showMessage("Không thể kết nối tới server. Vui lòng thử lại.", "danger");
      console.error("Login error:", error);
    } finally {
      loginBtn.disabled = false;
      loginSpinner.classList.add("d-none");
      loginText.textContent = "Đăng nhập";
    }
  });
});
