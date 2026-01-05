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
                        <div class="header-actions">
                            <!-- Search Form -->
                            <form action="/admin/product" method="get" class="admin-search-form">
                                <div class="admin-search-box">
                                    <input type="text" name="keyword" class="admin-search-input" 
                                           placeholder="Tìm tên sản phẩm, hãng..." 
                                           value="${keyword}">
                                    <button type="submit" class="admin-search-btn">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                            <a href="/admin/product/create" class="btn-create">
                                <i class="fas fa-plus-circle me-2"></i>Thêm Sản Phẩm
                            </a>
                        </div>
                    </div>
                    
                    <!-- Search Result Info -->
                    <c:if test="${not empty keyword}">
                        <div class="search-result-bar">
                            <span>
                                <i class="fas fa-search me-2"></i>
                                Kết quả tìm kiếm cho "<strong>${keyword}</strong>": ${totalItems} sản phẩm
                            </span>
                            <a href="/admin/product" class="btn-clear-search">
                                <i class="fas fa-times me-1"></i>Xóa tìm kiếm
                            </a>
                        </div>
                    </c:if>
                    
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
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="card-footer d-flex justify-content-center align-items-center">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <!-- Previous Button -->
                                    <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
                                        <a class="page-link" href="/admin/product?pageNo=<c:out value='${currentPage - 1}'/><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>>
                                            <i class="fas fa-chevron-left"></i> Trước
                                        </a>
                                    </li>

                                    <!-- Page Numbers -->
                                    <c:set var="startPage" value="${currentPage > 2 ? currentPage - 2 : 1}" />
                                    <c:set var="endPage" value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" />
                                    
                                    <c:if test="${startPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="/admin/product?pageNo=1<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">1</a>
                                        </li>
                                        <c:if test="${startPage > 2}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                    </c:if>

                                    <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                        <li class="page-item <c:if test='${page == currentPage}'>active</c:if>">
                                            <a class="page-link" href="/admin/product?pageNo=${page}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${page}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${endPage < totalPages}">
                                        <c:if test="${endPage < totalPages - 1}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                        <li class="page-item">
                                            <a class="page-link" href="/admin/product?pageNo=${totalPages}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${totalPages}</a>
                                        </li>
                                    </c:if>

                                    <!-- Next Button -->
                                    <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
                                        <a class="page-link" href="/admin/product?pageNo=<c:out value='${currentPage + 1}'/><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>
                                            Sau <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        
                        </div>
                    </c:if>
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
