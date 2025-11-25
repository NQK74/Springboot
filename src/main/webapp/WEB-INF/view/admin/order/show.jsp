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
    <title>LaptopShop</title>
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
                <h1 class="mt-4">Manage Orders</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Manage Orders</li>
                </ol>
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>Table Orders</h3>
                        </div>
                        <hr/>
                        
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">User</th>
                                    <th scope="col">Receiver Name</th>
                                    <th scope="col">Receiver Phone</th>
                                    <th scope="col">Total Price</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <th>${order.id}</th>
                                        <td>${order.user.fullName}</td>
                                        <td>${order.receiverName}</td>
                                        <td>${order.receiverPhone}</td>
                                        <td>
                                            <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                        </td>
                                        <td>
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
                                        </td>
                                        <td>
                                            <a href="/admin/order/${order.id}" class="btn btn-success">View</a>
                                            <a href="/admin/order/update/${order.id}" class="btn btn-warning mx-2">Update</a>
                                            <a href="/admin/order/delete/${order.id}" class="btn btn-danger">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
