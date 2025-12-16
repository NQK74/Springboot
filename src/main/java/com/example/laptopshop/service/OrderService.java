package com.example.laptopshop.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.OrderDetail;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.domain.dto.RevenueDTO;
import com.example.laptopshop.repository.OrderDetailRepository;
import com.example.laptopshop.repository.OrderRepository;

@Service
public class OrderService {
    
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    /**
     * Lấy tất cả các đơn hàng
     */
    public List<Order> getAllOrders() {
        return this.orderRepository.findAll();
    }

    
    public Page<Order> getAllOrdersWithPagination(int pageNo) {
        Pageable pageable = PageRequest.of(pageNo - 1, 5);
        return this.orderRepository.findAll(pageable);
    }

    /**
     * Tìm kiếm đơn hàng với phân trang
     */
    public Page<Order> searchOrdersWithPagination(String keyword, int pageNo) {
        Pageable pageable = PageRequest.of(pageNo - 1, 5);
        return this.orderRepository.searchOrders(keyword, pageable);
    }

    /**
     * Lấy đơn hàng theo ID
     */
    public Optional<Order> getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    /**
     * Lấy lịch sử đơn hàng của một user
     */
    public List<Order> getOrdersByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    /**
     * Tạo hoặc cập nhật đơn hàng
     */
    public Order saveOrder(Order order) {
        return this.orderRepository.save(order);
    }

    /**
     * Cập nhật trạng thái đơn hàng
     */
    public void updateOrderStatus(long orderId, String status) {
        Optional<Order> orderOptional = this.orderRepository.findById(orderId);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.setStatus(status);
            this.orderRepository.save(order);
        }
    }

    /**
     * Xóa đơn hàng (xóa các OrderDetail trước, sau đó xóa Order)
     */
    public void deleteOrder(long orderId) {
        Optional<Order> orderOptional = this.orderRepository.findById(orderId);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            // Xóa tất cả OrderDetail
            List<OrderDetail> orderDetails = order.getOrderDetails();
            if (orderDetails != null) {
                for (OrderDetail od : orderDetails) {
                    this.orderDetailRepository.deleteById(od.getId());
                }
            }
            // Xóa Order
            this.orderRepository.deleteById(orderId);
        }
    }

    /**
     * Lấy chi tiết đơn hàng
     */
    public List<OrderDetail> getOrderDetails(long orderId) {
        Optional<Order> orderOptional = this.orderRepository.findById(orderId);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            return order.getOrderDetails();
        }
        return List.of();
    }

    /**
     * Lấy doanh thu theo ngày trong 7 ngày gần nhất
     */
    public List<RevenueDTO> getRevenueByDays(int days) {
        List<RevenueDTO> result = new ArrayList<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");
        
        for (int i = days - 1; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            LocalDateTime startOfDay = date.atStartOfDay();
            LocalDateTime endOfDay = date.atTime(LocalTime.MAX);
            
            List<Order> orders = this.orderRepository.findByOrderDateBetween(startOfDay, endOfDay);
            double revenue = orders.stream()
                .filter(o -> "DELIVERED".equals(o.getStatus()))
                .mapToDouble(Order::getTotalPrice)
                .sum();
            long orderCount = orders.stream()
                .filter(o -> "DELIVERED".equals(o.getStatus()))
                .count();
            
            result.add(new RevenueDTO(date.format(formatter), revenue, orderCount));
        }
        
        return result;
    }

    /**
     * Lấy doanh thu theo tháng trong 12 tháng gần nhất
     */
    public List<RevenueDTO> getRevenueByMonths(int months) {
        List<RevenueDTO> result = new ArrayList<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yyyy");
        
        for (int i = months - 1; i >= 0; i--) {
            LocalDate monthDate = today.minusMonths(i);
            LocalDate startOfMonth = monthDate.withDayOfMonth(1);
            LocalDate endOfMonth = monthDate.withDayOfMonth(monthDate.lengthOfMonth());
            
            LocalDateTime startDateTime = startOfMonth.atStartOfDay();
            LocalDateTime endDateTime = endOfMonth.atTime(LocalTime.MAX);
            
            List<Order> orders = this.orderRepository.findByOrderDateBetween(startDateTime, endDateTime);
            double revenue = orders.stream()
                .filter(o -> "DELIVERED".equals(o.getStatus()))
                .mapToDouble(Order::getTotalPrice)
                .sum();
            long orderCount = orders.stream()
                .filter(o -> "DELIVERED".equals(o.getStatus()))
                .count();
            
            result.add(new RevenueDTO(startOfMonth.format(formatter), revenue, orderCount));
        }
        
        return result;
    }

    /**
     * Lấy tổng doanh thu hôm nay
     */
    public double getTodayRevenue() {
        LocalDateTime startOfDay = LocalDate.now().atStartOfDay();
        LocalDateTime endOfDay = LocalDate.now().atTime(LocalTime.MAX);
        
        List<Order> orders = this.orderRepository.findByOrderDateBetween(startOfDay, endOfDay);
        return orders.stream()
            .filter(o -> "DELIVERED".equals(o.getStatus()))
            .mapToDouble(Order::getTotalPrice)
            .sum();
    }

    /**
     * Lấy tổng doanh thu tháng này
     */
    public double getThisMonthRevenue() {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfMonth = today.withDayOfMonth(1).atStartOfDay();
        LocalDateTime endOfMonth = today.withDayOfMonth(today.lengthOfMonth()).atTime(LocalTime.MAX);
        
        List<Order> orders = this.orderRepository.findByOrderDateBetween(startOfMonth, endOfMonth);
        return orders.stream()
            .filter(o -> "DELIVERED".equals(o.getStatus()))
            .mapToDouble(Order::getTotalPrice)
            .sum();
    }

}
