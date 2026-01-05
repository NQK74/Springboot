// AI Chatbot Widget JavaScript - Powered by Gemini AI + RAG
let chatSessionId = null;

document.addEventListener('DOMContentLoaded', function() {
    initAIChatbot();
});

function initAIChatbot() {
    const toggle = document.querySelector('.chatbot-toggle');
    const container = document.querySelector('.chatbot-container');
    const closeBtn = document.querySelector('.chatbot-close');
    const input = document.querySelector('.chatbot-input input');
    const sendBtn = document.querySelector('.chatbot-send');
    const resetBtn = document.querySelector('.chatbot-reset');
    
    // Load session từ localStorage
    chatSessionId = localStorage.getItem('ai_chatbot_session');
    
    // Toggle chatbot
    toggle?.addEventListener('click', () => {
        toggle.classList.toggle('active');
        container.classList.toggle('active');
        if (container.classList.contains('active')) {
            const badge = document.querySelector('.chatbot-badge');
            if (badge) badge.style.display = 'none';
            input?.focus();
            
            // Load lịch sử chat từ server nếu có session
            if (chatSessionId) {
                loadChatHistory();
            } else {
                initSession();
            }
        }
    });
    
    // Close chatbot
    closeBtn?.addEventListener('click', () => {
        toggle.classList.remove('active');
        container.classList.remove('active');
    });
    
    // Send message on button click
    sendBtn?.addEventListener('click', () => sendMessage());
    
    // Reset conversation
    resetBtn?.addEventListener('click', () => resetConversation());
    
    // Send message on Enter
    input?.addEventListener('keypress', (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
    
    // Quick action buttons
    document.addEventListener('click', (e) => {
        if (e.target.classList.contains('quick-action-btn')) {
            const text = e.target.dataset.message || e.target.textContent;
            input.value = text;
            sendMessage();
        }
    });
    
    // Show welcome after delay (chỉ khi chưa có session)
    setTimeout(() => {
        if (!chatSessionId && !sessionStorage.getItem('ai_chatbot_welcomed')) {
            showWelcomeMessage();
            sessionStorage.setItem('ai_chatbot_welcomed', 'true');
        }
    }, 3000);
}

/**
 * Load lịch sử chat từ server
 */
function loadChatHistory() {
    const messagesContainer = document.querySelector('.chatbot-messages');
    
    // Nếu đã có tin nhắn trong container thì không load lại
    if (messagesContainer && messagesContainer.children.length > 0) {
        return;
    }
    
    fetch('/api/ai-chatbot/history', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ sessionId: chatSessionId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            if (data.exists && data.history && data.history.length > 0) {
                // Hiển thị lịch sử chat
                messagesContainer.innerHTML = '';
                data.history.forEach(msg => {
                    if (msg.role === 'user') {
                        addUserMessage(msg.content);
                    } else {
                        const formattedReply = formatAIResponse(msg.content);
                        addBotMessage(formattedReply);
                    }
                });
            } else {
                // Session không tồn tại trên server, tạo mới
                initSession();
            }
        } else {
            // Lỗi, tạo session mới
            initSession();
        }
    })
    .catch(error => {
        console.error('Load history error:', error);
        initSession();
    });
}

function initSession() {
    fetch('/api/ai-chatbot/init', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            chatSessionId = data.sessionId;
            localStorage.setItem('ai_chatbot_session', chatSessionId);
            
            // Show welcome message
            const messagesContainer = document.querySelector('.chatbot-messages');
            if (messagesContainer && messagesContainer.children.length === 0) {
                addBotMessage(data.welcomeMessage);
                addQuickActions([
                    { text: '🔍 Tư vấn laptop', message: 'Tư vấn laptop phù hợp với tôi' },
                    { text: '💻 Laptop gaming', message: 'Tìm laptop gaming tốt nhất' },
                    { text: '💼 Laptop văn phòng', message: 'Gợi ý laptop văn phòng' },
                    { text: '💰 Laptop giá rẻ', message: 'Laptop dưới 15 triệu' }
                ]);
            }
        }
    })
    .catch(error => {
        console.error('Init session error:', error);
    });
}

