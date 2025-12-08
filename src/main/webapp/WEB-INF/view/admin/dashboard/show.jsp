<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Dashboard - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/dashboard/show.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <!-- Welcome Section -->
                <div class="welcome-section">
                    <div class="welcome-content">
                        <h1 class="welcome-title">
                            <i class="fas fa-chart-line me-3"></i>Dashboard
                        </h1>
                        <p class="welcome-subtitle">
                            Chào mừng trở lại! Đây là tổng quan về hoạt động của hệ thống.
                        </p>
                        <div class="welcome-time">
                            <i class="far fa-clock"></i>
                            <span id="currentTime"></span>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <!-- Users Card -->
                    <div class="stat-card users">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                        <div class="stat-body">
                            <div class="stat-value">${totalUsers}</div>
                            <div class="stat-label">Tổng Người Dùng</div>
                        </div>
                        <div class="stat-footer">
                            <a href="/admin/user" class="stat-link">
                                <span>Xem Chi Tiết</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Products Card -->
                    <div class="stat-card products">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-box"></i>
                            </div>
                    
                        </div>
                        <div class="stat-body">
                            <div class="stat-value">${totalProducts}</div>
                            <div class="stat-label">Tổng Sản Phẩm</div>
                        </div>
                        <div class="stat-footer">
                            <a href="/admin/product" class="stat-link">
                                <span>Xem Chi Tiết</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Orders Card -->
                    <div class="stat-card orders">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                        
                        </div>
                        <div class="stat-body">
                            <div class="stat-value">${empty totalOrders ? 0 : totalOrders}</div>
                            <div class="stat-label">Tổng Đơn Hàng</div>
                        </div>
                        <div class="stat-footer">
                            <a href="/admin/order" class="stat-link">
                                <span>Xem Chi Tiết</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Revenue Card -->
                    <div class="stat-card revenue">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                        <div class="stat-body">
                            <div class="stat-value"><fmt:formatNumber value="${totalRevenue}" type="number"/> đ</div>
                            <div class="stat-label">Doanh Thu Tổng</div>
                        </div>
                        <div class="stat-footer">
                            <a href="/admin/order" class="stat-link">
                                <span>Xem Chi Tiết</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions">
                    <h2 class="section-title">
                        <i class="fas fa-bolt"></i>
                        Thao Tác Nhanh
                    </h2>
                    <div class="actions-grid">
                        <a href="/admin/user/create" class="action-btn primary">
                            <div class="action-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="action-label">Thêm User Mới</div>
                        </a>
                        <a href="/admin/product/create" class="action-btn warning">
                            <div class="action-icon">
                                <i class="fas fa-plus-circle"></i>
                            </div>
                            <div class="action-label">Thêm Sản Phẩm</div>
                        </a>
                        <a href="/admin/order" class="action-btn success">
                            <div class="action-icon">
                                <i class="fas fa-clipboard-list"></i>
                            </div>
                            <div class="action-label">Quản Lý Đơn Hàng</div>
                        </a>
                        <a href="/admin/user" class="action-btn danger">
                            <div class="action-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <div class="action-label">Xem Báo Cáo</div>
                        </a>
                    </div>
                </div>

            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script>
    // Update current time
    function updateTime() {
        const now = new Date();
        const options = { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        document.getElementById('currentTime').textContent = now.toLocaleDateString('vi-VN', options);
    }
    
    updateTime();
    setInterval(updateTime, 60000); 
</script>
</body>
</html>