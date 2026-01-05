package com.example.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.ChatMessage;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    
    // Lấy tin nhắn theo session
    List<ChatMessage> findByChatSessionIdOrderByCreatedAtAsc(long sessionId);
    
    // Lấy tin nhắn mới hơn 1 id cụ thể (để polling)
    List<ChatMessage> findByChatSessionIdAndIdGreaterThanOrderByCreatedAtAsc(long sessionId, long lastMessageId);
    
    // Đánh dấu đã đọc tất cả tin nhắn của session
    @Modifying
    @Query("UPDATE ChatMessage cm SET cm.isRead = true WHERE cm.chatSession.id = :sessionId AND cm.senderType = :senderType")
    void markAsReadBySessionAndSenderType(long sessionId, String senderType);
}
