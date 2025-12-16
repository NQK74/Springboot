package com.example.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.laptopshop.domain.Role;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.UploadService;
import com.example.laptopshop.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

    // DI - Dependency Injection
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUser = this.userService.getAllUsersByEmail("lolibatbai0204@gmail.com");
        System.out.println(arrUser);

        model.addAttribute("test", "test");
        model.addAttribute("khanh", "from controller");
        return "hello";
    }

    @GetMapping("/admin/user") // Get
    public String getTableUser(Model model, 
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
        
        Page<User> page;
        if (keyword != null && !keyword.trim().isEmpty()) {
            page = this.userService.searchUsersWithPagination(keyword.trim(), pageNumber);
            model.addAttribute("keyword", keyword.trim());
        } else {
            page = this.userService.getAllUsersWithPagination(pageNumber);
        }
        
        model.addAttribute("users1", page.getContent());
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("currentPage", pageNumber);
        model.addAttribute("totalItems", page.getTotalElements());
        
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

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model,
            @ModelAttribute("newUser") @Valid User khanhUser, BindingResult newUserBindingResult,
            @RequestParam("khanhFile") MultipartFile file) {
        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>>" + error.getField() + " - " + error.getDefaultMessage());
        }

        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        }

        String avatar = this.uploadService.handleSavaUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(khanhUser.getPassword());

        khanhUser.setAvatar(avatar);
        khanhUser.setPassword(hashPassword);
        khanhUser.setRole(this.userService.getRoleByName(khanhUser.getRole().getName()));
        this.userService.handleSaveUser(khanhUser);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = this.userService.getUserById(id);
        
        // Lấy thông tin user đang đăng nhập từ session
        Long loggedInUserId = (Long) session.getAttribute("id");
        String loggedInUserRole = (String) session.getAttribute("role");
        
        // Không cho phép xóa chính mình
        if (loggedInUserId != null && loggedInUserId.equals(id)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không thể xóa chính mình!");
            return "redirect:/admin/user";
        }
        
        // Kiểm tra quyền xóa
        if (user != null && user.getRole() != null) {
            String targetRole = user.getRole().getName();
            
            // Chỉ SUPER_ADMIN mới có thể xóa ADMIN hoặc SUPER_ADMIN khác
            if (!"SUPER_ADMIN".equals(loggedInUserRole)) {
                if ("SUPER_ADMIN".equals(targetRole) || "ADMIN".equals(targetRole)) {
                    redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xóa người dùng này!");
                    return "redirect:/admin/user";
                }
            }
        }
        
        model.addAttribute("id", id);
        model.addAttribute("user", user);
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete/{id}")
    public String postDeleteUser(Model model, @ModelAttribute("user") User user, HttpSession session, RedirectAttributes redirectAttributes) {
        Long loggedInUserId = (Long) session.getAttribute("id");
        String loggedInUserRole = (String) session.getAttribute("role");
        
        // Không cho phép xóa chính mình
        if (loggedInUserId != null && loggedInUserId.equals(user.getId())) {
            redirectAttributes.addFlashAttribute("error", "Bạn không thể xóa chính mình!");
            return "redirect:/admin/user";
        }
        
        // Lấy thông tin user cần xóa
        User targetUser = this.userService.getUserById(user.getId());
        
        // Kiểm tra quyền xóa
        if (targetUser != null && targetUser.getRole() != null) {
            String targetRole = targetUser.getRole().getName();
            
            // Chỉ SUPER_ADMIN mới có thể xóa ADMIN hoặc SUPER_ADMIN khác
            if (!"SUPER_ADMIN".equals(loggedInUserRole)) {
                if ("SUPER_ADMIN".equals(targetRole) || "ADMIN".equals(targetRole)) {
                    redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xóa người dùng này!");
                    return "redirect:/admin/user";
                }
            }
        }
        
        this.userService.deleteAUser(user.getId());
        return "redirect:/admin/user";
    }

    // ========== UPDATE USER ==========
    // Admin có thể sửa STAFF và chính mình
    // SUPER_ADMIN có thể sửa tất cả
    // Không ai có thể sửa USER thông thường
    
    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = this.userService.getUserById(id);
        
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
            return "redirect:/admin/user";
        }
        
        Long loggedInUserId = (Long) session.getAttribute("id");
        String loggedInUserRole = (String) session.getAttribute("role");
        String targetRole = user.getRole() != null ? user.getRole().getName() : "";
        
        // Kiểm tra quyền chỉnh sửa
        boolean canEdit = false;
        
        // SUPER_ADMIN có thể sửa tất cả
        if ("SUPER_ADMIN".equals(loggedInUserRole)) {
            canEdit = true;
        } 
        // ADMIN có thể sửa chính mình
        else if ("ADMIN".equals(loggedInUserRole) && loggedInUserId != null && loggedInUserId.equals(id)) {
            canEdit = true;
        }
        // ADMIN có thể sửa STAFF
        else if ("ADMIN".equals(loggedInUserRole) && "STAFF".equals(targetRole)) {
            canEdit = true;
        }
        
        if (!canEdit) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền chỉnh sửa người dùng này!");
            return "redirect:/admin/user";
        }
        
        model.addAttribute("user", user);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update/{id}")
    public String postUpdateUser(Model model, @PathVariable Long id,
            @ModelAttribute("user") User user,
            @RequestParam("khanhFile") MultipartFile file,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        Long loggedInUserId = (Long) session.getAttribute("id");
        String loggedInUserRole = (String) session.getAttribute("role");
        
        User currentUser = this.userService.getUserById(id);
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng!");
            return "redirect:/admin/user";
        }
        
        String targetRole = currentUser.getRole() != null ? currentUser.getRole().getName() : "";
        
        // Kiểm tra quyền chỉnh sửa
        boolean canEdit = false;
        
        // SUPER_ADMIN có thể sửa tất cả
        if ("SUPER_ADMIN".equals(loggedInUserRole)) {
            canEdit = true;
        } 
        // ADMIN có thể sửa chính mình
        else if ("ADMIN".equals(loggedInUserRole) && loggedInUserId != null && loggedInUserId.equals(id)) {
            canEdit = true;
        }
        // ADMIN có thể sửa STAFF
        else if ("ADMIN".equals(loggedInUserRole) && "STAFF".equals(targetRole)) {
            canEdit = true;
        }
        
        if (!canEdit) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền chỉnh sửa người dùng này!");
            return "redirect:/admin/user";
        }
        
        // Cập nhật thông tin
        currentUser.setPhone(user.getPhone());
        currentUser.setFullName(user.getFullName());
        currentUser.setAddress(user.getAddress());
        
        // Chỉ cho phép thay đổi role nếu có quyền
        if (user.getRole() != null && user.getRole().getName() != null) {
            String newRole = user.getRole().getName();
            
            // SUPER_ADMIN có thể thay đổi role thành bất kỳ role nào
            if ("SUPER_ADMIN".equals(loggedInUserRole)) {
                Role role = this.userService.getRoleByName(newRole);
                if (role != null) {
                    currentUser.setRole(role);
                }
            }
            // ADMIN chỉ có thể đặt role là STAFF (không thể tự nâng cấp thành SUPER_ADMIN)
            else if ("ADMIN".equals(loggedInUserRole)) {
                // Nếu đang sửa chính mình, không cho đổi role
                if (!loggedInUserId.equals(id)) {
                    // Chỉ cho phép đặt role STAFF hoặc USER
                    if ("STAFF".equals(newRole) || "USER".equals(newRole)) {
                        Role role = this.userService.getRoleByName(newRole);
                        if (role != null) {
                            currentUser.setRole(role);
                        }
                    }
                }
            }
        }
        
        // Upload avatar mới nếu có
        if (!file.isEmpty()) {
            String avatar = this.uploadService.handleSavaUploadFile(file, "avatar");
            currentUser.setAvatar(avatar);
        }
        
        this.userService.handleSaveUser(currentUser);
        
        // Cập nhật session nếu đang sửa chính mình
        if (loggedInUserId != null && loggedInUserId.equals(id)) {
            session.setAttribute("fullName", currentUser.getFullName());
            session.setAttribute("avatar", currentUser.getAvatar());
        }
        
        return "redirect:/admin/user";
    }

}
