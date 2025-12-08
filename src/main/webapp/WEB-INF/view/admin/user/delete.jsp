<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Xóa Người Dùng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/user/delete.css">
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="page-header">
                        <h1><i class="fas fa-user-slash me-2"></i>Xóa Người Dùng</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                            <li class="breadcrumb-item active">Xóa</li>
                        </ol>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 mx-auto">
                            <div class="delete-card">
                                <div class="delete-header">
                                    <div class="delete-icon"><i class="fas fa-exclamation-triangle"></i></div>
                                    <h3 class="delete-title">Xóa Người Dùng</h3>
                                    <p class="delete-subtitle">Bạn chắc chắn muốn xóa người dùng này không?</p>
                                </div>
                                <div class="delete-body">
                                    <div class="user-avatar">
                                        <c:if test="${not empty user.avatar}">
                                            <img src="/images/avatar/${user.avatar}" alt="User Avatar" />
                                        </c:if>
                                        <c:if test="${empty user.avatar}">
                                            <div style="width: 150px; height: 150px; border-radius: 50%; background: #e5e7eb; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                                <i class="fas fa-user" style="font-size: 3rem; color: #9ca3af;"></i>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="user-info">
                                        <div class="info-row">
                                            <span class="info-label"><i class="fas fa-id-card me-2"></i>ID:</span>
                                            <span class="info-value">${user.id}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label"><i class="fas fa-envelope me-2"></i>Email:</span>
                                            <span class="info-value">${user.email}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label"><i class="fas fa-user me-2"></i>Họ Tên:</span>
                                            <span class="info-value">${user.fullName}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label"><i class="fas fa-phone me-2"></i>Điện Thoại:</span>
                                            <span class="info-value">${user.phone}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label"><i class="fas fa-shield-alt me-2"></i>Vai Trò:</span>
                                            <span class="info-value">${user.role.name}</span>
                                        </div>
                                        <div class="info-row">
                                            <span class="info-label"><i class="fas fa-map-marker-alt me-2"></i>Địa Chỉ:</span>
                                            <span class="info-value">${user.address}</span>
                                        </div>
                                    </div>
                                    <div class="warning-message">
                                        <i class="fas fa-exclamation-circle"></i>
                                        <strong>Lưu ý:</strong> Hành động này không thể hoàn tác. Tất cả dữ liệu của người dùng sẽ bị xóa vĩnh viễn.
                                    </div>
                                    <form:form method="post" action="/admin/user/delete/${id}" modelAttribute="user">
                                        <div style="display: none;">
                                            <form:input value="${id}" type="text" path="id"/>
                                        </div>
                                        <div class="form-actions">
                                            <a href="/admin/user" class="btn-cancel">
                                                <i class="fas fa-times me-2"></i>Hủy
                                            </a>
                                            <button class="btn-confirm" type="submit">
                                                <i class="fas fa-trash-alt me-2"></i>Xác Nhận Xóa
                                            </button>
                                        </div>
                                    </form:form>
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