function showWelcomeMessage() {
    const messagesContainer = document.querySelector('.chatbot-messages');
    if (!messagesContainer || messagesContainer.children.length > 0) return;
    
    // Init if not yet
    if (!chatSessionId) {
        initSession();
    }
}

function sendMessage() {
    const input = document.querySelector('.chatbot-input input');
    const message = input.value.trim();
    
    if (!message) return;
    
    // Disable input while processing
    input.disabled = true;
    const sendBtn = document.querySelector('.chatbot-send');
    if (sendBtn) sendBtn.disabled = true;
    
    // Add user message
    addUserMessage(message);
    input.value = '';
    
    // Remove quick actions
    removeQuickActions();
    
    // Show typing indicator
    showTypingIndicator();
    
    // Send to AI server
    fetch('/api/ai-chatbot/message', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 
            sessionId: chatSessionId,
            message: message 
        })
    })
    .then(response => response.json())
    .then(data => {
        hideTypingIndicator();
        
        if (data.success) {
            // Update sessionId nếu có
            if (data.sessionId) {
                chatSessionId = data.sessionId;
                localStorage.setItem('ai_chatbot_session', chatSessionId);
            }
            
            // Format and display AI reply
            const formattedReply = formatAIResponse(data.reply);
            addBotMessage(formattedReply);
            
            // Add contextual quick actions based on response
            addContextualQuickActions(message, data.reply);
        } else {
            addBotMessage('❌ ' + (data.error || 'Đã có lỗi xảy ra. Vui lòng thử lại!'));
        }
    })
    .catch(error => {
        hideTypingIndicator();
        console.error('Send message error:', error);
        addBotMessage('❌ Xin lỗi, không thể kết nối đến AI. Vui lòng thử lại sau!');
    })
    .finally(() => {
        // Re-enable input
        input.disabled = false;
        if (sendBtn) sendBtn.disabled = false;
        input.focus();
    });
}

function resetConversation() {
    fetch('/api/ai-chatbot/reset', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ sessionId: chatSessionId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            chatSessionId = data.sessionId;
            localStorage.setItem('ai_chatbot_session', chatSessionId);
            
            // Clear messages
            const messagesContainer = document.querySelector('.chatbot-messages');
            if (messagesContainer) {
                messagesContainer.innerHTML = '';
            }
            
            // Show new welcome
            addBotMessage('🔄 ' + data.message + ' Tôi có thể giúp gì cho bạn?');
            addQuickActions([
                { text: '🔍 Tư vấn laptop', message: 'Tư vấn laptop phù hợp với tôi' },
                { text: '💻 Laptop gaming', message: 'Tìm laptop gaming tốt nhất' },
                { text: '💼 Laptop văn phòng', message: 'Gợi ý laptop văn phòng' },
                { text: '💰 Laptop giá rẻ', message: 'Laptop dưới 15 triệu' }
            ]);
        }
    })
    .catch(error => {
        console.error('Reset error:', error);
    });
}

function formatAIResponse(text) {
    if (!text) return '';
    
    // Convert markdown-like formatting to HTML
    let formatted = text
        // Bold
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        // Italic
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        // Product links: [text](/product/id) -> clickable link
        .replace(/\[([^\]]+)\]\(\/product\/(\d+)\)/g, '<a href="/product/$2" class="product-link" target="_blank">$1 🔗</a>')
        // General markdown links: [text](url)
        .replace(/\[([^\]]+)\]\((\/[^\)]+)\)/g, '<a href="$2" class="chat-link" target="_blank">$1</a>')
        // Line breaks
        .replace(/\n/g, '<br>')
        // Lists
        .replace(/^- /gm, '• ')
        // Price formatting highlight
        .replace(/(\d{1,3}(?:,\d{3})*(?:\.\d+)?\s*VNĐ)/g, '<span class="price-highlight">$1</span>');
    
    return formatted;
}

