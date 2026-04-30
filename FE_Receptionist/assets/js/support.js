// ================= STATE =================
let stompClient = null;
let currentConversationId = null;
let conversationSub = null;
let username = null; 
let conversationCache = {};

const VI_TIME_OPTIONS = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' };

document.addEventListener("DOMContentLoaded", async () => {
    const token = localStorage.getItem("tokenHotelBookingReceptionist"); 
    if (!token) {
        alert('Vui lòng đăng nhập với tài khoản Lễ tân!');
        window.location.href = "login.html";
        return;
    }

    try {
        const userInfo = await callAPIWithAuth("/users/my-info", "GET");
        if (userInfo && userInfo.code === 1000) {
            username = userInfo.result.username;
            connectWS(token);
            loadConversations();
        } else {
            throw new Error("Lỗi lấy thông tin");
        }
    } catch (err) {
        console.error("Lỗi xác thực:", err);
        alert("Phiên đăng nhập hết hạn hoặc lỗi kết nối.");
    }
});

// ================= CONNECT & SUBSCRIBE =================
function connectWS(token) {
    const socket = new SockJS(`${API_BASE}/ws`);
    stompClient = Stomp.over(socket);
    stompClient.debug = null; 
    
    stompClient.connect({ "Authorization": "Bearer " + token }, (frame) => {
        // SUBSCRIBE KÊNH TỔNG
        stompClient.subscribe("/user/topic/conversations", (msg) => {
            const data = JSON.parse(msg.body); 
            
            data.forEach(conv => {
                const oldConv = conversationCache[conv.conversationId];

                if (conv.conversationId === currentConversationId) {
                    if (oldConv && conv.lastMessageTime !== oldConv.lastMessageTime) {

                    }
                    conv.hasNewMessage = false;
                } else {
                    if (!oldConv || conv.lastMessageTime !== oldConv.lastMessageTime) {
                        conv.hasNewMessage = true;
                    }
                }
                conversationCache[conv.conversationId] = conv;
            });
            renderConversations(); 
        });
    });
}

// ================= API CALLS =================
function loadConversations() {
    callAPIWithAuth("/chat/conversations", "GET").then(data => {
        if (Array.isArray(data)) {
            conversationCache = {};
            data.forEach(c => conversationCache[c.conversationId] = c);
            renderConversations();
        }
    });
}

function openConversation(id) {
    currentConversationId = id;
    const conv = conversationCache[id];
    
    document.getElementById("welcomeScreen").classList.add("d-none");
    document.getElementById("chatArea").classList.remove("d-none");
    
    updateChatUI(conv.status);

    callAPIWithAuth(`/chat/conversations/${id}/read`, "PUT").then(() => {
        if (conversationCache[id]) {
            conversationCache[id].hasNewMessage = false;
            renderConversations();
        }
    });

    // Load tin nhắn cũ
    loadMessages(id);

    if (conversationSub) conversationSub.unsubscribe();
    
    conversationSub = stompClient.subscribe("/topic/conversation/" + id, (msg) => {
        const message = JSON.parse(msg.body);
        
        if (message.systemAction === 'CLOSE') {
            if (conversationCache[id]) conversationCache[id].status = 'CLOSED';
            updateChatUI('CLOSED');
            renderConversations();
            return;
        }

        // Hiển thị tin nhắn nếu thuộc hội thoại đang mở
        if (message.conversationId === currentConversationId) {
            showMessage(message);
            
            // Cập nhật sidebar
            if (conversationCache[id]) {
                conversationCache[id].lastMessage = message.content;
                conversationCache[id].lastMessageTime = message.createdAt;
                renderConversations();
            }
        }
    });
}

function updateChatUI(status) {
    const isOpen = (status === 'OPEN');
    
    // Cập nhật tiêu đề và trạng thái trên header
    document.getElementById("chatHeaderTitle").innerText = `Hỗ trợ #${currentConversationId.toString().slice(-4)}`;
    document.getElementById("chatHeaderStatus").innerHTML = isOpen 
        ? '<span class="text-success"><i class="bi bi-circle-fill small"></i> Đang mở</span>'
        : '<span class="text-secondary"><i class="bi bi-lock-fill small"></i> Đã đóng</span>';
    
    const closeBtn = document.getElementById("closeTicketBtn");
    const inputArea = document.getElementById("chatInputArea");

    if (isOpen) {
        closeBtn.style.display = "block";
        inputArea.classList.remove("d-none");
        inputArea.classList.add("d-flex");
    } else {
        closeBtn.style.display = "none";
        inputArea.classList.add("d-none");
        inputArea.classList.remove("d-flex");
    }
}

