document.addEventListener("DOMContentLoaded", function () {

  // CHECK TOKEN
  const token = localStorage.getItem("tokenHotelBookingCustomer");
  if (!token) {
    window.location.href = "index.html";
    return;
  }

  // LOAD THÔNG TIN CÁ NHÂN
  async function loadUserInfo() {
    try {
      const res = await callAPIWithAuth("/users/my-info", "GET");

      if (res.code === 1000) {
        const user = res.result;

        // fill dữ liệu vào form
        document.getElementById("first-name").value = user.firstName || "";
        document.getElementById("last-name").value = user.lastName || "";
        document.getElementById("gender").value = user.gender || "OTHER";
        document.getElementById("email").value = user.email || "";
        document.getElementById("phone").value = user.phone || "";

        // cập nhật tên hiển thị
        document.getElementById("customer-name").innerText = user.firstName + " " + user.lastName;

      } else {
        alert(res.message);
      }

    } catch (error) {
      console.error(error);
      alert("Không thể tải thông tin người dùng!");
    }
  }

  loadUserInfo();


  // CẬP NHẬT THÔNG TIN CÁ NHÂN
  const profileForm = document.getElementById("profile-form");

  profileForm.addEventListener("submit", async function (e) {
    e.preventDefault();

    const data = {
      firstName: document.getElementById("first-name").value.trim(),
      lastName: document.getElementById("last-name").value.trim(),
      gender: document.getElementById("gender").value,
      email: document.getElementById("email").value.trim(),
      phone: document.getElementById("phone").value.trim()
    };

    try {
      const res = await callAPIWithAuth(
        "/users/my-info",
        "PUT",
        data
      );

      alert(res.message);

      if (res.code === 1000) {
        // cập nhật lại tên
        document.getElementById("customer-name").innerText =
          res.result.firstName + " " + res.result.lastName;
      }

    } catch (error) {
      console.error(error);
      alert("Có lỗi khi cập nhật thông tin!");
    }
  });


  // ĐỔI MẬT KHẨU
  const securityForm = document.getElementById("security-form");

  securityForm.addEventListener("submit", async function (e) {
    e.preventDefault();

    const inputs = securityForm.querySelectorAll("input");

    const currentPassword = inputs[0].value;
    const newPassword = inputs[1].value;
    const confirmPassword = inputs[2].value;

    // validate
    if (newPassword !== confirmPassword) {
      alert("Mật khẩu xác nhận không khớp!");
      return;
    }

    if (newPassword.length < 8) {
      alert("Mật khẩu mới phải >= 8 ký tự!");
      return;
    }

    const data = {
      currentPassword,
      newPassword
    };

    try {
      const res = await callAPIWithAuth(
        "/users/my-password",
        "PUT",
        data
      );

      alert(res.message);

      if (res.code === 1000) {
        securityForm.reset();
      }

    } catch (error) {
      console.error(error);
      alert("Có lỗi khi đổi mật khẩu!");
    }
  });

});