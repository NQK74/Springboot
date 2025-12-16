<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công - LaptopShop</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template Stylesheet -->
    <link rel="stylesheet" href="/client/css/style.css">
    <link rel="stylesheet" href="/client/css/cart/order-success.css">
     
</head>
<body>
    <!-- Success Section -->
    <div class="success-section">
        <div class="success-card">
            <!-- Success Icon -->
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            
            <!-- Title -->
            <h1 class="success-title">Đặt Hàng Thành Công!</h1>
            
            <!-- Message -->
            <p class="success-message">
                Cảm ơn bạn đã đặt hàng tại LaptopShop. Chúng tôi đã nhận được đơn hàng của bạn và sẽ xử lý trong thời gian sớm nhất.
            </p>
            
            <!-- Order Info -->
            <div class="order-info">
                <div class="order-info-row">
                    <span class="order-info-label">
                        <i class="fas fa-clock me-2"></i>Thời gian đặt:
                    </span>
                    <span class="order-info-value">Vừa xong</span>
                </div>
                <div class="order-info-row">
                    <span class="order-info-label">
                        <i class="fas fa-box me-2"></i>Trạng thái:
                    </span>
                    <span class="order-info-value text-warning">Đang xử lý</span>
                </div>
            </div>
            
            <!-- Buttons -->
            <div class="btn-group-custom">
                <a href="/" class="btn-primary-custom">
                    <i class="fas fa-home me-2"></i>Về Trang Chủ
                </a>
                <a href="/product/show" class="btn-secondary-custom">
                    <i class="fas fa-shopping-bag me-2"></i>Tiếp Tục Mua Sắm
                </a>
            </div>
            
            <!-- Features -->
            <div class="features">
                <div class="feature-item">
                    <i class="fas fa-shipping-fast"></i>
                    <span>Giao hàng nhanh chóng trong 2-3 ngày</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-shield-alt"></i>
                    <span>Bảo hành chính hãng toàn quốc</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-headset"></i>
                    <span>Hỗ trợ 24/7 qua hotline</span>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
