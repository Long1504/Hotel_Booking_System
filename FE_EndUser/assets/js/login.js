document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("loginForm");
  const username = document.getElementById("loginUsername");
  const password = document.getElementById("loginPassword");

  const setValid = (el) => {
    el.classList.remove("is-invalid");
    el.classList.add("is-valid");
  };

  const setInvalid = (el) => {
    el.classList.remove("is-valid");
    el.classList.add("is-invalid");
  };

  const validateUsername = () => {
    const v = username.value.trim();
    if (v.length >= 4 && !/\s/.test(v)) {
      setValid(username);
      return true;
    }
    setInvalid(username);
    return false;
  };

  const validatePassword = () => {
    const v = password.value;
    if (v.length >= 6) {
      setValid(password);
      return true;
    }
    setInvalid(password);
    return false;
  };

  username.addEventListener("input", validateUsername);
  password.addEventListener("input", validatePassword);

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const ok = validateUsername() & validatePassword(); // bitwise to run both
    if (ok) {
      alert("Đăng nhập thành công! (demo UI)");
      form.reset();
      username.classList.remove("is-valid");
      password.classList.remove("is-valid");
    }
  });
});