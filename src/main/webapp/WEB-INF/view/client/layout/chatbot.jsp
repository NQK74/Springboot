<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- AI Chatbot Widget - Powered by Gemini AI -->
<link rel="stylesheet" href="/client/css/chatbot.css">

<div class="chatbot-widget">
    <!-- Toggle Button -->
    <button class="chatbot-toggle" aria-label="Open AI Chat">
        <i class="fas fa-robot"></i>
        <span class="chatbot-badge" id="chatBadge" style="display: none;">1</span>
    </button>
    
    <!-- Chat Container -->
    <div class="chatbot-container">
        <!-- Header -->
        <div class="chatbot-header">
            <div class="chatbot-avatar">
                <i class="fas fa-robot"></i>
            </div>
            <div class="chatbot-info">
                <h4>AI Assistant</h4>
                <span class="chatbot-status">Powered by Gemini AI</span>
            </div>
            <button class="chatbot-reset" aria-label="Reset conversation" title="Làm mới cuộc trò chuyện">
                <i class="fas fa-redo"></i>
            </button>
            <button class="chatbot-close" aria-label="Close chat">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <!-- Messages -->
        <div class="chatbot-messages" id="chatMessages">
            <!-- Messages will be loaded dynamically -->
        </div>
        
        <!-- Input -->
        <div class="chatbot-input">
            <input type="text" id="chatInput" placeholder="Hỏi tôi về laptop..." aria-label="Chat message">
            <button class="chatbot-send" id="chatSendBtn" aria-label="Send message">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
        
        <!-- Footer -->
        <div class="chatbot-footer">
            🤖 AI có thể mắc sai sót. Vui lòng xác minh thông tin quan trọng.
        </div>
    </div>
</div>

<!-- Load AI Chatbot JS -->
<script src="/client/js/chatbot.js"></script>
