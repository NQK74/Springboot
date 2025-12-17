<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <link rel="stylesheet" href="/client/css/cart/checkout.css">

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
            
            <form id="checkoutForm" action="/place-order" method="post">
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
                                        <input type="text" class="form-control" name="receiverName" id="receiverName"
                                               placeholder="Nguyễn Văn A" value="${user.fullName}" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-phone me-1 text-muted"></i>Số Điện Thoại
                                        </label>
                                        <input type="tel" class="form-control" name="receiverPhone" id="receiverPhone"
                                               placeholder="0901234567" value="${user.phone}" 
                                               pattern="^(0|\+84)[0-9]{9,10}$" 
                                               title="Số điện thoại phải bắt đầu bằng 0 hoặc +84 và có 10-11 số" required>
                                        <div class="invalid-feedback" id="phoneError">Số điện thoại không hợp lệ (VD: 0901234567)</div>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="fas fa-envelope me-1 text-muted"></i>Email
                                    </label>
                                    <input type="email" class="form-control" name="receiverEmail" id="receiverEmail"
                                           placeholder="email@example.com" value="${user.email}">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="fas fa-map-marker-alt me-1 text-muted"></i>Địa Chỉ Giao Hàng
                                    </label>
                                    <input type="text" class="form-control" name="receiverAddress" id="receiverAddress"
                                           placeholder="Số nhà, tên đường, phường/xã" value="${user.address}" required>
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
            </form>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="/client/js/cart/checkout.js"></script>
    <script>
        // Validate số điện thoại
        document.getElementById('receiverPhone').addEventListener('input', function() {
            const phone = this.value;
            const phoneRegex = /^(0|\+84)[0-9]{9,10}$/;
            
            if (phone && !phoneRegex.test(phone)) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else if (phone) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
        });
        
        // Validate form trước khi submit
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const phone = document.getElementById('receiverPhone').value;
            const phoneRegex = /^(0|\+84)[0-9]{9,10}$/;
            
            if (!phoneRegex.test(phone)) {
                e.preventDefault();
                document.getElementById('receiverPhone').classList.add('is-invalid');
                document.getElementById('receiverPhone').focus();
                alert('Vui lòng nhập số điện thoại hợp lệ (VD: 0901234567)');
                return false;
            }
        });
    </script>
</body>
</html>
