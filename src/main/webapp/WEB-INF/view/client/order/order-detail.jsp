<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng - LaptopShop</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <link rel="stylesheet" href="/client/css/order/order-detail.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3), transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(252, 70, 107, 0.3), transparent 50%);
            z-index: -1;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 1;
        }

        .breadcrumb-blur {
            display: inline-block;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 12px 30px;
            border-radius: 50px;
            margin-bottom: 25px;
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
        }

        .breadcrumb-item a {
            color: white;
            text-decoration: none;
            font-weight: 600;
        }

        .breadcrumb-item a:hover {
            color: #ffd700;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            color: white;
            margin-bottom: 15px;
        }

        /* Order Info Card */
        .order-info-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }

        .order-id-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 25px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .status-pending { background: linear-gradient(135deg, #ffeaa7 0%, #fdcb6e 100%); color: #d63031; }
        .status-confirmed { background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%); color: white; }
        .status-shipping { background: linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%); color: white; }
        .status-delivered { background: linear-gradient(135deg, #55efc4 0%, #00b894 100%); color: white; }
        .status-cancelled { background: linear-gradient(135deg, #fab1a0 0%, #e17055 100%); color: white; }

        .info-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .info-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 12px;
            border-left: 4px solid #667eea;
        }

        .info-item label {
            font-weight: 700;
            color: #667eea;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: block;
            margin-bottom: 5px;
        }

        .info-item value {
            font-size: 1.05rem;
            color: #2d3748;
        }

        /* Products Table */
        .products-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .products-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        .products-table thead tr {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .products-table thead th {
            color: white;
            font-weight: 700;
            padding: 18px 15px;
            border: none;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .products-table tbody tr {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .products-table tbody tr:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .products-table tbody td {
            padding: 20px 15px;
            border: none;
            vertical-align: middle;
            color: #4a5568;
        }

        .product-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .product-name {
            font-weight: 700;
            color: #2d3748;
            font-size: 1rem;
        }

        .price-badge {
            display: inline-block;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
            white-space: nowrap;
        }

        .total-row {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 700;
            font-size: 1.3rem;
        }

        .total-row td {
            padding: 20px 15px !important;
            border-radius: 15px;
        }

        /* Summary Section */
        .summary-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .summary-item {
            text-align: center;
            padding: 20px;
            border: 2px solid #f0f0f0;
            border-radius: 15px;
        }

        .summary-item i {
            font-size: 2.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
            display: block;
        }

        .summary-item .label {
            font-size: 0.85rem;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .summary-item .value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2d3748;
        }

        /* Actions */
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }

        .btn-custom {
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back {
            background: white;
            color: #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        .btn-back:hover {
            background: #f8f9fa;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
            color: #667eea;
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .order-header {
                flex-direction: column;
                gap: 15px;
            }

            .page-header h1 {
                font-size: 1.8rem;
            }

            .products-table {
                border-spacing: 0 5px;
            }

            .products-table thead th {
                padding: 12px 8px;
                font-size: 0.75rem;
            }

            .products-table tbody td {
                padding: 15px 8px;
            }

            .actions {
                flex-direction: column;
            }

            .btn-custom {
                justify-content: center;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="breadcrumb-blur">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="/">Trang Chủ</a></li>
                        <li class="breadcrumb-item"><a href="/order-history">Lịch Sử Đơn Hàng</a></li>
                        <li class="breadcrumb-item active">Chi Tiết Đơn Hàng</li>
                    </ol>
                </nav>
            </div>
            <h1>
                <i class="fas fa-receipt"></i> Chi Tiết Đơn Hàng
            </h1>
        </div>

        <!-- Order Info -->
        <div class="order-info-card">
            <div class="order-header">
                <div class="order-id-badge">
                    Đơn Hàng #${order.id}
                </div>
                <div>
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}">
                            <span class="status-badge status-pending">
                                <i class="fas fa-clock"></i> Chờ Xác Nhận
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'CONFIRMED'}">
                            <span class="status-badge status-confirmed">
                                <i class="fas fa-check-circle"></i> Đã Xác Nhận
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'SHIPPING'}">
                            <span class="status-badge status-shipping">
                                <i class="fas fa-truck"></i> Đang Giao
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'DELIVERED'}">
                            <span class="status-badge status-delivered">
                                <i class="fas fa-check"></i> Đã Giao
                            </span>
                        </c:when>
                        <c:when test="${order.status == 'CANCELLED'}">
                            <span class="status-badge status-cancelled">
                                <i class="fas fa-times-circle"></i> Đã Hủy
                            </span>
                        </c:when>
                    </c:choose>
                </div>
            </div>

            <!-- Order Info Details -->
            <div class="info-row">
                <div class="info-item">
                    <label><i class="fas fa-user"></i> Người Nhận</label>
                    <value>${order.receiverName}</value>
                </div>
                <div class="info-item">
                    <label><i class="fas fa-phone"></i> Điện Thoại</label>
                    <value>${order.receiverPhone}</value>
                </div>
                <div class="info-item">
                    <label><i class="fas fa-envelope"></i> Email</label>
                    <value>${order.receiverEmail}</value>
                </div>
                <div class="info-item">
                    <label><i class="fas fa-map-marker-alt"></i> Địa Chỉ Giao</label>
                    <value>${order.receiverAddress}</value>
                </div>
                <div class="info-item">
                    <label><i class="fas fa-credit-card"></i> Phương Thức Thanh Toán</label>
                    <value>${order.paymentMethod}</value>
                </div>
                <div class="info-item">
                    <label><i class="fas fa-sticky-note"></i> Ghi Chú</label>
                    <value>${not empty order.note ? order.note : 'Không có'}</value>
                </div>
            </div>
        </div>

        <!-- Products Section -->
        <div class="products-section">
            <h2 class="section-title">
                <i class="fas fa-shopping-bag"></i> Sản Phẩm Trong Đơn Hàng
            </h2>

            <table class="products-table">
                <thead>
                    <tr>
                        <th style="width: 10%;">STT</th>
                        <th style="width: 45%;">Tên Sản Phẩm</th>
                        <th style="width: 15%;">Số Lượng</th>
                        <th style="width: 15%;">Giá</th>
                        <th style="width: 15%;">Thành Tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="count" value="0" />
                    <c:set var="totalAmount" value="0" />
                    <c:forEach var="detail" items="${orderDetails}">
                        <c:set var="count" value="${count + 1}" />
                        <c:set var="itemTotal" value="${detail.price * detail.quantity}" />
                        <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                        <tr>
                            <td><strong>${count}</strong></td>
                            <td>
                                <div class="product-info">
                                    <div>
                                        <div class="product-name">${detail.product.name}</div>
                                    </div>
                                </div>
                            </td>
                            <td><strong>${detail.quantity}</strong></td>
                            <td>
                                <span class="price-badge">
                                    <fmt:formatNumber type="number" value="${detail.price}" /> đ
                                </span>
                            </td>
                            <td>
                                <span class="price-badge">
                                    <fmt:formatNumber type="number" value="${itemTotal}" /> đ
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr class="total-row">
                        <td colspan="4" style="text-align: right;">TỔNG CỘNG:</td>
                        <td>
                            <fmt:formatNumber type="number" value="${totalAmount}" /> đ
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Summary Section -->
        <div class="summary-section">
            <div class="summary-item">
                <i class="fas fa-boxes"></i>
                <div class="label">Tổng Sản Phẩm</div>
                <div class="value">${orderDetails.size()}</div>
            </div>
            <div class="summary-item">
                <i class="fas fa-money-bill-wave"></i>
                <div class="label">Tổng Giá Trị</div>
                <div class="value">
                    <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                </div>
            </div>
            <div class="summary-item">
                <i class="fas fa-info-circle"></i>
                <div class="label">Trạng Thái</div>
                <div class="value">${order.status}</div>
            </div>
        </div>

        <!-- Actions -->
        <div class="actions">
            <a href="/order-history" class="btn-custom btn-back">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
            <c:if test="${order.status == 'PENDING'}">
                <form method="post" action="/order-delete/${order.id}" style="display: inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="btn-custom btn-delete" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                        <i class="fas fa-trash-alt"></i> Hủy Đơn Hàng
                    </button>
                </form>
            </c:if>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
