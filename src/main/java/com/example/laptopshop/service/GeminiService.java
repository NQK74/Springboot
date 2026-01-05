package com.example.laptopshop.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class GeminiService {
    
    @Value("${gemini.api.key:}")
    private String apiKey;
    
    @Value("${gemini.api.model:gemini-2.0-flash}")
    private String model;
    
    private final WebClient webClient;
    private final ProductContextService productContextService;
    private final ObjectMapper objectMapper;
    
    // Store conversation history per session
    private final Map<String, List<Map<String, Object>>> conversationHistory = new HashMap<>();
    
    public GeminiService(ProductContextService productContextService) {
        this.productContextService = productContextService;
        this.objectMapper = new ObjectMapper();
        this.webClient = WebClient.builder()
                .baseUrl("https://generativelanguage.googleapis.com")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();
    }
    
    /**
     * Gửi tin nhắn đến Gemini API với RAG context
     */
    public String chat(String sessionId, String userMessage) {
        if (apiKey == null || apiKey.isEmpty()) {
            return "⚠️ Gemini API chưa được cấu hình. Vui lòng liên hệ quản trị viên.";
        }
        
        try {
            // Tạo context từ RAG
            String ragContext = productContextService.buildContext(userMessage);
            
            // Lấy conversation history
            List<Map<String, Object>> history = conversationHistory.getOrDefault(sessionId, new ArrayList<>());
            
            // Build system prompt với RAG context
            String systemPrompt = buildSystemPrompt(ragContext);
            
            // Build request body
            Map<String, Object> requestBody = buildRequestBody(systemPrompt, history, userMessage);
            
            // Call Gemini API
            String response = webClient.post()
                    .uri("/v1beta/models/{model}:generateContent?key={apiKey}", model, apiKey)
                    .bodyValue(requestBody)
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();
            
            // Parse response
            String assistantMessage = parseGeminiResponse(response);
            
            // Update conversation history
            updateHistory(sessionId, userMessage, assistantMessage);
            
            return assistantMessage;
            
        } catch (Exception e) {
            e.printStackTrace();
            return "❌ Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại sau. (" + e.getMessage() + ")";
        }
    }
    
    /**
     * Build system prompt với RAG context
     */
    private String buildSystemPrompt(String ragContext) {
        StringBuilder sb = new StringBuilder();
        sb.append("Bạn là trợ lý AI thông minh của LaptopShop - cửa hàng bán laptop uy tín. ");
        sb.append("Nhiệm vụ của bạn là tư vấn và hỗ trợ khách hàng một cách thân thiện, chuyên nghiệp.\n\n");
        
        sb.append("HƯỚNG DẪN:\n");
        sb.append("1. Trả lời ngắn gọn, súc tích và thân thiện bằng tiếng Việt\n");
        sb.append("2. Khi tư vấn sản phẩm, hãy dựa vào dữ liệu sản phẩm bên dưới\n");
        sb.append("3. Nếu không có thông tin, hãy nói rằng bạn không tìm thấy và đề nghị khách liên hệ hotline\n");
        sb.append("4. Có thể sử dụng emoji phù hợp để tạo thiện cảm\n");
        sb.append("5. Luôn đưa ra giá sản phẩm khi giới thiệu (format: XXX,XXX VNĐ)\n");
        sb.append("6. Nếu khách hỏi về đơn hàng, hướng dẫn họ vào mục 'Đơn hàng của tôi' trong tài khoản\n");
        sb.append("7. QUAN TRỌNG: Khi giới thiệu sản phẩm, LUÔN kèm theo link chi tiết với format: [Xem chi tiết](/product/ID) - thay ID bằng ID sản phẩm thực tế từ dữ liệu\n\n");
        
        sb.append("THÔNG TIN CHÍNH SÁCH:\n");
        sb.append("- Miễn phí giao hàng với đơn từ 10 triệu\n");
        sb.append("- Bảo hành 24 tháng chính hãng\n");
        sb.append("- Đổi trả trong 30 ngày\n");
        sb.append("- Hỗ trợ trả góp 0%\n");
        sb.append("- Hotline: 1900.xxxx (8h-22h)\n\n");
        
        if (ragContext != null && !ragContext.isEmpty()) {
            sb.append("DỮ LIỆU SẢN PHẨM (RAG CONTEXT):\n");
            sb.append(ragContext);
            sb.append("\n\n");
        }
        
        return sb.toString();
    }
    
    /**
     * Build request body cho Gemini API
     */
    private Map<String, Object> buildRequestBody(String systemPrompt, List<Map<String, Object>> history, String userMessage) {
        Map<String, Object> body = new HashMap<>();
        
        // System instruction
        Map<String, Object> systemInstruction = new HashMap<>();
        List<Map<String, String>> systemParts = new ArrayList<>();
        systemParts.add(Map.of("text", systemPrompt));
        systemInstruction.put("parts", systemParts);
        body.put("systemInstruction", systemInstruction);
        
        // Contents (history + current message)
        List<Map<String, Object>> contents = new ArrayList<>();
        
        // Add history
        for (Map<String, Object> msg : history) {
            contents.add(msg);
        }
        
        // Add current user message
        Map<String, Object> userContent = new HashMap<>();
        userContent.put("role", "user");
        List<Map<String, String>> userParts = new ArrayList<>();
        userParts.add(Map.of("text", userMessage));
        userContent.put("parts", userParts);
        contents.add(userContent);
        
        body.put("contents", contents);
        
        // Generation config
        Map<String, Object> generationConfig = new HashMap<>();
        generationConfig.put("temperature", 0.7);
        generationConfig.put("topK", 40);
        generationConfig.put("topP", 0.95);
        generationConfig.put("maxOutputTokens", 1024);
        body.put("generationConfig", generationConfig);
        
        // Safety settings
        List<Map<String, String>> safetySettings = new ArrayList<>();
        safetySettings.add(Map.of("category", "HARM_CATEGORY_HARASSMENT", "threshold", "BLOCK_MEDIUM_AND_ABOVE"));
        safetySettings.add(Map.of("category", "HARM_CATEGORY_HATE_SPEECH", "threshold", "BLOCK_MEDIUM_AND_ABOVE"));
        safetySettings.add(Map.of("category", "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold", "BLOCK_MEDIUM_AND_ABOVE"));
        safetySettings.add(Map.of("category", "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold", "BLOCK_MEDIUM_AND_ABOVE"));
        body.put("safetySettings", safetySettings);
        
        return body;
    }
    
    /**
     * Parse response từ Gemini API
     */
    private String parseGeminiResponse(String response) {
        try {
            JsonNode root = objectMapper.readTree(response);
            JsonNode candidates = root.path("candidates");
            
            if (candidates.isArray() && candidates.size() > 0) {
                JsonNode content = candidates.get(0).path("content");
                JsonNode parts = content.path("parts");
                
                if (parts.isArray() && parts.size() > 0) {
                    return parts.get(0).path("text").asText();
                }
            }
            
            // Check for blocked content
            JsonNode promptFeedback = root.path("promptFeedback");
            if (promptFeedback.has("blockReason")) {
                return "⚠️ Tin nhắn không thể xử lý. Vui lòng thử lại với nội dung khác.";
            }
            
            return "❌ Không thể xử lý phản hồi từ AI.";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "❌ Lỗi khi xử lý phản hồi: " + e.getMessage();
        }
    }
    
    /**
     * Update conversation history
     */
    private void updateHistory(String sessionId, String userMessage, String assistantMessage) {
        List<Map<String, Object>> history = conversationHistory.getOrDefault(sessionId, new ArrayList<>());
        
        // Add user message
        Map<String, Object> userContent = new HashMap<>();
        userContent.put("role", "user");
        List<Map<String, String>> userParts = new ArrayList<>();
        userParts.add(Map.of("text", userMessage));
        userContent.put("parts", userParts);
        history.add(userContent);
        
        // Add assistant message
        Map<String, Object> modelContent = new HashMap<>();
        modelContent.put("role", "model");
        List<Map<String, String>> modelParts = new ArrayList<>();
        modelParts.add(Map.of("text", assistantMessage));
        modelContent.put("parts", modelParts);
        history.add(modelContent);
        
        // Keep only last 10 exchanges (20 messages)
        if (history.size() > 20) {
            history = new ArrayList<>(history.subList(history.size() - 20, history.size()));
        }
        
        conversationHistory.put(sessionId, history);
    }
    
    /**
     * Clear conversation history for a session
     */
    public void clearHistory(String sessionId) {
        conversationHistory.remove(sessionId);
    }
    
    /**
     * Get conversation history for a session (for client display)
     */
    public List<Map<String, String>> getHistoryForDisplay(String sessionId) {
        List<Map<String, Object>> history = conversationHistory.get(sessionId);
        List<Map<String, String>> displayHistory = new ArrayList<>();
        
        if (history != null) {
            for (Map<String, Object> msg : history) {
                String role = (String) msg.get("role");
                @SuppressWarnings("unchecked")
                List<Map<String, String>> parts = (List<Map<String, String>>) msg.get("parts");
                if (parts != null && !parts.isEmpty()) {
                    Map<String, String> displayMsg = new HashMap<>();
                    displayMsg.put("role", "model".equals(role) ? "bot" : "user");
                    displayMsg.put("content", parts.get(0).get("text"));
                    displayHistory.add(displayMsg);
                }
            }
        }
        
        return displayHistory;
    }
    
    /**
     * Check if session exists
     */
    public boolean hasSession(String sessionId) {
        return sessionId != null && conversationHistory.containsKey(sessionId);
    }
}
