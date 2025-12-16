<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="currentPath" value="${pageContext.request.requestURI}" />

<div class="navbar-enhanced">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3 ps-4">
                <a href="/" class="navbar-brand">
                    <h1 class="mb-0"><i class="fas fa-laptop me-2"></i>LaptopShop</h1>
                </a>
            </div>

            <!-- Navigation Links -->
            <div class="col-md-3 d-none d-lg-block">
                <nav class="navbar navbar-expand-lg p-0 m-0">
                    <div class="navbar-nav gap-2">
                        <a href="/" class="nav-link ${currentPath.contains('/homepage/') || currentPath == '/' ? 'active' : ''}">Trang chủ</a>
                        <a href="/product/show" class="nav-link ${currentPath.contains('/product/') ? 'active' : ''}">Sản phẩm</a>
                    </div>
                </nav>
            </div>

            <div class="col-md-4 d-flex justify-content-end align-items-center gap-2 pe-4">
                <!-- Search Bar (Desktop Only) -->
               <form action="/product/show" method="get" class="d-none d-lg-flex align-items-center desktop-search">
                    <div class="header-search-modern">
                        <input type="text" 
                            name="keyword" 
                            class="header-search-input-modern" 
                            placeholder="Tìm kiếm laptop, phụ kiện..." 
                            value="${param.keyword}" 
                            autocomplete="off">
                        <button type="submit" class="header-search-btn-modern" title="Tìm kiếm">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>

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
                        <a style= "padding-left:  0.5rem !important;" href="#" class="dropdown" role="button" id="dropdownMenuLink"
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
                            <li><a class="dropdown-item" href="/order-history"><i class="fas fa-history me-2"></i>Lịch sử mua hàng</a></li>
                            <c:if test="${sessionScope.role == 'ROLE_ADMIN' || sessionScope.role == 'ADMIN'}">
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item admin-link" href="/admin"><i class="fas fa-tachometer-alt me-2"></i>Trang quản trị</a></li>
                            </c:if>
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
                <button class="navbar-toggler d-lg-none border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mobileMenu">
                    <i class="fas fa-bars text-white"></i>
                </button>
            </div>
        </div>

        <!-- Mobile Menu -->
        <div class="collapse" id="mobileMenu">
            <!-- Mobile Search -->
            <div class="mobile-search my-3">
                <form action="/product/show" method="get">
                    <div class="header-search-modern">
                        <input type="text" 
                            name="keyword" 
                            class="header-search-input-modern" 
                            placeholder="Tìm kiếm sản phẩm..." 
                            value="${param.keyword}" 
                            autocomplete="off">
                        <button type="submit" class="header-search-btn-modern" title="Tìm kiếm">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <div class="navbar-nav gap-2">
                <a href="/" class="nav-link">Trang chủ</a>
                <a href="/product/show" class="nav-link">Sản phẩm</a>
            </div>
        </div>
    </div>
</div>
<!-- Navbar Improved End -->