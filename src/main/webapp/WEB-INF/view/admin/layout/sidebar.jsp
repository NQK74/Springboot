<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="/css/layout/sidebar.css">

<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Tổng Quan</div>
                <a class="nav-link" href="/admin" data-page="dashboard">
                    <div class="sb-nav-link-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    Dashboard
                </a>
                
                <div class="sb-sidenav-menu-heading">Quản Lý</div>
                
                <!-- User Management - Only visible to ADMIN and SUPER_ADMIN -->
                <sec:authorize access="hasAnyRole('ADMIN', 'SUPER_ADMIN')">
                    <a class="nav-link" href="/admin/user" data-page="user">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        Người Dùng
                    </a>
                </sec:authorize>
                
                <a class="nav-link" href="/admin/product" data-page="product">
                    <div class="sb-nav-link-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    Sản Phẩm
                </a>
                <a class="nav-link" href="/admin/order" data-page="order">
                    <div class="sb-nav-link-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    Đơn Hàng
                </a>
                
                <%-- AI Chatbot - không cần quản lý, tự động trả lời bởi Gemini AI --%>
                
                <div class="sb-sidenav-menu-heading">Hệ Thống</div>
                <sec:authorize access="hasAnyRole('ADMIN', 'SUPER_ADMIN')">
                    <a class="nav-link" href="/admin/settings" data-page="settings">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-cog"></i>
                        </div>
                        Cài Đặt
                    </a>
                </sec:authorize>
                <a class="nav-link" href="/admin/reports" data-page="reports">
                    <div class="sb-nav-link-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    Báo Cáo
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="sidebar-user-info">
                <div class="sidebar-user-avatar">
                    ${sessionScope.fullName != null ? sessionScope.fullName.substring(0, 2).toUpperCase() : 'AD'}
                </div>
                <div class="sidebar-user-details">
                    <div class="sidebar-user-name">${sessionScope.fullName != null ? sessionScope.fullName : 'Admin'}</div>
                    <div class="sidebar-user-role">
                        <sec:authorize access="hasRole('SUPER_ADMIN')">Super Administrator</sec:authorize>
                        <sec:authorize access="hasRole('ADMIN')">Administrator</sec:authorize>
                        <sec:authorize access="hasRole('STAFF')">Nhân viên</sec:authorize>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</div>

<script>
    // Auto-activate sidebar links based on current URL
    document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.sb-sidenav .nav-link');
        
        // Remove all active classes first
        navLinks.forEach(link => link.classList.remove('active'));
        
        // Determine which link to activate
        if (currentPath === '/admin' || currentPath === '/admin/') {
            // Activate Dashboard
            const dashboardLink = document.querySelector('.nav-link[data-page="dashboard"]');
            if (dashboardLink) dashboardLink.classList.add('active');
        } else if (currentPath.startsWith('/admin/user')) {
            // Activate User
            const userLink = document.querySelector('.nav-link[data-page="user"]');
            if (userLink) userLink.classList.add('active');
        } else if (currentPath.startsWith('/admin/product')) {
            // Activate Product
            const productLink = document.querySelector('.nav-link[data-page="product"]');
            if (productLink) productLink.classList.add('active');
        } else if (currentPath.startsWith('/admin/order')) {
            // Activate Order
            const orderLink = document.querySelector('.nav-link[data-page="order"]');
            if (orderLink) orderLink.classList.add('active');
        } else if (currentPath.startsWith('/admin/chat')) {
            // Activate Chat
            const chatLink = document.querySelector('.nav-link[data-page="chat"]');
            if (chatLink) chatLink.classList.add('active');
        } else if (currentPath.startsWith('/admin/settings')) {
            // Activate Settings
            const settingsLink = document.querySelector('.nav-link[data-page="settings"]');
            if (settingsLink) settingsLink.classList.add('active');
        } else if (currentPath.startsWith('/admin/reports')) {
            // Activate Reports
            const reportsLink = document.querySelector('.nav-link[data-page="reports"]');
            if (reportsLink) reportsLink.classList.add('active');
        }
        
        // Poll for chat badge count
        function updateChatBadge() {
            fetch('/api/admin/chat/count')
                .then(r => r.json())
                .then(data => {
                    const badge = document.getElementById('chatBadgeSidebar');
                    if (badge && data.waitingCount > 0) {
                        badge.textContent = data.waitingCount;
                        badge.style.display = 'inline-block';
                    } else if (badge) {
                        badge.style.display = 'none';
                    }
                })
                .catch(() => {});
        }
        
        updateChatBadge();
        setInterval(updateChatBadge, 5000);
    });
</script>