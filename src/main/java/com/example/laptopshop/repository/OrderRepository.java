package com.example.laptopshop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);
    
    // Lấy đơn hàng của user sắp xếp theo ngày mới nhất (cho client)
    List<Order> findByUserOrderByOrderDateDescIdDesc(User user);
    
    // Lấy tất cả đơn hàng sắp xếp theo ngày mới nhất
    @Query("SELECT o FROM Order o ORDER BY o.orderDate DESC, o.id DESC")
    Page<Order> findAllOrderByOrderDateDesc(Pageable pageable);

    // Tìm kiếm order theo id, receiverName, receiverPhone, receiverEmail, hoặc status - sắp xếp mới nhất
    @Query("SELECT o FROM Order o WHERE CAST(o.id AS string) LIKE CONCAT('%', :keyword, '%') " +
           "OR LOWER(o.receiverName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(o.receiverPhone) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(o.receiverEmail) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(o.status) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "ORDER BY o.orderDate DESC, o.id DESC")
    Page<Order> searchOrders(@Param("keyword") String keyword, Pageable pageable);

    // Lấy đơn hàng trong khoảng thời gian
    List<Order> findByOrderDateBetween(LocalDateTime startDate, LocalDateTime endDate);
    
    // Lấy đơn hàng đã giao (DELIVERED) trong khoảng thời gian
    @Query("SELECT o FROM Order o WHERE o.orderDate BETWEEN :startDate AND :endDate AND o.status = 'DELIVERED'")
    List<Order> findDeliveredOrdersBetween(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    // Tìm kiếm order theo status - sắp xếp mới nhất
    @Query("SELECT o FROM Order o WHERE o.status = :status ORDER BY o.orderDate DESC, o.id DESC")
    Page<Order> findByStatus(@Param("status") String status, Pageable pageable);

    // Tìm kiếm order theo keyword và status - sắp xếp mới nhất
    @Query("SELECT o FROM Order o WHERE " +
           "(CAST(o.id AS string) LIKE CONCAT('%', :keyword, '%') " +
           "OR LOWER(o.receiverName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(o.receiverPhone) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(o.receiverEmail) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
           "AND o.status = :status " +
           "ORDER BY o.orderDate DESC, o.id DESC")
    Page<Order> searchOrdersByStatus(@Param("keyword") String keyword, @Param("status") String status, Pageable pageable);

    // Đếm số đơn hàng theo status
    long countByStatus(String status);
}
