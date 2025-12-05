package com.example.laptopshop.service;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        Optional<Product> optionalProduct = this.productRepository.findById(id);
        return optionalProduct.orElse(null);
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

    @Transactional
    public void handleAddProductToCart(String email, long productId, HttpSession session) {
        User user = this.userService.getUserByEmail(email);
        
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);

            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);
            }
        
            Optional<Product> productOptional = this.productRepository.findById(productId);
            
            if (productOptional.isPresent()) {
                Product realProduct = productOptional.get();

                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
                
                if (oldDetail == null) {
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(realProduct);
                    cartDetail.setQuantity(1);
                    cartDetail.setPrice(realProduct.getPrice());

                    this.cartDetailRepository.save(cartDetail);
                    
                    int sum = cart.getSum() + 1;
                    cart.setSum(sum);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", sum);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oldDetail);
                }
            }
        }
    }

    @Transactional
    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            
            // ✅ LẤY cartId TRƯỚC KHI XÓA
            long cartId = cartDetail.getCart().getId();
            
            // ✅ XÓA CartDetail trước
            this.cartDetailRepository.deleteById(cartDetailId);
            
            // ✅ SAU ĐÓ LẤY LẠI Cart từ database (để có managed entity)
            Optional<Cart> cartOptional = this.cartRepository.findById(cartId);
            
            if (cartOptional.isPresent()) {
                Cart currentCart = cartOptional.get();
                int currentSum = currentCart.getSum();
                
                if (currentSum > 1) {
                    // Còn sản phẩm -> giảm sum
                    currentCart.setSum(currentSum - 1);
                    this.cartRepository.save(currentCart);
                    session.setAttribute("sum", currentSum - 1);
                } else {
                    // Không còn sản phẩm -> xóa cart
                    this.cartRepository.deleteById(cartId);
                    session.setAttribute("sum", 0);
                }
            }
        }
    }
}