document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("loginForm");
    const messageDiv = document.getElementById("loginMessage");

    if (!form.dataset.listenerAttached) {
        form.dataset.listenerAttached = "true";

        form.addEventListener("submit", async function (event) {
            event.preventDefault();
            event.stopPropagation();

            // Reset thông báo
            messageDiv.textContent = "";
            messageDiv.className = "mb-3 text-center";

            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value;

            const data = { username, password };

            try {
                const res = await callAPI("/auth/login", "POST", data);

                if (res.code === 1000) {
                    messageDiv.textContent = res.message; // "Đăng nhập thành công"
                    messageDiv.classList.add("text-success");

                    // Lưu token vào localStorage
                    localStorage.setItem("tokenHotelBookingCustomer", res.result.token);

                    // Chuyển hướng sau 1.5 giây
                    setTimeout(() => {
                        window.location.href = "index.html";
                    }, 1500);
                } else {
                    // Hiển thị lỗi từ server
                    messageDiv.textContent = res.message;
                    messageDiv.classList.add("text-danger");
                }
            } catch (error) {
                console.error("Đăng nhập thất bại:", error);
                messageDiv.textContent = "Có lỗi xảy ra, vui lòng thử lại sau.";
                messageDiv.classList.add("text-danger");
            }
        });
    }
});

// Đăng nhập Google
async function handleCredentialResponse(response) {

    const messageDiv = document.getElementById("loginMessage");

    // Reset message
    messageDiv.textContent = "";
    messageDiv.className = "mb-3 text-center";

    try {

        const res = await callAPI(
            "/auth/google",
            "POST",
            {
                token: response.credential
            }
        );

        console.log("Google Login:", res);

        if (res.code === 1000) {

            messageDiv.textContent = res.message;
            messageDiv.classList.add("text-success");

            // Lưu JWT
            localStorage.setItem(
                "tokenHotelBookingCustomer",
                res.result.token
            );

            // Redirect
            setTimeout(() => {
                window.location.href = "index.html";
            }, 1500);

        } else {

            messageDiv.textContent = res.message;
            messageDiv.classList.add("text-danger");
        }

    } catch (error) {

        console.error("Google Login Error:", error);

        messageDiv.textContent =
            "Đăng nhập Google thất bại";

        messageDiv.classList.add("text-danger");
    }
}