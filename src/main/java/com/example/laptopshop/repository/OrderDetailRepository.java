package com.example.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.OrderDetail;
import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.User;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    List<OrderDetail> findByProduct(Product product);
    
    // Kiểm tra user đã mua sản phẩm chưa (đơn hàng đã giao thành công)
    @Query("SELECT COUNT(od) > 0 FROM OrderDetail od WHERE od.order.user = :user AND od.product = :product AND od.order.status = 'DELIVERED'")
    boolean hasUserPurchasedProduct(@Param("user") User user, @Param("product") Product product);
}
