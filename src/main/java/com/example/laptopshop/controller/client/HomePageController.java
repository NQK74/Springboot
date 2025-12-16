package com.example.laptopshop.controller.client;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.domain.dto.RegisterDTO;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
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
        List<Product> allProducts = productService.fetchProducts();
        // Hiển thị 8 sản phẩm đầu tiên
        List<Product> products = allProducts.stream().limit(8).toList();
        model.addAttribute("products", products);
        return "client/homepage/show";
    }

    @GetMapping("/product/show")
    public String getAllProducts(Model model, 
                                  @RequestParam(value = "pageNo", required = false) Optional<String> pageNo,
                                  @RequestParam(value = "factory", required = false) List<String> factories,
                                  @RequestParam(value = "target", required = false) List<String> targets,
                                  @RequestParam(value = "minPrice", required = false) Double minPrice,
                                  @RequestParam(value = "maxPrice", required = false) Double maxPrice,
                                  @RequestParam(value = "sort", required = false) String sort,
                                  @RequestParam(value = "keyword", required = false) String keyword) {
        int pageNumber = 1;
        
        if (pageNo.isPresent()) {
            try {
                pageNumber = Integer.parseInt(pageNo.get());
                if (pageNumber < 1) {
                    pageNumber = 1;
                }
            } catch (NumberFormatException e) {
                pageNumber = 1;
            }
        }
        
        Page<Product> page = productService.fetchProductsWithFilters(pageNumber, factories, targets, minPrice, maxPrice, sort, keyword);
        
        model.addAttribute("products", page.getContent());
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalItems", page.getTotalElements());
        
        // Get all factories and targets for filter options
        model.addAttribute("allFactories", productService.getAllFactories());
        model.addAttribute("allTargets", productService.getAllTargets());
        
        // Keep selected filter values
        model.addAttribute("selectedFactories", factories);
        model.addAttribute("selectedTargets", targets);
        model.addAttribute("selectedMinPrice", minPrice);
        model.addAttribute("selectedMaxPrice", maxPrice);
        model.addAttribute("selectedSort", sort);
        model.addAttribute("keyword", keyword);
        
        return "client/product/show";
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
