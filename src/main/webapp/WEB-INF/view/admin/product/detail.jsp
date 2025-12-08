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
    <title>Chi Tiết Sản Phẩm - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/product/detail.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="page-header">
                        <h1><i class="fas fa-search me-2"></i>Chi Tiết Sản Phẩm</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/product">Sản Phẩm</a></li>
                            <li class="breadcrumb-item active">Chi Tiết</li>
                        </ol>
                    </div>
                    <div class="row">
                        <div class="col-lg-10 mx-auto">
                            <div class="detail-card">
                                <div class="detail-header">
                                    <h5><i class="fas fa-box me-2"></i>${product.name}</h5>
                                </div>
                                <div class="detail-body">
                                    <div class="detail-row">
                                        <div class="product-image">
                                            <c:if test="${not empty product.image}">
                                                <img src="/images/product/${product.image}" alt="${product.name}">
                                            </c:if>
                                            <c:if test="${empty product.image}">
                                                <div style="background: #e5e7eb; height: 300px; border-radius: 12px; display: flex; align-items: center; justify-content: center;">
                                                    <i class="fas fa-image" style="font-size: 3rem; color: #9ca3af;"></i>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div>
                                            <div class="info-group">
                                                <div class="info-label">ID Sản Phẩm</div>
                                                <div class="info-value">#${product.id}</div>
                                            </div>
                                            <div class="info-group" style="margin-top: 1rem;">
                                                <div class="info-label">Giá</div>
                                                <div class="price-display"><fmt:formatNumber type="number" value="${product.price}" /> đ</div>
                                            </div>
                                            <div class="info-group" style="margin-top: 1rem;">
                                                <div class="info-label">Số Lượng Tồn Kho</div>
                                                <div class="info-value">${product.quantity}<span class="stock-badge">Còn hàng</span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="detail-row full">
                                        <div>
                                            <div class="info-label">Thông Tin Sản Phẩm</div>
                                            <div style="margin-top: 1rem;">
                                                <span class="factory-badge"><i class="fas fa-industry me-1"></i>${product.factory}</span>
                                                <c:if test="${not empty product.target}">
                                                    <span class="target-badge"><i class="fas fa-bullseye me-1"></i>${product.target}</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${not empty product.shortDesc}">
                                        <div class="detail-row full">
                                            <div class="description-section">
                                                <div class="description-title"><i class="fas fa-comment me-2"></i>Mô Tả Ngắn</div>
                                                <div class="description-text">${product.shortDesc}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty product.detailDesc}">
                                        <div class="detail-row full">
                                            <div class="description-section">
                                                <div class="description-title"><i class="fas fa-align-left me-2"></i>Mô Tả Chi Tiết</div>
                                                <div class="description-text">${product.detailDesc}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="action-buttons">
                                        <a href="/admin/product" class="btn-action btn-back"><i class="fas fa-arrow-left"></i>Quay Lại</a>
                                        <a href="/admin/product/update/${product.id}" class="btn-action btn-edit"><i class="fas fa-edit"></i>Cập Nhật</a>
                                        <a href="/admin/product/delete/${product.id}" class="btn-action btn-delete"><i class="fas fa-trash"></i>Xóa</a>
                                    </div>
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
