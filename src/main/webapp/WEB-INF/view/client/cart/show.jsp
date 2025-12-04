<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - LaptopShop</title>
    
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
        .empty-cart-container {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 20px;
            padding: 60px 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            margin: 40px auto;
            max-width: 600px;
        }
        
        .cart-icon-wrapper {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 0 0 20px rgba(102, 126, 234, 0);
            }
        }
        
        .cart-icon-wrapper i {
            color: white;
            font-size: 3.5rem;
        }
        
        .empty-cart-title {
            color: #2d3748;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 15px;
        }
        
        .empty-cart-subtitle {
            color: #718096;
            font-size: 1.1rem;
            margin-bottom: 35px;
            line-height: 1.6;
        }
        
        .shop-now-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 15px 45px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .shop-now-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .feature-list {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #4a5568;
            font-size: 0.95rem;
        }
        
        .feature-item i {
            color: #667eea;
            font-size: 1.2rem;
        }

        .quantity-controls {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-top: 1rem;
    }
    
    .quantity-btn {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        border: 2px solid #e5e7eb;
        background: white;
        color: #374151;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
        padding: 0;
    }
    
    .quantity-btn:hover {
        background: #81c408;
        border-color: #81c408;
        color: white;
        transform: scale(1.1);
    }
    
    .quantity-btn:active {
        transform: scale(0.95);
    }
    
    .quantity-display {
        min-width: 50px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 1rem;
        color: #1f2937;
        background: #f9fafb;
        border: 2px solid #e5e7eb;
        border-radius: 8px;
        padding: 0 12px;
    }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />

    <!-- Cart Section -->
    <div class="container-fluid py-5 mt-5">
        <div class="container py-5">
            <!-- Breadcrumb -->
            <div class="row g-4 mb-4">
                <div>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/" style="color: #00d4ff;">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                        </ol>
                    </nav>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${empty cartDetails}">
                    <!-- Empty Cart - Redesigned -->
                    <div class="empty-cart-container">
                        <div class="cart-icon-wrapper">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h3 class="empty-cart-title text-center">Giỏ hàng của bạn đang trống</h3>
                        <p class="empty-cart-subtitle text-center">
                            Hãy khám phá các sản phẩm laptop tuyệt vời<br>và thêm chúng vào giỏ hàng của bạn!
                        </p>
                        <div class="text-center">
                            <a href="/" class="shop-now-btn">
                                <i class="fas fa-laptop me-2"></i>Khám phá sản phẩm
                            </a>
                        </div>
                        
                        <div class="feature-list">
                            <div class="feature-item">
                                <i class="fas fa-shipping-fast"></i>
                                <span>Miễn phí vận chuyển</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-shield-alt"></i>
                                <span>Bảo hành chính hãng</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-headset"></i>
                                <span>Hỗ trợ 24/7</span>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Cart Table -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Tên</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col" class="text-center">Số lượng</th>
                                    <th scope="col">Thành tiền</th>
                                    <th scope="col">Xử lý</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cartDetail" items="${cartDetails}">
                                    <tr>
                                        <th scope="row">
                                            <div class="d-flex align-items-center">
                                                <img src="/images/product/${cartDetail.product.image}" 
                                                     class="img-fluid me-5 rounded-circle" 
                                                     style="width: 80px; height: 80px; object-fit: cover;" 
                                                     alt="${cartDetail.product.name}">
                                            </div>
                                        </th>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <a href="/product/${cartDetail.product.id}" target="_blank" style = "color: #00d4ff;">
                                                    ${cartDetail.product.name}
                                                </a>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <fmt:formatNumber value="${cartDetail.price}" type="number"/> đ
                                            </p>
                                        </td>
                                        <td>
                                            <div class="quantity-controls">
                                                <button class="quantity-btn btn-minus" 
                                                        data-cart-detail-id="${cartDetail.id}"
                                                        data-cart-detail-quantity="${cartDetail.quantity}"
                                                        data-cart-detail-price="${cartDetail.price}">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                                
                                                <div class="quantity-display" data-cart-detail-index="${status.index}">
                                                    ${cartDetail.quantity}
                                                </div>
                                                
                                                <button class="quantity-btn btn-plus"
                                                        data-cart-detail-id="${cartDetail.id}"
                                                        data-cart-detail-quantity="${cartDetail.quantity}"
                                                        data-cart-detail-price="${cartDetail.price}">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                <fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}" type="number"/> đ
                                            </p>
                                        </td>
                                        <td>
                                            <form method="post" action="/cart/delete/${cartDetail.id}">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button class="btn btn-md rounded-circle bg-light border mt-4">
                                                    <i class="fa fa-times text-danger"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Cart Total -->
                    <div class="row g-4 justify-content-start mt-4">
                        <div class="col-sm-8 col-md-7 col-lg-5 col-xl-4">
                            <div class="bg-light rounded">
                                <div class="p-4">
                                    <h4 class="mb-4 fw-bold" style="color: #333;">
                                        Thông Tin <span class="fw-normal" style="color: #00d4ff;">Đơn Hàng</span>
                                    </h4>
                                    <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                                        <span class="text-muted">Tạm tính:</span>
                                        <span class="fw-bold total-price" style="color: #00d4ff;" data-cart-detail-id="${totalPrice}" data-cart-total="${totalPrice}">
                                            <fmt:formatNumber value="${totalPrice}" type="number"/> đ
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                                        <span class="text-muted">Phí vận chuyển:</span>
                                        <span>0 đ</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-4">
                                        <span class="fw-bold">Tổng số tiền:</span>
                                        <span class="fw-bold total-price" data-cart-detail-id="${totalPrice}" data-cart-total="${totalPrice}">
                                            <fmt:formatNumber value="${totalPrice}" type="number"/> đ
                                        </span>
                                    </div>
                                    <a href="/checkout" class="btn w-100 py-3 text-white text-uppercase fw-bold" 
                                       style="background: linear-gradient(#00d4ff); border-radius: 8px;">
                                        <i class="fas fa-check me-2"></i>Xác Nhận Đặt Hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- jQuery (cần load trước) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Cart JS -->
    <script src="/client/js/cart.js"></script>
</body>
</html>