<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Create Product</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    $(document).ready(() => {
    const imageFile = $("#imageFile");
    imageFile.change(function (e) {
        const imgURL = URL.createObjectURL(e.target.files[0]);
        $("#imagePreview").attr("src", imgURL);
        $("#imagePreview").css({ "display": "block" });
        });
    });
    </script>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp" />
    
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Products</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Create Products</li>
                </ol>
        <div class="row">
            <div class="col-md-6 col-12 mx-auto">
                <h3>Create a Product</h3> <hr/>
                <form:form method="post" action="/admin/product/create" modelAttribute="newProduct" class="row"
                enctype="multipart/form-data">
                  
                    <c:set var="errorName" >
                        <form:errors path="name" cssClass="invalid-feedback" />
                    </c:set>
                    
                    <c:set var="errorPrice" >
                        <form:errors path="price" cssClass="invalid-feedback" />
                    </c:set>

                    <c:set var="errorDetailDesc" >
                        <form:errors path="detailDesc" cssClass="invalid-feedback" />
                    </c:set>

                    <c:set var="errorShortDesc" >
                        <form:errors path="shortDesc" cssClass="invalid-feedback" />
                    </c:set>

                    <c:set var="errorQuantity" >
                        <form:errors path="quantity" cssClass="invalid-feedback" />
                    </c:set>
                
                    <div class="mb-3 col-12 col-md-6" >
                        <label for="name" class="form-label">Name</label>
                        <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="name" />
                        ${errorName}
                    </div>

                    <div class="mb-3 col-12 col-md-6" >
                        <label for="price" class="form-label">Price</label>
                        <form:input type="number" class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" path="price"/>
                        ${errorPrice}
                    </div>

                    <div class="mb-3 col-12">
                        <label for="detailDesc" class="form-label">Detail description</label>
                        <form:textarea type="text" class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" path="detailDesc"/>
                        ${errorDetailDesc}
                    </div>

                    <div class="mb-3 col-12 col-md-6" >
                        <label for="shortDesc" class="form-label">Short Description</label>
                        <form:input type="text" class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" path="shortDesc" />
                        ${errorShortDesc}
                    </div>

                    <div class="mb-3 col-12 col-md-6" >
                        <label for="quantity" class="form-label">Quantity</label>
                        <form:input type="text" class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" path="quantity"/>
                        ${errorQuantity}
                    </div>

                    <div class="mb-3 col-12 col-md-6">
                    <label for="factory" class="form-label">Factory</label>
                        <form:select class="form-select" path="factory" >
                            <form:option value="APPLE">Apple(MacBook)</form:option>
                            <form:option value="ASUS">Asus</form:option>
                            <form:option value="LENOVO">Lenovo</form:option>
                            <form:option value="ACER">Acer</form:option>
                            <form:option value="DELL">Dell</form:option>
                            <form:option value="LG">LG</form:option>
                            <form:option value="HP">HP</form:option>
                        </form:select>
                    </div>

                    <div class="mb-3 col-12 col-md-6">
                    <label for="target" class="form-label">Target</label>
                        <form:select class="form-select" path="target" >
                            <form:option value="GAMING">Gaming</form:option>
                            <form:option value="SINHVIEN-VANPHONG">Sinh Viên - Văn Phòng</form:option>
                            <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                            <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                            <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                        </form:select>
                    </div>

                    <div class="mb-3 col-12 col-md-6">
                    <label for="imageFile" class="form-label">Image</label>
                    <input class="form-control" type="file" id="imageFile" accept=" .png, .jpg, .jpeg, .webp" name = "imageFile"/>
                    </div>

                    <div class="mb-3 col-12">
                    <img id="imagePreview" alt="imagePreview" style="max-width: 250px; display: none;" />
                    </div>

                    <div class="mb-3 col-12">
                    <button type="submit" class="btn btn-primary">Create</button>
                    </div>
                </form:form>
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
