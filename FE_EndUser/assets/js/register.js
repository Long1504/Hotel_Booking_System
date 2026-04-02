document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("registerForm");
  const username = document.getElementById("username");
  const lastName = document.getElementById("lastName");
  const firstName = document.getElementById("firstName");
  const gender = document.getElementById("gender");
  const email = document.getElementById("email");
  const phone = document.getElementById("phone");
  const password = document.getElementById("password");
  const confirmPassword = document.getElementById("confirmPassword");
  const submitButton = form?.querySelector('button[type="submit"]');

  if (!form) return;

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
    submitButton.textContent = isLoading ? "Đang tạo tài khoản..." : "Tạo tài khoản";
  };

  const isEmailValid = (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim());
  const normalizePhone = (value) => (value || "").replace(/\D/g, "");
  const isPhoneValid = (value) => /^0\d{9}$/.test(normalizePhone(value));

  const validateUsername = () => {
    const value = username.value.trim();
    const isValid = value.length >= 4 && !/\s/.test(value);
    isValid ? setValid(username) : setInvalid(username);
    return isValid;
  };

  const validateLastName = () => {
    const isValid = lastName.value.trim().length > 0;
    isValid ? setValid(lastName) : setInvalid(lastName);
    return isValid;
  };

  const validateFirstName = () => {
    const isValid = firstName.value.trim().length > 0;
    isValid ? setValid(firstName) : setInvalid(firstName);
    return isValid;
  };

  const validateGender = () => {
    const isValid = gender.value.trim().length > 0;
    isValid ? setValid(gender) : setInvalid(gender);
    return isValid;
  };

  const validateEmail = () => {
    const isValid = isEmailValid(email.value);
    isValid ? setValid(email) : setInvalid(email);
    return isValid;
  };

  const validatePhone = () => {
    phone.value = normalizePhone(phone.value);
    const isValid = isPhoneValid(phone.value);
    isValid ? setValid(phone) : setInvalid(phone);
    return isValid;
  };

  const validatePassword = () => {
    const isValid = password.value.length >= 6;
    isValid ? setValid(password) : setInvalid(password);
    return isValid;
  };

  const validateConfirmPassword = () => {
    const isValid =
      confirmPassword.value.length >= 6 &&
      confirmPassword.value === password.value;
    isValid ? setValid(confirmPassword) : setInvalid(confirmPassword);
    return isValid;
  };

  const mapGender = (value) => {
    switch (value) {
      case "male":
        return "MALE";
      case "female":
        return "FEMALE";
      default:
        return "OTHER";
    }
  };

  [username, lastName, firstName, email, phone, password, confirmPassword].forEach((input) => {
    input.addEventListener("input", () => {
      if (input === username) validateUsername();
      if (input === lastName) validateLastName();
      if (input === firstName) validateFirstName();
      if (input === email) validateEmail();
      if (input === phone) validatePhone();
      if (input === password) {
        validatePassword();
        validateConfirmPassword();
      }
      if (input === confirmPassword) validateConfirmPassword();
    });
  });

  gender.addEventListener("change", validateGender);

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const isFormValid =
      validateUsername() &&
      validateLastName() &&
      validateFirstName() &&
      validateGender() &&
      validateEmail() &&
      validatePhone() &&
      validatePassword() &&
      validateConfirmPassword();

    if (!isFormValid) {
      alert("Vui lòng kiểm tra lại thông tin đăng ký.");
      return;
    }

    setLoading(true);

    try {
      const response = await callAPI("/users/register", "POST", {
        username: username.value.trim(),
        password: password.value,
        firstName: firstName.value.trim(),
        lastName: lastName.value.trim(),
        gender: mapGender(gender.value),
        email: email.value.trim(),
        phone: normalizePhone(phone.value),
      });

      alert(response?.message || "Đăng ký thành công.");

      form.reset();
      [username, lastName, firstName, gender, email, phone, password, confirmPassword].forEach((el) => {
        el.classList.remove("is-valid", "is-invalid");
      });

      window.location.href = "login.html";
    } catch (error) {
      console.error("Register error:", error);
      alert(error.message || "Không thể kết nối tới server.");
    } finally {
      setLoading(false);
    }
  });
});