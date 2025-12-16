package com.example.laptopshop.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    // Số sao đánh giá (1-5)
    private int rating;

    // Tiêu đề đánh giá
    private String title;

    // Nội dung đánh giá
    @Column(columnDefinition = "TEXT")
    private String content;

    // Số lượt thấy hữu ích
    private int helpfulCount;

    // Thời gian tạo đánh giá
    private LocalDateTime createdAt;

    // Người đánh giá
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Sản phẩm được đánh giá
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    public Review() {
        this.createdAt = LocalDateTime.now();
        this.helpfulCount = 0;
    }

    public Review(int rating, String title, String content, User user, Product product) {
        this.rating = rating;
        this.title = title;
        this.content = content;
        this.user = user;
        this.product = product;
        this.createdAt = LocalDateTime.now();
        this.helpfulCount = 0;
    }

    // Getters and Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getHelpfulCount() {
        return helpfulCount;
    }

    public void setHelpfulCount(int helpfulCount) {
        this.helpfulCount = helpfulCount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
