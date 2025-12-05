<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - LaptopShop</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template Stylesheet -->
    <link rel="stylesheet" href="/client/css/style.css">
    
    <style>
        .checkout-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
        }
        
        .checkout-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .checkout-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px 30px;
        }
        
        .checkout-header h4 {
            margin: 0;
            font-weight: 700;
        }
        
        .checkout-header p {
            margin: 5px 0 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }
        
        .checkout-body {
            padding: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
        }
        
        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
        }
        
        .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
        }
        
        .section-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: #667eea;
        }
        
        /* Order Summary */
        .order-summary {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 25px;
        }
        
        .order-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-item-image {
            width: 70px;
            height: 70px;
            border-radius: 10px;
            object-fit: cover;
            margin-right: 15px;
            border: 2px solid #e2e8f0;
        }
        
        .order-item-info {
            flex: 1;
        }
        
        .order-item-name {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
            font-size: 0.95rem;
        }
        
        .order-item-quantity {
            color: #718096;
            font-size: 0.85rem;
        }
        
        .order-item-price {
            font-weight: 700;
            color: #667eea;
        }
        
        .order-total-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px dashed #e2e8f0;
        }
        
        .order-total-row:last-child {
            border-bottom: none;
            padding-top: 15px;
            margin-top: 5px;
            border-top: 2px solid #667eea;
        }
        
        .order-total-row.final {
            font-size: 1.2rem;
        }
        
        .order-total-row.final .order-total-value {
            color: #667eea;
        }
        
        .order-total-label {
            color: #718096;
        }
        
        .order-total-value {
            font-weight: 600;
            color: #2d3748;
        }
        
        /* Payment Methods */
        .payment-method {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 15px;
        }
        
        .payment-method:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }
        
        .payment-method.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
        }
        
        .payment-method .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }
        
        .payment-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.3rem;
            margin-right: 15px;
        }
        
        .payment-info h6 {
            margin: 0;
            font-weight: 600;
            color: #2d3748;
        }
        
        .payment-info p {
            margin: 5px 0 0;
            font-size: 0.85rem;
            color: #718096;
        }
        
        /* Submit Button */
        .btn-checkout {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 16px 40px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .btn-checkout:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-checkout:active {
            transform: translateY(-1px);
        }
        
        .btn-back {
            background: transparent;
            border: 2px solid #e2e8f0;
            color: #718096;
            padding: 14px 30px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            border-color: #667eea;
            color: #667eea;
            background: #f8f9ff;
        }
        
        /* Security Badge */
        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
            padding: 15px;
            background: #f0fff4;
            border-radius: 10px;
            color: #38a169;
            font-size: 0.9rem;
        }
        
        .security-badge i {
            font-size: 1.2rem;
        }
        
        /* Responsive */
        @media (max-width: 991px) {
            .order-summary {
                margin-top: 30px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />

    <!-- Checkout Section -->
    <div class="checkout-section py-5 mt-5">
        <div class="container py-5">
            <!-- Breadcrumb -->
            <div class="row mb-4">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/" style="color: #667eea;">Trang Chủ</a></li>
                            <li class="breadcrumb-item"><a href="/cart" style="color: #667eea;">Giỏ Hàng</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Thanh Toán</li>
                        </ol>
                    </nav>
                </div>
            </div>
            
            <form:form action="/place-order" method="post" modelAttribute="cart">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <div class="row">
                    <!-- Left Column - Shipping & Payment -->
                    <div class="col-lg-7">
                        <!-- Shipping Information -->
                        <div class="checkout-card mb-4">
                            <div class="checkout-header">
                                <h4><i class="fas fa-shipping-fast me-2"></i>Thông Tin Giao Hàng</h4>
                                <p>Vui lòng điền đầy đủ thông tin để chúng tôi giao hàng cho bạn</p>
                            </div>
                            <div class="checkout-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-user me-1 text-muted"></i>Họ và Tên
                                        </label>
                                        <input type="text" class="form-control" name="receiverName" 
                                               placeholder="Nguyễn Văn A" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-phone me-1 text-muted"></i>Số Điện Thoại
                                        </label>
                                        <input type="tel" class="form-control" name="receiverPhone" 
                                               placeholder="0901234567" required>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="fas fa-envelope me-1 text-muted"></i>Email
                                    </label>
                                    <input type="email" class="form-control" name="receiverEmail" 
                                           placeholder="email@example.com" value="${sessionScope.email}">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="fas fa-map-marker-alt me-1 text-muted"></i>Địa Chỉ Giao Hàng
                                    </label>
                                    <input type="text" class="form-control" name="receiverAddress" 
                                           placeholder="Số nhà, tên đường, phường/xã" required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tỉnh/Thành Phố</label>
                                        <select class="form-select" name="city" required>
                                            <option value="">-- Chọn Tỉnh/Thành --</option>
                                            <option value="Hà Nội">Hà Nội</option>
                                            <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                                            <option value="Đà Nẵng">Đà Nẵng</option>
                                            <option value="Cần Thơ">Cần Thơ</option>
                                            <option value="Hải Phòng">Hải Phòng</option>
                                            <option value="Bình Dương">Bình Dương</option>
                                            <option value="Đồng Nai">Đồng Nai</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Quận/Huyện</label>
                                        <select class="form-select" name="district" required>
                                            <option value="">-- Chọn Quận/Huyện --</option>
                                            <option value="Quận 1">Quận 1</option>
                                            <option value="Quận 2">Quận 2</option>
                                            <option value="Quận 3">Quận 3</option>
                                            <option value="Quận 7">Quận 7</option>
                                            <option value="Quận Bình Thạnh">Quận Bình Thạnh</option>
                                            <option value="Quận Tân Bình">Quận Tân Bình</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="fas fa-sticky-note me-1 text-muted"></i>Ghi Chú (Tùy chọn)
                                    </label>
                                    <textarea class="form-control" name="note" rows="3" 
                                              placeholder="Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết hơn."></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Method -->
                        <div class="checkout-card">
                            <div class="checkout-header">
                                <h4><i class="fas fa-credit-card me-2"></i>Phương Thức Thanh Toán</h4>
                                <p>Chọn cách thanh toán phù hợp với bạn</p>
                            </div>
                            <div class="checkout-body">
                                <div class="payment-method selected" onclick="selectPayment(this, 'COD')">
                                    <div class="d-flex align-items-center">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" 
                                                   value="COD" id="paymentCOD" checked>
                                        </div>
                                        <div class="payment-icon">
                                            <i class="fas fa-money-bill-wave"></i>
                                        </div>
                                        <div class="payment-info">
                                            <h6>Thanh toán khi nhận hàng (COD)</h6>
                                            <p>Thanh toán bằng tiền mặt khi nhận hàng</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="payment-method" onclick="selectPayment(this, 'BANKING')">
                                    <div class="d-flex align-items-center">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" 
                                                   value="BANKING" id="paymentBanking">
                                        </div>
                                        <div class="payment-icon">
                                            <i class="fas fa-university"></i>
                                        </div>
                                        <div class="payment-info">
                                            <h6>Chuyển khoản ngân hàng</h6>
                                            <p>Chuyển khoản qua tài khoản ngân hàng</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="payment-method" onclick="selectPayment(this, 'VNPAY')">
                                    <div class="d-flex align-items-center">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="paymentMethod" 
                                                   value="VNPAY" id="paymentVNPay">
                                        </div>
                                        <div class="payment-icon">
                                            <i class="fas fa-qrcode"></i>
                                        </div>
                                        <div class="payment-info">
                                            <h6>VNPay / Ví điện tử</h6>
                                            <p>Thanh toán qua VNPay, MoMo, ZaloPay...</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Column - Order Summary -->
                    <div class="col-lg-5">
                        <div class="order-summary">
                            <h5 class="section-title">
                                <i class="fas fa-receipt"></i>
                                Đơn Hàng Của Bạn
                            </h5>
                            
                            <!-- Order Items -->
                            <div class="order-items mb-4">
                                <c:forEach var="cartDetail" items="${cartDetails}">
                                    <div class="order-item">
                                        <img src="/images/product/${cartDetail.product.image}" 
                                             class="order-item-image" 
                                             alt="${cartDetail.product.name}">
                                        <div class="order-item-info">
                                            <div class="order-item-name">${cartDetail.product.name}</div>
                                            <div class="order-item-quantity">Số lượng: ${cartDetail.quantity}</div>
                                        </div>
                                        <div class="order-item-price">
                                            <fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}" type="number"/> đ
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Order Totals -->
                            <div class="order-totals">
                                <div class="order-total-row">
                                    <span class="order-total-label">Tạm tính:</span>
                                    <span class="order-total-value">
                                        <fmt:formatNumber value="${totalPrice}" type="number"/> đ
                                    </span>
                                </div>
                                <div class="order-total-row">
                                    <span class="order-total-label">Phí vận chuyển:</span>
                                    <span class="order-total-value">0 đ</span>
                                </div>
                                <div class="order-total-row">
                                    <span class="order-total-label">Giảm giá:</span>
                                    <span class="order-total-value text-success">0 đ</span>
                                </div>
                                <div class="order-total-row final">
                                    <span class="order-total-label fw-bold">Tổng cộng:</span>
                                    <span class="order-total-value">
                                        <fmt:formatNumber value="${totalPrice}" type="number"/> đ
                                    </span>
                                </div>
                            </div>
                            
                            <!-- Buttons -->
                            <div class="mt-4">
                                <button type="submit" class="btn-checkout mb-3">
                                    <i class="fas fa-lock me-2"></i>Đặt Hàng Ngay
                                </button>
                                <a href="/cart" class="btn btn-back w-100">
                                    <i class="fas fa-arrow-left me-2"></i>Quay Lại Giỏ Hàng
                                </a>
                            </div>
                            
                            <!-- Security Badge -->
                            <div class="security-badge">
                                <i class="fas fa-shield-alt"></i>
                                <span>Thanh toán an toàn & bảo mật</span>
                            </div>
                        </div>
                    </div>
                </div>
            </form:form>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function selectPayment(element, method) {
            // Remove selected class from all
            document.querySelectorAll('.payment-method').forEach(el => {
                el.classList.remove('selected');
            });
            // Add selected class to clicked element
            element.classList.add('selected');
            // Check the radio button
            element.querySelector('input[type="radio"]').checked = true;
        }
    </script>
</body>
</html>
