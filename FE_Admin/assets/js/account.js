document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector("#profile-change-password form");

  form.addEventListener("submit", async function (e) {
    e.preventDefault();

    const currentPassword = document.getElementById("current-password").value.trim();
    const newPassword = document.getElementById("new-password").value.trim();
    const renewPassword = document.getElementById("renew-password").value.trim();

    // ===== Validate =====
    if (!currentPassword || !newPassword || !renewPassword) {
      alert("Vui lòng nhập đầy đủ thông tin");
      return;
    }

    if (newPassword !== renewPassword) {
      alert("Mật khẩu xác nhận không khớp");
      return;
    }

    if (newPassword.length < 8) {
      alert("Mật khẩu mới phải có ít nhất 8 ký tự");
      return;
    }

    try {
      const response = await callAPIWithAuth(
        "/users/my-password",
        "PUT",
        {
          currentPassword: currentPassword,
          newPassword: newPassword
        }
      );

      // ===== Xử lý kết quả =====
      if (response && response.code === 1000) {
        alert("Đổi mật khẩu thành công");

        // reset form
        form.reset();
      } else {
        alert(response.message || "Đổi mật khẩu thất bại");
      }
    } catch (error) {
      console.error("Lỗi:", error);
      alert("Có lỗi xảy ra, vui lòng thử lại");
    }
  });
});