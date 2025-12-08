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
    <title>Xóa Sản Phẩm - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/product/delete.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="page-header">
                        <h1><i class="fas fa-trash me-2"></i>Xóa Sản Phẩm</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/product">Sản Phẩm</a></li>
                            <li class="breadcrumb-item active">Xóa</li>
                        </ol>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 mx-auto">
                            <div class="delete-card">
                                <div class="delete-header">
                                    <div class="delete-icon"><i class="fas fa-exclamation-triangle"></i></div>
                                    <h3 class="delete-title">Xóa Sản Phẩm</h3>
                                    <p class="delete-subtitle">Bạn chắc chắn muốn xóa sản phẩm này không?</p>
                                </div>
                                <div class="delete-body">
                                    <div class="product-image">
                                        <c:if test="${not empty product.image}">
                                            <img src="/images/product/${product.image}" alt="${product.name}">
                                        </c:if>
                                    </div>
                                    <div class="product-info">
                                        <div class="info-row">
                                            <span class="info-label">ID Sản Phẩm:</span>
                                            <span class="info-value">#${product.id}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Tên:</span>
                                            <span class="info-value">${product.name}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Giá:</span>
                                            <span class="info-value"><fmt:formatNumber type="number" value="${product.price}" /> đ</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Số Lượng:</span>
                                            <span class="info-value">${product.quantity}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label">Hãng:</span>
                                            <span class="info-value">${product.factory}</span>
                                        </div>
                                    </div>
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <i class="fas fa-exclamation-circle me-2"></i>
                                            <strong>Lỗi:</strong> ${errorMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    <div class="warning-message">
                                        <i class="fas fa-warning"></i>
                                        <strong>Chú ý:</strong> Hành động này không thể hoàn tác. Sản phẩm sẽ bị xóa vĩnh viễn khỏi hệ thống.
                                    </div>
                                    <form method="post" action="/admin/product/delete/${product.id}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="form-actions">
                                            <a href="/admin/product" class="btn-cancel"><i class="fas fa-arrow-left me-1"></i>Quay Lại</a>
                                            <button type="submit" class="btn-confirm"><i class="fas fa-check me-1"></i>Xác Nhận Xóa</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
