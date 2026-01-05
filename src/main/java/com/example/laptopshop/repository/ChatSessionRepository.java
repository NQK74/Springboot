package com.example.laptopshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.ChatSession;

@Repository
public interface ChatSessionRepository extends JpaRepository<ChatSession, Long> {
    
    Optional<ChatSession> findBySessionId(String sessionId);
    
    // Lấy các session đang chờ hỗ trợ
    List<ChatSession> findByStatusOrderByLastMessageAtDesc(String status);
    
    // Lấy các session active của 1 staff
    List<ChatSession> findByStaffIdAndStatusOrderByLastMessageAtDesc(long staffId, String status);
    
    // Đếm số session đang chờ
    long countByStatus(String status);
    
    // Lấy tất cả session chưa đóng (WAITING + ACTIVE)
    @Query("SELECT cs FROM ChatSession cs WHERE cs.status IN ('WAITING', 'ACTIVE') ORDER BY cs.lastMessageAt DESC")
    List<ChatSession> findAllOpenSessions();
    
    // Đếm tổng tin nhắn chưa đọc
    @Query("SELECT COALESCE(SUM(cs.unreadCount), 0) FROM ChatSession cs WHERE cs.status IN ('WAITING', 'ACTIVE')")
    long countTotalUnread();
    
    // Tìm session theo user (cho user đã đăng nhập) - chưa đóng
    @Query("SELECT cs FROM ChatSession cs WHERE cs.user.id = :userId AND cs.status IN ('WAITING', 'ACTIVE') ORDER BY cs.lastMessageAt DESC")
    List<ChatSession> findOpenSessionsByUserId(long userId);
    
    // Tìm session mới nhất của user
    Optional<ChatSession> findFirstByUserIdOrderByLastMessageAtDesc(long userId);
}
