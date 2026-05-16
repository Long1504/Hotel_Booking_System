document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("registerForm");
    const messageDiv = document.getElementById("registerMessage");

    // Kiểm tra nếu form đã có listener trước đó thì không gắn thêm
    if (!form.dataset.listenerAttached) {
        form.dataset.listenerAttached = "true";

        form.addEventListener("submit", async function (event) {
            event.preventDefault();
            event.stopPropagation();

            // Reset thông báo
            messageDiv.textContent = "";
            messageDiv.className = "mb-4 text-center";

            let isValid = true;

            const username = document.getElementById("username");
            const lastName = document.getElementById("last-name");
            const firstName = document.getElementById("first-name");
            const gender = document.getElementById("gender");
            const email = document.getElementById("email");
            const phone = document.getElementById("phone");
            const password = document.getElementById("password");
            const confirmPassword = document.getElementById("confirm-password");

            // Reset trạng thái
            form.querySelectorAll(".form-control, .form-select").forEach(input => {
                input.classList.remove("is-invalid");
            });

            // Validate
            if (username.value.trim().length < 4) { username.classList.add("is-invalid"); isValid = false; }
            if (lastName.value.trim() === "") { lastName.classList.add("is-invalid"); isValid = false; }
            if (firstName.value.trim() === "") { firstName.classList.add("is-invalid"); isValid = false; }
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value.trim())) { email.classList.add("is-invalid"); isValid = false; }
            const phoneRegex = /^[0-9]{10}$/;
            if (!phoneRegex.test(phone.value.trim())) { phone.classList.add("is-invalid"); isValid = false; }
            if (password.value.length < 8) { password.classList.add("is-invalid"); isValid = false; }
            if (confirmPassword.value !== password.value || confirmPassword.value === "") { confirmPassword.classList.add("is-invalid"); isValid = false; }

            if (!isValid) return;

            // Gọi API
            const data = {
                username: username.value.trim(),
                password: password.value,
                firstName: firstName.value.trim(),
                lastName: lastName.value.trim(),
                gender: gender.value,
                email: email.value.trim(),
                phone: phone.value.trim()
            };

            try {
                const res = await callAPI("/users/register", "POST", data);

                if (res.code === 1000) {
                    messageDiv.textContent = res.message; // "Tạo tài khoản thành công"
                    messageDiv.classList.add("text-success");

                    form.reset();

                    // Chuyển sang login sau 1.5 giây
                    setTimeout(() => {
                        window.location.href = "login.html";
                    }, 300);
                } else {
                    messageDiv.textContent = res.message; // lỗi từ server
                    messageDiv.classList.add("text-danger");
                }
            } catch (error) {
                console.error(error);
                messageDiv.textContent = "Có lỗi xảy ra, vui lòng thử lại sau.";
                messageDiv.classList.add("text-danger");
            }
        });
    }
});

// Đăng nhập Google
async function handleCredentialResponse(response) {
    const messageDiv = document.getElementById("registerMessage");

    // Reset thông báo
    messageDiv.textContent = "";
    messageDiv.className = "mb-4 text-center";

    try {
        // Gửi token nhận được từ Google lên Backend
        const res = await callAPI(
            "/auth/google",
            "POST",
            {
                token: response.credential
            }
        );

        console.log("Google Auth Response:", res);

        if (res.code === 1000) {
            messageDiv.textContent = "Đăng nhập thành công bằng Google!";
            messageDiv.classList.add("text-success");

            localStorage.setItem("tokenHotelBookingCustomer", res.result.token);

            setTimeout(() => {
                window.location.href = "index.html";
            }, 300);

        } else {
            messageDiv.textContent = res.message;
            messageDiv.classList.add("text-danger");
        }

    } catch (error) {
        console.error("Google Auth Error:", error);
        messageDiv.textContent = "Xác thực với Google thất bại. Vui lòng thử lại.";
        messageDiv.classList.add("text-danger");
    }
}