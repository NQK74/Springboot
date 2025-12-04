<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="navbar-enhanced">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3 ps-4">
                <a href="/" class="navbar-brand">
                    <h1 class="mb-0"><i class="fas fa-laptop me-2"></i>LaptopShop</h1>
                </a>
            </div>

            <div class="col-md-6 d-none d-md-block">
                <nav class="navbar navbar-expand-lg p-0 m-0">
                    <div class="navbar-nav gap-2">
                        <a href="/" class="nav-link active">Trang chủ</a>
                        <a href="#" class="nav-link">Sản phẩm</a>
                        <!-- <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Danh mục</a>
                            <div class="dropdown-menu bg-secondary rounded-3 border-0">
                                <a href="/gaming" class="dropdown-item">Laptop Gaming</a>
                                <a href="/office" class="dropdown-item">Laptop Văn Phòng</a>
                                <a href="/design" class="dropdown-item">Laptop Đồ Họa</a>
                                <a href="/student" class="dropdown-item">Laptop Sinh Viên</a>
                            </div>
                        </div>
                        <a href="/deals" class="nav-link">Khuyến mãi</a>
                        <a href="/contact" class="nav-link">Liên hệ</a> -->
                    </div>
                </nav>
            </div>

            <div class="col-md-3 d-flex justify-content-end gap-3 pe-4">
                <!-- <a href="#" class="icon-btn" data-bs-toggle="modal" data-bs-target="#searchModal">
                    <i class="fas fa-search"></i>
                </a> -->
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <!-- <a href="/notifications" class="icon-btn position-relative">
                        <i class="fas fa-bell"></i>
                        <span class="badge-circle">5</span>
                    </a> -->
                    <a href="/cart" class="icon-btn position-relative">
                        <i class="fas fa-shopping-bag"></i>
                        <span class="badge-circle">${sessionScope.sum}</span>
                    </a>

                    <div class="dropdown my-auto">
                        <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user fa-2x"></i>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                            <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.avatar}">
                                        <img src="/images/avatar/${sessionScope.avatar}" 
                                             style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;" 
                                             alt="Avatar"/>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-circle fa-5x text-secondary"></i>
                                    </c:otherwise>
                                </c:choose>
                                <div class="text-center my-3 fw-bold text-white">
                                    <c:out value="${sessionScope.fullName}" />
                                </div>
                            </li>
                            <li><a class="dropdown-item" href="/account"><i class="fas fa-cog me-2"></i>Quản lý tài khoản</a></li>
                            <li><a class="dropdown-item" href="/orders"><i class="fas fa-history me-2"></i>Lịch sử mua hàng</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form method="post" action="/logout">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="dropdown-item text-danger">
                                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty pageContext.request.userPrincipal}">
                    <a href="/login" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                    </a>
                </c:if>
                <button class="navbar-toggler d-md-none border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mobileMenu">
                    <i class="fas fa-bars text-white"></i>
                </button>
            </div>
        </div>

        <!-- Mobile Menu -->
        <div class="collapse" id="mobileMenu">
            <div class="navbar-nav gap-2 mt-3">
                <a href="/" class="nav-link">Trang chủ</a>
                <a href="/shop" class="nav-link">Sản phẩm</a>
                <a href="/gaming" class="nav-link">Laptop Gaming</a>
                <a href="/deals" class="nav-link">Khuyến mãi</a>
                <a href="/contact" class="nav-link">Liên hệ</a>
            </div>
        </div>
    </div>
</div>
<!-- Navbar Improved End -->

<!-- Modal Search Start -->
<div class="modal fade" id="searchModal" tabindex="-1">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content bg-white">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold">Tìm kiếm sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body d-flex align-items-center justify-content-center" style="min-height: 300px;">
                <div class="w-75">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-lg rounded-start-5" placeholder="Nhập từ khóa tìm kiếm...">
                        <button class="btn btn-primary btn-lg rounded-end-5" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal Search End -->