package com.example.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {

    List<Product> findByName(String name);

    // Tìm kiếm product theo name hoặc factory
    @Query("SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.factory) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Product> searchProducts(@Param("keyword") String keyword, Pageable pageable);

    void deleteById(long id);
    
    @Query("SELECT DISTINCT p.factory FROM Product p WHERE p.factory IS NOT NULL")
    List<String> findAllFactories();
    
    @Query("SELECT DISTINCT p.target FROM Product p WHERE p.target IS NOT NULL")
    List<String> findAllTargets();
}
