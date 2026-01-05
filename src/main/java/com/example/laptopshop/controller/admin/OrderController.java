package com.example.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.OrderDetail;
import com.example.laptopshop.service.OrderService;

@Controller
public class OrderController {
    
    private final OrderService orderService;
    
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrderPage(Model model, 
                               @RequestParam(value = "pageNo", required = false) Optional<String> pageNo,
                               @RequestParam(value = "keyword", required = false) String keyword,
                               @RequestParam(value = "status", required = false) String status) {
        int pageNumber = 1;
        
        if (pageNo.isPresent()) {
            try {
                pageNumber = Integer.parseInt(pageNo.get());
                if (pageNumber < 1) {
                    pageNumber = 1;
                }
            } catch (NumberFormatException e) {
                pageNumber = 1;
            }
        }
        
        Page<Order> page;
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasStatus = status != null && !status.trim().isEmpty() && !"ALL".equals(status);
        
        if (hasKeyword && hasStatus) {
            // Tìm kiếm theo keyword và status
            page = this.orderService.searchOrdersByStatusWithPagination(keyword.trim(), status, pageNumber);
            model.addAttribute("keyword", keyword.trim());
            model.addAttribute("status", status);
        } else if (hasKeyword) {
            // Chỉ tìm kiếm theo keyword
            page = this.orderService.searchOrdersWithPagination(keyword.trim(), pageNumber);
            model.addAttribute("keyword", keyword.trim());
        } else if (hasStatus) {
            // Chỉ filter theo status
            page = this.orderService.getOrdersByStatusWithPagination(status, pageNumber);
            model.addAttribute("status", status);
        } else {
            // Lấy tất cả
            page = this.orderService.getAllOrdersWithPagination(pageNumber);
        }
        
        // Thống kê số đơn theo trạng thái
        model.addAttribute("pendingCount", this.orderService.countByStatus("PENDING"));
        model.addAttribute("confirmedCount", this.orderService.countByStatus("CONFIRMED"));
        model.addAttribute("shippedCount", this.orderService.countByStatus("SHIPPED"));
        model.addAttribute("deliveredCount", this.orderService.countByStatus("DELIVERED"));
        model.addAttribute("cancelledCount", this.orderService.countByStatus("CANCELLED"));
        
        model.addAttribute("orders", page.getContent());
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalItems", page.getTotalElements());
        
        return "admin/order/show";
    }
    
    @GetMapping("/admin/order/{id}")
    public String getOrderDetail(@PathVariable long id, Model model) {
        Optional<Order> orderOptional = this.orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = this.orderService.getOrderDetails(id);
            
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", orderDetails);
            
            return "admin/order/detail";
        }
        return "redirect:/admin/order";
    }
    
    @PostMapping("/admin/order/{id}/update-status")
    public String updateOrderStatus(@PathVariable long id, @RequestParam String status) {
        this.orderService.updateOrderStatus(id, status);
        return "redirect:/admin/order/" + id;
    }
    
    @PostMapping("/admin/order/{id}/update-payment-status")
    public String updatePaymentStatus(@PathVariable long id, @RequestParam String paymentStatus) {
        this.orderService.updatePaymentStatus(id, paymentStatus);
        return "redirect:/admin/order/" + id;
    }
    
    @PostMapping("/admin/order/{id}/delete")
    public String deleteOrder(@PathVariable long id) {
        this.orderService.deleteOrder(id);
        return "redirect:/admin/order";
    }

}

