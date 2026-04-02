async function logout() {
  const token = localStorage.getItem("tokenHotelBookingReceptionist");

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

  localStorage.removeItem("tokenHotelBookingReceptionist");
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