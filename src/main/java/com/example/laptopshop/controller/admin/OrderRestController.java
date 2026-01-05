package com.example.laptopshop.controller.admin;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.service.OrderService;

@RestController
@RequestMapping("/api/admin")
public class OrderRestController {

    private final OrderService orderService;

    public OrderRestController(OrderService orderService) {
        this.orderService = orderService;
    }

    /**
     * Cập nhật trạng thái đơn hàng qua AJAX
     */
    @PutMapping("/order/{id}/status")
    public ResponseEntity<Map<String, Object>> updateOrderStatus(
            @PathVariable long id,
            @RequestBody Map<String, String> payload) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            String status = payload.get("status");
            if (status == null || status.isEmpty()) {
                response.put("success", false);
                response.put("message", "Trạng thái không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }
            
            Optional<Order> orderOptional = this.orderService.getOrderById(id);
            if (orderOptional.isEmpty()) {
                response.put("success", false);
                response.put("message", "Không tìm thấy đơn hàng");
                return ResponseEntity.notFound().build();
            }
            
            this.orderService.updateOrderStatus(id, status);
            
            response.put("success", true);
            response.put("message", "Cập nhật trạng thái đơn hàng thành công!");
            response.put("newStatus", status);
            response.put("statusLabel", getStatusLabel(status));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /**
     * Cập nhật trạng thái thanh toán qua AJAX
     */
    @PutMapping("/order/{id}/payment-status")
    public ResponseEntity<Map<String, Object>> updatePaymentStatus(
            @PathVariable long id,
            @RequestBody Map<String, String> payload) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            String paymentStatus = payload.get("paymentStatus");
            if (paymentStatus == null || paymentStatus.isEmpty()) {
                response.put("success", false);
                response.put("message", "Trạng thái thanh toán không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }
            
            Optional<Order> orderOptional = this.orderService.getOrderById(id);
            if (orderOptional.isEmpty()) {
                response.put("success", false);
                response.put("message", "Không tìm thấy đơn hàng");
                return ResponseEntity.notFound().build();
            }
            
            this.orderService.updatePaymentStatus(id, paymentStatus);
            
            response.put("success", true);
            response.put("message", "Cập nhật trạng thái thanh toán thành công!");
            response.put("newPaymentStatus", paymentStatus);
            response.put("paymentStatusLabel", getPaymentStatusLabel(paymentStatus));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    private String getStatusLabel(String status) {
        switch (status) {
            case "PENDING": return "Chờ Xác Nhận";
            case "CONFIRMED": return "Đã Xác Nhận";
            case "SHIPPED": return "Đang Giao";
            case "DELIVERED": return "Đã Giao";
            case "CANCELLED": return "Đã Hủy";
            default: return status;
        }
    }

    private String getPaymentStatusLabel(String paymentStatus) {
        switch (paymentStatus) {
            case "PAID": return "Đã Thanh Toán";
            case "UNPAID": return "Chưa Thanh Toán";
            default: return paymentStatus;
        }
    }
}
