package com.example.laptopshop.controller.client;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.laptopshop.service.GeminiService;

/**
 * Controller cho AI Chatbot sử dụng Gemini API + RAG
 */
@RestController
@RequestMapping("/api/ai-chatbot")
public class AIChatbotController {

    private final GeminiService geminiService;

    public AIChatbotController(GeminiService geminiService) {
        this.geminiService = geminiService;
    }

    /**
     * Gửi tin nhắn đến AI Chatbot
     */
    @PostMapping("/message")
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, String> payload) {
        String sessionId = payload.get("sessionId");
        String message = payload.get("message");
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Tạo sessionId nếu chưa có
            if (sessionId == null || sessionId.isEmpty()) {
                sessionId = UUID.randomUUID().toString();
            }
            
            // Validate message
            if (message == null || message.trim().isEmpty()) {
                response.put("success", false);
                response.put("error", "Tin nhắn không được để trống");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Gọi Gemini AI
            String aiReply = geminiService.chat(sessionId, message.trim());
            
            response.put("success", true);
            response.put("sessionId", sessionId);
            response.put("reply", aiReply);
            response.put("timestamp", System.currentTimeMillis());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("error", "Đã có lỗi xảy ra: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /**
     * Khởi tạo session mới
     */
    @PostMapping("/init")
    public ResponseEntity<Map<String, Object>> initSession() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String sessionId = UUID.randomUUID().toString();
            
            response.put("success", true);
            response.put("sessionId", sessionId);
            response.put("welcomeMessage", "Xin chào! 👋 Tôi là trợ lý AI của LaptopShop. Tôi có thể giúp bạn tìm kiếm laptop, tư vấn sản phẩm, hoặc giải đáp thắc mắc. Bạn cần hỗ trợ gì?");
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /**
     * Reset conversation (xóa history)
     */
    @PostMapping("/reset")
    public ResponseEntity<Map<String, Object>> resetConversation(@RequestBody Map<String, String> payload) {
        String sessionId = payload.get("sessionId");
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (sessionId != null) {
                geminiService.clearHistory(sessionId);
            }
            
            // Tạo session mới
            String newSessionId = UUID.randomUUID().toString();
            
            response.put("success", true);
            response.put("sessionId", newSessionId);
            response.put("message", "Cuộc trò chuyện đã được làm mới!");
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /**
     * Lấy lịch sử chat của session
     */
    @PostMapping("/history")
    public ResponseEntity<Map<String, Object>> getHistory(@RequestBody Map<String, String> payload) {
        String sessionId = payload.get("sessionId");
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (sessionId == null || sessionId.isEmpty()) {
                response.put("success", false);
                response.put("error", "Session ID không được để trống");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Kiểm tra session có tồn tại không
            if (!geminiService.hasSession(sessionId)) {
                response.put("success", true);
                response.put("exists", false);
                response.put("history", new java.util.ArrayList<>());
                return ResponseEntity.ok(response);
            }
            
            // Lấy lịch sử chat
            response.put("success", true);
            response.put("exists", true);
            response.put("history", geminiService.getHistoryForDisplay(sessionId));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
}
