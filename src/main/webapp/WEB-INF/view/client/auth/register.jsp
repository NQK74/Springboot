<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="/client/css/auth/register.css">
</head>

<body>
    <div class="register-container">
        <div class="register-left">
            <i class="fas fa-laptop icon-laptop"></i>
            <h2>LaptopShop</h2>
            <p>Tham gia cùng hàng nghìn khách hàng tin tưởng chúng tôi. Đăng ký ngay để nhận nhiều ưu đãi hấp dẫn!</p>
        </div>
        
        <div class="register-right">
            <h3>Tạo tài khoản</h3>
            <p class="subtitle">Điền thông tin để đăng ký tài khoản mới</p>

            <form:form method="post" action="/register" modelAttribute="registerUser">
                <div class="row-name">
                    <div class="form-floating">
                        <form:input type="text" class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}" 
                                    id="firstName" path="firstName" placeholder="Họ" />
                        <label for="firstName"><i class="fas fa-user me-2"></i>Họ</label>
                        <form:errors path="firstName" cssClass="invalid-feedback" />
                    </div>

                    <div class="form-floating">
                        <form:input type="text" class="form-control ${not empty errorLastName ? 'is-invalid' : ''}" 
                                    id="lastName" path="lastName" placeholder="Tên" />
                        <label for="lastName"><i class="fas fa-user me-2"></i>Tên</label>
                        <form:errors path="lastName" cssClass="invalid-feedback" />
                    </div>
                </div>

                <div class="form-floating">
                    <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" 
                                id="email" path="email" placeholder="Email" />
                    <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                    <form:errors path="email" cssClass="invalid-feedback" />
                </div>

                <div class="form-floating">
                    <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid' : ''}" 
                                id="password" path="password" placeholder="Mật khẩu" />
                    <label for="password"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
                    <form:errors path="password" cssClass="invalid-feedback" />
                </div>
                <p class="password-requirements">
                    <i class="fas fa-info-circle me-1"></i>
                    Tối thiểu 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt
                </p>

                <div class="form-floating">
                    <form:input type="password" class="form-control ${not empty errorConfirmPassword ? 'is-invalid' : ''}" 
                                id="confirmPassword" path="confirmPassword" placeholder="Xác nhận mật khẩu" />
                    <label for="confirmPassword"><i class="fas fa-lock me-2"></i>Xác nhận mật khẩu</label>
                    <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                </div>

                <button type="submit" class="btn btn-register">
                    <i class="fas fa-user-plus me-2"></i>Đăng ký
                </button>
            </form:form>

            <div class="divider">
                <span>hoặc</span>
            </div>

            <div class="login-link">
                Đã có tài khoản? <a href="/login">Đăng nhập ngay</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
