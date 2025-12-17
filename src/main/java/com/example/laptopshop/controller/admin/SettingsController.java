package com.example.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.laptopshop.service.OrderService;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;

@Controller
public class SettingsController {
    
    private final UserService userService;
    private final ProductService productService;
    private final OrderService orderService;
    
    public SettingsController(UserService userService, ProductService productService, OrderService orderService) {
        this.userService = userService;
        this.productService = productService;
        this.orderService = orderService;
    }

    @GetMapping("/admin/settings")
    public String getSettingsPage(Model model) {
        // Thống kê tổng quan
        long totalUsers = this.userService.countAllUsers();
        long totalProducts = this.productService.countAllProducts();
        long totalOrders = this.orderService.getAllOrders().size();
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalOrders", totalOrders);
        
        return "admin/settings/show";
    }
    
    @PostMapping("/admin/settings/update-site")
    public String updateSiteSettings(
            @RequestParam(required = false) String siteName,
            @RequestParam(required = false) String siteEmail,
            @RequestParam(required = false) String sitePhone,
            @RequestParam(required = false) String siteAddress,
            RedirectAttributes redirectAttributes) {
        
        // TODO: Lưu cài đặt vào database hoặc file cấu hình
        // Hiện tại chỉ hiển thị thông báo thành công
        
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật cài đặt website thành công!");
        return "redirect:/admin/settings";
    }
    
    @PostMapping("/admin/settings/update-payment")
    public String updatePaymentSettings(
            @RequestParam(required = false) boolean enableCod,
            @RequestParam(required = false) boolean enableVnpay,
            @RequestParam(required = false) boolean enableBanking,
            RedirectAttributes redirectAttributes) {
        
        // TODO: Lưu cài đặt thanh toán vào database
        
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật cài đặt thanh toán thành công!");
        return "redirect:/admin/settings";
    }
    
    @PostMapping("/admin/settings/update-order")
    public String updateOrderSettings(
            @RequestParam(required = false) boolean autoConfirmVnpay,
            @RequestParam(required = false) int orderExpiryDays,
            RedirectAttributes redirectAttributes) {
        
        // TODO: Lưu cài đặt đơn hàng vào database
        
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật cài đặt đơn hàng thành công!");
        return "redirect:/admin/settings";
    }
}
