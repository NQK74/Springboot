package com.example.laptopshop.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.laptopshop.domain.Cart;
import com.example.laptopshop.domain.CartDetail;
import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.OrderDetail;
import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.repository.CartDetailRepository;
import com.example.laptopshop.repository.CartRepository;
import com.example.laptopshop.repository.OrderDetailRepository;
import com.example.laptopshop.repository.OrderRepository;
import com.example.laptopshop.repository.ProductRepository;
import com.example.laptopshop.service.specification.ProductSpecification;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(CartDetailRepository cartDetailRepository, CartRepository cartRepository, 
                         ProductRepository productRepository, UserService userService,
                         OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Product getProductById(long id) {
        Optional<Product> optionalProduct = this.productRepository.findById(id);
        return optionalProduct.orElse(null);
    }

    public Product createProduct(Product product) {
        return this.productRepository.save(product);
    }

    public void deleteAProduct(long id) throws Exception {
        Product product = this.productRepository.findById(id).orElse(null);
        if (product == null) {
            throw new Exception("Sản phẩm không tồn tại");
        }
        
        // Check if product is in any orders
        List<OrderDetail> orderDetails = this.orderDetailRepository.findByProduct(product);
        if (!orderDetails.isEmpty()) {
            throw new Exception("Không thể xóa sản phẩm vì nó đã được sử dụng trong " + orderDetails.size() + " đơn hàng. Vui lòng kiểm tra lại.");
        }
        
        this.productRepository.deleteById(id);
    }

    public List<Product> fetchProducts() {
        return this.productRepository.findAll();
    }

    public long countAllProducts() {
        return this.productRepository.count();
    }

    public Page<Product> fetchProductsWithPagination(int pageNo) {
        Pageable pageable = PageRequest.of(pageNo - 1, 6);
        return this.productRepository.findAll(pageable);
    }

    public Page<Product> searchProductsWithPagination(String keyword, int pageNo) {
        Pageable pageable = PageRequest.of(pageNo - 1, 6);
        return this.productRepository.searchProducts(keyword, pageable);
    }

    public Page<Product> fetchProductsWithFilters(int pageNo, List<String> factories, List<String> targets, 
                                                   Double minPrice, Double maxPrice, String sort, String keyword) {
        Specification<Product> spec = Specification.allOf();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            spec = spec.and(ProductSpecification.hasNameContaining(keyword));
        }
        
        if (factories != null && !factories.isEmpty()) {
            spec = spec.and(ProductSpecification.hasFactory(factories));
        }
        
        if (targets != null && !targets.isEmpty()) {
            spec = spec.and(ProductSpecification.hasTarget(targets));
        }
        
        if (minPrice != null || maxPrice != null) {
            spec = spec.and(ProductSpecification.hasPriceBetween(minPrice, maxPrice));
        }
        
        Sort sorting = Sort.by("id").descending();
        if (sort != null) {
            if ("price-asc".equals(sort)) {
                sorting = Sort.by("price").ascending();
            } else if ("price-desc".equals(sort)) {
                sorting = Sort.by("price").descending();
            } else if ("name-asc".equals(sort)) {
                sorting = Sort.by("name").ascending();
            } else if ("name-desc".equals(sort)) {
                sorting = Sort.by("name").descending();
            }
        }
        
        Pageable pageable = PageRequest.of(pageNo - 1, 6, sorting);
        return this.productRepository.findAll(spec, pageable);
    }

    public List<String> getAllFactories() {
        return this.productRepository.findAllFactories();
    }

    public List<String> getAllTargets() {
        return this.productRepository.findAllTargets();
    }

    public Product updateProduct(Product product) {
        return this.productRepository.save(product);
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    @Transactional
    public void handleAddProductToCart(String email, long productId, long quantity, HttpSession session) {
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
                    cartDetail.setQuantity(quantity);
                    cartDetail.setPrice(realProduct.getPrice());
                    cartDetail.setSelected(true); // Mặc định chọn sản phẩm mới

                    this.cartDetailRepository.save(cartDetail);
                    
                    int sum = cart.getSum() + 1;
                    cart.setSum(sum);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", sum);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
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
            Cart cart = cartDetail.getCart();
            
            if (cart != null) {
                int currentSum = cart.getSum();
                
                this.cartDetailRepository.deleteById(cartDetailId);
                
                if (currentSum <= 1) {
                    cart.setSum(0);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", 0);
                } else {
                    cart.setSum(currentSum - 1);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", currentSum - 1);
                }
            }
        }
    }

    @Transactional
    public void handleUpdateCartQuantity(long cartDetailId, long quantity, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            
            if (quantity <= 0) {
                this.handleRemoveCartDetail(cartDetailId, session);
            } else {
                cartDetail.setQuantity(quantity);
                this.cartDetailRepository.save(cartDetail);
            }
        }
    }
    
    // Cập nhật trạng thái selected cho một CartDetail
    @Transactional
    public void updateCartDetailSelection(long cartDetailId, boolean selected) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            cartDetail.setSelected(selected);
            this.cartDetailRepository.save(cartDetail);
        }
    }
    
    // Cập nhật trạng thái selected cho nhiều CartDetail
    @Transactional
    public void updateAllCartDetailSelection(List<Long> cartDetailIds, boolean selected) {
        for (Long id : cartDetailIds) {
            updateCartDetailSelection(id, selected);
        }
    }
    
    @Transactional
    public void handlePlaceOrder(User user, HttpSession session,
                            String receiverName, String receiverPhone, String receiverAddress,
                            String receiverEmail, String note, String paymentMethod) {
        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            return;
        }

        List<CartDetail> cartDetails = cart.getCartDetails();
        if (cartDetails == null || cartDetails.isEmpty()) {
            return;
        }

        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverEmail(receiverEmail);
        order.setNote(note);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("PENDING");
        order.setOrderDate(LocalDateTime.now());

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        order.setTotalPrice(totalPrice);

        order = this.orderRepository.save(order);

        for (CartDetail cd : cartDetails) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(cd.getProduct());
            orderDetail.setQuantity((int) cd.getQuantity());
            orderDetail.setPrice(cd.getPrice());
            
            this.orderDetailRepository.save(orderDetail);
            
            // Giảm số lượng sản phẩm trong kho
            Product product = cd.getProduct();
            long newQuantity = product.getQuantity() - cd.getQuantity();
            if (newQuantity < 0) {
                newQuantity = 0;
            }
            product.setQuantity(newQuantity);
            this.productRepository.save(product);
        }

        List<Long> cartDetailIds = new ArrayList<>();
        for (CartDetail cd : cartDetails) {
            cartDetailIds.add(cd.getId());
        }
        
        for (Long cdId : cartDetailIds) {
            this.cartDetailRepository.deleteById(cdId);
        }
        
        cart.setSum(0);
        this.cartRepository.save(cart);

        session.setAttribute("sum", 0);
    }

    // Xử lý đặt hàng chỉ với các sản phẩm đã chọn
    @Transactional
    public void handlePlaceOrderSelected(User user, HttpSession session,
                            String receiverName, String receiverPhone, String receiverAddress,
                            String receiverEmail, String note, String paymentMethod,
                            List<Long> selectedCartDetailIds) {
        
        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null || selectedCartDetailIds == null || selectedCartDetailIds.isEmpty()) {
            return;
        }

        // Lấy danh sách CartDetail đã chọn
        List<CartDetail> selectedCartDetails = new ArrayList<>();
        for (Long id : selectedCartDetailIds) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(id);
            if (cdOptional.isPresent()) {
                selectedCartDetails.add(cdOptional.get());
            }
        }

        if (selectedCartDetails.isEmpty()) {
            return;
        }

        // Tạo Order
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverEmail(receiverEmail);
        order.setNote(note);
        order.setPaymentMethod(paymentMethod);
        
        // Đặt trạng thái thanh toán và trạng thái đơn hàng dựa trên phương thức thanh toán
        if ("VNPAY".equals(paymentMethod)) {
            order.setPaymentStatus("PAID"); // VNPay: đã thanh toán
            order.setStatus("CONFIRMED"); // VNPay: tự động xác nhận
        } else {
            order.setPaymentStatus("UNPAID"); // COD: chưa thanh toán
            order.setStatus("PENDING"); // COD: chờ xác nhận
        }
        
        order.setOrderDate(LocalDateTime.now());

        // Tính tổng giá chỉ cho các sản phẩm đã chọn
        double totalPrice = 0;
        for (CartDetail cd : selectedCartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        order.setTotalPrice(totalPrice);

        order = this.orderRepository.save(order);

        // Tạo OrderDetail cho các sản phẩm đã chọn và giảm số lượng tồn kho
        for (CartDetail cd : selectedCartDetails) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(cd.getProduct());
            orderDetail.setQuantity((int) cd.getQuantity());
            orderDetail.setPrice(cd.getPrice());
            
            this.orderDetailRepository.save(orderDetail);
            
            // Giảm số lượng sản phẩm trong kho
            Product product = cd.getProduct();
            long newQuantity = product.getQuantity() - cd.getQuantity();
            if (newQuantity < 0) {
                newQuantity = 0;
            }
            product.setQuantity(newQuantity);
            this.productRepository.save(product);
        }

        // Xóa chỉ các CartDetail đã chọn
        for (Long cdId : selectedCartDetailIds) {
            this.cartDetailRepository.deleteById(cdId);
        }
        
        // Cập nhật sum của Cart (trừ đi số lượng sản phẩm đã đặt)
        int currentSum = cart.getSum();
        int newSum = currentSum - selectedCartDetails.size();
        if (newSum < 0) newSum = 0;
        
        cart.setSum(newSum);
        this.cartRepository.save(cart);

        // Cập nhật session
        session.setAttribute("sum", newSum);
    }
}