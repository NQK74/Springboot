<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/layout/header.css">

<nav class="sb-topnav navbar navbar-expand navbar-dark">
    <!-- Navbar Brand -->
    <a class="navbar-brand" href="/admin">
        <i class="fas fa-laptop"></i>
        <span class="brand-text">LaptopShop</span>
    </a>
    
    <!-- Sidebar Toggle -->
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" type="button">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
        
    </form>
    
    <!-- Navbar Items -->
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4 d-flex align-items-center">
        <!-- Notifications -->
        <li class="nav-item dropdown me-3">
            <a class="nav-link notification-bell" href="#" role="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-bell"></i>
                <span class="notification-badge" id="notificationBadge" style="display: none;">0</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end notification-dropdown" aria-labelledby="notificationDropdown">
                <li class="dropdown-header">
                    <i class="fas fa-bell me-2"></i>Thông Báo
                </li>
                <li><hr class="dropdown-divider" /></li>
                <li id="pendingOrdersNotification" style="display: none;">
                    <a class="dropdown-item notification-item" href="/admin/order">
                        <div class="notification-icon pending">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">Đơn hàng mới</div>
                            <div class="notification-text">Có <span id="pendingOrdersCount">0</span> đơn hàng chờ xác nhận</div>
                        </div>
                    </a>
                </li>
                <li id="noNotifications">
                    <div class="dropdown-item text-center text-muted">
                        <i class="fas fa-check-circle me-2"></i>Không có thông báo mới
                    </div>
                </li>
            </ul>
        </li>
        
        <!-- Messages -->
        <li class="nav-item me-3">
            <a class="nav-link" href="#" role="button">
                <i class="fas fa-envelope"></i>
               
            </a>
        </li>
        
        <!-- User Dropdown -->
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-user"></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                <li class="dropdown-user-info">
                    <div class="dropdown-user-name">${sessionScope.fullName != null ? sessionScope.fullName : 'Admin'}</div>
                    <div class="dropdown-user-email">${sessionScope.email != null ? sessionScope.email : 'admin@laptopshop.com'}</div>
                </li>
                <li>
                    <a class="dropdown-item" href="/admin/profile">
                        <i class="fas fa-user-circle"></i>
                        Hồ Sơ
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="/admin/settings">
                        <i class="fas fa-cog"></i>
                        Cài Đặt
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="/admin/activity">
                        <i class="fas fa-history"></i>
                        Lịch Sử Hoạt Động
                    </a>
                </li>
                <li><hr class="dropdown-divider" /></li>
                <li>
                    <a class="dropdown-item client-link" href="/">
                        <i class="fas fa-store"></i>
                        Trang Người Dùng
                    </a>
                </li>
                <li><hr class="dropdown-divider" /></li>
                <li>
                    <form action="/logout" method="post" id="logoutForm" style="margin: 0;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <a class="dropdown-item logout" href="javascript:void(0);" onclick="document.getElementById('logoutForm').submit();">
                            <i class="fas fa-sign-out-alt"></i>
                            Đăng Xuất
                        </a>
                    </form>
                </li>
            </ul>
        </li>
    </ul>
</nav>

<script>
// Sidebar Toggle
document.addEventListener('DOMContentLoaded', function() {
    const sidebarToggle = document.getElementById('sidebarToggle');
    
    if (sidebarToggle) {
        // Check for saved state in localStorage
        if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
            document.body.classList.add('sb-sidenav-toggled');
        }
        
        sidebarToggle.addEventListener('click', function(e) {
            e.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }
    
    // Load notifications
    loadNotifications();
    // Refresh notifications every 30 seconds
    setInterval(loadNotifications, 30000);
});

// Load pending orders notifications
async function loadNotifications() {
    try {
        const response = await fetch('/admin/api/notifications/pending-orders');
        const data = await response.json();
        
        const badge = document.getElementById('notificationBadge');
        const pendingOrdersNotification = document.getElementById('pendingOrdersNotification');
        const pendingOrdersCount = document.getElementById('pendingOrdersCount');
        const noNotifications = document.getElementById('noNotifications');
        
        if (data.count > 0) {
            badge.textContent = data.count;
            badge.style.display = 'flex';
            pendingOrdersCount.textContent = data.count;
            pendingOrdersNotification.style.display = 'block';
            noNotifications.style.display = 'none';
            
            // Add animation to bell
            document.querySelector('.notification-bell').classList.add('has-notification');
        } else {
            badge.style.display = 'none';
            pendingOrdersNotification.style.display = 'none';
            noNotifications.style.display = 'block';
            document.querySelector('.notification-bell').classList.remove('has-notification');
        }
    } catch (error) {
        console.error('Error loading notifications:', error);
    }
}
</script>