function loadMessages(id) {
    callAPIWithAuth(`/chat/conversations/${id}/messages`, "GET").then(data => {
        const box = document.getElementById("chatBox");
        box.innerHTML = ""; 
        if (Array.isArray(data)) data.forEach(showMessage);
        scrollBottom();
    });
}

function sendMessage() {
    const input = document.getElementById("messageInput");
    const content = input.value.trim();
    if (!content || !currentConversationId) return;

    const payload = {
        conversationId: currentConversationId,
        senderUsername: username,
        content: content
    };

    stompClient.send("/app/chat.send", {}, JSON.stringify(payload));

    input.value = "";
    input.focus();
}

function closeConversation() {
    if (!currentConversationId) return;
    
    const confirmClose = confirm("Bạn có chắc chắn muốn kết thúc phiên hỗ trợ này?");
    if (confirmClose) {
        callAPIWithAuth(`/chat/conversations/${currentConversationId}/close`, "PUT")
            .then((res) => {
                alert('Phiên hỗ trợ đã được đóng.');
                
                if (conversationCache[currentConversationId]) {
                    conversationCache[currentConversationId].status = 'CLOSED';
                    conversationCache[currentConversationId].closedAt = new Date().toISOString();
                }
                
                // Cập nhật giao diện vùng chat và sidebar
                updateChatUI('CLOSED');
                renderConversations(); 
            })
            .catch(err => {
                console.error("Lỗi khi đóng hội thoại:", err);
            });
    }
}

// ================= UI RENDER =================
function renderConversations() {
    const list = document.getElementById("conversationList");
    if (!list) return;
    list.innerHTML = "";

    const sorted = Object.values(conversationCache).sort((a, b) => 
        new Date(b.lastMessageTime || b.createdAt) - new Date(a.lastMessageTime || a.createdAt)
    );

    sorted.forEach(c => {
        const isActive = c.conversationId === currentConversationId;
        const div = document.createElement("div");
        div.className = `conversation-item p-3 border-bottom ${isActive ? 'active' : ''}`;
        
        // Định dạng thời gian
        const createdTime = new Date(c.createdAt).toLocaleString('vi-VN', VI_TIME_OPTIONS);
        const closedAtTime = c.closedAt ? new Date(c.closedAt).toLocaleString('vi-VN', VI_TIME_OPTIONS) : null;

        const statusBadge = c.status === 'OPEN' 
            ? '<span class="badge bg-success" style="font-size: 0.6rem;">ĐANG MỞ</span>'
            : '<span class="badge bg-secondary" style="font-size: 0.6rem;">ĐÃ ĐÓNG</span>';

        div.innerHTML = `
            <div class="d-flex justify-content-between align-items-center mb-1">
                <span class="fw-bold text-truncate" style="max-width: 130px;">
                    ${c.customerUsername || 'Khách vãng lai'}
                </span>
                <div class="d-flex align-items-center">
                    ${statusBadge}
                    ${c.hasNewMessage ? '<span class="ms-2 badge rounded-circle bg-primary" style="width: 8px; height: 8px; padding: 0;">&nbsp;</span>' : ''}
                </div>
            </div>
            <div class="text-truncate small mb-2 ${c.hasNewMessage ? 'fw-semibold text-dark' : 'text-muted'}">
                ${c.lastMessage || '<i>Chưa có tin nhắn...</i>'}
            </div>
            <div class="d-flex flex-column" style="font-size: 0.7rem; color: #6c757d; gap: 2px;">
                <span><i class="bi bi-clock me-1"></i> Bắt đầu: ${createdTime}</span>
                ${closedAtTime ? `<span><i class="bi bi-check-circle me-1"></i> Kết thúc: ${closedAtTime}</span>` : ''}
            </div>
        `;

        div.onclick = () => openConversation(c.conversationId);
        list.appendChild(div);
    });
}

function showMessage(msg) {
    const box = document.getElementById("chatBox");
    const isMe = msg.senderUsername === username;
    
    const div = document.createElement("div");
    div.className = `msg-container ${isMe ? 'msg-me' : 'msg-other'}`;

    const time = new Date(msg.createdAt || Date.now()).toLocaleString('vi-VN', VI_TIME_OPTIONS);

    div.innerHTML = `
        <div class="sender-name">${isMe ? "Bạn (Lễ tân)" : "Khách hàng"}</div>
        <div class="msg-bubble shadow-sm ${isMe ? '' : 'bg-white border'}">
            ${msg.content}
        </div>
        <div class="msg-time">${time}</div>
    `;

    box.appendChild(div);
    scrollBottom();
}

function scrollBottom() {
    const box = document.getElementById("chatBox");
    box.scrollTop = box.scrollHeight;
}

function handleEnter(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        sendMessage();
    }
}