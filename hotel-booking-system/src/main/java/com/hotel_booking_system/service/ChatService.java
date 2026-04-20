package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.SendMessageRequest;
import com.hotel_booking_system.dto.response.ConversationResponse;
import com.hotel_booking_system.dto.response.MessageResponse;
import com.hotel_booking_system.entity.Conversation;
import com.hotel_booking_system.entity.ConversationMember;
import com.hotel_booking_system.entity.Message;
import com.hotel_booking_system.entity.User;
import com.hotel_booking_system.enums.RoleName;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.mapper.ConversationMapper;
import com.hotel_booking_system.mapper.MessageMapper;
import com.hotel_booking_system.repository.ConversationMemberRepository;
import com.hotel_booking_system.repository.ConversationRepository;
import com.hotel_booking_system.repository.MessageRepository;
import com.hotel_booking_system.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChatService {
    private final ConversationRepository conversationRepository;
    private final MessageRepository messageRepository;
    private final ConversationMemberRepository conversationMemberRepository;
    private final UserRepository userRepository;

    private final ConversationMapper conversationMapper;
    private final MessageMapper messageMapper;

    private final SimpMessagingTemplate messagingTemplate;

    // Create or get conversation
    @Transactional
    public ConversationResponse getOrCreateConversation() {

        String customerUsername = SecurityContextHolder.getContext().getAuthentication().getName();

        Conversation conversation = conversationRepository
                .findByCustomerUsernameAndStatus(customerUsername, "OPEN")
                .orElseGet(() -> {
                    Conversation c = Conversation.builder()
                            .customerUsername(customerUsername)
                            .status("OPEN")
                            .createdAt(LocalDateTime.now())
                            .build();

                    conversationRepository.save(c);

                    addMember(c.getConversationId(), customerUsername, RoleName.CUSTOMER.name());

                    return c;
                });

        return conversationMapper.toConversationResponse(conversation);
    }

    // Add member
    public void addMember(String conversationId, String username, String role) {
        boolean exists = conversationMemberRepository.existsByConversationIdAndUsername(conversationId, username);

        if (!exists) {
            ConversationMember conversationMember = ConversationMember.builder()
                    .conversationId(conversationId)
                    .username(username)
                    .role(role)
                    .lastReadAt(LocalDateTime.now())
                    .build();

            conversationMemberRepository.save(conversationMember);
        }
    }

    // Đóng hội thoại
    @Transactional
    public void closeConversation(String conversationId) {
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new AppException(ErrorCode.CONVERSATION_NOT_FOUND));

        conversation.setStatus("CLOSED");
        conversation.setClosedAt(LocalDateTime.now());
        conversationRepository.save(conversation);

        // Thông báo cho tất cả thành viên cập nhật Sidebar
        List<String> members = getMemberUsernames(conversationId);
        for (String username : members) {
            messagingTemplate.convertAndSendToUser(
                    username,
                    "/topic/conversations",
                    getConversationsForUser(username)
            );
        }

        // Gửi 1 tin nhắn hệ thống vào box chat để FE biết và disable input ngay lập tức
        Map<String, String> payload = new HashMap<>();
        payload.put("systemAction", "CLOSE");

        messagingTemplate.convertAndSend(
                "/topic/conversation/" + conversationId,
                payload
        );
    }

    // Save message
    @Transactional
    public MessageResponse saveMessage(SendMessageRequest request) {

        Conversation conversation = conversationRepository.findById(request.getConversationId())
                .orElseThrow(() -> new AppException(ErrorCode.CONVERSATION_NOT_FOUND));

        if ("CLOSED".equals(conversation.getStatus())) {
            throw new AppException(ErrorCode.CONVERSATION_CLOSED);
        }

        Message message = Message.builder()
                .conversationId(request.getConversationId())
                .senderUsername(request.getSenderUsername())
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .build();

        Message saved = messageRepository.save(message);

        // Update last_read_at cho sender
        conversationMemberRepository.updateLastRead(
                request.getConversationId(),
                request.getSenderUsername(),
                LocalDateTime.now()
        );

        // Add receptionist
        boolean hasReceptionist = conversationMemberRepository.existsByConversationIdAndRole(
                request.getConversationId(),
                RoleName.RECEPTIONIST.name()
        );

        // Chưa có receptionist mới thêm
        if (!hasReceptionist) {
            List<User> receptionists = userRepository.findAllByRoleName(RoleName.RECEPTIONIST.name());
            for (User r : receptionists) {
                addMember(request.getConversationId(), r.getUsername(), RoleName.RECEPTIONIST.name());
            }
        }

        return messageMapper.toMessageResponse(saved);
    }

    public List<ConversationResponse> getConversations() {

        User user = getCurrentUser();

        return conversationRepository.getConversationSummaries(user.getUsername());
    }

    public List<ConversationResponse> getAllConversationsRealtime() {
        return conversationRepository.getConversationSummaries(getCurrentUser().getUsername());
    }

    // Lấy danh sách hội thoại theo username truyền vào
    public List<ConversationResponse> getConversationsForUser(String username) {
        return conversationRepository.getConversationSummaries(username);
    }

    // Lấy tất cả thành viên trong 1 cuộc hội thoại
    public List<String> getMemberUsernames(String conversationId) {
        return conversationMemberRepository.findAllByConversationId(conversationId)
                .stream()
                .map(ConversationMember::getUsername)
                .toList();
    }

    // Load messages
    public List<MessageResponse> getMessages(String conversationId) {
        List<Message> messages = messageRepository.findByConversationIdOrderByCreatedAtAsc(conversationId);

        return messageMapper.toMessageResponses(messages);
    }

    // Mark as read
    @Transactional
    public void markAsRead(String conversationId) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        conversationMemberRepository.updateLastRead(conversationId, username, LocalDateTime.now());

        // Sau khi đọc, gửi lại danh sách hội thoại cho chính mình để mất chữ Unread
        List<ConversationResponse> updatedList = getConversationsForUser(username);
        messagingTemplate.convertAndSendToUser(username, "/topic/conversations", updatedList);
    }

    private User getCurrentUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        return userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
    }
}
