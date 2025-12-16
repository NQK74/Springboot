package com.example.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import com.example.laptopshop.domain.PasswordResetToken;
import com.example.laptopshop.domain.User;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {
    PasswordResetToken findByOtpCode(String otpCode);
    PasswordResetToken findByUser(User user);
    
    @Modifying
    @Transactional
    void deleteByUser(User user);
}
