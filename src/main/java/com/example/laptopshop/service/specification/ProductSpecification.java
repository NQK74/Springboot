package com.example.laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.example.laptopshop.domain.Product;

public class ProductSpecification {

    public static Specification<Product> hasFactory(List<String> factories) {
        return (root, query, criteriaBuilder) -> {
            if (factories == null || factories.isEmpty()) {
                return criteriaBuilder.conjunction();
            }
            return root.get("factory").in(factories);
        };
    }

    public static Specification<Product> hasTarget(List<String> targets) {
        return (root, query, criteriaBuilder) -> {
            if (targets == null || targets.isEmpty()) {
                return criteriaBuilder.conjunction();
            }
            return root.get("target").in(targets);
        };
    }

    public static Specification<Product> hasPriceGreaterThanOrEqual(Double minPrice) {
        return (root, query, criteriaBuilder) -> {
            if (minPrice == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice);
        };
    }

    public static Specification<Product> hasPriceLessThanOrEqual(Double maxPrice) {
        return (root, query, criteriaBuilder) -> {
            if (maxPrice == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice);
        };
    }

    public static Specification<Product> hasPriceBetween(Double minPrice, Double maxPrice) {
        return (root, query, criteriaBuilder) -> {
            if (minPrice == null && maxPrice == null) {
                return criteriaBuilder.conjunction();
            }
            if (minPrice != null && maxPrice != null) {
                return criteriaBuilder.between(root.get("price"), minPrice, maxPrice);
            }
            if (minPrice != null) {
                return criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice);
            }
            return criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice);
        };
    }

    public static Specification<Product> hasNameContaining(String keyword) {
        return (root, query, criteriaBuilder) -> {
            if (keyword == null || keyword.trim().isEmpty()) {
                return criteriaBuilder.conjunction();
            }
            String searchPattern = "%" + keyword.toLowerCase().trim() + "%";
            return criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), searchPattern);
        };
    }
}
