package com.example.laptopshop.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.domain.dto.RevenueDTO;
import com.example.laptopshop.repository.OrderRepository;
import com.example.laptopshop.service.OrderService;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;

@Controller
public class DashboardController {
    private final UserService userService;
    private final ProductService productService;
    private final OrderRepository orderRepository;
    private final OrderService orderService;
    private final PasswordEncoder passwordEncoder;

    public DashboardController(UserService userService, ProductService productService, 
                               OrderRepository orderRepository, OrderService orderService,
                               PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.productService = productService;
        this.orderRepository = orderRepository;
        this.orderService = orderService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        // Get statistics
        long totalUsers = userService.getAllUser().size();
        long totalProducts = productService.fetchProducts().size();
        long totalOrders = orderRepository.findAll().size();
        
        // Calculate total revenue from all orders
        double totalRevenue = orderRepository.findAll().stream()
            .filter(order -> order != null)
            .mapToDouble(order -> order.getTotalPrice() > 0 ? order.getTotalPrice() : 0)
            .sum();
        
        // Thống kê doanh thu
        double todayRevenue = orderService.getTodayRevenue();
        double thisMonthRevenue = orderService.getThisMonthRevenue();
        
        // Add data to model
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevenue", totalRevenue > 0 ? totalRevenue : 0);
        model.addAttribute("todayRevenue", todayRevenue);
        model.addAttribute("thisMonthRevenue", thisMonthRevenue);
        
        return "admin/dashboard/show";
    }
    
    // API lấy dữ liệu doanh thu theo ngày (7 ngày gần nhất)
    @GetMapping("/admin/api/revenue/daily")
    @ResponseBody
    public List<RevenueDTO> getDailyRevenue(@RequestParam(defaultValue = "7") int days) {
        return orderService.getRevenueByDays(days);
    }
    
    // API lấy dữ liệu doanh thu theo tháng (12 tháng gần nhất)
    @GetMapping("/admin/api/revenue/monthly")
    @ResponseBody
    public List<RevenueDTO> getMonthlyRevenue(@RequestParam(defaultValue = "12") int months) {
        return orderService.getRevenueByMonths(months);
    }
    
    // API lấy số đơn hàng PENDING (chờ xác nhận)
    @GetMapping("/admin/api/notifications/pending-orders")
    @ResponseBody
    public Map<String, Object> getPendingOrdersCount() {
        List<Order> allOrders = orderRepository.findAll();
        long pendingCount = allOrders.stream()
            .filter(o -> "PENDING".equals(o.getStatus()))
            .count();
        
        Map<String, Object> result = new HashMap<>();
        result.put("count", pendingCount);
        return result;
    }
    
    // Trang báo cáo
    @GetMapping("/admin/reports")
    public String getReportsPage(Model model) {
        List<Order> allOrders = orderRepository.findAll();
        
        // Thống kê tổng quan
        long totalOrders = allOrders.size();
        long pendingOrders = allOrders.stream().filter(o -> "PENDING".equals(o.getStatus())).count();
        long confirmedOrders = allOrders.stream().filter(o -> "CONFIRMED".equals(o.getStatus())).count();
        long shippingOrders = allOrders.stream().filter(o -> "SHIPPING".equals(o.getStatus())).count();
        long deliveredOrders = allOrders.stream().filter(o -> "DELIVERED".equals(o.getStatus())).count();
        long cancelledOrders = allOrders.stream().filter(o -> "CANCELLED".equals(o.getStatus())).count();
        
        // Doanh thu
        double todayRevenue = orderService.getTodayRevenue();
        double thisMonthRevenue = orderService.getThisMonthRevenue();
        double totalRevenue = allOrders.stream()
            .filter(o -> "DELIVERED".equals(o.getStatus()))
            .mapToDouble(Order::getTotalPrice)
            .sum();
        
        // Sản phẩm
        long totalProducts = productService.fetchProducts().size();
        long totalUsers = userService.getAllUser().size();
        
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("confirmedOrders", confirmedOrders);
        model.addAttribute("shippingOrders", shippingOrders);
        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("cancelledOrders", cancelledOrders);
        model.addAttribute("todayRevenue", todayRevenue);
        model.addAttribute("thisMonthRevenue", thisMonthRevenue);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalUsers", totalUsers);
        
        return "admin/reports/show";
    }
    
    // API lấy thống kê đơn hàng theo trạng thái
    @GetMapping("/admin/api/reports/order-stats")
    @ResponseBody
    public Map<String, Object> getOrderStats() {
        List<Order> allOrders = orderRepository.findAll();
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("pending", allOrders.stream().filter(o -> "PENDING".equals(o.getStatus())).count());
        stats.put("confirmed", allOrders.stream().filter(o -> "CONFIRMED".equals(o.getStatus())).count());
        stats.put("shipping", allOrders.stream().filter(o -> "SHIPPING".equals(o.getStatus())).count());
        stats.put("delivered", allOrders.stream().filter(o -> "DELIVERED".equals(o.getStatus())).count());
        stats.put("cancelled", allOrders.stream().filter(o -> "CANCELLED".equals(o.getStatus())).count());
        
        return stats;
    }
}


