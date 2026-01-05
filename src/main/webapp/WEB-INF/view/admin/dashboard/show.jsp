<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    <!-- Users Card - Only visible to ADMIN -->
                    <sec:authorize access="hasRole('ADMIN')">
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
                    </sec:authorize>

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
                    <!-- <div class="stat-card revenue">
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
                    </div> -->
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions">
                    <h2 class="section-title">
                        <i class="fas fa-bolt"></i>
                        Thao Tác Nhanh
                    </h2>
                    <div class="actions-grid">
                        <sec:authorize access="hasRole('ADMIN')">
                            <a href="/admin/user/create" class="action-btn primary">
                                <div class="action-icon">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <div class="action-label">Thêm User Mới</div>
                            </a>
                        </sec:authorize>
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
                        <a href="/admin/reports" class="action-btn danger">
                            <div class="action-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <div class="action-label">Xem Báo Cáo</div>
                        </a>
                    </div>
                </div>

                <!-- Revenue Charts Section -->
                <div class="charts-section">
                    <h2 class="section-title">
                        <i class="fas fa-chart-area"></i>
                        Thống Kê Doanh Thu
                    </h2>
                    
                    <!-- Revenue Summary Cards -->
                    <div class="revenue-summary">
                        <div class="revenue-card today">
                            <div class="revenue-icon">
                                <i class="fas fa-calendar-day"></i>
                            </div>
                            <div class="revenue-info">
                                <div class="revenue-label">Doanh Thu Hôm Nay</div>
                                <div class="revenue-value"><fmt:formatNumber value="${todayRevenue}" type="number"/> đ</div>
                            </div>
                        </div>
                        <div class="revenue-card month">
                            <div class="revenue-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <div class="revenue-info">
                                <div class="revenue-label">Doanh Thu Tháng Này</div>
                                <div class="revenue-value"><fmt:formatNumber value="${thisMonthRevenue}" type="number"/> đ</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Chart Controls -->
                    <div class="chart-controls">
                        <button class="chart-btn active" data-chart="daily" onclick="showChart('daily')">
                            <i class="fas fa-calendar-week"></i> 7 Ngày Qua
                        </button>
                        <button class="chart-btn" data-chart="monthly" onclick="showChart('monthly')">
                            <i class="fas fa-calendar"></i> 12 Tháng Qua
                        </button>
                    </div>
                    
                    <!-- Charts Container -->
                    <div class="charts-container">
                        <div class="chart-wrapper" id="dailyChartWrapper">
                            <canvas id="dailyRevenueChart"></canvas>
                        </div>
                        <div class="chart-wrapper" id="monthlyChartWrapper" style="display: none;">
                            <canvas id="monthlyRevenueChart"></canvas>
                        </div>
                    </div>
                </div>

            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="/js/dashboard/show.js"></script>
</body>
</html>