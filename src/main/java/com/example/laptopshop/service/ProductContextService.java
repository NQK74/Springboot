package com.example.laptopshop.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.example.laptopshop.domain.Product;
import com.example.laptopshop.repository.ProductRepository;

@Service
public class ProductContextService {
    
    private final ProductRepository productRepository;
    private final DecimalFormat priceFormat = new DecimalFormat("#,###");
    
    // Keywords để detect intent
    private static final List<String> LAPTOP_KEYWORDS = Arrays.asList(
            "laptop", "máy tính", "notebook", "macbook", "dell", "hp", "asus", 
            "lenovo", "acer", "msi", "thinkpad", "gaming", "văn phòng", "đồ họa",
            "sinh viên", "lập trình", "code", "học tập", "làm việc"
    );
    
    private static final List<String> PRICE_KEYWORDS = Arrays.asList(
            "giá", "bao nhiêu", "tiền", "triệu", "rẻ", "đắt", "tầm giá", 
            "ngân sách", "budget", "dưới", "trên", "khoảng"
    );
    
    private static final List<String> RECOMMEND_KEYWORDS = Arrays.asList(
            "tư vấn", "gợi ý", "đề xuất", "nên mua", "recommend", "suggest",
            "phù hợp", "tốt nhất", "hot", "bán chạy", "mới nhất"
    );
    
    public ProductContextService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    
    /**
     * Build RAG context based on user message
     */
    public String buildContext(String userMessage) {
        String lowerMessage = userMessage.toLowerCase();
        
        List<Product> relevantProducts = new ArrayList<>();
        
        // Detect intent và lấy sản phẩm phù hợp
        if (isAskingForRecommendation(lowerMessage)) {
            // Gợi ý sản phẩm hot/bán chạy
            relevantProducts = getTopProducts(5);
        } else if (isSearchingByBrand(lowerMessage)) {
            // Tìm theo hãng
            String brand = extractBrand(lowerMessage);
            if (brand != null) {
                relevantProducts = searchByFactory(brand);
            }
        } else if (isSearchingByPrice(lowerMessage)) {
            // Tìm theo giá
            double[] priceRange = extractPriceRange(lowerMessage);
            relevantProducts = searchByPriceRange(priceRange[0], priceRange[1]);
        } else if (isSearchingByTarget(lowerMessage)) {
            // Tìm theo mục đích sử dụng
            String target = extractTarget(lowerMessage);
            if (target != null) {
                relevantProducts = searchByTarget(target);
            }
        } else if (containsLaptopKeywords(lowerMessage)) {
            // Tìm chung các sản phẩm liên quan
            relevantProducts = searchProducts(userMessage);
        }
        
        // Nếu không tìm thấy gì cụ thể, lấy một số sản phẩm phổ biến
        if (relevantProducts.isEmpty() && containsLaptopKeywords(lowerMessage)) {
            relevantProducts = getTopProducts(3);
        }
        
        return formatProductsContext(relevantProducts);
    }
    
    /**
     * Format danh sách sản phẩm thành context string
     */
    private String formatProductsContext(List<Product> products) {
        if (products.isEmpty()) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        sb.append("Danh sách sản phẩm liên quan:\n\n");
        
        for (int i = 0; i < products.size(); i++) {
            Product p = products.get(i);
            sb.append(String.format("%d. **%s**\n", i + 1, p.getName()));
            sb.append(String.format("   - ID sản phẩm: %d\n", p.getId()));
            sb.append(String.format("   - Link xem chi tiết: /product/%d\n", p.getId()));
            sb.append(String.format("   - Giá: %s VNĐ\n", priceFormat.format(p.getPrice())));
            sb.append(String.format("   - Hãng: %s\n", p.getFactory() != null ? p.getFactory() : "N/A"));
            sb.append(String.format("   - Phù hợp: %s\n", p.getTarget() != null ? p.getTarget() : "Đa năng"));
            sb.append(String.format("   - Còn hàng: %d sản phẩm\n", p.getQuantity()));
            if (p.getShortDesc() != null && !p.getShortDesc().isEmpty()) {
                sb.append(String.format("   - Mô tả: %s\n", p.getShortDesc()));
            }
            sb.append("\n");
        }
        
        return sb.toString();
    }
    
    // ===== Intent Detection Methods =====
    
    private boolean isAskingForRecommendation(String message) {
        return RECOMMEND_KEYWORDS.stream().anyMatch(message::contains);
    }
    
    private boolean isSearchingByPrice(String message) {
        return PRICE_KEYWORDS.stream().anyMatch(message::contains);
    }
    
    private boolean isSearchingByBrand(String message) {
        String[] brands = {"dell", "hp", "asus", "lenovo", "acer", "msi", "macbook", "apple", "thinkpad"};
        for (String brand : brands) {
            if (message.contains(brand)) return true;
        }
        return false;
    }
    
