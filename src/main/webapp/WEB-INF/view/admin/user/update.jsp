<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Cập Nhật Người Dùng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/user/update.css">
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            const currentAvatar = "${user.avatar}";
            
            // Hiển thị hình ảnh hiện tại nếu có
            if (currentAvatar) {
                $("#avatarPreview").attr("src", "/images/avatar/" + currentAvatar);
                $(".image-preview-container").show();
            }
            
            avatarFile.change(function (e) {
                if (e.target.files && e.target.files[0]) {
                    const file = e.target.files[0];
                    if (file.type.startsWith('image/')) {
                        const imgURL = URL.createObjectURL(file);
                        $("#avatarPreview").attr("src", imgURL);
                        $(".image-preview-container").show();
                    } else {
                        alert("Vui lòng chọn file hình ảnh!");
                    }
                }
            });
        });
    </script>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="page-header">
                        <h1><i class="fas fa-user-edit me-2"></i>Cập Nhật Người Dùng</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                            <li class="breadcrumb-item active">Cập Nhật</li>
                        </ol>
                    </div>

                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="form-card">
                                <div class="form-header">
                                    <h5><i class="fas fa-user-circle me-2"></i>Chỉnh Sửa Thông Tin Người Dùng</h5>
                                </div>
                                
                                <div class="form-body">
                                    <div class="user-info-badge">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>ID:</strong> ${user.id} | <strong>Email:</strong> ${user.email}
                                    </div>

                                    <form:form method="post" action="/admin/user/update/${user.id}" modelAttribute="user" enctype="multipart/form-data">
                                        <div style="display: none;">
                                            <form:input type="text" path="id"/>
                                        </div>

                                        <div class="form-section-title"><i class="fas fa-info-circle me-2"></i>Thông Tin Cơ Bản</div>
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="email" class="form-label"><i class="fas fa-envelope me-2"></i>Email</label>
                                                <form:input type="email" class="form-control" path="email" disabled="true" />
                                                <small class="text-muted"><i class="fas fa-lock me-1"></i>Email không thể thay đổi</small>
                                            </div>

                                            <div class="form-group">
                                                <label for="phone" class="form-label"><i class="fas fa-phone me-2"></i>Điện Thoại</label>
                                                <form:input type="text" class="form-control" path="phone" placeholder="Nhập số điện thoại"/>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="fullName" class="form-label"><i class="fas fa-user me-2"></i>Họ Tên</label>
                                                <form:input type="text" class="form-control" path="fullName" placeholder="Nhập họ tên"/>
                                            </div>

                                            <div class="form-group">
                                                <label for="role" class="form-label"><i class="fas fa-shield-alt me-2"></i>Vai Trò</label>
                                                <form:select class="form-select" path="role.name">
                                                    <%-- SUPER_ADMIN có thể chọn tất cả vai trò --%>
                                                    <sec:authorize access="hasRole('SUPER_ADMIN')">
                                                        <form:option value="USER">Người Dùng (USER)</form:option>
                                                        <form:option value="STAFF">Nhân Viên (STAFF)</form:option>
                                                        <form:option value="ADMIN">Quản Trị Viên (ADMIN)</form:option>
                                                        <form:option value="SUPER_ADMIN">Super Admin (SUPER_ADMIN)</form:option>
                                                    </sec:authorize>
                                                    <%-- ADMIN chỉ có thể chọn STAFF hoặc USER (không thể thay đổi khi sửa chính mình) --%>
                                                    <sec:authorize access="hasRole('ADMIN') and !hasRole('SUPER_ADMIN')">
                                                        <c:choose>
                                                            <c:when test="${user.id == sessionScope.id}">
                                                                <%-- Khi sửa chính mình, chỉ hiển thị vai trò hiện tại --%>
                                                                <form:option value="${user.role.name}">${user.role.name}</form:option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <%-- Khi sửa STAFF, có thể chọn USER hoặc STAFF --%>
                                                                <form:option value="USER">Người Dùng (USER)</form:option>
                                                                <form:option value="STAFF">Nhân Viên (STAFF)</form:option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </sec:authorize>
                                                </form:select>
                                            </div>
                                        </div>

                                        <div class="form-row full">
                                            <div class="form-group">
                                                <label for="address" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Địa Chỉ</label>
                                                <form:input type="text" class="form-control" path="address" placeholder="Nhập địa chỉ"/>
                                            </div>
                                        </div>

                                        <div class="form-section-title"><i class="fas fa-image me-2"></i>Hình Ảnh Đại Diện</div>
                                        <div class="avatar-upload-wrapper">
                                            <div class="file-input-group">
                                                <input type="file" id="avatarFile" accept=".png, .jpg, .jpeg, .webp" name="khanhFile"/>
                                                <label for="avatarFile" class="file-input-label">
                                                    <i class="fas fa-cloud-upload-alt"></i>
                                                    <span>Chọn hình ảnh đại diện mới</span>
                                                </label>
                                            </div>
                                            <div class="image-preview-container">
                                                <small><i class="fas fa-check-circle me-2"></i>Hình ảnh đã chọn</small>
                                                <img id="avatarPreview" alt="avatarPreview" />
                                            </div>
                                        </div>

                                        <div class="button-group">
                                            <a href="/admin/user" class="btn-action btn-back">
                                                <i class="fas fa-arrow-left"></i>Quay Lại
                                            </a>
                                            <button type="submit" class="btn-action btn-submit">
                                                <i class="fas fa-save"></i>Cập Nhật
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
