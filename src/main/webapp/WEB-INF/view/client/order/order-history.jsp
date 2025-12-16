<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng - LaptopShop</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/client/css/order/order-history.css">
    
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="breadcrumb-blur">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="/">Trang Chủ</a></li>
                        <li class="breadcrumb-item active">Lịch Sử Đơn Hàng</li>
                    </ol>
                </nav>
            </div>
            <h1>
                <i class="fas fa-history"></i> Lịch Sử Đơn Hàng
            </h1>
            <p class="subtitle">Quản lý và xem chi tiết các đơn hàng của bạn</p>
        </div>

        <!-- Order History Card -->
        <div class="order-card">
            <c:if test="${not empty listOrder}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="width: 8%;">
                                    <i class="fas fa-hashtag"></i> ID
                                </th>
                                <th style="width: 15%;">
                                    <i class="fas fa-user"></i> Người Đặt
                                </th>
                                <th style="width: 15%;">
                                    <i class="fas fa-phone"></i> Điện Thoại
                                </th>
                                <th style="width: 20%;">
                                    <i class="fas fa-map-marker-alt"></i> Địa Chỉ
                                </th>
                                <th style="width: 12%;">
                                    <i class="fas fa-money-bill-wave"></i> Tổng Tiền
                                </th>
                                <th style="width: 12%;">
                                    <i class="fas fa-info-circle"></i> Trạng Thái
                                </th>
                                <th style="width: 18%;">
                                    <i class="fas fa-cogs"></i> Hành Động
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${listOrder}">
                                <tr>
                                    <td data-label="ID">
                                        <strong>#${order.id}</strong>
                                    </td>
                                    <td data-label="Người Đặt">
                                        <span class="text-muted">${order.receiverName}</span>
                                    </td>
                                    <td data-label="Điện Thoại">
                                        <span class="text-muted">${order.receiverPhone}</span>
                                    </td>
                                    <td data-label="Địa Chỉ">
                                        <span class="text-muted">${order.receiverAddress}</span>
                                    </td>
                                    <td data-label="Tổng Tiền">
                                        <span class="price-badge">
                                            <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                        </span>
                                    </td>
                                    <td data-label="Trạng Thái">
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="status-badge status-pending">
                                                    <i class="fas fa-clock"></i> Chờ Xác Nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <span class="status-badge status-confirmed">
                                                    <i class="fas fa-check-circle"></i> Đã Xác Nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPING'}">
                                                <span class="status-badge status-shipping">
                                                    <i class="fas fa-truck"></i> Đang Giao
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <span class="status-badge status-delivered">
                                                    <i class="fas fa-check"></i> Đã Giao
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="status-badge status-cancelled">
                                                    <i class="fas fa-times-circle"></i> Đã Hủy
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge" style="background-color: #e5e7eb; color: #374151;">
                                                    <i class="fas fa-question-circle"></i> ${order.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td data-label="Hành Động">
                                        <a href="/order-detail/${order.id}" class="action-btn view-btn" title="Xem Chi Tiết">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <c:if test="${order.status == 'PENDING'}">
                                            <form method="post" action="/order-delete/${order.id}" style="display: inline;">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="action-btn delete-btn" title="Hủy Đơn" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            
            <!-- Empty State -->
            <c:if test="${empty listOrder}">
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>Chưa có đơn hàng nào</h3>
                    <p>Bạn chưa có đơn hàng nào. Hãy bắt đầu mua sắm ngay!</p>
                    <a href="/" class="btn btn-primary">
                        <i class="fas fa-shopping-cart"></i> Tiếp Tục Mua Sắm
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Add animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe all table rows
        document.querySelectorAll('tbody tr').forEach(row => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            row.style.transition = 'all 0.5s ease';
            observer.observe(row);
        });

        // Confirm delete with better UX
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                const confirmed = confirm('⚠️ Bạn có chắc chắn muốn hủy đơn hàng này?\n\nĐơn hàng đã hủy không thể khôi phục.');
                if (!confirmed) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>