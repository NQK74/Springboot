<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Live Chat - LaptopShop Admin</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/chat/chat.css" />
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    
                    <div class="page-header">
                        <h1><i class="fas fa-comments me-2"></i>Live Chat</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item active">Live Chat</li>
                        </ol>
                    </div>
                    
                    <div class="chat-container">
                        <!-- Sessions Panel -->
                        <div class="sessions-panel">
                            <div class="sessions-header">
                                <h5><i class="fas fa-inbox me-2"></i>Cuộc Hội Thoại</h5>
                                <div class="sessions-stats">
                                    <div class="stat-item">
                                        <i class="fas fa-clock"></i>
                                        <span id="waitingCount">${waitingCount}</span> đang chờ
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-envelope"></i>
                                        <span id="unreadCount">${unreadCount}</span> chưa đọc
                                    </div>
                                </div>
                            </div>
                            
                            <div class="sessions-list" id="sessionsList">
                                <c:choose>
                                    <c:when test="${empty sessions}">
                                        <div class="no-sessions">
                                            <i class="fas fa-comments"></i>
                                            <p>Chưa có cuộc hội thoại nào</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="session" items="${sessions}">
                                            <div class="session-item" data-id="${session.id}" onclick="selectSession(${session.id})">
                                                <div class="session-avatar ${session.status == 'WAITING' ? 'waiting' : 'active'}">
                                                    ${session.displayName.substring(0, 1).toUpperCase()}
                                                </div>
                                                <div class="session-info">
                                                    <div class="session-name">${session.displayName}</div>
                                                    <div class="session-status">
                                                        <span class="badge ${session.status == 'WAITING' ? 'badge-waiting' : 'badge-active-chat'}">
                                                            ${session.status == 'WAITING' ? 'Đang chờ' : 'Đang chat'}
                                                        </span>
                                                        <c:if test="${session.staff != null}">
                                                            <span>• ${session.staff.fullName}</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <c:if test="${session.unreadCount > 0}">
                                                    <div class="unread-badge">${session.unreadCount}</div>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <!-- Chat Panel -->
                        <div class="chat-panel" id="chatPanel">
                            <div class="empty-state" id="emptyState">
                                <i class="fas fa-comments"></i>
                                <h4>Chọn một cuộc hội thoại</h4>
                                <p>Chọn cuộc hội thoại từ danh sách bên trái để bắt đầu chat</p>
                            </div>
                            
                            <div id="chatContent" style="display: none; flex-direction: column; height: 100%;">
                                <div class="chat-header">
                                    <div class="chat-user-info">
                                        <div class="chat-user-avatar" id="chatUserAvatar">K</div>
                                        <div>
                                            <div class="chat-user-name" id="chatUserName">Khách hàng</div>
                                            <div class="chat-user-status"><i class="fas fa-circle me-1" style="font-size: 8px;"></i>Đang hoạt động</div>
                                        </div>
                                    </div>
                                    <div class="chat-actions">
                                        <button onclick="closeCurrentSession()" title="Đóng cuộc chat">
                                            <i class="fas fa-times-circle"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="chat-messages" id="chatMessages">
                                    <!-- Messages will be loaded here -->
                                </div>
                                
                                <div class="chat-input">
                                    <input type="text" id="messageInput" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)">
                                    <button onclick="sendMessage()">
                                        <i class="fas fa-paper-plane"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/scripts.js"></script>
    <script src="/js/chat/chat.js"></script>
</body>
</html>
