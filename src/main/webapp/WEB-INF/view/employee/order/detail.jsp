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
    <title>Order Details - Employee</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Order Details</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/employee">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/employee/order">Orders</a></li>
                    <li class="breadcrumb-item active">Order Details</li>
                </ol>
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>Order Details with id = ${id}</h3>
                        </div>
                        <hr/>
                        <div class="card mb-4" style="width: 60%;">
                            <div class="card-header">
                                Order Information
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">ID: ${order.id}</li>
                                <li class="list-group-item">User: ${order.user.fullName}</li>
                                <li class="list-group-item">Receiver Name: ${order.receiverName}</li>
                                <li class="list-group-item">Receiver Address: ${order.receiverAddress}</li>
                                <li class="list-group-item">Receiver Phone: ${order.receiverPhone}</li>
                                <li class="list-group-item">Status: 
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="badge bg-warning text-dark">PENDING</span>
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPING'}">
                                            <span class="badge bg-info">SHIPPING</span>
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETE'}">
                                            <span class="badge bg-success">COMPLETE</span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCEL'}">
                                            <span class="badge bg-danger">CANCEL</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="list-group-item">Total Price: <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/> VND</li>
                            </ul>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header">
                                Order Items
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Product Name</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <tr>
                                                <td>${orderDetail.product.name}</td>
                                                <td>${orderDetail.quantity}</td>
                                                <td><fmt:formatNumber type="number" value="${orderDetail.price}" /> VND</td>
                                                <td><fmt:formatNumber type="number" value="${orderDetail.price * orderDetail.quantity}" /> VND</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <a href="/employee/order" class="btn btn-success mt-3">Back</a>
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
