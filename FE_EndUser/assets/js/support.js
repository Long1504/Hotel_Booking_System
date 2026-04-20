// ================= STATE =================
let stompClient = null;
let currentConversationId = null;
let conversationSub = null;
let username = null;
let conversationCache = {};

document.addEventListener("DOMContentLoaded", async () => {
    try {
        // Lấy thông tin người dùng trước
        const userInfo = await callAPIWithAuth("/users/my-info", "GET");
        if (userInfo && userInfo.code === 1000) {
            username = userInfo.result.username;
            console.log("Logged in as:", username);
            
            // Sau khi có username mới kết nối WS và tải dữ liệu
            connectWS();
            loadConversations();
        } else {
            console.error("Không thể lấy thông tin người dùng");
            window.location.href = "/login.html";
        }
    } catch (err) {
        console.error("Lỗi khởi tạo:", err);
    }
});

// ================= CONNECT =================
function connectWS() {
    const socket = new SockJS(`${API_BASE}/ws`);
    stompClient = Stomp.over(socket);
    stompClient.debug = null;
    
    const token = localStorage.getItem("tokenHotelBookingCustomer");

    stompClient.connect({
        "Authorization": "Bearer " + token 
    }, (frame) => {
        console.log('Connected to WebSocket server');

        stompClient.subscribe("/user/topic/conversations", (msg) => {
            const data = JSON.parse(msg.body);
            
            data.forEach(conv => {
                const oldConv = conversationCache[conv.conversationId];
                let isNew = conv.hasNewMessage === true;

                if (!isNew) {
                    if (oldConv && conv.lastMessageTime && oldConv.lastMessageTime !== conv.lastMessageTime) {
                        isNew = true;
                    } else if (!oldConv && conv.lastMessage) {
                        isNew = true;
                    } else if (oldConv) {
                        isNew = oldConv.hasNewMessage;
                    }
                }

                if (conv.conversationId === currentConversationId) {
                    isNew = false;
                }
                
                conv.hasNewMessage = isNew;
                conversationCache[conv.conversationId] = conv;
            });

            renderConversations(); 
        });
    });
}

function createNewChat() {
    callAPIWithAuth("/chat/conversations", "POST")
    .then(newConv => {
        conversationCache[newConv.conversationId] = newConv;
        renderConversations();
        openConversation(newConv.conversationId);
    })
    .catch(err => console.error("Lỗi tạo chat:", err));
}

function loadConversations() {
    callAPIWithAuth("/chat/conversations", "GET")
        .then(data => {
            conversationCache = {};
            data.forEach(c => conversationCache[c.conversationId] = c);
            renderConversations();
        })
        .catch(err => console.error("Lỗi tải danh sách:", err));
}

// ================= RENDER =================
function renderConversations() {
    const list = document.getElementById("conversationList");
    if (!list) return;
    list.innerHTML = "";

    const data = Object.values(conversationCache);

    data.sort((a, b) => {
        if (a.status !== b.status) return a.status === 'OPEN' ? -1 : 1; 
        return new Date(b.lastMessageTime || b.createdAt) - new Date(a.lastMessageTime || a.createdAt);
    });

    data.forEach(c => {
        const isActive = c.conversationId === currentConversationId;
        const div = document.createElement("div");
        div.className = `list-group-item list-group-item-action conversation-item border-0 border-bottom p-3 ${isActive ? 'active' : ''}`;
        
        // ĐỊNH DẠNG: dd/mm/yyyy HH:mm
        const timeOptions = { 
            day: '2-digit', 
            month: '2-digit', 
            year: 'numeric', 
            hour: '2-digit', 
            minute: '2-digit' 
        };
        const createdDate = new Date(c.createdAt).toLocaleString('vi-VN', timeOptions);
        const closedAt = c.closedAt ? new Date(c.closedAt).toLocaleString('vi-VN', timeOptions) : null;

        div.innerHTML = `
            <div class="d-flex justify-content-between align-items-center mb-1">
                <span class="fw-bold text-truncate" style="max-width: 150px;">Hỗ trợ #${c.conversationId.toString().slice(-4)}</span>
                <span class="badge ${c.status === 'OPEN' ? 'bg-success' : 'bg-secondary'} rounded-pill" style="font-size: 0.65rem;">
                    ${c.status === 'OPEN' ? 'Đang mở' : 'Kết thúc'}
                </span>
            </div>
            <div class="d-flex justify-content-between align-items-center">
                <small class="text-truncate flex-grow-1 ${c.hasNewMessage ? 'fw-bold text-dark' : 'text-muted'}" style="font-size: 0.8rem;">
                    ${c.lastMessage || 'Chưa có tin nhắn...'}
                </small>
                ${c.hasNewMessage ? '<span class="p-1 bg-primary border border-light rounded-circle ms-2"></span>' : ''}
            </div>
            <div class="mt-2 d-flex flex-column" style="font-size: 0.7rem; color: #adb5bd;">
                <span><i class="bi bi-clock"></i> Bắt đầu: ${createdDate}</span>
                ${closedAt ? `<span><i class="bi bi-check-circle"></i> Kết thúc: ${closedAt}</span>` : ''}
            </div>
        `;

        div.onclick = () => {
            currentConversationId = c.conversationId;
            openConversation(c.conversationId);
        };
        list.appendChild(div);
    });
}

