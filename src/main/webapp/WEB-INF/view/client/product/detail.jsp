<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>${product.name} - LaptopShop</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/client/css/style.css">
    <link rel="stylesheet" href="/client/css/product/detail.css">
    

</head>
<body>
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />

    <!-- Product Detail Container -->
    <div class="product-detail-container">
        <div class="container">
            <!-- Breadcrumb -->
            <div class="custom-breadcrumb">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="/">Trang Chủ</a></li>
                        <li class="breadcrumb-item"><a href="/">Sản Phẩm</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                    </ol>
                </nav>
            </div>

            <!-- Product Main Card -->
            <div class="product-main-card">
                <div class="row g-0">
                    <!-- Image Gallery Section -->
                    <div class="col-lg-6">
                        <div class="image-gallery-section">
                            <!-- Product Badges -->
                            <div class="product-badges">
                                <span class="badge-item badge-new">Mới</span>
                                <c:if test="${product.quantity > 0}">
                                    <span class="badge-item badge-hot">Hot</span>
                                </c:if>
                            </div>

                            <!-- Main Image -->
                            <div class="main-image-wrapper">
                                <img src="/images/product/${product.image}" 
                                     class="main-product-image" 
                                     alt="${product.name}"
                                     id="mainImage">
                            </div>

                            <!-- Thumbnail Gallery -->
                            <!-- <div class="thumbnail-gallery">
                                <div class="thumbnail-item active">
                                    <img src="/images/product/${product.image}" alt="Thumbnail 1">
                                </div>
                                <div class="thumbnail-item">
                                    <img src="/images/product/${product.image}" alt="Thumbnail 2">
                                </div>
                                <div class="thumbnail-item">
                                    <img src="/images/product/${product.image}" alt="Thumbnail 3">
                                </div>
                                <div class="thumbnail-item">
                                    <img src="/images/product/${product.image}" alt="Thumbnail 4">
                                </div>
                            </div> -->
                        </div>
                    </div>

                    <!-- Product Info Section -->
                    <div class="col-lg-6">
                        <div class="product-info-section">
                            <!-- Product Meta -->
                            <div class="product-meta">
                                <span class="product-brand-tag">
                                    <i class="fas fa-laptop me-1"></i>
                                    ${product.factory}
                                </span>
                                <h1 class="product-title">${product.name}</h1>
                            </div>

                            <!-- Rating Section -->
                            <div class="rating-section">
                                <div class="rating-stars" id="avgRatingStars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= averageRating}">
                                                <i class="fas fa-star"></i>
                                            </c:when>
                                            <c:when test="${i - 0.5 <= averageRating}">
                                                <i class="fas fa-star-half-alt"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-star empty"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <span class="rating-text" id="avgRatingText">
                                    <fmt:formatNumber value="${averageRating}" maxFractionDigits="1"/>
                                </span>
                                <span class="rating-count" data-bs-toggle="tab" data-bs-target="#reviews">
                                    (<span id="totalReviewsCount">${totalReviews}</span> đánh giá)
                                </span>
                            </div>

                            <!-- Price Section -->
                            <div class="price-section">
                                <div class="price-main">
                                    <fmt:formatNumber value="${product.price}" type="number"/> đ
                                </div>
                                <%-- Uncomment if you have original price
                                <div>
                                    <span class="price-original">29,990,000 đ</span>
                                    <span class="price-discount">-15%</span>
                                </div>
                                --%>
                            </div>

                            <!-- Product Description -->
                            <div class="product-description">
                                <i class="fas fa-info-circle me-2"></i>
                                ${product.shortDesc}
                            </div>

                            <!-- Stock Status -->
                            <c:choose>
                                <c:when test="${product.quantity > 50}">
                                    <div class="stock-status in-stock">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Còn ${product.quantity} sản phẩm</span>
                                    </div>
                                </c:when>
                                <c:when test="${product.quantity > 0 && product.quantity <= 50}">
                                    <div class="stock-status low-stock">
                                        <i class="fas fa-exclamation-triangle"></i>
                                        <span>Chỉ còn ${product.quantity} sản phẩm</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="stock-status out-of-stock">
                                        <i class="fas fa-times-circle"></i>
                                        <span>Hết hàng</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Quantity Selector -->
                            <div class="quantity-selector-wrapper">
                                <label class="quantity-label">Số lượng:</label>
                                <div class="quantity-selector">
                                    <button class="quantity-btn" id="btnMinus">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <input type="number" class="quantity-input" id="quantityInput" 
                                           value="1" min="1" max="${product.quantity}">
                                    <button class="quantity-btn" id="btnPlus">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <form method="post" action="/add-product-to-cart/${product.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="quantity" id="cartQuantity" value="1"/>
                                
                                <div class="action-buttons">
                                    <button type="submit" class="btn-add-cart" ${product.quantity == 0 ? 'disabled' : ''}>
                                        <i class="fas fa-shopping-cart"></i>
                                        <span>Thêm Vào Giỏ Hàng</span>
                                    </button>
                                    <button type="button" class="btn-wishlist" id="btnWishlist">
                                        <i class="far fa-heart"></i>
                                    </button>
                                </div>
                            </form>

                            <!-- Product Features -->
                            <div class="product-features">
                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="fas fa-shipping-fast"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h6>Miễn Phí Vận Chuyển</h6>
                                        <p>Cho đơn hàng trên 5 triệu</p>
                                    </div>
                                </div>

                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="fas fa-shield-alt"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h6>Bảo Hành Chính Hãng</h6>
                                        <p>12-24 tháng bảo hành</p>
                                    </div>
                                </div>

                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="fas fa-exchange-alt"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h6>Đổi Trả Trong 7 Ngày</h6>
                                        <p>Nếu có lỗi từ NSX</p>
                                    </div>
                                </div>

                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="fas fa-headset"></i>
                                    </div>
                                    <div class="feature-content">
                                        <h6>Hỗ Trợ nhiệt tình 24/7</h6>
                                        <p>Tư vấn miễn phí</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Tabs Section -->
            <div class="product-tabs-section">
                <ul class="nav custom-nav-tabs" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#description">
                            <i class="fas fa-align-left"></i>
                            Mô Tả Chi Tiết
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#specifications">
                            <i class="fas fa-list-ul"></i>
                            Thông Số Kỹ Thuật
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#reviews">
                            <i class="fas fa-star"></i>
                            Đánh Giá
                        </button>
                    </li>
                </ul>

                <div class="tab-content tab-content-wrapper">
                    <!-- Description Tab -->
                    <div class="tab-pane fade show active" id="description">
                        ${product.detailDesc}
                    </div>

                    <!-- Specifications Tab -->
                    <div class="tab-pane fade" id="specifications">
                        <h4 class="mb-4">
                            <i class="fas fa-laptop me-2"></i>
                            Thông Số Kỹ Thuật
                        </h4>
                        <table class="table table-bordered">
                            <tbody>
                                <tr>
                                    <td class="fw-bold" style="width: 30%;">Hãng Sản Xuất</td>
                                    <td>${product.factory}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Mục Đích Sử Dụng</td>
                                    <td>${product.target}</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Trạng Thái</td>
                                    <td>
                                        <c:if test="${product.quantity > 0}">
                                            <span class="badge bg-success">Còn Hàng</span>
                                        </c:if>
                                        <c:if test="${product.quantity == 0}">
                                            <span class="badge bg-danger">Hết Hàng</span>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Giá Bán</td>
                                    <td class="text-primary fw-bold fs-5">
                                        <fmt:formatNumber value="${product.price}" type="number"/> đ
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Reviews Tab -->
                    <div class="tab-pane fade" id="reviews">
                        <div class="reviews-container">
                            <!-- Reviews Summary -->
                            <div class="reviews-summary">
                                <div class="rating-overview">
                                    <div class="rating-number" id="summaryAvgRating">
                                        <fmt:formatNumber value="${averageRating}" maxFractionDigits="1"/>
                                    </div>
                                    <div class="rating-stars-large">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= averageRating}">
                                                    <i class="fas fa-star"></i>
                                                </c:when>
                                                <c:when test="${i - 0.5 <= averageRating}">
                                                    <i class="fas fa-star-half-alt"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="far fa-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <div class="total-reviews" id="summaryTotalReviews">${totalReviews} đánh giá</div>
                                </div>

                                <div class="rating-breakdown">
                                    <!-- Calculate rating breakdown from reviews if not provided -->
                                    <c:forEach begin="1" end="5" var="star">
                                        <c:set var="starKey" value="${6 - star}"/>
                                        <c:set var="count" value="0"/>
                                        
                                        <!-- Count reviews with this rating -->
                                        <c:forEach var="review" items="${reviews}">
                                            <c:if test="${review.rating == starKey}">
                                                <c:set var="count" value="${count + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <!-- If no reviews on current page, try ratingBreakdown map -->
                                        <c:if test="${count == 0 && ratingBreakdown != null}">
                                            <c:set var="count" value="${ratingBreakdown.get(starKey) != null ? ratingBreakdown.get(starKey) : 0}"/>
                                        </c:if>
                                        
                                        <c:set var="percentage" value="${totalReviews > 0 && count > 0 ? (count * 100.0 / totalReviews) : 0}"/>
                                        <div class="rating-bar-item">
                                            <div class="rating-bar-label">
                                                <i class="fas fa-star"></i> ${starKey} sao
                                            </div>
                                            <div class="rating-bar">
                                                <div class="rating-bar-fill" style="width: ${percentage}%"></div>
                                            </div>
                                            <div class="rating-bar-count">${count}</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Write Review Form -->
                            <c:choose>
                                <c:when test="${currentUser != null && !hasReviewed}">
                                    <div class="write-review-section mb-4">
                                        <button class="write-review-btn" type="button" data-bs-toggle="collapse" data-bs-target="#reviewForm">
                                            <i class="fas fa-pen"></i>
                                            <span>Viết Đánh Giá</span>
                                        </button>
                                        
                                        <div class="collapse mt-3" id="reviewForm">
                                            <div class="card card-body" style="border-radius: 20px; border: 2px solid #e2e8f0;">
                                                <h5 class="mb-3"><i class="fas fa-star me-2"></i>Đánh giá của bạn</h5>
                                                
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Số sao:</label>
                                                    <div class="rating-input">
                                                        <input type="hidden" id="ratingInput" value="5">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star star-input" data-rating="${i}" style="font-size: 2rem; cursor: pointer; color: #ffc107;"></i>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="reviewTitle" class="form-label fw-bold">Tiêu đề:</label>
                                                    <input type="text" class="form-control" id="reviewTitle" 
                                                           placeholder="Tóm tắt đánh giá của bạn" required>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="reviewContent" class="form-label fw-bold">Nội dung:</label>
                                                    <textarea class="form-control" id="reviewContent" rows="4" 
                                                              placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..." required></textarea>
                                                </div>
                                                
                                                <button type="button" class="btn btn-primary" id="submitReviewBtn" 
                                                        style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; padding: 12px 30px; border-radius: 25px;">
                                                    <i class="fas fa-paper-plane me-2"></i>Gửi Đánh Giá
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${currentUser != null && hasReviewed}">
                                    <div class="alert alert-info mb-4" style="border-radius: 15px;">
                                        <i class="fas fa-info-circle me-2"></i>
                                        Bạn đã đánh giá sản phẩm này rồi. Cảm ơn bạn!
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning mb-4" style="border-radius: 15px;">
                                        <i class="fas fa-sign-in-alt me-2"></i>
                                        Vui lòng <a href="/login" class="alert-link">đăng nhập</a> để viết đánh giá.
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Reviews List -->
                            <div class="reviews-list" id="reviewsList">
                                <c:choose>
                                    <c:when test="${empty reviews}">
                                        <div class="reviews-empty">
                                            <i class="far fa-comment-dots"></i>
                                            <h4>Chưa có đánh giá nào</h4>
                                            <p>Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="review" items="${reviews}">
                                            <div class="review-item" data-review-id="${review.id}">
                                                <div class="review-header">
                                                    <div class="reviewer-info">
                                                        <div class="reviewer-avatar">
                                                            <c:choose>
                                                                <c:when test="${not empty review.user.avatar}">
                                                                    <img src="/images/avatar/${review.user.avatar}" 
                                                                         style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${fn:substring(review.user.fullName, 0, 1)}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="reviewer-details">
                                                            <h5>${review.user.fullName}</h5>
                                                            <div class="reviewer-meta">
                                                                <span class="verified-badge">
                                                                    <i class="fas fa-check-circle"></i>
                                                                    Đã mua hàng
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="review-rating-date">
                                                        <div class="review-stars">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <c:choose>
                                                                    <c:when test="${i <= review.rating}">
                                                                        <i class="fas fa-star"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="far fa-star"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </div>
                                                        <div class="review-date">
                                                            <fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="review-content">
                                                    <strong>${review.title}</strong><br>
                                                    ${review.content}
                                                </div>
                                                <div class="review-actions">
                                                    <button class="review-action-btn helpful-btn" data-review-id="${review.id}">
                                                        <i class="far fa-thumbs-up"></i>
                                                        <span>Hữu ích (<span class="helpful-count">${review.helpfulCount}</span>)</span>
                                                    </button>
                                                    <!-- Nút sửa/xóa chỉ hiển thị cho chủ đánh giá -->
                                                    <c:if test="${currentUser != null && currentUser.id == review.user.id}">
                                                        <button class="review-action-btn edit-review-btn" 
                                                                data-review-id="${review.id}"
                                                                data-rating="${review.rating}"
                                                                data-title="${review.title}"
                                                                data-content="${review.content}">
                                                            <i class="fas fa-edit"></i>
                                                            <span>Sửa</span>
                                                        </button>
                                                        <button class="review-action-btn delete-review-btn" 
                                                                data-review-id="${review.id}"
                                                                style="color: #e74c3c;">
                                                            <i class="fas fa-trash"></i>
                                                            <span>Xóa</span>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="reviews-pagination" id="reviewsPagination">
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <button class="pagination-btn ${i == currentPage ? 'active' : ''}" data-page="${i}">
                                            ${i + 1}
                                        </button>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Sửa Đánh Giá -->
    <div class="modal fade" id="editReviewModal" tabindex="-1" aria-labelledby="editReviewModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 20px;">
                <div class="modal-header" style="border-bottom: 2px solid #e2e8f0;">
                    <h5 class="modal-title" id="editReviewModalLabel">
                        <i class="fas fa-edit me-2"></i>Chỉnh Sửa Đánh Giá
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editReviewId">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Số sao:</label>
                        <div class="edit-rating-input">
                            <input type="hidden" id="editRatingInput" value="5">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star edit-star-input" data-rating="${i}" 
                                   style="font-size: 2rem; cursor: pointer; color: #ffc107;"></i>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editReviewTitle" class="form-label fw-bold">Tiêu đề:</label>
                        <input type="text" class="form-control" id="editReviewTitle" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editReviewContent" class="form-label fw-bold">Nội dung:</label>
                        <textarea class="form-control" id="editReviewContent" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 2px solid #e2e8f0;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 20px;">Hủy</button>
                    <button type="button" class="btn btn-primary" id="saveEditReviewBtn" 
                            style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; border-radius: 20px;">
                        <i class="fas fa-save me-2"></i>Lưu Thay Đổi
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // JSP data variables
        var productData = {
            maxQuantity: <c:out value="${product.quantity != null ? product.quantity : 0}"/>,
            productId: <c:out value="${product.id != null ? product.id : 0}"/>
        };
    </script>
    <script>
        // Show toast notification
        function showToast(message, type) {
            var toastId = 'toast_' + Date.now();
            var toastHTML = '<div id="' + toastId + '" class="toast-notification toast-' + type + '">' +
                           '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + ' me-2"></i>' +
                           message + '</div>';
            
            var container = document.getElementById('toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'toast-container';
                container.style.position = 'fixed';
                container.style.top = '100px';
                container.style.right = '20px';
                container.style.zIndex = '9999';
                container.style.maxWidth = '400px';
                document.body.appendChild(container);
            }
            
            container.insertAdjacentHTML('beforeend', toastHTML);
            
            var toastElement = document.getElementById(toastId);
            
            // Auto remove after 3 seconds
            setTimeout(function() {
                toastElement.classList.add('fade-out');
                setTimeout(function() {
                    toastElement.remove();
                }, 300);
            }, 3000);
        }
    </script>
    <script>
        $(document).ready(function() {
            const maxQuantity = productData.maxQuantity;
            const productId = productData.productId;
            const csrfToken = $('meta[name="_csrf"]').attr('content');
            const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
            
            // Handle Add to Cart Form Submission
            $('form[action="/add-product-to-cart/${product.id}"]').on('submit', function(e) {
                e.preventDefault();
                
                const form = this;
                const quantity = $('#cartQuantity').val();
                
                $.ajax({
                    url: '/add-product-to-cart/' + productId,
                    type: 'POST',
                    data: {
                        quantity: quantity,
                        _csrf: csrfToken
                    },
                    headers: csrfHeader ? {[csrfHeader]: csrfToken} : {},
                    success: function(response) {
                        showToast('Đã thêm sản phẩm vào giỏ hàng!', 'success');
                        
                        // Update cart count if it exists
                        var badgeElement = document.querySelector('.badge-circle');
                        if (badgeElement) {
                            var currentCount = parseInt(badgeElement.textContent) || 0;
                            badgeElement.textContent = currentCount + parseInt(quantity);
                        }
                    },
                    error: function() {
                        showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger');
                    }
                });
            });
            
            // Quantity Controls
            $('#btnPlus').on('click', function() {
                let input = $('#quantityInput');
                let currentVal = parseInt(input.val());
                if (currentVal < maxQuantity) {
                    input.val(currentVal + 1);
                    $('#cartQuantity').val(currentVal + 1);
                }
            });

            $('#btnMinus').on('click', function() {
                let input = $('#quantityInput');
                let currentVal = parseInt(input.val());
                if (currentVal > 1) {
                    input.val(currentVal - 1);
                    $('#cartQuantity').val(currentVal - 1);
                }
            });

            $('#quantityInput').on('change', function() {
                let val = parseInt($(this).val());
                if (val < 1) val = 1;
                if (val > maxQuantity) val = maxQuantity;
                $(this).val(val);
                $('#cartQuantity').val(val);
            });

            // Wishlist Toggle
            $('#btnWishlist').on('click', function() {
                $(this).find('i').toggleClass('far fas');
                $(this).toggleClass('active');
            });

            // Thumbnail Gallery
            $('.thumbnail-item').on('click', function() {
                $('.thumbnail-item').removeClass('active');
                $(this).addClass('active');
                const newImage = $(this).find('img').attr('src');
                $('#mainImage').attr('src', newImage);
            });

            // Star Rating Input
            $('.star-input').on('click', function() {
                const rating = $(this).data('rating');
                $('#ratingInput').val(rating);
                $('.star-input').each(function(index) {
                    if (index < rating) {
                        $(this).removeClass('far').addClass('fas').css('color', '#ffc107');
                    } else {
                        $(this).removeClass('fas').addClass('far').css('color', '#e2e8f0');
                    }
                });
            });

            $('.star-input').on('mouseenter', function() {
                const rating = $(this).data('rating');
                $('.star-input').each(function(index) {
                    if (index < rating) {
                        $(this).css('color', '#ffdb4d');
                    }
                });
            });

            $('.star-input').on('mouseleave', function() {
                const currentRating = $('#ratingInput').val();
                $('.star-input').each(function(index) {
                    if (index < currentRating) {
                        $(this).css('color', '#ffc107');
                    } else {
                        $(this).css('color', '#e2e8f0');
                    }
                });
            });

            // Submit Review
            $('#submitReviewBtn').on('click', function() {
                const rating = $('#ratingInput').val();
                const title = $('#reviewTitle').val().trim();
                const content = $('#reviewContent').val().trim();

                if (!title || !content) {
                    alert('Vui lòng nhập đầy đủ tiêu đề và nội dung đánh giá!');
                    return;
                }

                $.ajax({
                    url: '/api/reviews/submit',
                    type: 'POST',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    data: {
                        productId: productId,
                        rating: rating,
                        title: title,
                        content: content
                    },
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('Có lỗi xảy ra. Vui lòng thử lại!');
                    }
                });
            });

            // Helpful Button
            $(document).on('click', '.helpful-btn', function() {
                const btn = $(this);
                const reviewId = btn.data('review-id');
                
                $.ajax({
                    url: '/api/reviews/helpful/' + reviewId,
                    type: 'POST',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(response) {
                        if (response.success) {
                            btn.find('.helpful-count').text(response.helpfulCount);
                            btn.addClass('active');
                        }
                    }
                });
            });

            // Edit Review Button - Mở modal chỉnh sửa
            $(document).on('click', '.edit-review-btn', function() {
                const reviewId = $(this).data('review-id');
                const rating = $(this).data('rating');
                const title = $(this).data('title');
                const content = $(this).data('content');
                
                $('#editReviewId').val(reviewId);
                $('#editRatingInput').val(rating);
                $('#editReviewTitle').val(title);
                $('#editReviewContent').val(content);
                
                // Cập nhật hiển thị sao
                $('.edit-star-input').each(function(index) {
                    if (index < rating) {
                        $(this).removeClass('far').addClass('fas').css('color', '#ffc107');
                    } else {
                        $(this).removeClass('fas').addClass('far').css('color', '#e2e8f0');
                    }
                });
                
                $('#editReviewModal').modal('show');
            });
            
            // Xử lý chọn sao trong modal edit
            $('.edit-star-input').on('click', function() {
                const rating = $(this).data('rating');
                $('#editRatingInput').val(rating);
                $('.edit-star-input').each(function(index) {
                    if (index < rating) {
                        $(this).removeClass('far').addClass('fas').css('color', '#ffc107');
                    } else {
                        $(this).removeClass('fas').addClass('far').css('color', '#e2e8f0');
                    }
                });
            });
            
            // Lưu chỉnh sửa đánh giá
            $('#saveEditReviewBtn').on('click', function() {
                const reviewId = $('#editReviewId').val();
                const rating = $('#editRatingInput').val();
                const title = $('#editReviewTitle').val().trim();
                const content = $('#editReviewContent').val().trim();
                
                if (!title || !content) {
                    alert('Vui lòng nhập đầy đủ tiêu đề và nội dung!');
                    return;
                }
                
                $.ajax({
                    url: '/api/reviews/update/' + reviewId,
                    type: 'POST',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    data: {
                        rating: rating,
                        title: title,
                        content: content
                    },
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            $('#editReviewModal').modal('hide');
                            location.reload();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('Có lỗi xảy ra. Vui lòng thử lại!');
                    }
                });
            });
            
            // Delete Review Button - Xóa đánh giá
            $(document).on('click', '.delete-review-btn', function() {
                const reviewId = $(this).data('review-id');
                
                if (!confirm('Bạn có chắc chắn muốn xóa đánh giá này?')) {
                    return;
                }
                
                $.ajax({
                    url: '/api/reviews/delete/' + reviewId,
                    type: 'POST',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('Có lỗi xảy ra. Vui lòng thử lại!');
                    }
                });
            });

            // Pagination
            $(document).on('click', '.pagination-btn', function() {
                const page = $(this).data('page');
                loadReviews(page);
            });

            function loadReviews(page) {
                $.ajax({
                    url: '/api/reviews/' + productId + '?page=' + page,
                    type: 'GET',
                    success: function(response) {
                        renderReviews(response.reviews);
                        renderPagination(response.currentPage, response.totalPages);
                    }
                });
            }

            function renderReviews(reviews) {
                let html = '';
                if (reviews.length === 0) {
                    html = '<div class="reviews-empty"><i class="far fa-comment-dots"></i><h4>Chưa có đánh giá nào</h4><p>Hãy là người đầu tiên đánh giá sản phẩm này!</p></div>';
                } else {
                    reviews.forEach(function(review) {
                        const stars = Array(5).fill(0).map((_, i) => i < review.rating ? '<i class="fas fa-star"></i>' : '<i class="far fa-star"></i>').join('');
                        const initial = review.userName ? review.userName.charAt(0).toUpperCase() : 'U';
                        const avatar = review.userAvatar ? '<img src="/images/avatar/' + review.userAvatar + '" style="width:100%;height:100%;border-radius:50%;object-fit:cover;">' : initial;
                        const date = new Date(review.createdAt).toLocaleDateString('vi-VN');
                        
                        html += '<div class="review-item" data-review-id="' + review.id + '">' +
                            '<div class="review-header">' +
                            '<div class="reviewer-info">' +
                            '<div class="reviewer-avatar">' + avatar + '</div>' +
                            '<div class="reviewer-details">' +
                            '<h5>' + review.userName + '</h5>' +
                            '<div class="reviewer-meta"><span class="verified-badge"><i class="fas fa-check-circle"></i> Đã mua hàng</span></div>' +
                            '</div></div>' +
                            '<div class="review-rating-date">' +
                            '<div class="review-stars">' + stars + '</div>' +
                            '<div class="review-date">' + date + '</div>' +
                            '</div></div>' +
                            '<div class="review-content"><strong>' + review.title + '</strong><br>' + review.content + '</div>' +
                            '<div class="review-actions">' +
                            '<button class="review-action-btn helpful-btn" data-review-id="' + review.id + '">' +
                            '<i class="far fa-thumbs-up"></i><span>Hữu ích (<span class="helpful-count">' + review.helpfulCount + '</span>)</span>' +
                            '</button></div></div>';
                    });
                }
                $('#reviewsList').html(html);
            }

            function renderPagination(currentPage, totalPages) {
                if (totalPages <= 1) {
                    $('#reviewsPagination').hide();
                    return;
                }
                let html = '';
                for (let i = 0; i < totalPages; i++) {
                    html += '<button class="pagination-btn ' + (i === currentPage ? 'active' : '') + '" data-page="' + i + '">' + (i + 1) + '</button>';
                }
                $('#reviewsPagination').html(html).show();
            }
        });
    </script>
</body>
</html>