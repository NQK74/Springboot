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
    <title>Tạo Người Dùng - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/user/create.css">
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            
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
                        <h1><i class="fas fa-user-plus me-2"></i>Tạo Người Dùng Mới</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                            <li class="breadcrumb-item active">Tạo Mới</li>
                        </ol>
                    </div>

                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="form-card">
                                <div class="form-header">
                                    <h5><i class="fas fa-user-check me-2"></i>Thêm Người Dùng Mới</h5>
                                </div>
                                
                                <div class="form-body">
                                    <form:form method="post" action="/admin/user/create" modelAttribute="newUser" enctype="multipart/form-data">
                                        <div class="form-section-title"><i class="fas fa-info-circle me-2"></i>Thông Tin Cơ Bản</div>
                                        <div class="form-row">
                                            <div class="form-group">
                                                <c:set var="errorEmail">
                                                    <form:errors path="email" cssClass="invalid-feedback" />
                                                </c:set>
                                                <label for="email" class="form-label"><i class="fas fa-envelope me-2"></i>Email <span style="color: #dc3545;">*</span></label>
                                                <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" path="email" placeholder="Nhập email"/>
                                                ${errorEmail}
                                            </div>

                                            <div class="form-group">
                                                <c:set var="errorPassword">
                                                    <form:errors path="password" cssClass="invalid-feedback" />
                                                </c:set>
                                                <label for="password" class="form-label"><i class="fas fa-lock me-2"></i>Mật khẩu <span style="color: #dc3545;">*</span></label>
                                                <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid' : ''}" path="password" placeholder="Nhập mật khẩu"/>
                                                ${errorPassword}
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <c:set var="errorFullName">
                                                    <form:errors path="fullName" cssClass="invalid-feedback" />
                                                </c:set>
                                                <label for="fullName" class="form-label"><i class="fas fa-user me-2"></i>Họ Tên <span style="color: #dc3545;">*</span></label>
                                                <form:input type="text" class="form-control ${not empty errorFullName ? 'is-invalid' : ''}" path="fullName" placeholder="Nhập họ tên"/>
                                                ${errorFullName}
                                            </div>

                                            <div class="form-group">
                                                <label for="phone" class="form-label"><i class="fas fa-phone me-2"></i>Điện Thoại</label>
                                                <form:input type="text" class="form-control" path="phone" placeholder="Nhập số điện thoại"/>
                                            </div>
                                        </div>

                                        <div class="form-row full">
                                            <div class="form-group">
                                                <label for="address" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Địa Chỉ</label>
                                                <form:input type="text" class="form-control" path="address" placeholder="Nhập địa chỉ"/>
                                            </div>
                                        </div>

                                        <div class="form-section-title"><i class="fas fa-cogs me-2"></i>Cấu Hình</div>
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="role" class="form-label"><i class="fas fa-shield-alt me-2"></i>Vai Trò <span style="color: #dc3545;">*</span></label>
                                                <form:select class="form-select" path="role.name">
                                                    <form:option value="USER">Người Dùng (USER)</form:option>
                                                    <form:option value="STAFF">Nhân Viên (STAFF)</form:option>
                                                    <sec:authorize access="hasRole('SUPER_ADMIN')">
                                                        <form:option value="ADMIN">Quản Trị Viên (ADMIN)</form:option>
                                                        <form:option value="SUPER_ADMIN">Super Admin (SUPER_ADMIN)</form:option>
                                                    </sec:authorize>
                                                </form:select>
                                            </div>
                                        </div>

                                        <div class="form-section-title"><i class="fas fa-image me-2"></i>Hình Ảnh Đại Diện</div>
                                        <div class="avatar-upload-wrapper">
                                            <div class="file-input-group">
                                                <input type="file" id="avatarFile" accept=".png, .jpg, .jpeg, .webp" name="khanhFile"/>
                                                <label for="avatarFile" class="file-input-label">
                                                    <i class="fas fa-cloud-upload-alt"></i>
                                                    <span>Chọn hình ảnh đại diện</span>
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
                                                <i class="fas fa-save"></i>Tạo Người Dùng
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
