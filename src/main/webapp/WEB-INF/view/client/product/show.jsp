<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất Cả Sản Phẩm - LaptopShop</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template Stylesheet -->
    <link rel="stylesheet" href="/client/css/style.css">
    <link rel="stylesheet" href="/client/css/product/show.css">
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@700;800;900&family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Spinner Start -->
    <div class="show w-100 vh-100 position-fixed top-0 start-0" id="spinner" style="pointer-events: none;">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <jsp:include page="../layout/header.jsp" />
    
    
    <!-- Products Shop -->
    <div class="container-fluid fruite py-5 mt-5">
        <div class="container py-5">
             <div class="row g-4 mb-4">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/" style="color: #00d4ff;">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Danh Sách Sản Phẩm</li>
                        </ol>
                    </nav>
                    
                    <!-- Hiển thị kết quả tìm kiếm -->
                    <c:if test="${not empty keyword}">
                        <div class="search-result-info mb-3 p-3 rounded" style="background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); border-left: 4px solid #00d4ff;">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>
                                    <i class="fas fa-search me-2" style="color: #00d4ff;"></i>
                                    Tìm thấy <strong style="color: #00d4ff;">${totalItems} sản phẩm</strong> cho từ khoá '<strong style="color: #00d4ff;">${keyword}</strong>'
                                </span>
                                <a href="/product/show" class="btn btn-outline-light btn-sm">
                                    <i class="fas fa-times me-1"></i>Xóa tìm kiếm
                                </a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="row g-4">
                <!-- Filter Sidebar -->
                <div class="col-lg-3">
                    <form id="filterForm" method="get" action="/product/show">
                        <!-- Giữ lại keyword khi filter -->
                        <input type="hidden" name="keyword" value="${keyword}">
                        <div class="filter-sidebar">
                            <!-- Hãng sản xuất -->
                            <div class="filter-section">
                                <h5 class="filter-title">Hãng sản xuất</h5>
                                <c:forEach var="factory" items="${allFactories}">
                                    <div class="filter-checkbox">
                                        <input type="checkbox" name="factory" value="${factory}" id="factory_${factory}"
                                               <c:if test="${selectedFactories != null && selectedFactories.contains(factory)}">checked</c:if>>
                                        <label for="factory_${factory}">${factory}</label>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Mục đích sử dụng -->
                            <div class="filter-section">
                                <h5 class="filter-title">Mục đích sử dụng</h5>
                                <c:forEach var="target" items="${allTargets}">
                                    <div class="filter-checkbox">
                                        <input type="checkbox" name="target" value="${target}" id="target_${target}"
                                               <c:if test="${selectedTargets != null && selectedTargets.contains(target)}">checked</c:if>>
                                        <label for="target_${target}">${target}</label>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Mức giá -->
                            <div class="filter-section">
                                <h5 class="filter-title">Mức giá</h5>
                                <div class="filter-radio">
                                    <input type="radio" name="priceRange" value="" id="price_all" 
                                           <c:if test="${empty selectedMinPrice && empty selectedMaxPrice}">checked</c:if>>
                                    <label for="price_all">Tất cả</label>
                                </div>
                                <div class="filter-radio">
                                    <input type="radio" name="priceRange" value="0-10000000" id="price_1"
                                           <c:if test="${selectedMinPrice == 0 && selectedMaxPrice == 10000000}">checked</c:if>>
                                    <label for="price_1">Dưới 10 triệu</label>
                                </div>
                                <div class="filter-radio">
                                    <input type="radio" name="priceRange" value="10000000-15000000" id="price_2"
                                           <c:if test="${selectedMinPrice == 10000000 && selectedMaxPrice == 15000000}">checked</c:if>>
                                    <label for="price_2">Từ 10 - 15 triệu</label>
                                </div>
                                <div class="filter-radio">
                                    <input type="radio" name="priceRange" value="15000000-20000000" id="price_3"
                                           <c:if test="${selectedMinPrice == 15000000 && selectedMaxPrice == 20000000}">checked</c:if>>
                                    <label for="price_3">Từ 15 - 20 triệu</label>
                                </div>
                                <div class="filter-radio">
                                    <input type="radio" name="priceRange" value="20000000-" id="price_4"
                                           <c:if test="${selectedMinPrice == 20000000 && empty selectedMaxPrice}">checked</c:if>>
                                    <label for="price_4">Trên 20 triệu</label>
                                </div>
                                <input type="hidden" name="minPrice" id="minPriceInput" value="${selectedMinPrice}">
                                <input type="hidden" name="maxPrice" id="maxPriceInput" value="${selectedMaxPrice}">
                            </div>
                            
                            <!-- Sắp xếp -->
                            <div class="filter-section">
                                <h5 class="filter-title">Sắp xếp</h5>
                                <div class="filter-radio">
                                    <input type="radio" name="sort" value="" id="sort_default" 
                                           <c:if test="${empty selectedSort}">checked</c:if>>
                                    <label for="sort_default">Mặc định</label>
                                </div>
                                <div class="filter-radio">
                                    <input type="radio" name="sort" value="price-asc" id="sort_price_asc"
                                           <c:if test="${selectedSort == 'price-asc'}">checked</c:if>>
                                    <label for="sort_price_asc">Giá tăng dần</label>
                                </div>
                                <div class="filter-radio">
                                    <input type="radio" name="sort" value="price-desc" id="sort_price_desc"
                                           <c:if test="${selectedSort == 'price-desc'}">checked</c:if>>
                                    <label for="sort_price_desc">Giá giảm dần</label>
                                </div>
                            </div>
                            
                            <button type="submit" class="filter-btn">
                                <i class="fas fa-filter me-2"></i>Lọc sản phẩm
                            </button>
                            <a href="/product/show" class="reset-btn d-block text-center text-decoration-none">
                                <i class="fas fa-redo me-2"></i>Xóa bộ lọc
                            </a>
                        </div>
                    </form>
                </div>
                
                <!-- Product List -->
                <div class="col-lg-9">
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="text-center py-5">
                                <div style="font-size: 4rem; color: #ddd; margin-bottom: 20px;">
                                    <i class="fas fa-inbox"></i>
                                </div>
                                <h3 class="text-muted">Không có sản phẩm nào</h3>
                                <p class="text-muted">Vui lòng thay đổi bộ lọc hoặc quay lại sau</p>
                                <a href="/product/show" class="btn btn-primary mt-3">Xem tất cả sản phẩm</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            
                            <!-- Product Grid - 3 products per row -->
                            <div class="row g-4">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="product-card">
                                            <div class="product-img">
                                                <a href="/product/${product.id}">
                                                    <img src="/images/product/${product.image}" alt="${product.name}">
                                                </a>
                                                <span class="badge-factory">${product.factory}</span>
                                            </div>
                                            <div class="product-info">
                                                <a href="/product/${product.id}" class="product-name">${product.name}</a>
                                                <p class="product-desc">${product.shortDesc}</p>
                                                <p class="product-price">
                                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> đ
                                                </p>
                                                <button type="button" class="add-cart-btn" onclick="addToCart(event, ${product.id})">
                                                    <i class="fas fa-shopping-cart me-2"></i>Add to cart
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="d-flex justify-content-center align-items-center gap-3 mt-5 pt-4">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination mb-0">
                                            <!-- Previous Button -->
                                            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                                                <a class="page-link" href="javascript:void(0)" onclick="goToPage(${currentPage - 1})" 
                                                   <c:if test='${currentPage == 1}'>style="pointer-events: none;"</c:if>>
                                                    <i class="fas fa-chevron-left"></i> Trước
                                                </a>
                                            </li>

                                            <!-- Page Numbers -->
                                            <c:set var="startPage" value="${currentPage > 2 ? currentPage - 2 : 1}" />
                                            <c:set var="endPage" value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" />
                                            
                                            <c:if test="${startPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="javascript:void(0)" onclick="goToPage(1)">1</a>
                                                </li>
                                                <c:if test="${startPage > 2}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                            </c:if>

                                            <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                                <li class="page-item <c:if test='${page == currentPage}'>active</c:if>">
                                                    <a class="page-link" href="javascript:void(0)" onclick="goToPage(${page})">${page}</a>
                                                </li>
                                            </c:forEach>

                                            <c:if test="${endPage < totalPages}">
                                                <c:if test="${endPage < totalPages - 1}">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                </c:if>
                                                <li class="page-item">
                                                    <a class="page-link" href="javascript:void(0)" onclick="goToPage(${totalPages})">${totalPages}</a>
                                                </li>
                                            </c:if>

                                            <!-- Next Button -->
                                            <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
                                                <a class="page-link" href="javascript:void(0)" onclick="goToPage(${currentPage + 1})" 
                                                   <c:if test='${currentPage == totalPages}'>style="pointer-events: none;"</c:if>>
                                                    Sau <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/feature.jsp" />
    <jsp:include page="../layout/footer.jsp" />

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/easing.min.js"></script>
    <script src="/client/js/waypoints.min.js"></script>
    <script src="/client/js/lightbox.min.js"></script>
    <script src="/client/js/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
    
    <script>
        // Handle price range radio buttons
        document.querySelectorAll('input[name="priceRange"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                var value = this.value;
                var minPriceInput = document.getElementById('minPriceInput');
                var maxPriceInput = document.getElementById('maxPriceInput');
                
                if (value === '') {
                    minPriceInput.value = '';
                    maxPriceInput.value = '';
                } else {
                    var parts = value.split('-');
                    minPriceInput.value = parts[0] || '';
                    maxPriceInput.value = parts[1] || '';
                }
            });
        });
        
        // Add to cart with AJAX
        function addToCart(event, productId) {
            event.preventDefault();
            
            var token = document.querySelector('input[name="_csrf"]') ? document.querySelector('input[name="_csrf"]').value : 
                        document.querySelector('meta[name="_csrf"]') ? document.querySelector('meta[name="_csrf"]').getAttribute('content') : '';
            var tokenHeader = document.querySelector('meta[name="_csrf_header"]') ? document.querySelector('meta[name="_csrf_header"]').getAttribute('content') : 'X-CSRF-TOKEN';
            
            // Fallback: get token from page if available
            if (!token) {
                var formElements = document.querySelectorAll('form');
                for (var i = 0; i < formElements.length; i++) {
                    var csrfInput = formElements[i].querySelector('input[name="_csrf"]');
                    if (csrfInput) {
                        token = csrfInput.value;
                        break;
                    }
                }
            }
            
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/add-product-to-cart/' + productId, true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            if (tokenHeader && token) {
                xhr.setRequestHeader(tokenHeader, token);
            }
            
            xhr.onload = function() {
                if (xhr.status === 200 || xhr.status === 0) {
                    // Show success toast
                    showToast('Đã thêm sản phẩm vào giỏ hàng!', 'success');
                    
                    // Update cart count if it exists
                    var badgeElement = document.querySelector('.badge-circle');
                    if (badgeElement) {
                        var currentCount = parseInt(badgeElement.textContent) || 0;
                        badgeElement.textContent = currentCount + 1;
                    }
                } else {
                    showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger');
                }
            };
            
            xhr.onerror = function() {
                showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger');
            };
            
            xhr.send('_csrf=' + encodeURIComponent(token));
        }
        
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
                container.style.top = '80px';
                container.style.right = '20px';
                container.style.zIndex = '9999';
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
        
        // Pagination with filters
        function goToPage(pageNo) {
            var form = document.getElementById('filterForm');
            var formData = new FormData(form);
            
            var params = new URLSearchParams();
            params.append('pageNo', pageNo);
            
            // Get keyword if exists
            var keyword = document.querySelector('input[name="keyword"]');
            if (keyword && keyword.value) {
                params.append('keyword', keyword.value);
            }
            
            // Get all checked factories
            document.querySelectorAll('input[name="factory"]:checked').forEach(function(cb) {
                params.append('factory', cb.value);
            });
            
            // Get all checked targets
            document.querySelectorAll('input[name="target"]:checked').forEach(function(cb) {
                params.append('target', cb.value);
            });
            
            // Get price range
            var minPrice = document.getElementById('minPriceInput').value;
            var maxPrice = document.getElementById('maxPriceInput').value;
            if (minPrice) params.append('minPrice', minPrice);
            if (maxPrice) params.append('maxPrice', maxPrice);
            
            // Get sort
            var sortRadio = document.querySelector('input[name="sort"]:checked');
            if (sortRadio && sortRadio.value) {
                params.append('sort', sortRadio.value);
            }
            
            window.location.href = '/product/show?' + params.toString();
        }
    </script>

</body>
</html>
