package com.example.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

    // DI - Dependency Injection
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUser = this.userService.getAllUsersByEmail("lolibatbai0204@gmail.com");
        System.out.println(arrUser);

        model.addAttribute("test", "test");
        model.addAttribute("khanh", "from controller");
        return "hello";
    }

    @RequestMapping("/admin/user") // Get
    public String getTableUser(Model model) {
        List<User> users = this.userService.getAllUser();
        model.addAttribute("users1", users);
        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}") // Get
    public String getUserDetailPage(Model model, @PathVariable Long id) {
        System.out.println(">>> check path id: " + id);
        User user = this.userService.getUserById(id);
        model.addAttribute("id", id);
        model.addAttribute("user", user);

        return "admin/user/detail";
    }

    @RequestMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUserPage(Model model, @ModelAttribute("newUser") User khanhUser) {
        this.userService.handleSaveUser(khanhUser);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}") // Get
    public String getUpdateUserpage(Model model, @PathVariable Long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("user", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update/{id}")
    public String postUpdateUser(Model model, @ModelAttribute("user") User user) {
        User currentUser = this.userService.getUserById(user.getId());
        if (currentUser != null) {
            currentUser.setAddress(user.getAddress());
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());

            this.userService.handleSaveUser(currentUser); // Lưu user đã update
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable Long id) {
        model.addAttribute("id", id);
        // User user = new User();
        // user.setId(id);
        model.addAttribute("user", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete/{id}")
    public String postDeleteUser(Model model, @ModelAttribute("user") User user) {
        this.userService.deleteAUser(user.getId());
        return "redirect:/admin/user";
    }

}
