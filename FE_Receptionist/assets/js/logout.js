async function logout() {
  const token = localStorage.getItem("tokenHotelBooking");

  if (!token) {
    window.location.href = "login.html";
    return;
  }

  try {
    await callAPI("/auth/logout", "POST", {
      token: token
    });
  } catch (error) {
    console.log("Logout error:", error);
  }

  localStorage.removeItem("tokenHotelBooking");
  window.location.href = "login.html";
}

document.addEventListener("DOMContentLoaded", () => {
  const logoutBtn = document.getElementById("logout-btn");

  if (logoutBtn) {
    logoutBtn.addEventListener("click", function (e) {
      e.preventDefault();
      logout();
    });
  }
});