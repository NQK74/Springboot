package com.example.laptopshop.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "order_details")
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private int quantity;
    private double price;

    // orderId
    @ManyToOne
    @JoinColumn(name = "order_id") // foreign key
    private Order order;

    // productId
    @ManyToOne
    @JoinColumn(name = "product_id") // foreign key
    private Product product;

    public OrderDetail() {
    }

    public OrderDetail(long id, int quantity, double price) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String toString() {
        return "OrderDetail [id=" + id + ", quantity=" + quantity + ", price=" + price + "]";
    }
}
