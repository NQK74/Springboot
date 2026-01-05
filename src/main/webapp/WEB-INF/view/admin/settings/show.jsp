<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Cài Đặt Hệ Thống - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .settings-container {
            padding: 20px;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-header h1 {
            color: #1e293b;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            padding: 25px;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }
        
        .stat-card.products {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        
        .stat-card.orders {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        .stat-card .stat-icon {
            font-size: 2.5rem;
            opacity: 0.8;
            margin-bottom: 10px;
        }
        
        .stat-card .stat-value {
            font-size: 2rem;
            font-weight: 700;
        }
        
        .stat-card .stat-label {
            opacity: 0.9;
            font-size: 0.95rem;
        }
        
        .settings-section {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            overflow: hidden;
        }
        
        .section-header {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            padding: 20px 25px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .section-header i {
            font-size: 1.25rem;
            color: #6366f1;
        }
        
        .section-header h5 {
            margin: 0;
            font-weight: 600;
            color: #1e293b;
        }
        
        .section-body {
            padding: 25px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            outline: none;
        }
        
        .form-check {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px;
            background: #f8fafc;
            border-radius: 10px;
            margin-bottom: 12px;
        }
        
        .form-check-input {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        
        .form-check-label {
            font-weight: 500;
            color: #374151;
            cursor: pointer;
        }
        
        .btn-save {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(99, 102, 241, 0.4);
        }
        
        .alert-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-box {
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            border-left: 4px solid #3b82f6;
            padding: 15px 20px;
            border-radius: 0 10px 10px 0;
            margin-top: 15px;
        }
        
        .info-box i {
            color: #3b82f6;
            margin-right: 8px;
        }
        
        .info-box p {
            margin: 0;
            color: #1e40af;
            font-size: 0.9rem;
        }
        
        .payment-option {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 20px;
            background: #f8fafc;
            border-radius: 12px;
            margin-bottom: 12px;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .payment-option:hover {
            border-color: #6366f1;
            background: white;
        }
        
        .payment-option .payment-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .payment-option .payment-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }
        
        .payment-option .payment-icon.cod {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #d97706;
        }
        
        .payment-option .payment-icon.vnpay {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: #2563eb;
        }
        
        .payment-option .payment-icon.banking {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
            color: #16a34a;
        }
        
        .payment-option .payment-name {
            font-weight: 600;
            color: #1e293b;
        }
        
        .payment-option .payment-desc {
            font-size: 0.85rem;
            color: #64748b;
        }
        
        .toggle-switch {
            position: relative;
            width: 50px;
            height: 26px;
        }
        
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        
        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #cbd5e1;
            transition: .3s;
            border-radius: 26px;
        }
        
        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .3s;
            border-radius: 50%;
        }
        
        .toggle-switch input:checked + .toggle-slider {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
        }
        
        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(24px);
        }
    </style>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid settings-container">
                <!-- Page Header -->
                <div class="page-header">
                    <h1><i class="fas fa-cog me-2"></i>Cài Đặt Hệ Thống</h1>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Cài Đặt</li>
                    </ol>
                </div>
                
                <!-- Success Message -->
                <c:if test="${not empty successMessage}">
                    <div class="alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${successMessage}
                    </div>
                </c:if>
                
                <!-- Stats Overview -->
                <div class="stats-row">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-users"></i></div>
                        <div class="stat-value">${totalUsers}</div>
                        <div class="stat-label">Tổng Người Dùng</div>
                    </div>
                    <div class="stat-card products">
                        <div class="stat-icon"><i class="fas fa-box"></i></div>
                        <div class="stat-value">${totalProducts}</div>
                        <div class="stat-label">Tổng Sản Phẩm</div>
                    </div>
                    <div class="stat-card orders">
                        <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
                        <div class="stat-value">${totalOrders}</div>
                        <div class="stat-label">Tổng Đơn Hàng</div>
                    </div>
                </div>
                
                <!-- Site Settings -->
                <div class="settings-section">
                    <div class="section-header">
                        <i class="fas fa-globe"></i>
                        <h5>Thông Tin Website</h5>
                    </div>
                    <div class="section-body">
                        <form action="/admin/settings/update-site" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Tên Website</label>
                                        <input type="text" class="form-control" name="siteName" value="LaptopShop" placeholder="Nhập tên website">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Email Liên Hệ</label>
                                        <input type="email" class="form-control" name="siteEmail" value="contact@laptopshop.com" placeholder="Nhập email liên hệ">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Số Điện Thoại</label>
                                        <input type="tel" class="form-control" name="sitePhone" value="0398794461" placeholder="Nhập số điện thoại">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Địa Chỉ</label>
                                        <input type="text" class="form-control" name="siteAddress" value="Đà Nẵng, Việt Nam" placeholder="Nhập địa chỉ">
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn-save">
                                <i class="fas fa-save"></i> Lưu Thay Đổi
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Payment Settings -->
                <div class="settings-section">
                    <div class="section-header">
                        <i class="fas fa-credit-card"></i>
                        <h5>Cài Đặt Thanh Toán</h5>
                    </div>
                    <div class="section-body">
                        <form action="/admin/settings/update-payment" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
                            <div class="payment-option">
                                <div class="payment-info">
                                    <div class="payment-icon cod">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <div>
                                        <div class="payment-name">Thanh Toán Khi Nhận Hàng (COD)</div>
                                        <div class="payment-desc">Khách hàng thanh toán khi nhận được hàng</div>
                                    </div>
                                </div>
                                <label class="toggle-switch">
                                    <input type="checkbox" name="enableCod" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            
                            <div class="payment-option">
                                <div class="payment-info">
                                    <div class="payment-icon vnpay">
                                        <i class="fas fa-qrcode"></i>
                                    </div>
                                    <div>
                                        <div class="payment-name">VNPay</div>
                                        <div class="payment-desc">Thanh toán online qua ví điện tử VNPay</div>
                                    </div>
                                </div>
                                <label class="toggle-switch">
                                    <input type="checkbox" name="enableVnpay" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            
                            <div class="payment-option">
                                <div class="payment-info">
                                    <div class="payment-icon banking">
                                        <i class="fas fa-university"></i>
                                    </div>
                                    <div>
                                        <div class="payment-name">Chuyển Khoản Ngân Hàng</div>
                                        <div class="payment-desc">Khách hàng chuyển khoản trực tiếp</div>
                                    </div>
                                </div>
                                <label class="toggle-switch">
                                    <input type="checkbox" name="enableBanking">
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            
                            <button type="submit" class="btn-save mt-3">
                                <i class="fas fa-save"></i> Lưu Cài Đặt Thanh Toán
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Order Settings -->
                <div class="settings-section">
                    <div class="section-header">
                        <i class="fas fa-shopping-bag"></i>
                        <h5>Cài Đặt Đơn Hàng</h5>
                    </div>
                    <div class="section-body">
                        <form action="/admin/settings/update-order" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="autoConfirmVnpay" name="autoConfirmVnpay" checked>
                                <label class="form-check-label" for="autoConfirmVnpay">
                                    <i class="fas fa-bolt text-warning me-2"></i>
                                    Tự động xác nhận đơn hàng khi thanh toán qua VNPay
                                </label>
                            </div>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="autoMarkPaid" name="autoMarkPaid" checked disabled>
                                <label class="form-check-label" for="autoMarkPaid">
                                    <i class="fas fa-check-double text-success me-2"></i>
                                    Tự động đánh dấu "Đã thanh toán" cho đơn hàng VNPay
                                </label>
                            </div>
                            
                            <div class="info-box">
                                <i class="fas fa-info-circle"></i>
                                <p>Các đơn hàng thanh toán qua VNPay sẽ tự động được xác nhận và đánh dấu đã thanh toán. Đơn hàng COD sẽ ở trạng thái "Chờ xác nhận" và "Chưa thanh toán" cho đến khi admin cập nhật.</p>
                            </div>
                            
                            <button type="submit" class="btn-save mt-3">
                                <i class="fas fa-save"></i> Lưu Cài Đặt Đơn Hàng
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- System Info -->
                <div class="settings-section">
                    <div class="section-header">
                        <i class="fas fa-server"></i>
                        <h5>Thông Tin Hệ Thống</h5>
                    </div>
                    <div class="section-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Phiên Bản</label>
                                    <input type="text" class="form-control" value="1.0.0" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Framework</label>
                                    <input type="text" class="form-control" value="Spring Boot 3.x" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Database</label>
                                    <input type="text" class="form-control" value="MySQL" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Java Version</label>
                                    <input type="text" class="form-control" value="17" readonly>
                                </div>
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
<script src="/js/scripts.js"></script>
</body>
</html>