    private boolean isSearchingByTarget(String message) {
        String[] targets = {"gaming", "game", "văn phòng", "đồ họa", "design", "lập trình", "code", 
                           "sinh viên", "học sinh", "học tập", "làm việc", "doanh nhân"};
        for (String target : targets) {
            if (message.contains(target)) return true;
        }
        return false;
    }
    
    private boolean containsLaptopKeywords(String message) {
        return LAPTOP_KEYWORDS.stream().anyMatch(message::contains);
    }
    
    // ===== Data Extraction Methods =====
    
    private String extractBrand(String message) {
        String[][] brandMappings = {
            {"dell", "DELL"},
            {"hp", "HP"},
            {"asus", "ASUS"},
            {"lenovo", "LENOVO"},
            {"thinkpad", "LENOVO"},
            {"acer", "ACER"},
            {"msi", "MSI"},
            {"macbook", "APPLE"},
            {"apple", "APPLE"}
        };
        
        for (String[] mapping : brandMappings) {
            if (message.contains(mapping[0])) {
                return mapping[1];
            }
        }
        return null;
    }
    
    private String extractTarget(String message) {
        if (message.contains("gaming") || message.contains("game")) {
            return "Gaming";
        } else if (message.contains("văn phòng") || message.contains("làm việc") || message.contains("doanh nhân")) {
            return "Văn phòng";
        } else if (message.contains("đồ họa") || message.contains("design") || message.contains("thiết kế")) {
            return "Đồ họa - Kỹ thuật";
        } else if (message.contains("sinh viên") || message.contains("học sinh") || message.contains("học tập")) {
            return "Sinh viên - Văn phòng";
        } else if (message.contains("lập trình") || message.contains("code") || message.contains("developer")) {
            return "Lập trình";
        }
        return null;
    }
    
    private double[] extractPriceRange(String message) {
        double minPrice = 0;
        double maxPrice = Double.MAX_VALUE;
        
        // Patterns như "dưới 20 triệu", "trên 15 triệu", "từ 10 đến 20 triệu", "tầm 15 triệu"
        try {
            if (message.contains("dưới")) {
                String numStr = extractNumber(message.substring(message.indexOf("dưới")));
                maxPrice = parsePrice(numStr);
            } else if (message.contains("trên")) {
                String numStr = extractNumber(message.substring(message.indexOf("trên")));
                minPrice = parsePrice(numStr);
            } else if (message.contains("tầm") || message.contains("khoảng")) {
                String numStr = extractNumber(message);
                double price = parsePrice(numStr);
                minPrice = price * 0.8; // -20%
                maxPrice = price * 1.2; // +20%
            } else {
                // Default range nếu chỉ mention về giá
                String numStr = extractNumber(message);
                if (!numStr.isEmpty()) {
                    double price = parsePrice(numStr);
                    minPrice = price * 0.7;
                    maxPrice = price * 1.3;
                }
            }
        } catch (Exception e) {
            // Fallback to default range
            minPrice = 0;
            maxPrice = Double.MAX_VALUE;
        }
        
        // Nếu không extract được, set default range phổ biến
        if (maxPrice == Double.MAX_VALUE && minPrice == 0) {
            if (message.contains("rẻ") || message.contains("giá rẻ")) {
                maxPrice = 15000000;
            } else if (message.contains("cao cấp") || message.contains("đắt")) {
                minPrice = 30000000;
            }
        }
        
        return new double[]{minPrice, maxPrice};
    }
    
    private String extractNumber(String text) {
        StringBuilder sb = new StringBuilder();
        boolean foundDigit = false;
        for (char c : text.toCharArray()) {
            if (Character.isDigit(c) || c == '.' || c == ',') {
                sb.append(c);
                foundDigit = true;
            } else if (foundDigit && c == ' ') {
                break;
            }
        }
        return sb.toString().replace(",", "");
    }
    
    private double parsePrice(String numStr) {
        if (numStr.isEmpty()) return 0;
        double value = Double.parseDouble(numStr);
        // Nếu số nhỏ, giả định là triệu VNĐ
        if (value < 1000) {
            value = value * 1000000;
        }
        return value;
    }
    
    // ===== Database Query Methods =====
    
    private List<Product> getTopProducts(int limit) {
        try {
            return productRepository.findAll(PageRequest.of(0, limit)).getContent();
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
    private List<Product> searchProducts(String keyword) {
        try {
            return productRepository.searchProducts(keyword, PageRequest.of(0, 5)).getContent();
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
    private List<Product> searchByFactory(String factory) {
        try {
            return productRepository.findByFactoryContainingIgnoreCase(factory, PageRequest.of(0, 5));
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
    private List<Product> searchByTarget(String target) {
        try {
            return productRepository.findByTargetContainingIgnoreCase(target, PageRequest.of(0, 5));
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
    private List<Product> searchByPriceRange(double minPrice, double maxPrice) {
        try {
            if (maxPrice == Double.MAX_VALUE) {
                maxPrice = 999999999;
            }
            return productRepository.findByPriceBetween(minPrice, maxPrice, PageRequest.of(0, 5));
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
}
