
package com.example.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.example.laptopshop.domain.Cart;
import com.example.laptopshop.domain.CartDetail;
import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;

@Controller
public class ItemController {

    private final ProductService productService;
    private final UserService userService;

    public ItemController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable Long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("id", id);
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String AddProductToCart(@PathVariable Long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, session);
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
}