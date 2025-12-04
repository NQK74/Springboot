package com.example.laptopshop.service;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.laptopshop.domain.Cart;
import com.example.laptopshop.domain.CartDetail;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.repository.CartDetailRepository;
import com.example.laptopshop.repository.CartRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public ProductService(CartDetailRepository cartDetailRepository, CartRepository cartRepository, ProductRepository productRepository, UserService userService) {
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
        this.userService = userService;
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

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session) {
        // Logic to add product to cart
        User user = this.userService.getUserByEmail(email);
        
        if (user != null) {
            Cart  cart = this.cartRepository.findByUser(user);

            if (cart == null) {
            //tao moi cart
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);
                cart = this.cartRepository.save(otherCart);
            }
        
        // save cart detail
        //tim cart product by id
        Optional<Product> productOptional = this.productRepository.findById(productId);
        
        if (productOptional.isPresent()) {
            Product realProduct = productOptional.get();

            // check san pham da co trong cart chua
            CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
            
            if (oldDetail == null) {
                // chua co san pham trong cart -> tao moi
                CartDetail cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProduct(realProduct);
                cartDetail.setQuantity(1);
                cartDetail.setPrice(realProduct.getPrice());

                this.cartDetailRepository.save(cartDetail);
                
                // cap nhat sum trong cart
                int sum = cart.getSum() + 1;
                cart.setSum(sum);
                this.cartRepository.save(cart);
                session.setAttribute("sum", sum);
            } else {
                // da co san pham trong cart -> tang quantity
                oldDetail.setQuantity(oldDetail.getQuantity() + 1);
                this.cartDetailRepository.save(oldDetail);
            }
            
        }

        }
        
    }

}
