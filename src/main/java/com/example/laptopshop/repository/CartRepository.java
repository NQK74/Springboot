package com.example.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.laptopshop.domain.Cart;
import com.example.laptopshop.domain.User;

public interface  CartRepository extends JpaRepository<Cart, Long> {

    Cart findByUser(User user);
}
