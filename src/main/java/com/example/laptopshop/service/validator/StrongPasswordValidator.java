package com.example.laptopshop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class StrongPasswordValidator implements ConstraintValidator<StrongPassword, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) {
            return false;
        }
        // Check minimum length
        if (value.length() < 8) {
            return false;
        }
        // Check for at least one uppercase letter
        if (!value.matches(".*[A-Z].*")) {
            return false;
        }
        // Check for at least one lowercase letter
        if (!value.matches(".*[a-z].*")) {
            return false;
        }
        // Check for at least one digit
        if (!value.matches(".*\\d.*")) {
            return false;
        }
        // Check for at least one special character
        if (!value.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*")) {
            return false;
        }
        return true;
    }
}
