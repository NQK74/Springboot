package com.example.laptopshop.controller.employee;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.service.OrderService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;

@Controller
public class EmployeeOrderController {

    private final OrderService orderService;
    private static final List<String> VALID_STATUSES = Arrays.asList("PENDING", "SHIPPING", "COMPLETE", "CANCEL");

    public EmployeeOrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/employee/order")
    public String getOrderPage(Model model) {
        List<Order> orders = this.orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "employee/order/show";
    }

    @GetMapping("/employee/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable Long id) {
        Order order = this.orderService.getOrderById(id);
        if (order == null) {
            return "redirect:/employee/order";
        }
        model.addAttribute("order", order);
        model.addAttribute("id", id);
        return "employee/order/detail";
    }

    @GetMapping("/employee/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable Long id) {
        Order order = this.orderService.getOrderById(id);
        if (order == null) {
            return "redirect:/employee/order";
        }
        model.addAttribute("order", order);
        return "employee/order/update";
    }

    @PostMapping("/employee/order/update/{id}")
    public String postUpdateOrder(@PathVariable Long id, @RequestParam("status") String status) {
        if (VALID_STATUSES.contains(status)) {
            this.orderService.updateOrderStatus(id, status);
        }
        return "redirect:/employee/order";
    }
}
