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
    <title>Quản Lý Sản Phẩm - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/product/show.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="page-header">
                    <h1><i class="fas fa-box me-2"></i>Quản Lý Sản Phẩm</h1>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Sản Phẩm</li>
                    </ol>
                </div>

                <div class="modern-card">
                    <div class="card-header">
                        <h5><i class="fas fa-list me-2"></i>Danh Sách Sản Phẩm</h5>
                        <a href="/admin/product/create" class="btn-create">
                            <i class="fas fa-plus-circle me-2"></i>Thêm Sản Phẩm
                        </a>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty products}">
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="fas fa-inbox"></i>
                                    </div>
                                    <div class="empty-title">Chưa có sản phẩm nào</div>
                                    <div class="empty-text">Thêm sản phẩm đầu tiên để bắt đầu</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table class="product-table table mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 8%;">ID</th>
                                                <th style="width: 30%;">Tên Sản Phẩm</th>
                                                <th style="width: 15%;">Giá</th>
                                                <th style="width: 15%;">Hãng Sản Xuất</th>
                                                <th style="width: 32%;">Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td><span class="product-id">#${product.id}</span></td>
                                                    <td><span class="product-name">${product.name}</span></td>
                                                    <td>
                                                        <span class="price-badge">
                                                            <fmt:formatNumber type="number" value="${product.price}" /> đ
                                                        </span>
                                                    </td>
                                                    <td><span class="factory-badge">${product.factory}</span></td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="/admin/product/${product.id}" class="btn-action btn-view" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>Xem
                                                            </a>
                                                            <a href="/admin/product/update/${product.id}" class="btn-action btn-edit" title="Cập nhật">
                                                                <i class="fas fa-edit"></i>Sửa
                                                            </a>
                                                            <a href="/admin/product/delete/${product.id}" class="btn-action btn-delete" title="Xóa">
                                                                <i class="fas fa-trash"></i>Xóa
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                            </c:otherwise>
                        </c:choose>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</body>
</html>
