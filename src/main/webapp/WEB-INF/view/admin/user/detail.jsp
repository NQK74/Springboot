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
    <title>Chi Tiết Người Dùng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/user/detail.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="page-header">
                        <h1><i class="fas fa-user-circle me-2"></i>Chi Tiết Người Dùng</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                            <li class="breadcrumb-item active">Chi Tiết</li>
                        </ol>
                    </div>

                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="detail-card">
                                <div class="detail-header">
                                    <h5><i class="fas fa-user me-2"></i>${user.fullName}</h5>
                                </div>
                                <div class="detail-body">
                                    <div class="detail-row">
                                        <div class="user-avatar">
                                            <c:if test="${not empty user.avatar}">
                                                <img src="/images/avatar/${user.avatar}" alt="User Avatar" />
                                            </c:if>
                                            <c:if test="${empty user.avatar}">
                                                <div class="no-avatar">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="detail-row">
                                        <div class="info-group">
                                            <div class="info-label"><i class="fas fa-id-card me-2"></i>ID</div>
                                            <div class="info-value">${user.id}</div>
                                        </div>
                                        <div class="info-group">
                                            <div class="info-label"><i class="fas fa-envelope me-2"></i>Email</div>
                                            <div class="info-value">${user.email}</div>
                                        </div>
                                    </div>

                                    <div class="detail-row">
                                        <div class="info-group">
                                            <div class="info-label"><i class="fas fa-user me-2"></i>Họ Tên</div>
                                            <div class="info-value">${user.fullName}</div>
                                        </div>
                                        <div class="info-group">
                                            <div class="info-label"><i class="fas fa-phone me-2"></i>Điện Thoại</div>
                                            <div class="info-value">${user.phone}</div>
                                        </div>
                                    </div>

                                    <div class="detail-row">
                                        <div class="info-group">
                                            <div class="info-label"><i class="fas fa-shield-alt me-2"></i>Vai Trò</div>
                                            <div class="info-value">
                                                <c:if test="${user.role.name == 'SUPER_ADMIN'}">
                                                    <span class="status-badge" style="background: linear-gradient(135deg, #fef3c7 0%, #fcd34d 100%); color: #92400e;">
                                                        <i class="fas fa-star me-1"></i>${user.role.name}
                                                    </span>
                                                </c:if>
                                                <c:if test="${user.role.name == 'ADMIN'}">
                                                    <span class="status-badge" style="background: linear-gradient(135deg, #fecaca 0%, #fca5a5 100%); color: #b91c1c;">
                                                        <i class="fas fa-crown me-1"></i>${user.role.name}
                                                    </span>
                                                </c:if>
                                                <c:if test="${user.role.name == 'USER'}">
                                                    <span class="status-badge" style="background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%); color: #1e40af;">
                                                        <i class="fas fa-user-check me-1"></i>${user.role.name}
                                                    </span>
                                                </c:if>
                                                <c:if test="${user.role.name == 'STAFF'}">
                                                    <span class="status-badge" style="background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%); color: #047857;">
                                                        <i class="fas fa-user-tie me-1"></i>${user.role.name}
                                                    </span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="info-group">
                                            <div class="info-label"><i class="fas fa-map-marker-alt me-2"></i>Địa Chỉ</div>
                                            <div class="info-value">${user.address}</div>
                                        </div>
                                    </div>

                                    <div class="action-buttons">
                                        <a href="/admin/user" class="btn-action btn-back">
                                            <i class="fas fa-arrow-left"></i>Quay Lại
                                        </a>
                                        <%-- SUPER_ADMIN có thể sửa tất cả --%>
                                        <sec:authorize access="hasRole('SUPER_ADMIN')">
                                            <a href="/admin/user/update/${user.id}" class="btn-action btn-edit">
                                                <i class="fas fa-edit"></i>Chỉnh Sửa
                                            </a>
                                        </sec:authorize>
                                        <%-- ADMIN có thể sửa STAFF và chính mình --%>
                                        <sec:authorize access="hasRole('ADMIN') and !hasRole('SUPER_ADMIN')">
                                            <c:if test="${user.role.name == 'STAFF' or user.id == sessionScope.id}">
                                                <a href="/admin/user/update/${user.id}" class="btn-action btn-edit">
                                                    <i class="fas fa-edit"></i>Chỉnh Sửa
                                                </a>
                                            </c:if>
                                        </sec:authorize>
                                        <a href="/admin/user/delete/${user.id}" class="btn-action btn-delete">
                                            <i class="fas fa-trash-alt"></i>Xóa
                                        </a>
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
