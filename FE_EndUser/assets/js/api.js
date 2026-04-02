const API_BASE = "http://localhost:8080/hotel-booking/api/v1";
// const API_BASE = "https://nadia-nonstudied-lilianna.ngrok-free.dev/hotel-booking/api/v1";

async function parseApiResponse(response) {
  const contentType = response.headers.get("content-type") || "";

  try {
    if (contentType.includes("application/json")) {
      return await response.json();
    }

    const text = await response.text();
    return text ? { message: text } : null;
  } catch (error) {
    console.error("Parse response error:", error);
    return null;
  }
}

function getStoredToken() {
  return (
    localStorage.getItem("tokenHotelBooking") ||
    sessionStorage.getItem("tokenHotelBooking") ||
    ""
  );
}

async function callAPI(endpoint, method = "GET", data = null) {
  const options = {
    method,
    headers: {
      "Content-Type": "application/json",
      "ngrok-skip-browser-warning": "true",
    },
  };

  if (data) {
    options.body = JSON.stringify(data);
  }

  const response = await fetch(API_BASE + endpoint, options);
  const payload = await parseApiResponse(response);

  if (!response.ok) {
    throw new Error(payload?.message || `API error (${response.status})`);
  }

  return payload;
}

async function callAPIWithAuth(endpoint, method = "GET", data = null) {
  const token = getStoredToken();

  const options = {
    method,
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
      "ngrok-skip-browser-warning": "true",
    },
  };

  if (data) {
    options.body = JSON.stringify(data);
  }

  const response = await fetch(API_BASE + endpoint, options);
  const payload = await parseApiResponse(response);

  if (!response.ok) {
    throw new Error(payload?.message || `API error (${response.status})`);
  }

  return payload;
}