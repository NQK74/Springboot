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
    <style>
        .reports-container {
            padding: 20px 0;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-header h1 {
            color: #1e293b;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .page-header h1 i {
            color: #6366f1;
        }
        
        /* Stats Cards */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
        }
        
        .stat-card.revenue::before { background: linear-gradient(135deg, #10b981, #059669); }
        .stat-card.orders::before { background: linear-gradient(135deg, #6366f1, #4f46e5); }
        .stat-card.pending::before { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .stat-card.delivered::before { background: linear-gradient(135deg, #22c55e, #16a34a); }
        .stat-card.cancelled::before { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .stat-card.products::before { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
        .stat-card.users::before { background: linear-gradient(135deg, #06b6d4, #0891b2); }
        
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 15px;
        }
        
        .stat-card.revenue .stat-icon { background: linear-gradient(135deg, #10b981, #059669); }
        .stat-card.orders .stat-icon { background: linear-gradient(135deg, #6366f1, #4f46e5); }
        .stat-card.pending .stat-icon { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .stat-card.delivered .stat-icon { background: linear-gradient(135deg, #22c55e, #16a34a); }
        .stat-card.cancelled .stat-icon { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .stat-card.products .stat-icon { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
        .stat-card.users .stat-icon { background: linear-gradient(135deg, #06b6d4, #0891b2); }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #64748b;
            font-size: 0.9rem;
        }
        
        /* Charts Section */
        .charts-section {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 20px;
            padding-left: 15px;
            border-left: 4px solid #6366f1;
        }
        
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 25px;
        }
        
        .chart-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .chart-card h3 {
            font-size: 1.1rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 20px;
        }
        
        .chart-card h3 i {
            color: #6366f1;
            margin-right: 10px;
        }
        
        .chart-wrapper {
            height: 300px;
            position: relative;
        }
        
        /* Order Status Grid */
        .order-status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .status-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
            border-left: 4px solid;
        }
        
        .status-card.pending { border-left-color: #f59e0b; }
        .status-card.confirmed { border-left-color: #3b82f6; }
        .status-card.shipping { border-left-color: #8b5cf6; }
        .status-card.delivered { border-left-color: #22c55e; }
        .status-card.cancelled { border-left-color: #ef4444; }
        
        .status-count {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .status-card.pending .status-count { color: #f59e0b; }
        .status-card.confirmed .status-count { color: #3b82f6; }
        .status-card.shipping .status-count { color: #8b5cf6; }
        .status-card.delivered .status-count { color: #22c55e; }
        .status-card.cancelled .status-count { color: #ef4444; }
        
        .status-label {
            color: #64748b;
            font-size: 0.85rem;
        }
        
        /* Revenue Summary */
        .revenue-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .revenue-card {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            border-radius: 16px;
            padding: 25px;
            position: relative;
            overflow: hidden;
        }
        
        .revenue-card.today {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }
        
        .revenue-card.month {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
        }
        
        .revenue-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        }
        
        .revenue-card .revenue-icon {
            font-size: 2.5rem;
            opacity: 0.3;
            position: absolute;
            right: 20px;
            top: 20px;
        }
        
        .revenue-value {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .revenue-label {
            opacity: 0.9;
            font-size: 0.95rem;
        }

        @media (max-width: 768px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }
            
            .stat-value {
                font-size: 1.4rem;
            }
        }
    </style>
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
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
    <script>
        // Order Status Pie Chart
        const orderStatusCtx = document.getElementById('orderStatusChart').getContext('2d');
        new Chart(orderStatusCtx, {
            type: 'doughnut',
            data: {
                labels: ['Chờ xác nhận', 'Đã xác nhận', 'Đang giao', 'Đã giao', 'Đã hủy'],
                datasets: [{
                    data: [${pendingOrders}, ${confirmedOrders}, ${shippingOrders}, ${deliveredOrders}, ${cancelledOrders}],
                    backgroundColor: [
                        '#f59e0b',
                        '#3b82f6',
                        '#8b5cf6',
                        '#22c55e',
                        '#ef4444'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                }
            }
        });
        
        // Revenue Chart
        async function loadRevenueChart() {
            try {
                const response = await fetch('/admin/api/revenue/daily?days=7');
                const data = await response.json();
                
                const labels = data.map(item => item.label);
                const revenues = data.map(item => item.revenue);
                
                const revenueCtx = document.getElementById('revenueChart').getContext('2d');
                new Chart(revenueCtx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Doanh thu (VNĐ)',
                            data: revenues,
                            backgroundColor: 'rgba(99, 102, 241, 0.8)',
                            borderColor: '#6366f1',
                            borderWidth: 1,
                            borderRadius: 8
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
                                    }
                                }
                            }
                        }
                    }
                });
            } catch (error) {
                console.error('Error loading revenue chart:', error);
            }
        }
        
        loadRevenueChart();
    </script>
</body>
</html>
