package com.example.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.Review;
import com.example.laptopshop.domain.User;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    // Lấy tất cả đánh giá của sản phẩm
    List<Review> findByProduct(Product product);

    // Lấy đánh giá của sản phẩm với phân trang
    Page<Review> findByProductOrderByCreatedAtDesc(Product product, Pageable pageable);

    // Lấy đánh giá của sản phẩm theo id với phân trang
    Page<Review> findByProductIdOrderByCreatedAtDesc(long productId, Pageable pageable);

    // Đếm số lượng đánh giá của sản phẩm
    long countByProduct(Product product);

    long countByProductId(long productId);

    // Tính điểm trung bình của sản phẩm
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.product.id = :productId")
    Double getAverageRatingByProductId(@Param("productId") long productId);

    // Đếm số lượng đánh giá theo từng mức sao
    @Query("SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId AND r.rating = :rating")
    long countByProductIdAndRating(@Param("productId") long productId, @Param("rating") int rating);

    // Kiểm tra user đã đánh giá sản phẩm chưa
    boolean existsByUserAndProduct(User user, Product product);

    // Lấy đánh giá của user cho sản phẩm cụ thể
    Review findByUserAndProduct(User user, Product product);

    // Lấy tất cả đánh giá của user
    List<Review> findByUser(User user);
}
