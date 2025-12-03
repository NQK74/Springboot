package com.example.laptopshop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.service.ProductService;

@Controller

public class HomePageController {

    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/") // Get
    public String getHomePage(Model model) {
        List<Product> products = productService.fetchProducts();
        model.addAttribute("products", products);
        return "client/homepage/show";
    }

}
