package com.example.laptopshop.service;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.repository.OrderRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

@Service
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public List<Order> getAllOrders() {
        return this.orderRepository.findAll();
    }

    public Order getOrderById(long id) {
        Optional<Order> optionalOrder = this.orderRepository.findById(id);
        return optionalOrder.orElse(null);
    }

    public void updateOrderStatus(long id, String status) {
        Optional<Order> optionalOrder = this.orderRepository.findById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus(status);
            this.orderRepository.save(order);
        }
    }

    public void deleteOrderById(long id) {
        this.orderRepository.deleteById(id);
    }
}
