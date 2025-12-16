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
    
    // Chart variables
    let dailyChart = null;
    let monthlyChart = null;
    
    // Format number to VND
    function formatVND(number) {
        return new Intl.NumberFormat('vi-VN').format(number) + ' đ';
    }
    
    // Switch between charts
    function showChart(chartType) {
        document.querySelectorAll('.chart-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelector(`[data-chart="${chartType}"]`).classList.add('active');
        
        if (chartType === 'daily') {
            document.getElementById('dailyChartWrapper').style.display = 'block';
            document.getElementById('monthlyChartWrapper').style.display = 'none';
        } else {
            document.getElementById('dailyChartWrapper').style.display = 'none';
            document.getElementById('monthlyChartWrapper').style.display = 'block';
        }
    }
    
    // Load daily revenue data
    async function loadDailyRevenue() {
        try {
            const response = await fetch('/admin/api/revenue/daily?days=7');
            const data = await response.json();
            
            const labels = data.map(item => item.label);
            const revenues = data.map(item => item.revenue);
            const orders = data.map(item => item.orderCount);
            
            const ctx = document.getElementById('dailyRevenueChart').getContext('2d');
            
            if (dailyChart) dailyChart.destroy();
            
            dailyChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh Thu (đ)',
                        data: revenues,
                        backgroundColor: 'rgba(102, 126, 234, 0.8)',
                        borderColor: 'rgba(102, 126, 234, 1)',
                        borderWidth: 2,
                        borderRadius: 8,
                        yAxisID: 'y'
                    }, {
                        label: 'Số Đơn Hàng',
                        data: orders,
                        type: 'line',
                        backgroundColor: 'rgba(16, 185, 129, 0.2)',
                        borderColor: 'rgba(16, 185, 129, 1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        yAxisID: 'y1'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: {
                                usePointStyle: true,
                                padding: 20,
                                font: { size: 13, weight: '500' }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            padding: 12,
                            titleFont: { size: 14 },
                            bodyFont: { size: 13 },
                            callbacks: {
                                label: function(context) {
                                    if (context.datasetIndex === 0) {
                                        return 'Doanh Thu: ' + formatVND(context.raw);
                                    }
                                    return 'Số Đơn: ' + context.raw + ' đơn';
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return formatVND(value);
                                }
                            },
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            beginAtZero: true,
                            grid: {
                                drawOnChartArea: false
                            },
                            ticks: {
                                stepSize: 1
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        } catch (error) {
            console.error('Error loading daily revenue:', error);
        }
    }
    
    // Load monthly revenue data
    async function loadMonthlyRevenue() {
        try {
            const response = await fetch('/admin/api/revenue/monthly?months=12');
            const data = await response.json();
            
            const labels = data.map(item => item.label);
            const revenues = data.map(item => item.revenue);
            const orders = data.map(item => item.orderCount);
            
            const ctx = document.getElementById('monthlyRevenueChart').getContext('2d');
            
            if (monthlyChart) monthlyChart.destroy();
            
            monthlyChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh Thu (đ)',
                        data: revenues,
                        backgroundColor: 'rgba(118, 75, 162, 0.2)',
                        borderColor: 'rgba(118, 75, 162, 1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointRadius: 6,
                        pointBackgroundColor: 'rgba(118, 75, 162, 1)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        yAxisID: 'y'
                    }, {
                        label: 'Số Đơn Hàng',
                        data: orders,
                        backgroundColor: 'rgba(245, 158, 11, 0.2)',
                        borderColor: 'rgba(245, 158, 11, 1)',
                        borderWidth: 3,
                        fill: false,
                        tension: 0.4,
                        pointRadius: 5,
                        pointBackgroundColor: 'rgba(245, 158, 11, 1)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        yAxisID: 'y1'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: {
                                usePointStyle: true,
                                padding: 20,
                                font: { size: 13, weight: '500' }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            padding: 12,
                            callbacks: {
                                label: function(context) {
                                    if (context.datasetIndex === 0) {
                                        return 'Doanh Thu: ' + formatVND(context.raw);
                                    }
                                    return 'Số Đơn: ' + context.raw + ' đơn';
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return formatVND(value);
                                }
                            },
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            beginAtZero: true,
                            grid: {
                                drawOnChartArea: false
                            },
                            ticks: {
                                stepSize: 1
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        } catch (error) {
            console.error('Error loading monthly revenue:', error);
        }
    }
    
    // Load charts on page load
    document.addEventListener('DOMContentLoaded', function() {
        loadDailyRevenue();
        loadMonthlyRevenue();
    });
</script>
</body>
</html>