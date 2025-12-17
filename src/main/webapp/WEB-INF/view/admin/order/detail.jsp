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
    <title>Chi Tiết Đơn Hàng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/order/detail.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4" >
                <!-- Page Header -->
                <div class="page-header">
                    <h1><i class="fas fa-file-invoice me-2"></i>Chi Tiết Đơn Hàng</h1>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/order">Đơn Hàng</a></li>
                        <li class="breadcrumb-item active">#${order.id}</li>
                    </ol>
                </div>
                
                <c:if test="${empty order}">
                    <div class="alert alert-danger alert-modern">
                        <i class="fas fa-exclamation-circle me-2"></i>Không tìm thấy đơn hàng
                    </div>
                    <a href="/admin/order" class="btn btn-secondary-modern">
                        <i class="fas fa-arrow-left me-2"></i>Quay Lại
                    </a>
                </c:if>
                
                <c:if test="${not empty order}">
                    <!-- Order Header -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="modern-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-4">
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-hashtag"></i>
                                                    Mã Đơn Hàng
                                                </div>
                                                <div class="info-value">
                                                    <span class="order-id-badge">#${order.id}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-coins"></i>
                                                    Tổng Tiền
                                                </div>
                                                <div class="info-value large">
                                                    <fmt:formatNumber value="${order.totalPrice}" type="number"/> đ
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-info-circle"></i>
                                                    Trạng Thái
                                                </div>
                                                <div class="info-value">
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
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Customer & Payment Info -->
                    <div class="row mb-4">
                        <div class="col-lg-6 mb-4">
                            <div class="modern-card">
                                <div class="card-header">
                                    <h5><i class="fas fa-truck me-2"></i>Thông Tin Giao Hàng</h5>
                                </div>
                                <div class="card-body">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-user"></i>
                                            Người Nhận
                                        </div>
                                        <div class="info-value">${order.receiverName}</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-phone"></i>
                                            Số Điện Thoại
                                        </div>
                                        <div class="info-value">${order.receiverPhone}</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-envelope"></i>
                                            Email
                                        </div>
                                        <div class="info-value">${order.receiverEmail}</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-map-marker-alt"></i>
                                            Địa Chỉ
                                        </div>
                                        <div class="info-value">${order.receiverAddress}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-6 mb-4">
                            <div class="modern-card">
                                <div class="card-header">
                                    <h5><i class="fas fa-credit-card me-2"></i>Thông Tin Thanh Toán</h5>
                                </div>
                                <div class="card-body">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-wallet"></i>
                                            Phương Thức
                                        </div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${order.paymentMethod == 'COD'}">
                                                    <span class="payment-badge payment-cod">
                                                        <i class="fas fa-money-bill-wave"></i> COD
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.paymentMethod == 'BANKING'}">
                                                    <span class="payment-badge payment-banking">
                                                        <i class="fas fa-university"></i> Ngân Hàng
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.paymentMethod == 'VNPAY'}">
                                                    <span class="payment-badge payment-vnpay">
                                                        <i class="fas fa-qrcode"></i> VNPay
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-receipt"></i>
                                            Trạng Thái Thanh Toán
                                        </div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${order.paymentStatus == 'PAID'}">
                                                    <span class="status-badge badge-delivered">
                                                        <i class="fas fa-check-circle"></i> Đã Thanh Toán
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge badge-pending">
                                                        <i class="fas fa-clock"></i> Chưa Thanh Toán
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-sticky-note"></i>
                                            Ghi Chú
                                        </div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${empty order.note}">
                                                    <div class="note-box empty">
                                                        <i class="fas fa-info-circle me-2"></i>Không có ghi chú
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="note-box">
                                                        <i class="fas fa-comment-dots me-2"></i>${order.note}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Products Table -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="modern-card">
                                <div class="card-header">
                                    <h5><i class="fas fa-shopping-bag me-2"></i>Sản Phẩm Đã Đặt</h5>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${empty orderDetails}">
                                            <div class="p-4 text-center">
                                                <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">Không có sản phẩm trong đơn hàng</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table product-table mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th>Mã SP</th>
                                                            <th>Tên Sản Phẩm</th>
                                                            <th>Đơn Giá</th>
                                                            <th>Số Lượng</th>
                                                            <th>Thành Tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="detail" items="${orderDetails}">
                                                            <tr>
                                                                <td><strong>#${detail.product.id}</strong></td>
                                                                <td>
                                                                    <a href="/product/${detail.product.id}" 
                                                                       target="_blank" 
                                                                       class="product-link">
                                                                        ${detail.product.name}
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatNumber value="${detail.price}" type="number"/> đ
                                                                </td>
                                                                <td>
                                                                    <span class="quantity-badge">${detail.quantity}</span>
                                                                </td>
                                                                <td>
                                                                    <strong style="color: var(--success-color);">
                                                                        <fmt:formatNumber value="${detail.price * detail.quantity}" type="number"/> đ
                                                                    </strong>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="4" class="text-end">
                                                                <i class="fas fa-calculator me-2"></i>TỔNG CỘNG:
                                                            </td>
                                                            <td>
                                                                <span style="color: var(--success-color); font-size: 1.25rem;">
                                                                    <fmt:formatNumber value="${order.totalPrice}" type="number"/> đ
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Status Update -->
                    <div class="row mb-4">
                        <div class="col-lg-6 mb-4">
                            <div class="modern-card">
                                <div class="card-header">
                                    <h5><i class="fas fa-sync-alt me-2"></i>Cập Nhật Trạng Thái Đơn Hàng</h5>
                                </div>
                                <div class="card-body">
                                    <form action="/admin/order/${order.id}/update-status" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <div class="status-form">
                                            <div class="mb-3">
                                                <label for="status" class="form-label fw-bold">
                                                    <i class="fas fa-tasks me-2"></i>Chọn Trạng Thái Mới
                                                </label>
                                                <select class="form-select" id="status" name="status" required>
                                                    <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>
                                                        ⏳ Chờ Xác Nhận
                                                    </option>
                                                    <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>
                                                        ✅ Đã Xác Nhận
                                                    </option>
                                                    <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>
                                                        🚚 Đang Giao Hàng
                                                    </option>
                                                    <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>
                                                        ✔️ Đã Giao Hàng
                                                    </option>
                                                    <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>
                                                        ❌ Đã Hủy
                                                    </option>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary-gradient btn-modern w-100">
                                                <i class="fas fa-save me-2"></i>Lưu Trạng Thái
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-6 mb-4">
                            <div class="modern-card">
                                <div class="card-header">
                                    <h5><i class="fas fa-money-check-alt me-2"></i>Cập Nhật Thanh Toán</h5>
                                </div>
                                <div class="card-body">
                                    <form action="/admin/order/${order.id}/update-payment-status" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <div class="status-form">
                                            <div class="mb-3">
                                                <label for="paymentStatus" class="form-label fw-bold">
                                                    <i class="fas fa-receipt me-2"></i>Trạng Thái Thanh Toán
                                                </label>
                                                <select class="form-select" id="paymentStatus" name="paymentStatus" required>
                                                    <option value="UNPAID" ${order.paymentStatus != 'PAID' ? 'selected' : ''}>
                                                        ⏳ Chưa Thanh Toán
                                                    </option>
                                                    <option value="PAID" ${order.paymentStatus == 'PAID' ? 'selected' : ''}>
                                                        ✅ Đã Thanh Toán
                                                    </option>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-success btn-modern w-100" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); border: none;">
                                                <i class="fas fa-save me-2"></i>Lưu Thanh Toán
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="d-flex gap-3 flex-wrap">
                                <a href="/admin/order" class="btn btn-secondary-modern btn-modern">
                                    <i class="fas fa-arrow-left me-2"></i>Quay Lại Danh Sách
                                </a>
                                <form action="/admin/order/${order.id}/delete" method="post" style="display:inline;" 
                                      onsubmit="return confirm('⚠️ Bạn chắc chắn muốn xóa đơn hàng #${order.id}?\n\nThao tác này không thể hoàn tác!');">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-danger-modern btn-modern">
                                        <i class="fas fa-trash-alt me-2"></i>Xóa Đơn Hàng
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>