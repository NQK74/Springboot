package com.example.laptopshop.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        // Lấy status code từ request
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());

            // Xử lý lỗi 404 - Not Found
            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                return "error/404";
            }

            // Xử lý lỗi 500 - Internal Server Error
            if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                return "error/500";
            }

            // Xử lý các lỗi 4xx khác
            if (statusCode >= 400 && statusCode < 500) {
                return "error/404";
            }

            // Xử lý các lỗi 5xx khác
            if (statusCode >= 500) {
                return "error/500";
            }
        }

        // Mặc định trả về trang 500
        return "error/500";
    }
}
