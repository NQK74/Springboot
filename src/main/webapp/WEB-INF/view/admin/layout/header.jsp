<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/layout/header.css">

<nav class="sb-topnav navbar navbar-expand navbar-dark">
    <!-- Navbar Brand -->
    <a class="navbar-brand" href="/admin">
        <i class="fas fa-laptop"></i>
        LaptopShop
    </a>
    
    <!-- Sidebar Toggle -->
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
        <div class="input-group">
            <input class="form-control" type="text" placeholder="Tìm kiếm..." aria-label="Search" />
            <button class="btn btn-primary" type="button">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </form>
    
    <!-- Navbar Items -->
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4 d-flex align-items-center">
        <!-- Notifications -->
        <li class="nav-item me-3">
            <a class="nav-link" href="#" role="button">
                <i class="fas fa-bell"></i>
            </a>
        </li>
        
        <!-- Messages -->
        <li class="nav-item me-3">
            <a class="nav-link" href="#" role="button">
                <i class="fas fa-envelope"></i>
               
            </a>
        </li>
        
        <!-- User Dropdown -->
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-user"></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                <li class="dropdown-user-info">
                    <div class="dropdown-user-name">NQK74</div>
                    <div class="dropdown-user-email">admin@laptopshop.com</div>
                </li>
                <li>
                    <a class="dropdown-item" href="/admin/profile">
                        <i class="fas fa-user-circle"></i>
                        Hồ Sơ
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="/admin/settings">
                        <i class="fas fa-cog"></i>
                        Cài Đặt
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="/admin/activity">
                        <i class="fas fa-history"></i>
                        Lịch Sử Hoạt Động
                    </a>
                </li>
                <li><hr class="dropdown-divider" /></li>
                <li>
                    <a class="dropdown-item logout" href="/logout">
                        <i class="fas fa-sign-out-alt"></i>
                        Đăng Xuất
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</nav>