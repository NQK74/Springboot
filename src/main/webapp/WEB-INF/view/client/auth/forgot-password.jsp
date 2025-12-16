<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/client/css/auth/forgot-password.css">
</head>

<body>
    <div class="forgot-container">
        <div class="forgot-header">
            <c:choose>
                <c:when test="${showOtpForm}">
                    <i class="fas fa-key"></i>
                    <h2>Nhập mã xác nhận</h2>
                    <p>Nhập mã 6 số đã được gửi đến email của bạn</p>
                </c:when>
                <c:otherwise>
                    <i class="fas fa-lock"></i>
                    <h2>Quên mật khẩu?</h2>
                    <p>Nhập email của bạn để nhận mã xác nhận</p>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${showOtpForm}">
                <!-- OTP Form -->
                <div class="otp-info">
                    Mã xác nhận đã được gửi đến <strong>${email}</strong>
                </div>

                <form method="post" action="/verify-otp" id="otpForm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    
                    <div class="otp-inputs">
                        <input type="text" maxlength="1" class="otp-digit" data-index="0" inputmode="numeric" pattern="[0-9]*" required>
                        <input type="text" maxlength="1" class="otp-digit" data-index="1" inputmode="numeric" pattern="[0-9]*" required>
                        <input type="text" maxlength="1" class="otp-digit" data-index="2" inputmode="numeric" pattern="[0-9]*" required>
                        <input type="text" maxlength="1" class="otp-digit" data-index="3" inputmode="numeric" pattern="[0-9]*" required>
                        <input type="text" maxlength="1" class="otp-digit" data-index="4" inputmode="numeric" pattern="[0-9]*" required>
                        <input type="text" maxlength="1" class="otp-digit" data-index="5" inputmode="numeric" pattern="[0-9]*" required>
                    </div>
                    <input type="hidden" name="otp" id="otpValue">

                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-check me-2"></i>Xác nhận
                    </button>
                </form>

                <div class="resend-link">
                    <a href="/forgot-password"><i class="fas fa-redo me-1"></i>Gửi lại mã</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Email Form -->
                <form method="post" action="/forgot-password">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="form-floating">
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="Email" required>
                        <label for="email"><i class="fas fa-envelope me-2"></i>Địa chỉ email</label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-paper-plane me-2"></i>Gửi mã xác nhận
                    </button>
                </form>
            </c:otherwise>
        </c:choose>

        <div class="back-to-login">
            <a href="/login"><i class="fas fa-arrow-left me-2"></i>Quay lại đăng nhập</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/auth/forgot-password.js"></script>
</body>

</html>
