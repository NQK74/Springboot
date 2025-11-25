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
    <title>Update Order</title>
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
                <h1 class="mt-4">Update Order</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/order">Orders</a></li>
                    <li class="breadcrumb-item active">Update Order</li>
                </ol>
                <div class="row">
                    <div class="col-md-6 col-12 mx-auto">
                        <h3>Update Order Status</h3>
                        <hr/>

                        <div class="card mb-4">
                            <div class="card-header">
                                Order Information
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">ID: ${order.id}</li>
                                <li class="list-group-item">User: ${order.user.fullName}</li>
                                <li class="list-group-item">Receiver Name: ${order.receiverName}</li>
                                <li class="list-group-item">Receiver Address: ${order.receiverAddress}</li>
                                <li class="list-group-item">Receiver Phone: ${order.receiverPhone}</li>
                                <li class="list-group-item">Total Price: <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/> VND</li>
                            </ul>
                        </div>

                        <form method="post" action="/admin/order/update/${order.id}">
                            <div class="mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status">
                                    <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                    <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>SHIPPING</option>
                                    <option value="COMPLETE" ${order.status == 'COMPLETE' ? 'selected' : ''}>COMPLETE</option>
                                    <option value="CANCEL" ${order.status == 'CANCEL' ? 'selected' : ''}>CANCEL</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary">Submit</button>
                                <a href="/admin/order" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
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
