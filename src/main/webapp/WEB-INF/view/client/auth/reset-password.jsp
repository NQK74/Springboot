<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/client/css/auth/reset-password.css">
</head>

<body>
    <div class="reset-container">
        <div class="reset-header">
            <i class="fas fa-key"></i>
            <h2>Đặt lại mật khẩu</h2>
            <p>Nhập mật khẩu mới cho tài khoản của bạn</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <c:if test="${invalidToken}">
            <div class="back-to-login">
                <a href="/forgot-password"><i class="fas fa-redo me-2"></i>Yêu cầu mã mới</a>
            </div>
        </c:if>

        <c:if test="${not invalidToken}">
            <form method="post" action="/reset-password">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Mật khẩu mới" required minlength="8">
                    <label for="password"><i class="fas fa-lock me-2"></i>Mật khẩu mới</label>
                </div>
                <p class="password-requirements">
                    <i class="fas fa-info-circle me-1"></i>
                    Tối thiểu 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt
                </p>

                <div class="form-floating">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                           placeholder="Xác nhận mật khẩu" required minlength="8">
                    <label for="confirmPassword"><i class="fas fa-lock me-2"></i>Xác nhận mật khẩu</label>
                </div>

                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-check me-2"></i>Đặt lại mật khẩu
                </button>
            </form>
        </c:if>

        <div class="back-to-login">
            <a href="/login"><i class="fas fa-arrow-left me-2"></i>Quay lại đăng nhập</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
