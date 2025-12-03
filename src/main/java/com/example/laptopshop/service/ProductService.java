package com.example.laptopshop.service;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.repository.ProductRepository;

import java.util.List;
import java.util.Optional; // ← THÊM IMPORT NÀY

import org.springframework.stereotype.Service;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product getProductById(long id) {
        // SỬA LẠI METHOD NÀY
        Optional<Product> optionalProduct = this.productRepository.findById(id);
        return optionalProduct.orElse(null); // Trả về null nếu không tìm thấy
    }

    public Product createProduct(Product product) {
        return this.productRepository.save(product);
    }

    public void deleteAProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public List<Product> fetchProducts() {
        return this.productRepository.findAll();
    }

    public Product updateProduct(Product product) {
        return this.productRepository.save(product);
    }

}
