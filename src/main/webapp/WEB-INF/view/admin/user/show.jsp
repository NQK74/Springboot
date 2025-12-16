<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Quản Lý Người Dùng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/user/show.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="page-header">
                        <h1><i class="fas fa-users me-2"></i>Quản Lý Người Dùng</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item active">Người Dùng</li>
                        </ol>
                    </div>

                    <div class="modern-card">
                        <!-- Error/Success Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <div class="card-header">
                            <h5><i class="fas fa-list me-2"></i>Danh Sách Người Dùng</h5>
                            <div class="d-flex gap-3 align-items-center">
                                <!-- Search Form -->
                                <form action="/admin/user" method="get" class="admin-search-form">
                                    <div class="admin-search-box">
                                        <input type="text" name="keyword" class="admin-search-input" 
                                               placeholder="Tìm email, họ tên..." value="${keyword}">
                                        <button type="submit" class="admin-search-btn">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </form>
                                <a href="/admin/user/create" class="btn-create">
                                    <i class="fas fa-user-plus me-2"></i>Thêm Người Dùng
                                </a>
                            </div>
                        </div>
                        
                        <!-- Search Result Info -->
                        <c:if test="${not empty keyword}">
                            <div class="search-result-bar">
                                <span><i class="fas fa-search me-2"></i>Tìm thấy <strong>${totalItems}</strong> kết quả cho "<strong>${keyword}</strong>"</span>
                                <a href="/admin/user" class="btn-clear-search"><i class="fas fa-times me-1"></i>Xóa tìm kiếm</a>
                            </div>
                        </c:if>
                        
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty users1}">
                                    <div class="empty-state">
                                        <div class="empty-icon">
                                            <i class="fas fa-users"></i>
                                        </div>
                                        <c:choose>
                                            <c:when test="${not empty keyword}">
                                                <div class="empty-title">Không tìm thấy người dùng</div>
                                                <div class="empty-text">Không có kết quả phù hợp với "${keyword}"</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="empty-title">Chưa có người dùng nào</div>
                                                <div class="empty-text">Thêm người dùng đầu tiên để bắt đầu</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <table class="user-table table mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%;"><i class="fas fa-id-card me-2"></i>ID</th>
                                                <th style="width: 30%;"><i class="fas fa-envelope me-2"></i>EMAIL</th>
                                                <th style="width: 20%;"><i class="fas fa-user me-2"></i>HỌ TÊN</th>
                                                <th style="width: 15%;"><i class="fas fa-shield-alt me-2"></i>VAI TRÒ</th>
                                                <th style="width: 25%;"><i class="fas fa-cogs me-2"></i>HÀNH ĐỘNG</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users1}">
                                                <tr>
                                                    <td><span class="user-id">#${user.id}</span></td>
                                                    <td><span class="user-email">${user.email}</span></td>
                                                    <td><span class="user-name">${user.fullName}</span></td>
                                                    <td>
                                                        <c:if test="${user.role.name == 'SUPER_ADMIN'}">
                                                            <span class="status-badge" style="background: linear-gradient(135deg, #fef3c7 0%, #fcd34d 100%); color: #92400e;">
                                                                <i class="fas fa-star me-1"></i>SUPER ADMIN
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${user.role.name == 'ADMIN'}">
                                                            <span class="status-badge" style="background: linear-gradient(135deg, #fecaca 0%, #fca5a5 100%); color: #b91c1c;">
                                                                <i class="fas fa-crown me-1"></i>ADMIN
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${user.role.name == 'USER'}">
                                                            <span class="status-badge" style="background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); color: #1e40af;">
                                                                <i class="fas fa-user-check me-1"></i>USER
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${user.role.name == 'STAFF'}">
                                                            <span class="status-badge" style="background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%); color: #047857;">
                                                                <i class="fas fa-user-tie me-1"></i>STAFF
                                                            </span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="/admin/user/${user.id}" class="btn-action btn-view" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>Xem
                                                            </a>
                                                            <%-- SUPER_ADMIN có thể sửa tất cả --%>
                                                            <sec:authorize access="hasRole('SUPER_ADMIN')">
                                                                <a href="/admin/user/update/${user.id}" class="btn-action btn-edit" title="Chỉnh sửa">
                                                                    <i class="fas fa-edit"></i>Sửa
                                                                </a>
                                                            </sec:authorize>
                                                            <%-- ADMIN có thể sửa STAFF và chính mình --%>
                                                            <sec:authorize access="hasRole('ADMIN') and !hasRole('SUPER_ADMIN')">
                                                                <c:if test="${user.role.name == 'STAFF' or user.id == sessionScope.id}">
                                                                    <a href="/admin/user/update/${user.id}" class="btn-action btn-edit" title="Chỉnh sửa">
                                                                        <i class="fas fa-edit"></i>Sửa
                                                                    </a>
                                                                </c:if>
                                                            </sec:authorize>
                                                            <a href="/admin/user/delete/${user.id}" class="btn-action btn-delete" title="Xóa">
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
                                            <a class="page-link" href="/admin/user?pageNo=<c:out value='${currentPage - 1}'/><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" <c:if test='${currentPage == 1}'>onclick="return false;"</c:if>>
                                                <i class="fas fa-chevron-left"></i> Trước
                                            </a>
                                        </li>

                                        <!-- Page Numbers -->
                                        <c:set var="startPage" value="${currentPage > 2 ? currentPage - 2 : 1}" />
                                        <c:set var="endPage" value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" />
                                        
                                        <c:if test="${startPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/user?pageNo=1<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">1</a>
                                            </li>
                                            <c:if test="${startPage > 2}">
                                                <li class="page-item disabled">
                                                    <span class="page-link">...</span>
                                                </li>
                                            </c:if>
                                        </c:if>

                                        <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                            <li class="page-item <c:if test='${page == currentPage}'>active</c:if>">
                                                <a class="page-link" href="/admin/user?pageNo=${page}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${page}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${endPage < totalPages}">
                                            <c:if test="${endPage < totalPages - 1}">
                                                <li class="page-item disabled">
                                                    <span class="page-link">...</span>
                                                </li>
                                            </c:if>
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/user?pageNo=${totalPages}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${totalPages}</a>
                                            </li>
                                        </c:if>

                                        <!-- Next Button -->
                                        <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
                                            <a class="page-link" href="/admin/user?pageNo=<c:out value='${currentPage + 1}'/><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" <c:if test='${currentPage == totalPages}'>onclick="return false;"</c:if>>
                                                Sau <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                    </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
