package com.example.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.laptopshop.repository.OrderRepository;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;

@Controller
public class DashboardController {
    private final UserService userService;
    private final ProductService productService;
    private final OrderRepository orderRepository;

    public DashboardController(UserService userService, ProductService productService, OrderRepository orderRepository) {
        this.userService = userService;
        this.productService = productService;
        this.orderRepository = orderRepository;
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
        
        // Add data to model
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevenue", totalRevenue > 0 ? totalRevenue : 0);
        
        return "admin/dashboard/show";
    }
}


