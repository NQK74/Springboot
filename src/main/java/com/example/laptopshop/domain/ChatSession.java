package com.example.laptopshop.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.Table;

@Entity
@Table(name = "chat_sessions")
public class ChatSession {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    // Session ID unique cho mỗi cuộc chat (dùng cho guest)
    @Column(unique = true)
    private String sessionId;
    
    // Tên khách (nếu là guest)
    private String guestName;
    
    // Email khách (nếu có)
    private String guestEmail;
    
    // User đã đăng nhập (nếu có)
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    // Staff đang hỗ trợ
    @ManyToOne
    @JoinColumn(name = "staff_id")
    private User staff;
    
    // Trạng thái: WAITING, ACTIVE, CLOSED
    private String status;
    
    // Thời gian tạo
    private LocalDateTime createdAt;
    
    // Thời gian cập nhật cuối
    private LocalDateTime lastMessageAt;
    
    // Số tin nhắn chưa đọc (cho staff)
    private int unreadCount;
    
    // Danh sách tin nhắn
    @OneToMany(mappedBy = "chatSession", cascade = CascadeType.ALL)
    @OrderBy("createdAt ASC")
    private List<ChatMessage> messages = new ArrayList<>();

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getGuestEmail() {
        return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getStaff() {
        return staff;
    }

    public void setStaff(User staff) {
        this.staff = staff;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getLastMessageAt() {
        return lastMessageAt;
    }

    public void setLastMessageAt(LocalDateTime lastMessageAt) {
        this.lastMessageAt = lastMessageAt;
    }

    public int getUnreadCount() {
        return unreadCount;
    }

    public void setUnreadCount(int unreadCount) {
        this.unreadCount = unreadCount;
    }

    public List<ChatMessage> getMessages() {
        return messages;
    }

    public void setMessages(List<ChatMessage> messages) {
        this.messages = messages;
    }
    
    // Helper method để lấy tên hiển thị
    public String getDisplayName() {
        if (user != null) {
            return user.getFullName();
        }
        return guestName != null ? guestName : "Khách #" + id;
    }
}
