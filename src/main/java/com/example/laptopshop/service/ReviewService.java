package com.example.laptopshop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.Review;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.repository.OrderDetailRepository;
import com.example.laptopshop.repository.ReviewRepository;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ReviewService(ReviewRepository reviewRepository, OrderDetailRepository orderDetailRepository) {
        this.reviewRepository = reviewRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // Lưu đánh giá
    public Review saveReview(Review review) {
        return this.reviewRepository.save(review);
    }

    // Lấy đánh giá theo ID
    public Optional<Review> getReviewById(long id) {
        return this.reviewRepository.findById(id);
    }

    // Lấy tất cả đánh giá của sản phẩm
    public List<Review> getReviewsByProduct(Product product) {
        return this.reviewRepository.findByProduct(product);
    }

    // Lấy đánh giá của sản phẩm với phân trang
    public Page<Review> getReviewsByProductId(long productId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return this.reviewRepository.findByProductIdOrderByCreatedAtDesc(productId, pageable);
    }

    // Đếm số lượng đánh giá của sản phẩm
    public long countReviewsByProductId(long productId) {
        return this.reviewRepository.countByProductId(productId);
    }

    // Tính điểm trung bình của sản phẩm
    public double getAverageRating(long productId) {
        Double avg = this.reviewRepository.getAverageRatingByProductId(productId);
        return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
    }

    // Lấy thống kê đánh giá theo từng mức sao
    public Map<Integer, Long> getRatingBreakdown(long productId) {
        Map<Integer, Long> breakdown = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            breakdown.put(i, this.reviewRepository.countByProductIdAndRating(productId, i));
        }
        return breakdown;
    }

    // Kiểm tra user đã đánh giá sản phẩm chưa
    public boolean hasUserReviewed(User user, Product product) {
        return this.reviewRepository.existsByUserAndProduct(user, product);
    }

    // Kiểm tra user đã mua sản phẩm chưa (đơn hàng đã hoàn thành)
    public boolean hasUserPurchasedProduct(User user, Product product) {
        return this.orderDetailRepository.hasUserPurchasedProduct(user, product);
    }

    // Lấy đánh giá của user cho sản phẩm
    public Review getUserReviewForProduct(User user, Product product) {
        return this.reviewRepository.findByUserAndProduct(user, product);
    }

    // Tăng số lượt hữu ích
    public void incrementHelpfulCount(long reviewId) {
        Optional<Review> reviewOpt = this.reviewRepository.findById(reviewId);
        if (reviewOpt.isPresent()) {
            Review review = reviewOpt.get();
            review.setHelpfulCount(review.getHelpfulCount() + 1);
            this.reviewRepository.save(review);
        }
    }

    // Xóa đánh giá
    public void deleteReview(long id) {
        this.reviewRepository.deleteById(id);
    }
    
    // Xóa đánh giá với kiểm tra quyền sở hữu
    public boolean deleteReviewByUser(long reviewId, User user) {
        Optional<Review> reviewOpt = this.reviewRepository.findById(reviewId);
        if (reviewOpt.isPresent()) {
            Review review = reviewOpt.get();
            if (review.getUser().getId() == user.getId()) {
                this.reviewRepository.deleteById(reviewId);
                return true;
            }
        }
        return false;
    }
    
    // Cập nhật đánh giá
    public boolean updateReview(long reviewId, User user, int rating, String title, String content) {
        Optional<Review> reviewOpt = this.reviewRepository.findById(reviewId);
        if (reviewOpt.isPresent()) {
            Review review = reviewOpt.get();
            if (review.getUser().getId() == user.getId()) {
                review.setRating(rating);
                review.setTitle(title);
                review.setContent(content);
                this.reviewRepository.save(review);
                return true;
            }
        }
        return false;
    }

    // Lấy tất cả đánh giá của user
    public List<Review> getReviewsByUser(User user) {
        return this.reviewRepository.findByUser(user);
    }
}
