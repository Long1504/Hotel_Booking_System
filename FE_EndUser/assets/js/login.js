document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("loginForm");
  const username = document.getElementById("loginUsername");
  const password = document.getElementById("loginPassword");
  const rememberMe = document.getElementById("rememberMe");
  const submitButton = form?.querySelector('button[type="submit"]');

  if (!form || !username || !password) return;

  const setValid = (el) => {
    el.classList.remove("is-invalid");
    el.classList.add("is-valid");
  };

  const setInvalid = (el) => {
    el.classList.remove("is-valid");
    el.classList.add("is-invalid");
  };

  const setLoading = (isLoading) => {
    if (!submitButton) return;
    submitButton.disabled = isLoading;
    submitButton.textContent = isLoading ? "Đang đăng nhập..." : "Đăng nhập";
  };

  const validateUsername = () => {
    const value = username.value.trim();
    const isValid = value.length >= 4 && !/\s/.test(value);
    isValid ? setValid(username) : setInvalid(username);
    return isValid;
  };

  const validatePassword = () => {
    const isValid = password.value.length >= 6;
    isValid ? setValid(password) : setInvalid(password);
    return isValid;
  };

  const getRedirectPageByRole = (roles = []) => {
    if (roles.includes("ADMIN")) return "../FE_Admin/index.html";
    if (roles.includes("RECEPTIONIST")) return "../FE_Admin/receptionist.html";
    return "index.html";
  };

  username.addEventListener("input", validateUsername);
  password.addEventListener("input", validatePassword);

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const isFormValid = validateUsername() && validatePassword();
    if (!isFormValid) {
      alert("Vui lòng nhập đúng tên đăng nhập và mật khẩu.");
      return;
    }

    setLoading(true);

    try {
      const response = await callAPI("/auth/login", "POST", {
        username: username.value.trim(),
        password: password.value,
      });

      const token = response?.result?.token;
      const authenticated = response?.result?.authenticated;

      if (!token || !authenticated) {
        throw new Error(response?.message || "Đăng nhập thất bại.");
      }

      const jwtPayload = decodeJwt(token);
      const roles = jwtPayload?.scope
        ? jwtPayload.scope.split(" ").filter(Boolean)
        : [];

      saveAuth({
        token,
        username: username.value.trim(),
        roles,
        rememberMe: rememberMe?.checked,
      });

      localStorage.setItem("username", username.value.trim());

      window.location.href = getRedirectPageByRole(roles);
    } catch (error) {
      console.error("Login error:", error);
      alert(error.message || "Không thể kết nối tới server.");
    } finally {
      setLoading(false);
    }
  });
});