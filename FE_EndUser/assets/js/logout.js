async function logout() {
  const token = localStorage.getItem("tokenHotelBookingCustomer");

  if (!token) {
    window.location.href = "index.html";
    return;
  }

  try {
    await callAPI("/auth/logout", "POST", {
      token: token
    });
  } catch (error) {
    console.log("Logout error:", error);
  }

  localStorage.removeItem("tokenHotelBookingCustomer");
  window.location.href = "index.html";
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