
        var currentSessionId = null;
        var lastMessageId = 0;
        var pollInterval = null;
        var sessionPollInterval = null;
        
        // Format time
        function formatTime(dateStr) {
            var date = new Date(dateStr);
            return date.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
        }
        
        // Select session
        function selectSession(sessionId) {
            currentSessionId = sessionId;
            lastMessageId = 0;
            
            // Update UI
            document.querySelectorAll('.session-item').forEach(function(item) {
                item.classList.remove('active');
            });
            document.querySelector('.session-item[data-id="' + sessionId + '"]').classList.add('active');
            
            document.getElementById('emptyState').style.display = 'none';
            document.getElementById('chatContent').style.display = 'flex';
            
            // Load messages
            loadMessages();
            
            // Start polling
            if (pollInterval) clearInterval(pollInterval);
            pollInterval = setInterval(pollNewMessages, 2000);
        }
        
        // Load messages
        function loadMessages() {
            fetch('/api/admin/chat/messages/' + currentSessionId)
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if (data.success) {
                        var container = document.getElementById('chatMessages');
                        container.innerHTML = '';
                        
                        data.messages.forEach(function(msg) {
                            addMessageToUI(msg);
                            if (msg.id > lastMessageId) lastMessageId = msg.id;
                        });
                        
                        container.scrollTop = container.scrollHeight;
                        
                        // Update header
                        if (data.messages.length > 0) {
                            var firstCustomerMsg = data.messages.find(function(m) { return m.senderType === 'CUSTOMER'; });
                            if (firstCustomerMsg) {
                                document.getElementById('chatUserName').textContent = firstCustomerMsg.senderName;
                                document.getElementById('chatUserAvatar').textContent = firstCustomerMsg.senderName.charAt(0).toUpperCase();
                            }
                        }
                    }
                });
        }
        
        // Poll new messages
        function pollNewMessages() {
            if (!currentSessionId) return;
            
            fetch('/api/admin/chat/messages/' + currentSessionId + '?lastMessageId=' + lastMessageId)
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if (data.success && data.messages.length > 0) {
                        data.messages.forEach(function(msg) {
                            addMessageToUI(msg);
                            if (msg.id > lastMessageId) lastMessageId = msg.id;
                        });
                        
                        var container = document.getElementById('chatMessages');
                        container.scrollTop = container.scrollHeight;
                    }
                });
        }
        
        // Add message to UI
        function addMessageToUI(msg) {
            var container = document.getElementById('chatMessages');
            var isStaff = msg.senderType === 'STAFF';
            
            var html = '<div class="message ' + (isStaff ? 'staff' : 'customer') + '">' +
                '<div class="message-avatar">' +
                    (isStaff ? '<i class="fas fa-headset"></i>' : '<i class="fas fa-user"></i>') +
                '</div>' +
                '<div>' +
                    '<div class="message-content">' + escapeHtml(msg.content) + '</div>' +
                    '<div class="message-time">' + formatTime(msg.createdAt) + '</div>' +
                '</div>' +
            '</div>';
            
            container.insertAdjacentHTML('beforeend', html);
        }
        
        // Send message
        function sendMessage() {
            var input = document.getElementById('messageInput');
            var content = input.value.trim();
            
            if (!content || !currentSessionId) return;
            
            fetch('/api/admin/chat/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    sessionId: currentSessionId,
                    message: content
                })
            })
            .then(function(r) { return r.json(); })
            .then(function(data) {
                if (data.success) {
                    addMessageToUI({
                        id: data.messageId,
                        content: content,
                        senderType: 'STAFF',
                        senderName: data.senderName,
                        createdAt: data.createdAt
                    });
                    
                    lastMessageId = data.messageId;
                    input.value = '';
                    
                    var container = document.getElementById('chatMessages');
                    container.scrollTop = container.scrollHeight;
                }
            });
        }
        
        // Handle enter key
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }
        
        // Close session
        function closeCurrentSession() {
            if (!currentSessionId) return;
            
            if (confirm('Bạn có chắc muốn đóng cuộc hội thoại này?')) {
                fetch('/api/admin/chat/close/' + currentSessionId, { method: 'POST' })
                    .then(function(r) { return r.json(); })
                    .then(function(data) {
                        if (data.success) {
                            location.reload();
                        }
                    });
            }
        }
        
        // Poll sessions list
        function pollSessions() {
            fetch('/api/admin/chat/sessions')
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if (data.success) {
                        document.getElementById('waitingCount').textContent = data.waitingCount;
                        document.getElementById('unreadCount').textContent = data.unreadCount;
                        
                        // Update sessions list
                        updateSessionsList(data.sessions);
                    }
                });
        }
        
        function updateSessionsList(sessions) {
            var container = document.getElementById('sessionsList');
            
            if (sessions.length === 0) {
                container.innerHTML = '<div class="no-sessions"><i class="fas fa-comments"></i><p>Chưa có cuộc hội thoại nào</p></div>';
                return;
            }
            
            var html = '';
            sessions.forEach(function(session) {
                var isActive = currentSessionId === session.id;
                html += '<div class="session-item ' + (isActive ? 'active' : '') + '" data-id="' + session.id + '" onclick="selectSession(' + session.id + ')">' +
                    '<div class="session-avatar ' + (session.status === 'WAITING' ? 'waiting' : 'active') + '">' +
                        session.displayName.charAt(0).toUpperCase() +
                    '</div>' +
                    '<div class="session-info">' +
                        '<div class="session-name">' + escapeHtml(session.displayName) + '</div>' +
                        '<div class="session-status">' +
                            '<span class="badge ' + (session.status === 'WAITING' ? 'badge-waiting' : 'badge-active-chat') + '">' +
                                (session.status === 'WAITING' ? 'Đang chờ' : 'Đang chat') +
                            '</span>' +
                            (session.staffName ? '<span>• ' + escapeHtml(session.staffName) + '</span>' : '') +
                        '</div>' +
                    '</div>' +
                    (session.unreadCount > 0 ? '<div class="unread-badge">' + session.unreadCount + '</div>' : '') +
                '</div>';
            });
            
            container.innerHTML = html;
        }
        
        function escapeHtml(text) {
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        // Start polling sessions
        sessionPollInterval = setInterval(pollSessions, 3000);