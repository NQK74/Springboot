<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LaptopShop - Homepage</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS - Load FIRST -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template Stylesheet - Load LAST to override Bootstrap -->
    <link rel="stylesheet" href="/client/css/style.css">
    <!-- Thêm vào <head> để font chữ đẹp hơn -->
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@700;800;900&family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    
</head>
<body>
    <!-- Spinner Start -->
    <div class="show w-100 vh-100 position-fixed top-0 start-0" id="spinner" style="pointer-events: none;">
    <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <jsp:include page="../layout/header.jsp" />
    
    <jsp:include page="../layout/banner.jsp" />

    

    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
    <div class="container py-5">
        <div class="tab-class text-center">
            <div class="row g-4">
                <div class="col-lg-4 text-start">
                    <h1>Sản Phẩm Nổi Bật</h1>
                </div>
                <div class="col-lg-8 text-end">
                    <a href="/product/show" class="btn btn-primary rounded-pill px-4">
                       Xem Tất Cả Sản Phẩm
                    </a>
                </div>
            </div>
            <div class="tab-content">
                <div id="tab-1" class="tab-pane fade show p-0 active">
                    <div class="row g-4">
                        <div class="col-lg-12">
                            <div class="row g-4">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-md-6 col-lg-4 col-xl-3">
                                        <div class="homepage-product-card">
                                            <div class="product-img-wrapper">
                                                <a href="/product/${product.id}">
                                                    <img src="/images/product/${product.image}" class="img-fluid w-100" alt="${product.name}">
                                                </a>
                                                <span class="badge-factory">${product.factory}</span>
                                            </div>
                                            <div class="product-info-wrapper">
                                                <h4>
                                                    <a href="/product/${product.id}" class="product-link">${product.name}</a>
                                                </h4>
                                                <p class="product-desc">${product.shortDesc}</p>
                                                <p class="product-price">
                                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫
                                                </p>
                                                <button type="button" class="add-cart-btn-home" onclick="addToCart(event, ${product.id})">
                                                    <i class="fa fa-shopping-bag me-2"></i> ADD TO CART
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>      
    </div>
    </div>
    <jsp:include page="../layout/feature.jsp" />

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <!-- <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a> -->

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
    
    <script src="/client/js/product/show.js"></script>

</body>

</html>
