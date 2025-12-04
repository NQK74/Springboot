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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .register-container {
            display: flex;
            max-width: 950px;
            width: 100%;
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
        }

        .register-left {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .register-left h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .register-left p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        .register-left .icon-laptop {
            font-size: 80px;
            margin-bottom: 30px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .register-right {
            flex: 1.2;
            padding: 50px;
        }

        .register-right h3 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .register-right .subtitle {
            color: #666;
            margin-bottom: 25px;
        }

        .form-floating {
            margin-bottom: 15px;
        }

        .form-floating input {
            border-radius: 10px;
            border: 2px solid #e1e5ea;
            padding: 15px;
            height: 55px;
            transition: all 0.3s;
        }

        .form-floating input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.15);
        }

        .form-floating input.is-invalid {
            border-color: #dc3545;
        }

        .form-floating label {
            padding: 15px;
        }

        .btn-register {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            margin-top: 10px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .divider {
            text-align: center;
            margin: 20px 0;
            position: relative;
        }

        .divider::before,
        .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 40%;
            height: 1px;
            background: #e1e5ea;
        }

        .divider::before { left: 0; }
        .divider::after { right: 0; }

        .divider span {
            background: #fff;
            padding: 0 15px;
            color: #999;
            font-size: 0.9rem;
        }

        .login-link {
            text-align: center;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .login-link a:hover {
            color: #764ba2;
        }

        .row-name {
            display: flex;
            gap: 15px;
        }

        .row-name .form-floating {
            flex: 1;
        }

        .invalid-feedback {
            font-size: 0.85rem;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: #666;
            margin-top: -10px;
            margin-bottom: 15px;
            padding-left: 5px;
        }

        @media (max-width: 768px) {
            .register-left {
                display: none;
            }
            .register-container {
                max-width: 450px;
            }
            .register-right {
                padding: 40px 30px;
            }
            .row-name {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
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