// ================= OPEN CHAT =================
function openConversation(id) {
    currentConversationId = id;
    const inputArea = document.getElementById("chatInputArea");

    if (conversationCache[id]) {
        conversationCache[id].hasNewMessage = false;
    }

    const conv = conversationCache[id];

    if (conv && conv.status === 'OPEN') {
        inputArea.classList.remove("d-none");
        inputArea.classList.add("d-flex");
        toggleInput(true);
    } else {
        inputArea.classList.remove("d-flex");
        inputArea.classList.add("d-none");
        toggleInput(false);
    }

    document.getElementById("chatHeader").innerHTML = `
        <div>
            <h5 class="mb-1 fw-semibold">Azure Hotel - Hỗ trợ</h5>
            <small class="text-muted d-flex align-items-center gap-1">
                <span class="spinner-grow spinner-grow-sm ${conv.status === 'OPEN' ? 'text-success' : 'text-secondary'}" style="width: 8px; height: 8px;" role="status"></span>
                ${conv.status === 'OPEN' ? 'Đang mở' : 'Đã kết thúc'}
            </small>
        </div>
    `;

    document.getElementById("chatBox").innerHTML = "";

    callAPIWithAuth(`/chat/conversations/${id}/read`, "PUT")
        .then(() => {
            if (conversationCache[id]) {
                conversationCache[id].hasNewMessage = false;
                renderConversations();
            }
        });

    if (conversationSub) conversationSub.unsubscribe();
    conversationSub = stompClient.subscribe("/topic/conversation/" + id, (msg) => {
        const data = JSON.parse(msg.body);
        
        if (data.systemAction === 'CLOSE') {
            inputArea.classList.remove("d-flex");
            inputArea.classList.add("d-none");
            toggleInput(false);
            return;
        }

        showMessage(data);
        scrollBottom();
    });

    loadMessages(id);
}

function toggleInput(enabled) {
    const input = document.getElementById("messageInput");
    const btn = document.querySelector("#chatInputArea button");
    if(input && btn) {
        input.disabled = !enabled;
        btn.disabled = !enabled;
        input.placeholder = enabled ? "Nhập tin nhắn..." : "Hỗ trợ đã kết thúc.";
    }
}

// ================= LOAD HISTORY =================
function loadMessages(id) {
    callAPIWithAuth(`/chat/conversations/${id}/messages`, "GET")
        .then(data => {
            const box = document.getElementById("chatBox");
            box.innerHTML = ""; // Xóa tin nhắn cũ của hội thoại trước
            data.forEach(showMessage);
            scrollBottom();
        })
        .catch(err => console.error("Lỗi tải tin nhắn:", err));
}

// ================= SEND =================
function sendMessage() {
    const input = document.getElementById("messageInput");
    const content = input.value.trim();

    if (!content || !currentConversationId) return;

    stompClient.send("/app/chat.send", {}, JSON.stringify({
        conversationId: currentConversationId,
        senderUsername: username,
        content: content
    }));

    input.value = "";
    input.focus();
}

function handleEnter(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        sendMessage();
    }
}

// ================= MESSAGE UI =================
function showMessage(msg) {
    const box = document.getElementById("chatBox");
    const isMe = msg.senderUsername === username;
    
    const div = document.createElement("div");
    div.className = `msg-container ${isMe ? 'msg-me' : 'msg-other'}`;

    // ĐỊNH DẠNG TRONG BOX CHAT: dd/mm/yyyy HH:mm
    const time = new Date(msg.createdAt || Date.now()).toLocaleString('vi-VN', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit', 
        minute: '2-digit'
    });

    div.innerHTML = `
        <div class="sender-name">${isMe ? "Bạn" : "Nhân viên hỗ trợ"}</div>
        <div class="msg-bubble shadow-sm border ${isMe ? 'border-primary' : 'border-light'}">
            ${msg.content}
        </div>
        <div class="msg-time">${time}</div>
    `;

    box.appendChild(div);
    scrollBottom();
}

// ================= SCROLL =================
function scrollBottom() {
    const box = document.getElementById("chatBox");
    if(box) {
        box.scrollTop = box.scrollHeight;
    }
}