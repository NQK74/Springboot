<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Thanh Toán VNPay - LaptopShop</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template Stylesheet -->
    <link rel="stylesheet" href="/client/css/style.css">
    <link rel="stylesheet" href="/client/css/cart/vnpay-result.css">
</head>
<body>
    <!-- Result Section -->
    <div class="vnpay-result-section">
        <div class="result-card">
            <c:choose>
                <c:when test="${success}">
                    <!-- Success Icon -->
                    <div class="result-icon success">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    
                    <!-- Title -->
                    <h1 class="result-title success">Thanh Toán Thành Công!</h1>
                    
                    <!-- Message -->
                    <p class="result-message">
                        Cảm ơn bạn đã thanh toán qua VNPay. Đơn hàng của bạn đã được xác nhận và sẽ được xử lý ngay.
                    </p>
                    
                    <!-- Transaction Info -->
                    <div class="transaction-info">
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-hashtag me-2"></i>Mã đơn hàng:
                            </span>
                            <span class="info-value">#${orderId}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-receipt me-2"></i>Mã giao dịch VNPay:
                            </span>
                            <span class="info-value">${transactionNo}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-money-bill-wave me-2"></i>Số tiền:
                            </span>
                            <span class="info-value amount">
                                <fmt:formatNumber value="${amount}" type="number"/> VNĐ
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-university me-2"></i>Ngân hàng:
                            </span>
                            <span class="info-value">${bankCode}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-clock me-2"></i>Thời gian:
                            </span>
                            <span class="info-value">${payDate}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-info-circle me-2"></i>Nội dung:
                            </span>
                            <span class="info-value">${orderInfo}</span>
                        </div>
                    </div>
                    
                    <!-- VNPay Badge -->
                    <div class="vnpay-badge success">
                        <i class="fas fa-shield-alt me-2"></i>
                        Thanh toán được bảo mật bởi VNPay
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Failed Icon -->
                    <div class="result-icon failed">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    
                    <!-- Title -->
                    <h1 class="result-title failed">Thanh Toán Thất Bại!</h1>
                    
                    <!-- Message -->
                    <p class="result-message">
                        ${message}
                    </p>
                    
                    <!-- Error Info -->
                    <div class="error-info">
                        <div class="info-row">
                            <span class="info-label">
                                <i class="fas fa-exclamation-triangle me-2"></i>Mã lỗi:
                            </span>
                            <span class="info-value error-code">${responseCode}</span>
                        </div>
                    </div>
                    
                    <!-- VNPay Badge -->
                    <div class="vnpay-badge failed">
                        <i class="fas fa-redo me-2"></i>
                        Vui lòng thử lại hoặc chọn phương thức thanh toán khác
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <c:if test="${success}">
                    <a href="/order-history" class="btn btn-primary-custom">
                        <i class="fas fa-list-alt me-2"></i>Xem Đơn Hàng
                    </a>
                </c:if>
                <c:if test="${not success}">
                    <a href="/cart" class="btn btn-primary-custom">
                        <i class="fas fa-redo me-2"></i>Thử Lại
                    </a>
                </c:if>
                <a href="/" class="btn btn-secondary-custom">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
