document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("registerForm");

    form.addEventListener("submit", function (event) {

        event.preventDefault();
        event.stopPropagation();

        let isValid = true;

        const username = document.getElementById("username");
        const lastName = document.getElementById("lastName");
        const firstName = document.getElementById("firstName");
        const gender = document.getElementById("gender");
        const email = document.getElementById("email");
        const phone = document.getElementById("phone");
        const password = document.getElementById("password");
        const confirmPassword = document.getElementById("confirmPassword");

        // Reset trạng thái
        form.querySelectorAll(".form-control, .form-select").forEach(input => {
            input.classList.remove("is-invalid");
        });

        // Username >= 4 ký tự
        if (username.value.trim().length < 4) {
            username.classList.add("is-invalid");
            isValid = false;
        }

        // Họ
        if (lastName.value.trim() === "") {
            lastName.classList.add("is-invalid");
            isValid = false;
        }

        // Tên
        if (firstName.value.trim() === "") {
            firstName.classList.add("is-invalid");
            isValid = false;
        }

        // Giới tính
        if (gender.value === "") {
            gender.classList.add("is-invalid");
            isValid = false;
        }

        // Email regex
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email.value.trim())) {
            email.classList.add("is-invalid");
            isValid = false;
        }

        // SĐT: 10-11 số
        const phoneRegex = /^[0-9]{10}$/;
        if (!phoneRegex.test(phone.value.trim())) {
            phone.classList.add("is-invalid");
            isValid = false;
        }

        // Password >= 6 ký tự
        if (password.value.length < 6) {
            password.classList.add("is-invalid");
            isValid = false;
        }

        // Confirm password
        if (confirmPassword.value !== password.value || confirmPassword.value === "") {
            confirmPassword.classList.add("is-invalid");
            isValid = false;
        }

        if (isValid) {
            alert("Đăng ký thành công!");
            form.reset();
        }
    });
});