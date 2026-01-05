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
    <title>Báo Cáo - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="/css/reports/show.css" />
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="reports-container">
                        <div class="page-header">
                            <h1><i class="fas fa-chart-bar me-2"></i>Báo Cáo Thống Kê</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Báo Cáo</li>
                            </ol>
                        </div>
                        
                        <!-- Revenue Summary -->
                        <div class="section-title"><i class="fas fa-money-bill-wave me-2"></i>Tổng Quan Doanh Thu</div>
                        <div class="revenue-summary">
                            <div class="revenue-card today">
                                <i class="fas fa-calendar-day revenue-icon"></i>
                                <div class="revenue-value">
                                    <fmt:formatNumber value="${todayRevenue}" type="number" groupingUsed="true"/> đ
                                </div>
                                <div class="revenue-label">Doanh thu hôm nay</div>
                            </div>
                            <div class="revenue-card month">
                                <i class="fas fa-calendar-alt revenue-icon"></i>
                                <div class="revenue-value">
                                    <fmt:formatNumber value="${thisMonthRevenue}" type="number" groupingUsed="true"/> đ
                                </div>
                                <div class="revenue-label">Doanh thu tháng này</div>
                            </div>
                            <div class="revenue-card">
                                <i class="fas fa-coins revenue-icon"></i>
                                <div class="revenue-value">
                                    <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/> đ
                                </div>
                                <div class="revenue-label">Tổng doanh thu</div>
                            </div>
                        </div>
                        
                        <!-- Quick Stats -->
                        <div class="section-title"><i class="fas fa-tachometer-alt me-2"></i>Thống Kê Nhanh</div>
                        <div class="stats-row">
                            <div class="stat-card orders">
                                <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
                                <div class="stat-value">${totalOrders}</div>
                                <div class="stat-label">Tổng đơn hàng</div>
                            </div>
                            <div class="stat-card products">
                                <div class="stat-icon"><i class="fas fa-box"></i></div>
                                <div class="stat-value">${totalProducts}</div>
                                <div class="stat-label">Sản phẩm</div>
                            </div>
                            <div class="stat-card users">
                                <div class="stat-icon"><i class="fas fa-users"></i></div>
                                <div class="stat-value">${totalUsers}</div>
                                <div class="stat-label">Người dùng</div>
                            </div>
                            <div class="stat-card delivered">
                                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                                <div class="stat-value">${deliveredOrders}</div>
                                <div class="stat-label">Đơn hoàn thành</div>
                            </div>
                        </div>
                        
                        <!-- Order Status -->
                        <div class="section-title"><i class="fas fa-clipboard-list me-2"></i>Trạng Thái Đơn Hàng</div>
                        <div class="order-status-grid">
                            <div class="status-card pending">
                                <div class="status-count">${pendingOrders}</div>
                                <div class="status-label"><i class="fas fa-clock me-1"></i>Chờ xác nhận</div>
                            </div>
                            <div class="status-card confirmed">
                                <div class="status-count">${confirmedOrders}</div>
                                <div class="status-label"><i class="fas fa-check me-1"></i>Đã xác nhận</div>
                            </div>
                            <div class="status-card shipping">
                                <div class="status-count">${shippingOrders}</div>
                                <div class="status-label"><i class="fas fa-truck me-1"></i>Đang giao</div>
                            </div>
                            <div class="status-card delivered">
                                <div class="status-count">${deliveredOrders}</div>
                                <div class="status-label"><i class="fas fa-check-double me-1"></i>Đã giao</div>
                            </div>
                            <div class="status-card cancelled">
                                <div class="status-count">${cancelledOrders}</div>
                                <div class="status-label"><i class="fas fa-times me-1"></i>Đã hủy</div>
                            </div>
                        </div>
                        
                        <!-- Charts -->
                        <div class="section-title"><i class="fas fa-chart-line me-2"></i>Biểu Đồ Thống Kê</div>
                        <div class="charts-grid">
                            <div class="chart-card">
                                <h3><i class="fas fa-chart-pie"></i>Phân Bố Đơn Hàng</h3>
                                <div class="chart-wrapper">
                                    <canvas id="orderStatusChart"></canvas>
                                </div>
                            </div>
                            <div class="chart-card">
                                <h3><i class="fas fa-chart-bar"></i>Doanh Thu 7 Ngày Gần Nhất</h3>
                                <div class="chart-wrapper">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 12 Month Revenue Chart -->
                        <div class="section-title mt-4"><i class="fas fa-chart-area me-2"></i>Thống Kê Doanh Thu 12 Tháng</div>
                        <div class="chart-card">
                            <h3><i class="fas fa-calendar-alt"></i>Biểu Đồ Doanh Thu 12 Tháng Gần Nhất</h3>
                            <div class="chart-wrapper" style="height: 400px;">
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

    <!-- report data for external JS -->
    <div id="report-data" style="display:none"
         data-pending="${pendingOrders}"
         data-confirmed="${confirmedOrders}"
         data-shipping="${shippingOrders}"
         data-delivered="${deliveredOrders}"
         data-cancelled="${cancelledOrders}"></div>

    <script src="/js/reports/show.js"></script>
</body>
</html>
