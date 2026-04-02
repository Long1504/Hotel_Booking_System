document.addEventListener("DOMContentLoaded", function () {
    const token = localStorage.getItem("tokenHotelBookingCustomer");

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
});