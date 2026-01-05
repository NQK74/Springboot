package com.example.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.laptopshop.domain.ChatMessage;
import com.example.laptopshop.domain.ChatSession;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.service.ChatService;
import com.example.laptopshop.service.UserService;

@RestController
@RequestMapping("/api/chatbot")
public class ChatbotController {

    private final ChatService chatService;
    private final UserService userService;

    public ChatbotController(ChatService chatService, UserService userService) {
        this.chatService = chatService;
        this.userService = userService;
    }

    /**
     * Gửi tin nhắn từ khách hàng
     */
    @PostMapping("/send")
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, String> payload) {
        String sessionId = payload.get("sessionId");
        String content = payload.get("message");
        String guestName = payload.get("guestName");
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Kiểm tra user đã đăng nhập
            User currentUser = getCurrentUser();
            if (currentUser != null && guestName == null) {
                guestName = currentUser.getFullName();
            }
            
            ChatMessage message = chatService.sendCustomerMessage(sessionId, content, guestName, currentUser);
            
            // Lấy session để trả về sessionId
            ChatSession session = message.getChatSession();
            
            response.put("success", true);
            response.put("messageId", message.getId());
            response.put("sessionId", session.getSessionId());
            response.put("createdAt", message.getCreatedAt().toString());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * Lấy tin nhắn mới (polling từ client)
     */
    @GetMapping("/messages")
    public ResponseEntity<Map<String, Object>> getNewMessages(
            @RequestParam String sessionId,
            @RequestParam(defaultValue = "0") long lastMessageId) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<ChatMessage> messages = chatService.getNewMessagesBySessionId(sessionId, lastMessageId);
            
            List<Map<String, Object>> messageList = new ArrayList<>();
            for (ChatMessage msg : messages) {
                Map<String, Object> msgData = new HashMap<>();
                msgData.put("id", msg.getId());
                msgData.put("content", msg.getContent());
                msgData.put("senderType", msg.getSenderType());
                msgData.put("senderName", msg.getSenderName());
                msgData.put("createdAt", msg.getCreatedAt().toString());
                messageList.add(msgData);
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
     * Khởi tạo session chat
     */
    @PostMapping("/init")
    public ResponseEntity<Map<String, Object>> initSession(@RequestBody Map<String, String> payload) {
        String sessionId = payload.get("sessionId");
        String guestName = payload.get("guestName");
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = getCurrentUser();
            ChatSession session = chatService.getOrCreateSession(sessionId, guestName, currentUser);
            
            // Lấy lịch sử tin nhắn
            List<ChatMessage> messages = chatService.getMessages(session.getId());
            List<Map<String, Object>> messageList = new ArrayList<>();
            for (ChatMessage msg : messages) {
                Map<String, Object> msgData = new HashMap<>();
                msgData.put("id", msg.getId());
                msgData.put("content", msg.getContent());
                msgData.put("senderType", msg.getSenderType());
                msgData.put("senderName", msg.getSenderName());
                msgData.put("createdAt", msg.getCreatedAt().toString());
                messageList.add(msgData);
            }
            
            response.put("success", true);
            response.put("sessionId", session.getSessionId());
            response.put("status", session.getStatus());
            response.put("messages", messageList);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() 
                && !"anonymousUser".equals(authentication.getPrincipal())) {
            String email = authentication.getName();
            return userService.getUserByEmail(email);
        }
        return null;
    }
}
