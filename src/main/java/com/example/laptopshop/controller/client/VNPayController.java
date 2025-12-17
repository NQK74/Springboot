package com.example.laptopshop.controller.client;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.laptopshop.domain.Cart;
import com.example.laptopshop.domain.CartDetail;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.OrderService;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;
import com.example.laptopshop.service.VNPayService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/vnpay")
public class VNPayController {

    private final VNPayService vnPayService;
    private final ProductService productService;
    private final UserService userService;
    private final OrderService orderService;

    public VNPayController(VNPayService vnPayService, ProductService productService,
                          UserService userService, OrderService orderService) {
        this.vnPayService = vnPayService;
        this.productService = productService;
        this.userService = userService;
        this.orderService = orderService;
    }

    /**
     * Xử lý khi user chọn thanh toán VNPay
     * Tạo đơn hàng với status PENDING_PAYMENT và redirect sang VNPay
     */
    @PostMapping("/create-payment")
    public String createPayment(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);

        // Lấy thông tin từ form
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");
        String receiverEmail = request.getParameter("receiverEmail");
        String note = request.getParameter("note");

        // Lấy danh sách ID sản phẩm đã chọn từ session
        @SuppressWarnings("unchecked")
        List<Long> selectedCartDetailIds = (List<Long>) session.getAttribute("selectedCartDetailIds");

        if (selectedCartDetailIds == null || selectedCartDetailIds.isEmpty()) {
            return "redirect:/cart";
        }

        // Lấy cart và tính tổng tiền
        Cart cart = this.productService.fetchByUser(user);
        double totalPrice = 0;
        for (Long id : selectedCartDetailIds) {
            for (CartDetail cd : cart.getCartDetails()) {
                if (cd.getId() == id) {
                    totalPrice += cd.getPrice() * cd.getQuantity();
                    break;
                }
            }
        }

        // Lưu thông tin đơn hàng vào session để xử lý sau khi thanh toán thành công
        session.setAttribute("vnpay_receiverName", receiverName);
        session.setAttribute("vnpay_receiverPhone", receiverPhone);
        session.setAttribute("vnpay_receiverAddress", receiverAddress);
        session.setAttribute("vnpay_receiverEmail", receiverEmail);
        session.setAttribute("vnpay_note", note);
        session.setAttribute("vnpay_totalPrice", totalPrice);

        // Tạo mã đơn hàng tạm thời (timestamp)
        String orderId = String.valueOf(System.currentTimeMillis());
        session.setAttribute("vnpay_orderId", orderId);

        // Tạo URL thanh toán VNPay
        String orderInfo = "Thanh toan don hang LaptopShop #" + orderId;
        long amount = (long) totalPrice;

        String paymentUrl = this.vnPayService.createPaymentUrl(amount, orderInfo, orderId, request);

        return "redirect:" + paymentUrl;
    }

    /**
     * Xử lý callback từ VNPay sau khi thanh toán
     */
    @GetMapping("/payment-return")
    public String paymentReturn(HttpServletRequest request, Model model) {
        // Lấy tất cả params từ VNPay
        Map<String, String> vnpParams = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            if (paramValue != null && !paramValue.isEmpty()) {
                vnpParams.put(paramName, paramValue);
            }
        }

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_PayDate = request.getParameter("vnp_PayDate");

        // Validate chữ ký
        boolean isValid = this.vnPayService.validatePaymentResponse(new HashMap<>(vnpParams));
        boolean isSuccess = this.vnPayService.isPaymentSuccess(vnp_ResponseCode);

        HttpSession session = request.getSession(false);

        if (isValid && isSuccess) {
            // Thanh toán thành công - Tạo đơn hàng
            String email = (String) session.getAttribute("email");
            User user = this.userService.getUserByEmail(email);

            String receiverName = (String) session.getAttribute("vnpay_receiverName");
            String receiverPhone = (String) session.getAttribute("vnpay_receiverPhone");
            String receiverAddress = (String) session.getAttribute("vnpay_receiverAddress");
            String receiverEmail = (String) session.getAttribute("vnpay_receiverEmail");
            String note = (String) session.getAttribute("vnpay_note");

            @SuppressWarnings("unchecked")
            List<Long> selectedCartDetailIds = (List<Long>) session.getAttribute("selectedCartDetailIds");

            if (selectedCartDetailIds != null && !selectedCartDetailIds.isEmpty()) {
                // Tạo đơn hàng với status PAID
                this.productService.handlePlaceOrderSelected(
                    user, session, receiverName, receiverPhone,
                    receiverAddress, receiverEmail, note, "VNPAY",
                    selectedCartDetailIds
                );
            }

            // Xóa các thông tin tạm từ session
            clearVnPaySession(session);

            model.addAttribute("success", true);
            model.addAttribute("message", "Thanh toán thành công!");
            model.addAttribute("orderId", vnp_TxnRef);
            model.addAttribute("amount", Long.parseLong(vnp_Amount) / 100);
            model.addAttribute("orderInfo", vnp_OrderInfo);
            model.addAttribute("transactionNo", vnp_TransactionNo);
            model.addAttribute("bankCode", vnp_BankCode);
            model.addAttribute("payDate", vnp_PayDate);
        } else {
            // Thanh toán thất bại
            clearVnPaySession(session);

            model.addAttribute("success", false);
            model.addAttribute("message", this.vnPayService.getResponseMessage(vnp_ResponseCode));
            model.addAttribute("responseCode", vnp_ResponseCode);
        }

        return "client/cart/vnpay-result";
    }

    /**
     * Xóa thông tin VNPay tạm từ session
     */
    private void clearVnPaySession(HttpSession session) {
        session.removeAttribute("vnpay_receiverName");
        session.removeAttribute("vnpay_receiverPhone");
        session.removeAttribute("vnpay_receiverAddress");
        session.removeAttribute("vnpay_receiverEmail");
        session.removeAttribute("vnpay_note");
        session.removeAttribute("vnpay_totalPrice");
        session.removeAttribute("vnpay_orderId");
        session.removeAttribute("selectedCartDetailIds");
    }
}
