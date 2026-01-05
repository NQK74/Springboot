package com.example.laptopshop.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.laptopshop.domain.ChatMessage;
import com.example.laptopshop.domain.ChatSession;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.ChatService;
import com.example.laptopshop.service.UserService;

@Controller
public class ChatController {
    
    private final ChatService chatService;
    private final UserService userService;
    
    public ChatController(ChatService chatService, UserService userService) {
        this.chatService = chatService;
        this.userService = userService;
    }
    
    /**
     * Trang quản lý chat
     */
    @GetMapping("/admin/chat")
    public String getChatPage(Model model) {
        List<ChatSession> sessions = chatService.getAllOpenSessions();
        long waitingCount = chatService.countWaitingSessions();
        long unreadCount = chatService.countTotalUnread();
        
        model.addAttribute("sessions", sessions);
        model.addAttribute("waitingCount", waitingCount);
        model.addAttribute("unreadCount", unreadCount);
        
        return "admin/chat/show";
    }
    
    /**
     * API: Lấy danh sách sessions
     */
    @GetMapping("/api/admin/chat/sessions")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getSessions() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<ChatSession> sessions = chatService.getAllOpenSessions();
            long waitingCount = chatService.countWaitingSessions();
            long unreadCount = chatService.countTotalUnread();
            
            List<Map<String, Object>> sessionList = new ArrayList<>();
            for (ChatSession session : sessions) {
                Map<String, Object> s = new HashMap<>();
                s.put("id", session.getId());
                s.put("sessionId", session.getSessionId());
                s.put("displayName", session.getDisplayName());
                s.put("status", session.getStatus());
                s.put("unreadCount", session.getUnreadCount());
                s.put("lastMessageAt", session.getLastMessageAt() != null ? 
                    session.getLastMessageAt().toString() : null);
                s.put("staffName", session.getStaff() != null ? 
                    session.getStaff().getFullName() : null);
                sessionList.add(s);
            }
            
            response.put("success", true);
            response.put("sessions", sessionList);
            response.put("waitingCount", waitingCount);
            response.put("unreadCount", unreadCount);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * API: Lấy tin nhắn của session
     */
    @GetMapping("/api/admin/chat/messages/{sessionId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getMessages(
            @PathVariable long sessionId,
            @RequestParam(defaultValue = "0") long lastMessageId) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<ChatMessage> messages;
            if (lastMessageId == 0) {
                messages = chatService.getMessages(sessionId);
                // Đánh dấu đã đọc
                chatService.markAsRead(sessionId, "CUSTOMER");
            } else {
                messages = chatService.getNewMessages(sessionId, lastMessageId);
            }
            
            List<Map<String, Object>> messageList = new ArrayList<>();
            for (ChatMessage msg : messages) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", msg.getId());
                m.put("content", msg.getContent());
                m.put("senderType", msg.getSenderType());
                m.put("senderName", msg.getSenderName());
                m.put("createdAt", msg.getCreatedAt().toString());
                messageList.add(m);
            }
            
            response.put("success", true);
            response.put("messages", messageList);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * API: Gửi tin nhắn từ staff
     */
    @PostMapping("/api/admin/chat/send")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, Object> payload) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            long sessionId = Long.parseLong(payload.get("sessionId").toString());
            String content = (String) payload.get("message");
            
            User staff = getCurrentUser();
            if (staff == null) {
                response.put("success", false);
                response.put("error", "Bạn cần đăng nhập");
                return ResponseEntity.badRequest().body(response);
            }
            
            ChatMessage message = chatService.sendStaffMessage(sessionId, content, staff);
            
            response.put("success", true);
            response.put("messageId", message.getId());
            response.put("createdAt", message.getCreatedAt().toString());
            response.put("senderName", message.getSenderName());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * API: Đóng session
     */
    @PostMapping("/api/admin/chat/close/{sessionId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> closeSession(@PathVariable long sessionId) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            chatService.closeSession(sessionId);
            response.put("success", true);
            response.put("message", "Đã đóng cuộc hội thoại");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * API: Lấy số lượng chờ (để hiển thị badge)
     */
    @GetMapping("/api/admin/chat/count")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCount() {
        Map<String, Object> response = new HashMap<>();
        response.put("waitingCount", chatService.countWaitingSessions());
        response.put("unreadCount", chatService.countTotalUnread());
        return ResponseEntity.ok(response);
    }
    
    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            String email = authentication.getName();
            return userService.getUserByEmail(email);
        }
        return null;
    }
}
