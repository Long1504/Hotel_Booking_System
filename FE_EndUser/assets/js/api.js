const API_BASE = "http://localhost:8080/hotel-booking/api/v1";

const STORAGE_KEYS = {
  token: "token",
  username: "username",
  userRoles: "userRoles",
  rememberMe: "rememberMe",
};

function getStorage(rememberMe = true) {
  return rememberMe ? localStorage : sessionStorage;
}

function saveAuth(auth) {
  const rememberMe = !!auth.rememberMe;
  const storage = getStorage(rememberMe);

  localStorage.removeItem(STORAGE_KEYS.token);
  localStorage.removeItem(STORAGE_KEYS.username);
  localStorage.removeItem(STORAGE_KEYS.userRoles);
  localStorage.removeItem(STORAGE_KEYS.rememberMe);

  sessionStorage.removeItem(STORAGE_KEYS.token);
  sessionStorage.removeItem(STORAGE_KEYS.username);
  sessionStorage.removeItem(STORAGE_KEYS.userRoles);
  sessionStorage.removeItem(STORAGE_KEYS.rememberMe);

  storage.setItem(STORAGE_KEYS.token, auth.token || "");
  storage.setItem(STORAGE_KEYS.username, auth.username || "");
  storage.setItem(STORAGE_KEYS.userRoles, JSON.stringify(auth.roles || []));
  localStorage.setItem(STORAGE_KEYS.rememberMe, rememberMe ? "true" : "false");
}

function getToken() {
  return (
    localStorage.getItem(STORAGE_KEYS.token) ||
    sessionStorage.getItem(STORAGE_KEYS.token)
  );
}

function getUsername() {
  return (
    localStorage.getItem(STORAGE_KEYS.username) ||
    sessionStorage.getItem(STORAGE_KEYS.username)
  );
}

function getRoles() {
  const roles =
    localStorage.getItem(STORAGE_KEYS.userRoles) ||
    sessionStorage.getItem(STORAGE_KEYS.userRoles);

  try {
    return roles ? JSON.parse(roles) : [];
  } catch (_) {
    return [];
  }
}

function clearAuth() {
  Object.values(STORAGE_KEYS).forEach((key) => {
    localStorage.removeItem(key);
    sessionStorage.removeItem(key);
  });
}

function decodeJwt(token) {
  try {
    const payload = token.split(".")[1];
    const normalized = payload.replace(/-/g, "+").replace(/_/g, "/");
    const decoded = decodeURIComponent(
      atob(normalized)
        .split("")
        .map((char) => `%${(`00${char.charCodeAt(0).toString(16)}`).slice(-2)}`)
        .join("")
    );

    return JSON.parse(decoded);
  } catch (_) {
    return null;
  }
}

async function handleResponse(response) {
  const data = await response.json().catch(() => null);

  if (!response.ok) {
    const message = data?.message || "Có lỗi xảy ra khi gọi API.";
    const error = new Error(message);
    error.status = response.status;
    error.payload = data;
    throw error;
  }

  return data;
}

async function callAPI(endpoint, method = "GET", data = null, extraHeaders = {}) {
  const options = {
    method,
    headers: {
      "Content-Type": "application/json",
      ...extraHeaders,
    },
  };

  if (data) {
    options.body = JSON.stringify(data);
  }

  const response = await fetch(`${API_BASE}${endpoint}`, options);
  return handleResponse(response);
}

async function callAPIWithAuth(endpoint, method = "GET", data = null) {
  const token = getToken();

  if (!token) {
    throw new Error("Bạn chưa đăng nhập.");
  }

  return callAPI(endpoint, method, data, {
    Authorization: `Bearer ${token}`,
  });
}