package com.example.laptopshop.controller.client;

import java.security.SecureRandom;
import java.util.regex.Pattern;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.laptopshop.domain.PasswordResetToken;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.repository.PasswordResetTokenRepository;
import com.example.laptopshop.service.EmailService;
import com.example.laptopshop.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ForgotPasswordController {

    private final UserService userService;
    private final PasswordResetTokenRepository tokenRepository;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;
    
    // Pattern mật khẩu: ít nhất 8 ký tự, chữ hoa, chữ thường, số và ký tự đặc biệt
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    );

    public ForgotPasswordController(UserService userService,
                                    PasswordResetTokenRepository tokenRepository,
                                    EmailService emailService,
                                    PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.tokenRepository = tokenRepository;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
    }

   
    private String generateOTP() {
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email,
                                        HttpSession session,
                                        Model model) {
        User user = userService.getUserByEmail(email);

        if (user == null) {
            model.addAttribute("error", "Không tìm thấy tài khoản với email này.");
            return "client/auth/forgot-password";
        }

        // Xóa token cũ nếu có
        tokenRepository.deleteByUser(user);

        // Tạo OTP mới
        String otpCode = generateOTP();
        PasswordResetToken resetToken = new PasswordResetToken(otpCode, user);
        tokenRepository.save(resetToken);

        try {
            emailService.sendPasswordResetOTP(user.getEmail(), otpCode);
            // Lưu email vào session để sử dụng ở bước tiếp theo
            session.setAttribute("resetEmail", email);
            model.addAttribute("success", "Mã xác nhận đã được gửi đến email của bạn.");
            model.addAttribute("showOtpForm", true);
            model.addAttribute("email", email);
        } catch (Exception e) {
            model.addAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
        }

        return "client/auth/forgot-password";
    }

    @PostMapping("/verify-otp")
    public String verifyOTP(@RequestParam("otp") String otp,
                            HttpSession session,
                            Model model) {
        String email = (String) session.getAttribute("resetEmail");
        
        if (email == null) {
            model.addAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thử lại.");
            return "client/auth/forgot-password";
        }

        PasswordResetToken resetToken = tokenRepository.findByOtpCode(otp);

        if (resetToken == null || resetToken.isExpired()) {
            model.addAttribute("error", "Mã xác nhận không hợp lệ hoặc đã hết hạn.");
            model.addAttribute("showOtpForm", true);
            model.addAttribute("email", email);
            return "client/auth/forgot-password";
        }

        // Kiểm tra OTP có khớp với email không
        if (!resetToken.getUser().getEmail().equals(email)) {
            model.addAttribute("error", "Mã xác nhận không hợp lệ.");
            model.addAttribute("showOtpForm", true);
            model.addAttribute("email", email);
            return "client/auth/forgot-password";
        }

        // Lưu OTP vào session để sử dụng khi đặt lại mật khẩu
        session.setAttribute("verifiedOtp", otp);
        return "redirect:/reset-password";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(HttpSession session, Model model) {
        String otp = (String) session.getAttribute("verifiedOtp");
        String email = (String) session.getAttribute("resetEmail");

        if (otp == null || email == null) {
            model.addAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thử lại.");
            model.addAttribute("invalidToken", true);
            return "client/auth/reset-password";
        }

        return "client/auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(@RequestParam("password") String password,
                                       @RequestParam("confirmPassword") String confirmPassword,
                                       HttpSession session,
                                       Model model) {
        String otp = (String) session.getAttribute("verifiedOtp");
        String email = (String) session.getAttribute("resetEmail");

        if (otp == null || email == null) {
            model.addAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thử lại.");
            model.addAttribute("invalidToken", true);
            return "client/auth/reset-password";
        }

        PasswordResetToken resetToken = tokenRepository.findByOtpCode(otp);

        if (resetToken == null || resetToken.isExpired()) {
            model.addAttribute("error", "Mã xác nhận không hợp lệ hoặc đã hết hạn.");
            model.addAttribute("invalidToken", true);
            return "client/auth/reset-password";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            return "client/auth/reset-password";
        }

        // Validate password: ít nhất 8 ký tự, chữ hoa, chữ thường, số và ký tự đặc biệt
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            model.addAttribute("error", "Mật khẩu phải có tối thiểu 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt (@$!%*?&).");
            return "client/auth/reset-password";
        }

        // Cập nhật mật khẩu
        User user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(password));
        userService.handleSaveUser(user);

        // Xóa token đã sử dụng và xóa session
        tokenRepository.delete(resetToken);
        session.removeAttribute("verifiedOtp");
        session.removeAttribute("resetEmail");

        return "redirect:/login?resetSuccess";
    }
}
