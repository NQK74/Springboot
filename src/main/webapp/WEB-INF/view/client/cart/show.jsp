<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Giỏ Hàng - LaptopShop</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/client/css/style.css">
    <link rel="stylesheet" href="/client/css/cart/show.css">
        
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container-fluid py-5 mt-5">
        <div class="container py-5">
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
                    <!-- Select All Checkbox -->
                    <div class="select-all-container">
                        <input type="checkbox" class="select-all-checkbox" id="selectAll" checked>
                        <label class="select-all-label" for="selectAll">
                            <i class="fas fa-check-square me-2"></i>Chọn tất cả sản phẩm
                        </label>
                        <span class="ms-auto text-muted" id="selectedCount">(${cartDetails.size()} sản phẩm)</span>
                    </div>

                    <!-- Cart Table -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col" style="width: 50px;">Chọn</th>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Tên</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col" class="text-center">Số lượng</th>
                                    <th scope="col">Thành tiền</th>
                                    <th scope="col">Xử lý</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                                    <tr class="cart-item" data-cart-detail-id="${cartDetail.id}">
                                        <td class="align-middle">
                                            <input type="checkbox" 
                                                   class="product-checkbox" 
                                                   data-cart-detail-id="${cartDetail.id}"
                                                   data-price="${cartDetail.price * cartDetail.quantity}"
                                                   data-unit-price="${cartDetail.price}"
                                                   ${cartDetail.selected ? 'checked' : ''}>
                                        </td>
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
                                                <a href="/product/${cartDetail.product.id}" target="_blank" style="color: #00d4ff;">
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
                                                        data-cart-detail-price="${cartDetail.price}"
                                                        type="button">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                                
                                                <div class="quantity-display" data-cart-detail-index="${status.index}">
                                                    ${cartDetail.quantity}
                                                </div>
                                                
                                                <button class="quantity-btn btn-plus"
                                                        data-cart-detail-id="${cartDetail.id}"
                                                        data-cart-detail-quantity="${cartDetail.quantity}"
                                                        data-cart-detail-price="${cartDetail.price}"
                                                        type="button">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4 item-total" 
                                               data-cart-detail-id="${cartDetail.id}"
                                               data-price="${cartDetail.price * cartDetail.quantity}">
                                                <fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}" type="number"/> đ
                                            </p>
                                        </td>
                                        <td>
                                            <form method="post" action="/delete-cart-product/${cartDetail.id}">
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
                                        <span class="text-muted">Sản phẩm đã chọn:</span>
                                        <span class="fw-bold" id="selectedItemsCount">0</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                                        <span class="text-muted">Tạm tính:</span>
                                        <span class="fw-bold total-price" style="color: #00d4ff;" id="subtotal">
                                            0 đ
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                                        <span class="text-muted">Phí vận chuyển:</span>
                                        <span>0 đ</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-4">
                                        <span class="fw-bold">Tổng số tiền:</span>
                                        <span class="fw-bold total-price" id="totalPrice">
                                            0 đ
                                        </span>
                                    </div>
                                    <form method="post" action="/confirm-checkout" id="checkoutForm">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <input type="hidden" name="selectedItems" id="selectedItemsInput">
                                        <button type="submit" class="btn w-100 py-3 text-white text-uppercase fw-bold" 
                                           style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; border: none;"
                                           id="checkoutBtn">
                                            <i class="fas fa-check me-2"></i>Xác Nhận Đặt Hàng
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/cart.js"></script>
</body>
</html>