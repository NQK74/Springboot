package com.example.laptopshop.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.laptopshop.domain.ChatMessage;
import com.example.laptopshop.domain.ChatSession;
import com.example.laptopshop.domain.User;
import com.example.laptopshop.repository.ChatMessageRepository;
import com.example.laptopshop.repository.ChatSessionRepository;

@Service
public class ChatService {
    
    private final ChatSessionRepository chatSessionRepository;
    private final ChatMessageRepository chatMessageRepository;
    
    public ChatService(ChatSessionRepository chatSessionRepository, 
                       ChatMessageRepository chatMessageRepository) {
        this.chatSessionRepository = chatSessionRepository;
        this.chatMessageRepository = chatMessageRepository;
    }
    
    /**
     * Tạo hoặc lấy session chat
     * Ưu tiên tìm theo user nếu đã đăng nhập, sau đó mới tìm theo sessionId
     */
    public ChatSession getOrCreateSession(String sessionId, String guestName, User user) {
        // Nếu user đã đăng nhập, ưu tiên tìm session đang mở của user đó
        if (user != null) {
            List<ChatSession> userSessions = chatSessionRepository.findOpenSessionsByUserId(user.getId());
            if (!userSessions.isEmpty()) {
                return userSessions.get(0); // Lấy session mới nhất
            }
        }
        
        // Nếu có sessionId và là guest, tìm theo sessionId
        if (sessionId != null && user == null) {
            Optional<ChatSession> existing = chatSessionRepository.findBySessionId(sessionId);
            if (existing.isPresent()) {
                return existing.get();
            }
        }
        
        // Tạo session mới
        ChatSession session = new ChatSession();
        session.setSessionId(UUID.randomUUID().toString()); // Luôn tạo sessionId mới
        session.setGuestName(user != null ? user.getFullName() : guestName);
        session.setUser(user);
        session.setStatus("WAITING");
        session.setCreatedAt(LocalDateTime.now());
        session.setLastMessageAt(LocalDateTime.now());
        session.setUnreadCount(0);
        
        return chatSessionRepository.save(session);
    }
    
    /**
     * Lấy session theo ID
     */
    public Optional<ChatSession> getSessionById(long id) {
        return chatSessionRepository.findById(id);
    }
    
    /**
     * Lấy session theo sessionId
     */
    public Optional<ChatSession> getSessionBySessionId(String sessionId) {
        return chatSessionRepository.findBySessionId(sessionId);
    }
    
    /**
     * Gửi tin nhắn từ khách
     */
    @Transactional
    public ChatMessage sendCustomerMessage(String sessionId, String content, String senderName, User user) {
        ChatSession session = getOrCreateSession(sessionId, senderName, user);
        
        ChatMessage message = new ChatMessage();
        message.setChatSession(session);
        message.setContent(content);
        message.setSenderType("CUSTOMER");
        message.setSender(user);
        message.setSenderName(senderName != null ? senderName : (user != null ? user.getFullName() : "Khách"));
        message.setCreatedAt(LocalDateTime.now());
        message.setRead(false);
        
        // Cập nhật session
        session.setLastMessageAt(LocalDateTime.now());
        session.setUnreadCount(session.getUnreadCount() + 1);
        if ("CLOSED".equals(session.getStatus())) {
            session.setStatus("WAITING");
        }
        chatSessionRepository.save(session);
        
        return chatMessageRepository.save(message);
    }
    
    /**
     * Gửi tin nhắn từ staff
     */
    @Transactional
    public ChatMessage sendStaffMessage(long sessionId, String content, User staff) {
        Optional<ChatSession> sessionOpt = chatSessionRepository.findById(sessionId);
        if (sessionOpt.isEmpty()) {
            throw new RuntimeException("Session không tồn tại");
        }
        
        ChatSession session = sessionOpt.get();
        
        ChatMessage message = new ChatMessage();
        message.setChatSession(session);
        message.setContent(content);
        message.setSenderType("STAFF");
        message.setSender(staff);
        message.setSenderName(staff.getFullName());
        message.setCreatedAt(LocalDateTime.now());
        message.setRead(false);
        
        // Cập nhật session
        session.setLastMessageAt(LocalDateTime.now());
        session.setStaff(staff);
        if ("WAITING".equals(session.getStatus())) {
            session.setStatus("ACTIVE");
        }
        chatSessionRepository.save(session);
        
        return chatMessageRepository.save(message);
    }
    
    /**
     * Lấy tất cả tin nhắn của session
     */
    public List<ChatMessage> getMessages(long sessionId) {
        return chatMessageRepository.findByChatSessionIdOrderByCreatedAtAsc(sessionId);
    }
    
    /**
     * Lấy tin nhắn mới (polling)
     */
    public List<ChatMessage> getNewMessages(long sessionId, long lastMessageId) {
        return chatMessageRepository.findByChatSessionIdAndIdGreaterThanOrderByCreatedAtAsc(sessionId, lastMessageId);
    }
    
    /**
     * Lấy tin nhắn mới theo sessionId (cho client)
     */
    public List<ChatMessage> getNewMessagesBySessionId(String sessionId, long lastMessageId) {
        Optional<ChatSession> session = chatSessionRepository.findBySessionId(sessionId);
        if (session.isPresent()) {
            return chatMessageRepository.findByChatSessionIdAndIdGreaterThanOrderByCreatedAtAsc(
                session.get().getId(), lastMessageId);
        }
        return List.of();
    }
    
    /**
     * Lấy tất cả session đang mở (cho admin/staff)
     */
    public List<ChatSession> getAllOpenSessions() {
        return chatSessionRepository.findAllOpenSessions();
    }
    
    /**
     * Lấy session đang chờ
     */
    public List<ChatSession> getWaitingSessions() {
        return chatSessionRepository.findByStatusOrderByLastMessageAtDesc("WAITING");
    }
    
    /**
     * Đếm session đang chờ
     */
    public long countWaitingSessions() {
        return chatSessionRepository.countByStatus("WAITING");
    }
    
    /**
     * Đếm tổng tin nhắn chưa đọc
     */
    public long countTotalUnread() {
        return chatSessionRepository.countTotalUnread();
    }
    
    /**
     * Đánh dấu đã đọc
     */
    @Transactional
    public void markAsRead(long sessionId, String senderType) {
        chatMessageRepository.markAsReadBySessionAndSenderType(sessionId, senderType);
        
        // Reset unread count
        Optional<ChatSession> sessionOpt = chatSessionRepository.findById(sessionId);
        if (sessionOpt.isPresent()) {
            ChatSession session = sessionOpt.get();
            session.setUnreadCount(0);
            chatSessionRepository.save(session);
        }
    }
    
    /**
     * Đóng session
     */
    @Transactional
    public void closeSession(long sessionId) {
        Optional<ChatSession> sessionOpt = chatSessionRepository.findById(sessionId);
        if (sessionOpt.isPresent()) {
            ChatSession session = sessionOpt.get();
            session.setStatus("CLOSED");
            chatSessionRepository.save(session);
        }
    }
}
