document.addEventListener("DOMContentLoaded", function () {
  const toggleBtn = document.getElementById("chatbotToggle");
  const chatbotWindow = document.getElementById("chatbotWindow");
  const chatMessages = document.getElementById("chatMessages");
  const chatInput = document.getElementById("chatInput");
  const sendBtn = document.getElementById("sendMsg");
  const chatbotClose = document.getElementById("chatbotClose");

  const CHAT_API = "/chatbot";
  const HISTORY_API = "/chatbot/history";

  const token = localStorage.getItem("tokenHotelBookingCustomer");

  // Chọn API phù hợp
  function callAPIByAuth(endpoint, method = "GET", data = null, requireAuth = false) {
    if (requireAuth) {
      return callAPIWithAuth(endpoint, method, data);
    } else {
      return callAPI(endpoint, method, data);
    }
  }

  // Hiển thị tin nhắn
  function appendMessage(type, content) {
    const msgDiv = document.createElement("div");
    msgDiv.className = type === "USER" ? "chat-message user" : "chat-message bot";
    msgDiv.innerHTML = content.replace(/\n/g, "<br>");
    chatMessages.appendChild(msgDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
  }

  // Load lịch sử chat (cần token)
  async function loadHistory() {
    try {
      if (!token) {
        chatMessages.innerHTML = `<div class="text-muted text-center small">Vui lòng đăng nhập để xem lịch sử</div>`;
        return;
      }

      const data = await callAPIByAuth(HISTORY_API, "GET", null, true);

      if (data.code === 1000 && Array.isArray(data.result)) {
        chatMessages.innerHTML = "";
        data.result.forEach(item => appendMessage(item.type, item.content));
      } else {
        chatMessages.innerHTML = `<div class="text-muted text-center small">Không thể tải lịch sử chat</div>`;
      }
    } catch (err) {
      console.error(err);
      chatMessages.innerHTML = `<div class="text-muted text-center small">Không thể tải lịch sử chat</div>`;
    }
  }

  function showTyping() {
    const typingDiv = document.createElement("div");
    typingDiv.className = "chat-message bot typing";
    typingDiv.id = "typingIndicator";

    typingDiv.innerHTML = `
      <span class="dot"></span>
      <span class="dot"></span>
      <span class="dot"></span>
    `;

    chatMessages.appendChild(typingDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
  }

  function removeTyping() {
    const typingDiv = document.getElementById("typingIndicator");
    if (typingDiv) typingDiv.remove();
  }

  // Gửi tin nhắn (có thể cần hoặc không cần token tùy backend)
  async function sendMessage() {
    const msg = chatInput.value.trim();
    if (!msg) return;

    appendMessage("USER", msg);
    chatInput.value = "";

    showTyping();

    try {
      const data = await callAPIByAuth(
        CHAT_API,
        "POST",
        { message: msg },
        !!token // chỉ gửi auth nếu có token
      );

      removeTyping();

      if (data.code === 1000) {
        appendMessage("ASSISTANT", data.result);
      } else {
        appendMessage("ASSISTANT", "Chatbot gặp lỗi. Hãy thử lại sau.");
      }
    } catch (err) {
      console.error(err);
      appendMessage("ASSISTANT", "Không thể kết nối tới server.");
    }
  }

  // Toggle chatbot
  toggleBtn.addEventListener("click", () => {
    const isShown = chatbotWindow.classList.toggle("show");
    if (isShown) loadHistory();
  });

  // Close chatbot
  chatbotClose.addEventListener("click", () => {
    chatbotWindow.classList.remove("show");
  });

  // Send button
  sendBtn.addEventListener("click", sendMessage);

  // Enter key
  chatInput.addEventListener("keypress", (e) => {
    if (e.key === "Enter") sendMessage();
  });
});