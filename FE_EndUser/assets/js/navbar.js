document.addEventListener("DOMContentLoaded", function () {
    const token = localStorage.getItem("tokenHotelBookingCustomer");

    // Xử lý ẩn hiện nút Tài khoản, Đăng ký, Đăng nhập dựa trên trạng thái đăng nhập
    const accountBtn = document.getElementById("account-btn");
    const registerBtn = document.getElementById("register-btn");
    const loginBtn = document.getElementById("login-btn");

    if (token) {
        accountBtn.style.display = "flex";
        registerBtn.style.display = "none";
        loginBtn.style.display = "none";
    } else {
        accountBtn.style.display = "none";
        registerBtn.style.display = "inline-flex";
        loginBtn.style.display = "inline-flex";
    }

    // Xử lý nút Hỗ trợ
    const supportLink = document.querySelector('a[href="support.html"]');
    if (supportLink) {
        supportLink.addEventListener("click", function (e) {
            if (!token) {
                e.preventDefault(); // Chặn chuyển trang
                alert("Vui lòng đăng nhập để sử dụng chức năng hỗ trợ!");
                window.location.href = "login.html"; // Chuyển hướng đến trang login của bạn
            }
        });
    }
});