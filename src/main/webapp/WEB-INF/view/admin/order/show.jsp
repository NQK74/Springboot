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
    <title>Quản Lý Đơn Hàng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/order/show.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <!-- Page Header -->
                <div class="page-header">
                    <h1><i class="fas fa-shopping-cart me-2"></i>Quản Lý Đơn Hàng</h1>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Đơn Hàng</li>
                    </ol>
                </div>

                <!-- Stats Cards -->
                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon stat-pending">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-value" id="pendingCount">0</div>
                        <div class="stat-label">Chờ Xác Nhận</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon stat-confirmed">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-value" id="confirmedCount">0</div>
                        <div class="stat-label">Đã Xác Nhận</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon stat-shipped">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <div class="stat-value" id="shippedCount">0</div>
                        <div class="stat-label">Đang Giao</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon stat-delivered">
                            <i class="fas fa-check-double"></i>
                        </div>
                        <div class="stat-value" id="deliveredCount">0</div>
                        <div class="stat-label">Đã Giao</div>
                    </div>
                </div>
                
                <!-- Orders Table -->
                <div class="modern-card mb-4">
                    <div class="card-header">
                        <h5><i class="fas fa-list me-2"></i>Danh Sách Đơn Hàng</h5>
                        <!-- Search Form -->
                        <form action="/admin/order" method="get" class="admin-search-form">
                            <div class="admin-search-box">
                                <input type="text" name="keyword" class="admin-search-input" 
                                       placeholder="Tìm mã ĐH, tên, SĐT, email..." 
                                       value="${keyword}">
                                <button type="submit" class="admin-search-btn">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Search Result Info -->
                    <c:if test="${not empty keyword}">
                        <div class="search-result-bar">
                            <span>
                                <i class="fas fa-search me-2"></i>
                                Kết quả tìm kiếm cho "<strong>${keyword}</strong>": ${totalItems} đơn hàng
                            </span>
                            <a href="/admin/order" class="btn-clear-search">
                                <i class="fas fa-times me-1"></i>Xóa tìm kiếm
                            </a>
                        </div>
                    </c:if>
                    
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="fas fa-inbox"></i>
                                    </div>
                                    <div class="empty-title">Chưa có đơn hàng nào</div>
                                    <div class="empty-text">Các đơn hàng sẽ hiển thị tại đây khi có khách đặt hàng</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="order-table-container">
                                    <table class="order-table table mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 8%;">Mã ĐH</th>
                                                <th style="width: 22%;">Khách Hàng</th>
                                                <th style="width: 15%;">Tổng Tiền</th>
                                                <th style="width: 15%;">Trạng Thái</th>
                                                <th style="width: 40%;">Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr data-status="${order.status}">
                                                    <td data-label="Mã ĐH">
                                                        <div class="order-id">#${order.id}</div>
                                                    </td>
                                                    <td data-label="Khách Hàng">
                                                        <div class="customer-info">
                                                            <div class="customer-name">${order.receiverName}</div>
                                                            <div class="customer-phone">
                                                                <i class="fas fa-phone-alt"></i>
                                                                ${order.receiverPhone}
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td data-label="Tổng Tiền">
                                                        <span class="price-badge">
                                                            <fmt:formatNumber value="${order.totalPrice}" type="number"/> đ
                                                        </span>
                                                    </td>
                                                    <td data-label="Trạng Thái">
                                                        <c:choose>
                                                            <c:when test="${order.status == 'PENDING'}">
                                                                <span class="status-badge badge-pending">
                                                                    <i class="fas fa-clock"></i> Chờ Xác Nhận
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                                <span class="status-badge badge-confirmed">
                                                                    <i class="fas fa-check-circle"></i> Đã Xác Nhận
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'SHIPPED'}">
                                                                <span class="status-badge badge-shipped">
                                                                    <i class="fas fa-shipping-fast"></i> Đang Giao
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'DELIVERED'}">
                                                                <span class="status-badge badge-delivered">
                                                                    <i class="fas fa-check-double"></i> Đã Giao
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'CANCELLED'}">
                                                                <span class="status-badge badge-cancelled">
                                                                    <i class="fas fa-times-circle"></i> Đã Hủy
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge" style="background: #e5e7eb; color: #6b7280;">
                                                                    ${order.status}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td data-label="Hành Động">
                                                        <div class="d-flex gap-2">
                                                            <a href="/admin/order/${order.id}" class="btn-action btn-view">
                                                                <i class="fas fa-eye"></i>Xem Chi Tiết
                                                            </a>
                                                            <form action="/admin/order/${order.id}/delete" method="post" style="display:inline;" 
                                                                  onsubmit="return confirm('⚠️ Bạn chắc chắn muốn xóa đơn hàng #${order.id}?\n\nThao tác này không thể hoàn tác!');">
                                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                                <button type="submit" class="btn-action btn-delete">
                                                                    <i class="fas fa-trash-alt"></i>Xóa
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="card-footer d-flex justify-content-center align-items-center">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <!-- Previous Button -->
                                    <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                                        <a class="page-link" href="/admin/order?pageNo=<c:out value='${currentPage - 1}'/><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>>
                                            <i class="fas fa-chevron-left"></i> Trước
                                        </a>
                                    </li>

                                    <!-- Page Numbers -->
                                    <c:set var="startPage" value="${currentPage > 2 ? currentPage - 2 : 1}" />
                                    <c:set var="endPage" value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" />
                                    
                                    <c:if test="${startPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="/admin/order?pageNo=1<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">1</a>
                                        </li>
                                        <c:if test="${startPage > 2}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                    </c:if>

                                    <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                        <li class="page-item <c:if test='${page == currentPage}'>active</c:if>">
                                            <a class="page-link" href="/admin/order?pageNo=${page}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${page}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${endPage < totalPages}">
                                        <c:if test="${endPage < totalPages - 1}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                        <li class="page-item">
                                            <a class="page-link" href="/admin/order?pageNo=${totalPages}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${totalPages}</a>
                                        </li>
                                    </c:if>

                                    <!-- Next Button -->
                                    <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
                                        <a class="page-link" href="/admin/order?pageNo=<c:out value='${currentPage + 1}'/><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>
                                            Sau <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script>
    // Calculate order statistics
    document.addEventListener('DOMContentLoaded', function() {
        const rows = document.querySelectorAll('tbody tr[data-status]');
        
        let pendingCount = 0;
        let confirmedCount = 0;
        let shippedCount = 0;
        let deliveredCount = 0;
        
        rows.forEach(row => {
            const status = row.getAttribute('data-status');
            switch(status) {
                case 'PENDING':
                    pendingCount++;
                    break;
                case 'CONFIRMED':
                    confirmedCount++;
                    break;
                case 'SHIPPED':
                    shippedCount++;
                    break;
                case 'DELIVERED':
                    deliveredCount++;
                    break;
            }
        });
        
        document.getElementById('pendingCount').textContent = pendingCount;
        document.getElementById('confirmedCount').textContent = confirmedCount;
        document.getElementById('shippedCount').textContent = shippedCount;
        document.getElementById('deliveredCount').textContent = deliveredCount;
    });
</script>
</body>
</html>