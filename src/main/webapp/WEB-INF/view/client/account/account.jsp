<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tài Khoản - LaptopShop</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    
    <link rel="stylesheet" href="/client/css/account/account.css">

</head>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="breadcrumb-blur">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="/">Trang Chủ</a></li>
                        <li class="breadcrumb-item active">Quản Lý Tài Khoản</li>
                    </ol>
                </nav>
            </div>
            <h1>
                <i class="fas fa-user-cog"></i> Quản Lý Tài Khoản
            </h1>
        </div>

        <!-- Account Container -->
        <div class="account-container">
            <!-- Sidebar -->
            <div class="account-sidebar">
                <div class="profile-avatar">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <img src="/images/avatar/${user.avatar}" alt="Avatar" class="avatar-img">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-placeholder">
                                <i class="fas fa-user-circle"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="profile-name">${user.fullName}</div>
                    <div class="profile-email">${user.email}</div>
                </div>

                <ul class="sidebar-menu">
                    <li><a href="/account" class="active"><i class="fas fa-cog"></i> Thông Tin Tài Khoản</a></li>
                    <li><a href="/order-history"><i class="fas fa-history"></i> Lịch Sử Mua Hàng</a></li>
                    <li><a href="/cart"><i class="fas fa-shopping-bag"></i> Giỏ Hàng</a></li>
                    <li><hr style="margin: 10px 0;"></li>
                    <li>
                        <form method="post" action="/logout" style="margin: 0;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="submit" style="width: 100%; background: none; border: none; padding: 12px 15px; text-align: left; cursor: pointer;">
                                <a style="display: flex; align-items: center; gap: 12px; color: #e74c3c; text-decoration: none;">
                                    <i class="fas fa-sign-out-alt"></i> Đăng Xuất
                                </a>
                            </button>
                        </form>
                    </li>
                </ul>
            </div>

            <!-- Main Panel -->
            <div class="account-panel">
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <h2 class="panel-title">
                    <i class="fas fa-edit"></i> Cập Nhật Thông Tin
                </h2>

                <div class="info-card">
                    <i class="fas fa-info-circle"></i>
                    <p>Vui lòng cập nhật thông tin cá nhân của bạn để có trải nghiệp tốt nhất khi sử dụng dịch vụ của chúng tôi.</p>
                </div>

                <form method="post" action="/account" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <!-- Full Name -->
                    <div class="form-group">
                        <label class="form-label" for="fullName">
                            <i class="fas fa-user"></i> Họ Và Tên
                        </label>
                        <div class="input-group">
                            <input 
                                type="text" 
                                class="form-control" 
                                id="fullName" 
                                name="fullName" 
                                value="${user.fullName}" 
                                placeholder="Nhập họ và tên..."
                                required>
                            <span class="input-icon"><i class="fas fa-user"></i></span>
                        </div>
                    </div>

                    <!-- Email (Read Only) -->
                    <div class="form-group">
                        <label class="form-label" for="email">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <div class="input-group">
                            <input 
                                type="email" 
                                class="form-control" 
                                id="email" 
                                name="email" 
                                value="${user.email}" 
                                readonly
                                style="background-color: #f8f9fa; cursor: not-allowed;">
                            <span class="input-icon"><i class="fas fa-envelope"></i></span>
                        </div>
                        <small class="text-muted d-block mt-2">Email không thể thay đổi. Liên hệ hỗ trợ để thay đổi email.</small>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label class="form-label" for="phone">
                            <i class="fas fa-phone"></i> Số Điện Thoại
                        </label>
                        <div class="input-group">
                            <input 
                                type="tel" 
                                class="form-control" 
                                id="phone" 
                                name="phone" 
                                value="${user.phone}" 
                                placeholder="Nhập số điện thoại..."
                                pattern="[0-9]{10,11}"
                                required>
                            <span class="input-icon"><i class="fas fa-phone"></i></span>
                        </div>
                    </div>

                    <!-- Address -->
                    <div class="form-group">
                        <label class="form-label" for="address">
                            <i class="fas fa-map-marker-alt"></i> Địa Chỉ
                        </label>
                        <textarea 
                            class="form-control" 
                            id="address" 
                            name="address" 
                            placeholder="Nhập địa chỉ chi tiết..."
                            required>${user.address}</textarea>
                    </div>

                    <!-- Avatar -->
                    <div class="form-group">
                        <label class="form-label" for="avatarFile">
                            <i class="fas fa-image"></i> Tải Ảnh Đại Diện
                        </label>
                        <c:if test="${not empty user.avatar}">
                            <div class="avatar-preview">
                                <img src="/images/avatar/${user.avatar}" alt="Avatar Preview" class="preview-img">
                                <div class="preview-text">
                                    <div class="label">Ảnh Hiện Tại</div>
                                    <div class="value">${user.avatar}</div>
                                </div>
                            </div>
                        </c:if>
                        <div class="upload-area" id="uploadArea">
                            <input 
                                type="file" 
                                class="form-control d-none" 
                                id="avatarFile" 
                                name="avatarFile" 
                                accept="image/*"
                                onchange="previewImage(event)">
                            <label for="avatarFile" class="upload-label">
                                <div class="upload-icon">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                </div>
                                <div class="upload-text">
                                    <div class="main-text">Kéo ảnh vào đây hoặc <span class="click-text">chọn từ thiết bị</span></div>
                                    <div class="sub-text">Hỗ trợ: JPG, PNG, GIF (Tối đa 5MB)</div>
                                </div>
                            </label>
                        </div>
                        <div id="previewContainer" style="margin-top: 15px; display: none;">
                            <img id="previewImg" src="" alt="Preview" style="max-width: 150px; border-radius: 10px; border: 2px solid #667eea;">
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions">
                        <button type="reset" class="btn-cancel">
                            <i class="fas fa-redo"></i> Nhập Lại
                        </button>
                        <button type="submit" class="btn-update">
                            <i class="fas fa-save"></i> Lưu Thay Đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/account/account.js"></script>
</body>
</html>
