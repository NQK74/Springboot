package com.example.laptopshop.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.domain.dto.RegisterDTO;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/")
    public String getHomePage(Model model, HttpServletRequest request) {
        List<Product> products = productService.fetchProducts();
        model.addAttribute("products", products);
        return "client/homepage/show";
    }

    @GetMapping("/login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(
            @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            if (bindingResult.hasFieldErrors("firstName")) {
                model.addAttribute("errorFirstName", true);
            }
            if (bindingResult.hasFieldErrors("lastName")) {
                model.addAttribute("errorLastName", true);
            }
            if (bindingResult.hasFieldErrors("email")) {
                model.addAttribute("errorEmail", true);
            }
            if (bindingResult.hasFieldErrors("password")) {
                model.addAttribute("errorPassword", true);
            }
            if (bindingResult.hasFieldErrors("confirmPassword")) {
                model.addAttribute("errorConfirmPassword", true);
            }
            return "client/auth/register";
        }

        User user = this.userService.registerDTOtoUser(registerDTO);
        this.userService.handleSaveUser(user);

        return "redirect:/login?registerSuccess";
    }

    @GetMapping("/access-deny")
    public String getAccessDenyPage() {
        return "client/auth/access";
    }
}
