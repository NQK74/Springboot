package com.example.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.service.ProductService;
import com.example.laptopshop.service.UploadService;

import jakarta.validation.Valid;

@Controller
public class ProductController {
    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("admin/product")
    public String getProduct(Model model, 
                             @RequestParam(value = "pageNo", required = false) Optional<String> pageNo,
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
        
        Page<Product> page;
        if (keyword != null && !keyword.trim().isEmpty()) {
            page = productService.searchProductsWithPagination(keyword.trim(), pageNumber);
            model.addAttribute("keyword", keyword.trim());
        } else {
            page = productService.fetchProductsWithPagination(pageNumber);
        }
        
        model.addAttribute("products", page.getContent());
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalItems", page.getTotalElements());
        
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String postCreateProduct(@ModelAttribute("newProduct") @Valid Product newProduct,
            BindingResult newProductBindingResult,
            @RequestParam("imageFile") MultipartFile productFile) {

        List<FieldError> errors = newProductBindingResult.getFieldErrors();

        for (FieldError error : errors) {
            System.out.println(">>> check error: " + error.getField() + " - " + error.getDefaultMessage());
        }
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String productImg = this.uploadService.handleSavaUploadFile(productFile, "product");
        newProduct.setImage(productImg);
        this.productService.createProduct(newProduct);

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable Long id) {
        Product currentProduct = this.productService.getProductById(id);
        model.addAttribute("existingProduct", currentProduct);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update/{id}")
    public String postUpdateProduct(
            @ModelAttribute("existingProduct") @Valid Product existingProduct,
            BindingResult existingProductBindingResult,
            @RequestParam("imageFile") MultipartFile productFile) {

        if (existingProductBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.getProductById(existingProduct.getId());
        if (currentProduct != null) {
            currentProduct.setName(existingProduct.getName());
            currentProduct.setPrice(existingProduct.getPrice());
            currentProduct.setShortDesc(existingProduct.getShortDesc());
            currentProduct.setDetailDesc(existingProduct.getDetailDesc());
            currentProduct.setQuantity(existingProduct.getQuantity());
            if (existingProduct.getFactory() != null) {
                currentProduct.setFactory(existingProduct.getFactory());
            }
            if (existingProduct.getTarget() != null) {
                currentProduct.setTarget(existingProduct.getTarget());
            }

            if (!productFile.isEmpty()) {
                String productImg = this.uploadService.handleSavaUploadFile(productFile, "product");
                currentProduct.setImage(productImg);
            }
            this.productService.updateProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable Long id) {

        Product product = this.productService.getProductById(id);
        model.addAttribute("id", id);
        model.addAttribute("product", product);

        return "admin/product/detail";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete/{id}")
    public String postDeleteProduct(@PathVariable Long id, Model model) {
        try {
            this.productService.deleteAProduct(id);
            return "redirect:/admin/product";
        } catch (Exception e) {
            Product product = this.productService.getProductById(id);
            model.addAttribute("id", id);
            model.addAttribute("product", product);
            model.addAttribute("errorMessage", e.getMessage());
            return "admin/product/delete";
        }
    }
}
