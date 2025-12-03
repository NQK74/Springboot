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
    <title>Product Details</title>
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
                <h1 class="mt-4">Product Details</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Product Details</li>
                </ol>
                        <div class="row">
            <div class="col-12 mx-auto">
                <div class="d-flex justify-content-between align-items-center">
                    <h3>Product Details with id = ${id}</h3>
                </div>
                <hr/>
                <div class="card" style="width: 60%;">
                <div class="card-body text-center">
                    <c:if test="${not empty product.image}">
                        <img src="/images/product/${product.image}" alt="${product.name}" class="img-fluid mb-3" style="max-width: 300px; border-radius: 8px;">
                    </c:if>
                </div>
                <div class="card-header">
                    Product Information
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">ID: ${id}</li>
                    <li class="list-group-item">Full Name: ${product.name}</li>
                    <li class="list-group-item">Price: <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> VND</li>
                </ul>
                </div>
                <a href="/admin/product" class="btn btn-success mt-3">Back</a>
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
