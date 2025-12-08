<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <div class="card-header">
                            <h5><i class="fas fa-list me-2"></i>Danh Sách Người Dùng</h5>
                            <a href="/admin/user/create" class="btn-create">
                                <i class="fas fa-user-plus me-2"></i>Thêm Người Dùng
                            </a>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty users1}">
                                    <div class="empty-state">
                                        <div class="empty-icon">
                                            <i class="fas fa-users"></i>
                                        </div>
                                        <div class="empty-title">Chưa có người dùng nào</div>
                                        <div class="empty-text">Thêm người dùng đầu tiên để bắt đầu</div>
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
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="/admin/user/${user.id}" class="btn-action btn-view" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>Xem
                                                            </a>
                                                            <a href="/admin/user/update/${user.id}" class="btn-action btn-edit" title="Cập nhật">
                                                                <i class="fas fa-edit"></i>Sửa
                                                            </a>
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
