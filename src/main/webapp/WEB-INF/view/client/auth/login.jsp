<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="/client/css/auth/login.css">
</head>

<body>
    <div class="login-container">
        <div class="login-left">
            <i class="fas fa-laptop icon-laptop"></i>
            <h2>LaptopShop</h2>
            <p>Chào mừng bạn đến với cửa hàng laptop hàng đầu Việt Nam. Chúng tôi cung cấp các sản phẩm chất lượng với giá cả cạnh tranh nhất.</p>
        </div>
        
        <div class="login-right">
            <h3>Đăng nhập</h3>
            <p class="subtitle">Chào mừng bạn quay trở lại!</p>

            <c:if test="${param.error != null}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    Email hoặc mật khẩu không đúng!
                </div>
            </c:if>

            <c:if test="${param.logout != null}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    Đăng xuất thành công!
                </div>
            </c:if>

            <c:if test="${param.registerSuccess != null}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    Đăng ký thành công! Vui lòng đăng nhập.
                </div>
            </c:if>

            <c:if test="${param.resetSuccess != null}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    Mật khẩu đã được đặt lại thành công! Vui lòng đăng nhập với mật khẩu mới.
                </div>
            </c:if>

            <form method="post" action="/login">
                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="username" placeholder="Email" required>
                    <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                </div>

                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                    <label for="password"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <button type="submit" class="btn btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                </button>
            </form>

            <div class="divider">
                <span>hoặc</span>
            </div>

            <div class="register-link">
                <a href="/forgot-password"><i class="fas fa-key me-1"></i>Quên mật khẩu?</a>
            </div>

            <div class="register-link" style="margin-top: 10px;">
                Chưa có tài khoản? <a href="/register">Đăng ký ngay</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
