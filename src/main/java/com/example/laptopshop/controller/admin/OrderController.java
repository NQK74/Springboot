package com.example.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.OrderDetail;
import com.example.laptopshop.repository.OrderDetailRepository;
import com.example.laptopshop.repository.OrderRepository;

@Controller
public class OrderController {
    
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    
    public OrderController(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    @GetMapping("/admin/order")
    public String getOrderPage(Model model) {
        List<Order> orders = this.orderRepository.findAll();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }
    
    @GetMapping("/admin/order/{id}")
    public String getOrderDetail(@PathVariable long id, Model model) {
        Optional<Order> orderOptional = this.orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", orderDetails);
            
            return "admin/order/detail";
        }
        return "redirect:/admin/order";
    }
    
    @PostMapping("/admin/order/{id}/update-status")
    public String updateOrderStatus(@PathVariable long id, @RequestParam String status) {
        Optional<Order> orderOptional = this.orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.setStatus(status);
            this.orderRepository.save(order);
        }
        return "redirect:/admin/order/" + id;
    }
    
    @PostMapping("/admin/order/{id}/delete")
    public String deleteOrder(@PathVariable long id) {
        Optional<Order> orderOptional = this.orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            // Xóa tất cả OrderDetail
            for (OrderDetail od : order.getOrderDetails()) {
                this.orderDetailRepository.deleteById(od.getId());
            }
            // Xóa Order
            this.orderRepository.deleteById(id);
        }
        return "redirect:/admin/order";
    }
}