function addContextualQuickActions(userMessage, aiReply) {
    const lowerReply = aiReply.toLowerCase();
    const actions = [];
    
    // Suggest based on context
    if (lowerReply.includes('laptop') || lowerReply.includes('sản phẩm')) {
        if (!lowerReply.includes('gaming')) {
            actions.push({ text: '🎮 Xem laptop gaming', message: 'Cho tôi xem laptop gaming' });
        }
        if (!lowerReply.includes('văn phòng')) {
            actions.push({ text: '💼 Laptop văn phòng', message: 'Laptop văn phòng giá tốt' });
        }
    }
    
    if (lowerReply.includes('giá') || lowerReply.includes('vnđ')) {
        actions.push({ text: '📊 So sánh giá', message: 'So sánh các laptop trong tầm giá này' });
    }
    
    if (lowerReply.includes('bảo hành') || lowerReply.includes('đổi trả')) {
        actions.push({ text: '📋 Chính sách chi tiết', message: 'Chi tiết chính sách bảo hành và đổi trả' });
    }
    
    // Default actions if none matched
    if (actions.length === 0) {
        actions.push({ text: '🔍 Tìm sản phẩm khác', message: 'Tìm laptop khác cho tôi' });
        actions.push({ text: '📞 Liên hệ hotline', message: 'Cho tôi số hotline hỗ trợ' });
    }
    
    if (actions.length > 0) {
        setTimeout(() => addQuickActions(actions), 300);
    }
}

function addUserMessage(text) {
    const messagesContainer = document.querySelector('.chatbot-messages');
    const messageHtml = `
        <div class="chat-message user">
            <div class="message-content">${escapeHtml(text)}</div>
            <div class="message-avatar">
                <i class="fas fa-user"></i>
            </div>
        </div>
    `;
    messagesContainer.insertAdjacentHTML('beforeend', messageHtml);
    scrollToBottom();
}

function addBotMessage(text) {
    const messagesContainer = document.querySelector('.chatbot-messages');
    const messageHtml = `
        <div class="chat-message bot">
            <div class="message-avatar ai-avatar">
                <i class="fas fa-robot"></i>
                <span class="ai-badge">AI</span>
            </div>
            <div class="message-content">${text}</div>
        </div>
    `;
    messagesContainer.insertAdjacentHTML('beforeend', messageHtml);
    scrollToBottom();
}

function addQuickActions(actions) {
    const messagesContainer = document.querySelector('.chatbot-messages');
    
    // Remove existing quick actions first
    removeQuickActions();
    
    const actionsHtml = `
        <div class="quick-actions">
            ${actions.map(action => {
                const text = typeof action === 'string' ? action : action.text;
                const message = typeof action === 'string' ? action : action.message;
                return `<button class="quick-action-btn" data-message="${escapeHtml(message)}">${text}</button>`;
            }).join('')}
        </div>
    `;
    messagesContainer.insertAdjacentHTML('beforeend', actionsHtml);
    scrollToBottom();
}

function removeQuickActions() {
    const quickActions = document.querySelectorAll('.quick-actions');
    quickActions.forEach(qa => qa.remove());
}

function showTypingIndicator() {
    const messagesContainer = document.querySelector('.chatbot-messages');
    const typingHtml = `
        <div class="chat-message bot typing-message">
            <div class="message-avatar ai-avatar">
                <i class="fas fa-robot"></i>
            </div>
            <div class="typing-indicator">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    `;
    messagesContainer.insertAdjacentHTML('beforeend', typingHtml);
    scrollToBottom();
}

function hideTypingIndicator() {
    const typing = document.querySelector('.typing-message');
    if (typing) {
        typing.remove();
    }
}

function scrollToBottom() {
    const messagesContainer = document.querySelector('.chatbot-messages');
    if (messagesContainer) {
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
