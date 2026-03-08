const API_BASE = "http://localhost:8080/hotel-booking/api/v1";

// API không cần token
async function callAPI(endpoint, method = "GET", data = null) {
  const options = {
    method: method,
    headers: {
      "Content-Type": "application/json",
    },
  };

  if (data) {
    options.body = JSON.stringify(data);
  }

  const response = await fetch(API_BASE + endpoint, options);

  if (!response.ok) {
    throw new Error("API error");
  }

  return response.json();
}

// API cần token
async function callAPIWithAuth(endpoint, method = "GET", data = null) {
  const token = localStorage.getItem("token");

  const options = {
    method: method,
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
  };

  if (data) {
    options.body = JSON.stringify(data);
  }

  const response = await fetch(API_BASE + endpoint, options);

  if (!response.ok) {
    throw new Error("API error");
  }

  return response.json();
}
