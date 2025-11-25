package com.example.laptopshop.controller.employee;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeDashboardController {

    @GetMapping("/employee")
    public String getEmployeeDashboard(Model model) {
        return "employee/dashboard/show";
    }
}
