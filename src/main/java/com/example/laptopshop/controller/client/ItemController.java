
package com.example.laptopshop.controller.client;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.laptopshop.domain.Cart;
import com.example.laptopshop.domain.CartDetail;
import com.example.laptopshop.domain.Order;
import com.example.laptopshop.domain.OrderDetail;
import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.Review;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.OrderService;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.ReviewService;
import com.example.laptopshop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {

    private final ProductService productService;
    private final UserService userService;
    private final OrderService orderService;
    private final ReviewService reviewService;

    public ItemController(ProductService productService, UserService userService, 
                         OrderService orderService, ReviewService reviewService) {
        this.productService = productService;
        this.userService = userService;
        this.orderService = orderService;
        this.reviewService = reviewService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable Long id, HttpServletRequest request) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("id", id);
        model.addAttribute("product", product);
        
        // Lấy thông tin đánh giá
        double averageRating = this.reviewService.getAverageRating(id);
        long totalReviews = this.reviewService.countReviewsByProductId(id);
        Map<Integer, Long> ratingBreakdown = this.reviewService.getRatingBreakdown(id);
        Page<Review> reviewsPage = this.reviewService.getReviewsByProductId(id, 0, 5);
        
        model.addAttribute("averageRating", averageRating);
        model.addAttribute("totalReviews", totalReviews);
        model.addAttribute("ratingBreakdown", ratingBreakdown);
        model.addAttribute("reviews", reviewsPage.getContent());
        model.addAttribute("totalPages", reviewsPage.getTotalPages());
        model.addAttribute("currentPage", 0);
        
        // Kiểm tra user đã login và đã đánh giá chưa
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("email") != null) {
            String email = (String) session.getAttribute("email");
            User user = this.userService.getUserByEmail(email);
            if (user != null) {
                boolean hasReviewed = this.reviewService.hasUserReviewed(user, product);
                model.addAttribute("hasReviewed", hasReviewed);
                model.addAttribute("currentUser", user);
            }
        }
        
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String AddProductToCart(@PathVariable Long id, 
                                   @RequestParam(defaultValue = "1") long quantity,
                                   HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, quantity, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.productService.fetchByUser(user);
        
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        
        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);
        
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.productService.handleRemoveCartDetail(id, session);
        return "redirect:/cart";
    }

    @PostMapping("/update-cart-quantity/{id}")
    public String updateCartQuantity(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String quantityStr = request.getParameter("quantity");
        
        try {
            long quantity = Long.parseLong(quantityStr);
            this.productService.handleUpdateCartQuantity(id, quantity, session);
        } catch (NumberFormatException e) {
            // Handle error
        }
        
        return "redirect:/cart";
    }
    
    // API để toggle trạng thái selected của từng sản phẩm
    @PostMapping("/api/cart/toggle-select/{id}")
    @ResponseBody
    public ResponseEntity<?> toggleSelectCartDetail(
            @PathVariable long id,
            @RequestParam boolean selected) {
        this.productService.updateCartDetailSelection(id, selected);
        return ResponseEntity.ok().build();
    }
    
    // API để toggle tất cả sản phẩm
    @PostMapping("/api/cart/toggle-select-all")
    @ResponseBody
    public ResponseEntity<?> toggleSelectAll(
            @RequestParam boolean selected,
            @RequestParam String cartDetailIds) {
        
        List<Long> ids = Arrays.stream(cartDetailIds.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        
        this.productService.updateAllCartDetailSelection(ids, selected);
        return ResponseEntity.ok().build();
    }
    
    @PostMapping("/confirm-checkout")
    public String getCheckoutPage(
            Model model, 
            HttpServletRequest request,
            @RequestParam(required = false) String selectedItems) {
        
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.productService.fetchByUser(user);
        
        List<CartDetail> cartDetails;
        
        if (selectedItems != null && !selectedItems.isEmpty()) {
            // Nếu có selectedItems, chỉ lấy những sản phẩm được chọn
            List<Long> selectedIds = Arrays.stream(selectedItems.split(","))
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            
            cartDetails = cart.getCartDetails().stream()
                    .filter(cd -> selectedIds.contains(cd.getId()))
                    .collect(Collectors.toList());
        } else {
            // Nếu không có selectedItems, lấy tất cả sản phẩm có selected = true
            cartDetails = cart.getCartDetails().stream()
                    .filter(CartDetail::isSelected)
                    .collect(Collectors.toList());
        }
        
        if (cartDetails.isEmpty()) {
            return "redirect:/cart";
        }
        
        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        
        // Lưu danh sách ID sản phẩm đã chọn vào session để sử dụng khi place order
        List<Long> selectedCartDetailIds = cartDetails.stream()
                .map(CartDetail::getId)
                .collect(Collectors.toList());
        session.setAttribute("selectedCartDetailIds", selectedCartDetailIds);
        
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);
        
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String placeOrder(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        
        // Lấy thông tin từ form
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");
        String receiverEmail = request.getParameter("receiverEmail");
        String note = request.getParameter("note");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Lấy danh sách ID sản phẩm đã chọn từ session
        @SuppressWarnings("unchecked")
        List<Long> selectedCartDetailIds = (List<Long>) session.getAttribute("selectedCartDetailIds");
        
        if (selectedCartDetailIds == null || selectedCartDetailIds.isEmpty()) {
            return "redirect:/cart";
        }
        
        // Xử lý đặt hàng chỉ với các sản phẩm đã chọn
        this.productService.handlePlaceOrderSelected(
            user, session, receiverName, receiverPhone, 
            receiverAddress, receiverEmail, note, paymentMethod,
            selectedCartDetailIds
        );
        
        // Xóa danh sách đã chọn khỏi session
        session.removeAttribute("selectedCartDetailIds");
        
        return "redirect:/order-success";
    }

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "client/cart/order-success";
    }

    /**
     * Endpoint để hiển thị lịch sử đơn hàng của user đang login
     */
    @GetMapping("/order-history")
    public String getOrderHistory(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        
        if (user != null) {
            List<Order> listOrder = this.orderService.getOrdersByUser(user);
            model.addAttribute("listOrder", listOrder);
        }
        
        return "client/order/order-history";
    }

    /**
     * Endpoint để xóa đơn hàng (chỉ cho phép xóa khi status = PENDING)
     */
    @PostMapping("/order-delete/{id}")
    public String deleteOrder(@PathVariable long id, HttpServletRequest request) {
        Optional<Order> orderOptional = this.orderService.getOrderById(id);
        
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            // Chỉ cho phép xóa nếu đơn hàng đang ở trạng thái PENDING
            if ("PENDING".equals(order.getStatus())) {
                this.orderService.deleteOrder(id);
            }
        }
        
        return "redirect:/order-history";
    }

    /**
     * Endpoint để xem chi tiết đơn hàng (các sản phẩm trong đơn)
     */
    @GetMapping("/order-detail/{id}")
    public String getOrderDetail(@PathVariable long id, Model model) {
        Optional<Order> orderOptional = this.orderService.getOrderById(id);
        
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = this.orderService.getOrderDetails(id);
            
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", orderDetails);
            
            return "client/order/order-detail";
        }
        
        return "redirect:/order-history";
    }

    @GetMapping("/account")
    public String getAccount(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            model.addAttribute("user", user);
        }
        return "client/account/account";
    }

    @PostMapping("/account")
    public String updateAccount(
            @RequestParam("fullName") String fullName,
            @RequestParam("phone") String phone,
            @RequestParam("address") String address,
            @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
            HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        
        if (user != null) {
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            
            // Handle avatar upload
            if (avatarFile != null && !avatarFile.isEmpty()) {
                try {
                    String fileName = System.currentTimeMillis() + "_" + avatarFile.getOriginalFilename();
                    String uploadDir = "src/main/webapp/resources/images/avatar/";
                    File uploadFolder = new File(uploadDir);
                    if (!uploadFolder.exists()) {
                        uploadFolder.mkdirs();
                     }
                    
                    Path filePath = Paths.get(uploadDir + fileName);
                    Files.write(filePath, avatarFile.getBytes());
                    
                    user.setAvatar(fileName);
                } catch (Exception e) {
                    model.addAttribute("errorMessage", "Lỗi tải ảnh lên: " + e.getMessage());
                }
            }
            
            this.userService.handleSaveUser(user);
            
            // Update session
            session.setAttribute("fullName", fullName);
            session.setAttribute("avatar", user.getAvatar());
            
            model.addAttribute("user", user);
            model.addAttribute("successMessage", "Cập nhật thông tin thành công!");
        }
        
        return "client/account/account";
    }


    @GetMapping("/api/reviews/{productId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getReviews(
            @PathVariable long productId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {
        
        Page<Review> reviewsPage = this.reviewService.getReviewsByProductId(productId, page, size);
        
        List<Map<String, Object>> reviewsList = new ArrayList<>();
        for (Review review : reviewsPage.getContent()) {
            Map<String, Object> reviewMap = new HashMap<>();
            reviewMap.put("id", review.getId());
            reviewMap.put("rating", review.getRating());
            reviewMap.put("title", review.getTitle());
            reviewMap.put("content", review.getContent());
            reviewMap.put("helpfulCount", review.getHelpfulCount());
            reviewMap.put("createdAt", review.getCreatedAt().toString());
            reviewMap.put("userName", review.getUser().getFullName());
            reviewMap.put("userAvatar", review.getUser().getAvatar());
            reviewsList.add(reviewMap);
        }
        
        Map<String, Object> response = new HashMap<>();
        response.put("reviews", reviewsList);
        response.put("currentPage", page);
        response.put("totalPages", reviewsPage.getTotalPages());
        response.put("totalReviews", reviewsPage.getTotalElements());
        
        return ResponseEntity.ok(response);
    }
    
    @PostMapping("/api/reviews/submit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitReview(
            @RequestParam long productId,
            @RequestParam int rating,
            @RequestParam String title,
            @RequestParam String content,
            HttpServletRequest request) {
        
        Map<String, Object> response = new HashMap<>();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập để đánh giá");
            return ResponseEntity.ok(response);
        }
        
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Product product = this.productService.getProductById(productId);
        
        if (user == null || product == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy thông tin");
            return ResponseEntity.ok(response);
        }
        
        // Kiểm tra đã đánh giá chưa
        if (this.reviewService.hasUserReviewed(user, product)) {
            response.put("success", false);
            response.put("message", "Bạn đã đánh giá sản phẩm này rồi");
            return ResponseEntity.ok(response);
        }
        
        // Kiểm tra user đã mua sản phẩm chưa
        if (!this.reviewService.hasUserPurchasedProduct(user, product)) {
            response.put("success", false);
            response.put("message", "Bạn cần mua sản phẩm này trước khi đánh giá");
            return ResponseEntity.ok(response);
        }
        
        // Tạo đánh giá mới
        Review review = new Review(rating, title, content, user, product);
        this.reviewService.saveReview(review);
        
        response.put("success", true);
        response.put("message", "Đánh giá của bạn đã được gửi thành công!");
        
        // Trả về thông tin cập nhật
        response.put("averageRating", this.reviewService.getAverageRating(productId));
        response.put("totalReviews", this.reviewService.countReviewsByProductId(productId));
        
        return ResponseEntity.ok(response);
    }
    
    /**
     * API để đánh dấu đánh giá hữu ích
     */
    @PostMapping("/api/reviews/helpful/{reviewId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> markHelpful(@PathVariable long reviewId) {
        this.reviewService.incrementHelpfulCount(reviewId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        
        Optional<Review> reviewOpt = this.reviewService.getReviewById(reviewId);
        if (reviewOpt.isPresent()) {
            response.put("helpfulCount", reviewOpt.get().getHelpfulCount());
        }
        
        return ResponseEntity.ok(response);
    }
    
    /**
     * API để xóa đánh giá
     */
    @PostMapping("/api/reviews/delete/{reviewId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteReview(
            @PathVariable long reviewId,
            HttpServletRequest request) {
        
        Map<String, Object> response = new HashMap<>();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập");
            return ResponseEntity.ok(response);
        }
        
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        
        if (user == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy người dùng");
            return ResponseEntity.ok(response);
        }
        
        boolean deleted = this.reviewService.deleteReviewByUser(reviewId, user);
        
        if (deleted) {
            response.put("success", true);
            response.put("message", "Đã xóa đánh giá thành công");
        } else {
            response.put("success", false);
            response.put("message", "Không thể xóa đánh giá này");
        }
        
        return ResponseEntity.ok(response);
    }
    
    /**
     * API để cập nhật đánh giá
     */
    @PostMapping("/api/reviews/update/{reviewId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateReview(
            @PathVariable long reviewId,
            @RequestParam int rating,
            @RequestParam String title,
            @RequestParam String content,
            HttpServletRequest request) {
        
        Map<String, Object> response = new HashMap<>();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập");
            return ResponseEntity.ok(response);
        }
        
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        
        if (user == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy người dùng");
            return ResponseEntity.ok(response);
        }
        
        boolean updated = this.reviewService.updateReview(reviewId, user, rating, title, content);
        
        if (updated) {
            response.put("success", true);
            response.put("message", "Đã cập nhật đánh giá thành công");
        } else {
            response.put("success", false);
            response.put("message", "Không thể cập nhật đánh giá này");
        }
        
        return ResponseEntity.ok(response);
    }
}
