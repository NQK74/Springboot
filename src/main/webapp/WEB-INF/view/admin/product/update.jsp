<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="NQK74- LaptopShop" />
    <meta name="author" content="NQK74- LaptopShop" />
    <title>Cập Nhật Sản Phẩm - LaptopShop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/product/update.css">
    <script>
        $(document).ready(() => {
            const imageFile = $("#imageFile");
            const currentImage = "${existingProduct.image}";
            
            // Hiển thị hình ảnh hiện tại nếu có
            if (currentImage) {
                $("#imagePreview").attr("src", "/images/product/" + currentImage);
                $(".image-preview-container").show();
            }
            
            imageFile.change(function (e) {
                if (e.target.files && e.target.files[0]) {
                    const file = e.target.files[0];
                    if (file.type.startsWith('image/')) {
                        const imgURL = URL.createObjectURL(file);
                        $("#imagePreview").attr("src", imgURL);
                        $(".image-preview-container").show();
                    } else {
                        alert("Vui lòng chọn file hình ảnh!");
                    }
                }
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
                    <div class="page-header">
                        <h1><i class="fas fa-edit me-2"></i>Cập Nhật Sản Phẩm</h1>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="/admin/product">Sản Phẩm</a></li>
                            <li class="breadcrumb-item active">Cập Nhật</li>
                        </ol>
                    </div>

                    <div class="row">
                        <div class="col-lg-10 mx-auto">
                            <div class="form-card">
                                <div class="form-header">
                                    <h5><i class="fas fa-pencil-alt me-2"></i>${existingProduct.name}</h5>
                                </div>
                                
                                <div class="form-body">
                                    <div class="product-info-badge">
                                        <strong><i class="fas fa-info-circle me-2"></i>ID Sản Phẩm:</strong> #${existingProduct.id}
                                    </div>

                                    <form:form method="post" action="/admin/product/update/${existingProduct.id}" modelAttribute="existingProduct" enctype="multipart/form-data">
                                        <!-- Thông Tin Cơ Bản -->
                                        <div class="form-section-title">
                                            <i class="fas fa-info-circle me-2"></i>Thông Tin Cơ Bản
                                        </div>

                                        <div class="form-row">
                                            <c:set var="errorName">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <div class="form-group">
                                                <label for="name" class="form-label"><i class="fas fa-tag me-2"></i>Tên Sản Phẩm <span style="color: #dc3545;">*</span></label>
                                                <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="name" />
                                                ${errorName}
                                            </div>

                                            <c:set var="errorPrice">
                                                <form:errors path="price" cssClass="invalid-feedback" />
                                            </c:set>
                                            <div class="form-group">
                                                <label for="price" class="form-label"><i class="fas fa-dollar-sign me-2"></i>Giá <span style="color: #dc3545;">*</span>
                                                </label>
                                                <form:input type="number" step="0.01" class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" path="price"/>
                                                ${errorPrice}
                                            </div>
                                        </div>

                                        <c:set var="errorQuantity">
                                            <form:errors path="quantity" cssClass="invalid-feedback" />
                                        </c:set>
                                        <div class="form-group">
                                            <label for="quantity" class="form-label"><i class="fas fa-boxes me-2"></i>Số Lượng <span style="color: #dc3545;">*</span></label>
                                            <form:input type="number" class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" path="quantity"/>

                                            ${errorQuantity}
                                        </div>

                                        <!-- Mô Tả -->
                                        <div class="form-section-title">
                                            <i class="fas fa-align-left me-2"></i>Mô Tả Sản Phẩm
                                        </div>

                                        <c:set var="errorShortDesc">
                                            <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                        </c:set>
                                        <div class="form-group">
                                            <label for="shortDesc" class="form-label"><i class="fas fa-comment me-2"></i>Mô Tả Ngắn <span style="color: #dc3545;">*</span></label>
                                            <form:input type="text" class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" path="shortDesc" />
                                            ${errorShortDesc}
                                        </div>

                                        <c:set var="errorDetailDesc">
                                            <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                        </c:set>
                                        <div class="form-group">
                                            <label for="detailDesc" class="form-label"><i class="fas fa-book me-2"></i>Mô Tả Chi Tiết <span style="color: #dc3545;">*</span></label>
                                            <form:textarea class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" path="detailDesc" rows="5"></form:textarea>
                                            ${errorDetailDesc}
                                        </div>

                                        <!-- Phân Loại -->
                                        <div class="form-section-title">
                                            <i class="fas fa-tags me-2"></i>Phân Loại Sản Phẩm
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="factory" class="form-label"><i class="fas fa-industry me-2"></i>Hãng Sản Xuất</label>
                                                <form:select class="form-select" path="factory">
                                                    <form:option value="">-- Chọn hãng --</form:option>
                                                    <form:option value="APPLE">Apple (MacBook)</form:option>
                                                    <form:option value="ASUS">Asus</form:option>
                                                    <form:option value="LENOVO">Lenovo</form:option>
                                                    <form:option value="ACER">Acer</form:option>
                                                    <form:option value="DELL">Dell</form:option>
                                                    <form:option value="LG">LG</form:option>
                                                    <form:option value="HP">HP</form:option>
                                                </form:select>
                                            </div>

                                            <div class="form-group">
                                                <label for="target" class="form-label"><i class="fas fa-bullseye me-2"></i>Đối Tượng Sử Dụng</label>
                                                <form:select class="form-select" path="target">
                                                    <form:option value="">-- Chọn đối tượng --</form:option>
                                                    <form:option value="GAMING">Gaming</form:option>
                                                    <form:option value="SINHVIEN-VANPHONG">Sinh Viên - Văn Phòng</form:option>
                                                    <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                                    <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                    <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                                </form:select>
                                            </div>
                                        </div>

                                        <!-- Hình Ảnh -->
                                        <div class="form-section-title">
                                            <i class="fas fa-image me-2"></i>Hình Ảnh Sản Phẩm
                                        </div>

                                        <div class="image-upload-wrapper">
                                            <div class="file-input-group">
                                                <input type="file" id="imageFile" accept=".png, .jpg, .jpeg, .webp" name="imageFile" />
                                                <label for="imageFile" class="file-input-label">
                                                    <i class="fas fa-folder-open"></i>Chọn File
                                                </label>
                                            </div>
                                            <small style="color: #999;"><i class="fas fa-info-circle me-1"></i>Hỗ trợ: PNG, JPG, JPEG, WEBP (Tối đa 5MB)</small>
                                            
                                            <div class="image-preview-container">
                                                <div class="image-preview-wrapper">
                                                    <small><i class="fas fa-eye me-1"></i>Xem Trước</small>
                                                    <img id="imagePreview" alt="Xem trước hình ảnh" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Nút Hành Động -->
                                        <div class="button-group">
                                            <a href="/admin/product" class="btn-action btn-back">
                                                <i class="fas fa-arrow-left"></i>Quay Lại
                                            </a>
                                            <button type="submit" class="btn-action btn-submit">
                                                <i class="fas fa-save"></i>Cập Nhật Sản Phẩm
                                            </button>
                                        </div>
                                    </form:form>
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
    <script src="js/scripts.js"></script>
</body>
</html>
