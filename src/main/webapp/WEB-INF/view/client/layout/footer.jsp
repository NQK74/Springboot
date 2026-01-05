<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="footer-enhanced bg-dark text-white-50">
    <div class="container-fluid">
        <div class="container py-5">
            <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(241, 162, 8, 0.3);">
                <div class="row g-4">
                    <div class="col-lg-3">
                        <a href="/" class="text-decoration-none">
                            <h3 class="text-secondary mb-2"><i class="fas fa-laptop me-2"></i>LaptopShop</h3>
                            <p class="text-muted mb-0">Laptop Chính Hãng - Giá Tốt Nhất</p>
                        </a>
                    </div>
                    <div class="col-lg-6">
                        <div class="position-relative">
                            <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="email" placeholder="Đăng ký nhận thông tin khuyến mãi">
                            <button type="submit" class="btn btn-secondary border-0 py-3 px-4 position-absolute rounded-pill text-white fw-bold" style="top: 0; right: 0;">Đăng ký</button>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="d-flex justify-content-end gap-3">
                            <a href="#" class="btn btn-outline-secondary btn-md-square rounded-circle">
                                <i class="fab fa-facebook-f text-white"></i>
                            </a>
                            <a href="#" class="btn btn-outline-secondary btn-md-square rounded-circle">
                                <i class="fab fa-twitter text-white"></i>
                            </a>
                            <a href="#" class="btn btn-outline-secondary btn-md-square rounded-circle">
                                <i class="fab fa-instagram text-white"></i>
                            </a>
                            <a href="#" class="btn btn-outline-secondary btn-md-square rounded-circle">
                                <i class="fab fa-youtube text-white"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h5 class="text-white mb-3">Về LaptopShop</h5>
                        <p class="mb-4">Chuyên cung cấp laptop chính hãng từ các thương hiệu hàng đầu: Dell, HP, Lenovo, Asus, Acer, MSI với giá tốt nhất thị trường.</p>
                        <a href="#" class="btn border-secondary py-2 px-4 rounded-pill text-secondary">Xem thêm</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h5 class="text-white mb-3">Danh Mục Sản Phẩm</h5>
                        <a href="#" class="btn-link mb-2">Laptop Gaming</a>
                        <a href="#" class="btn-link mb-2">Laptop Văn Phòng</a>
                        <a href="#" class="btn-link mb-2">Laptop Đồ Họa</a>
                        <a href="#" class="btn-link mb-2">Laptop Sinh Viên</a>
                        <a href="#" class="btn-link mb-2">Phụ Kiện Laptop</a>
                        <a href="#" class="btn-link mb-2">Laptop Cũ</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h5 class="text-white mb-3">Hỗ Trợ Khách Hàng</h5>
                        <a href="#" class="btn-link mb-2">Chính Sách Bảo Hành</a>
                        <a href="#" class="btn-link mb-2">Hướng Dẫn Mua Hàng</a>
                        <a href="#" class="btn-link mb-2">Giỏ Hàng</a>
                        <a href="#" class="btn-link mb-2">Tra Cứu Đơn Hàng</a>
                        <a href="#" class="btn-link mb-2">Chính Sách Đổi Trả</a>
                        <a href="#" class="btn-link mb-2">Hỏi Đáp</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h5 class="text-white mb-3">Thông Tin Liên Hệ</h5>
                        <p class="mb-2"><i class="fas fa-map-marker-alt me-2"></i>Tp. Đà Nẵng, Việt Nam</p>
                        <p class="mb-2"><i class="fas fa-envelope me-2"></i>support@laptopshop.vn</p>
                        <p class="mb-2"><i class="fas fa-phone me-2"></i>1900 xxxx (miễn phí)</p>
                        <p class="mb-3"><i class="fas fa-clock me-2"></i>8:00 - 22:00 (Hàng ngày)</p>
                        <p class="mb-2 text-white fw-bold">Phương thức thanh toán:</p>
                        <img src="/client/images/payment.png" class="img-fluid w-75" alt="Payment Methods">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid copyright bg-darker py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <span class="text-white-50">
                    <i class="fas fa-copyright me-2"></i>
                    <a href="#" class="text-decoration-none text-white">LaptopShop 2024</a>, Tất cả quyền được bảo lưu.
                </span>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <span class="text-white-50">
                    Thiết kế bởi 
                    <a href="#" class="text-decoration-none" style="color: #00d4ff;">LaptopShop Team</a>
                </span>
            </div>
        </div>
    </div>
</div>
</div>

<!-- Chatbot Widget -->
<jsp:include page="chatbot.jsp" />

<!-- Copyright End -->
<!-- Footer Improved End -->