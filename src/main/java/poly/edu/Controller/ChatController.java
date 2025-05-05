package poly.edu.Controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import poly.edu.Model.Message;
import poly.edu.Model.User;
import poly.edu.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class ChatController {

    @Autowired
    private UserService userService;

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public Message sendMessage(@Payload Message chatMessage) {
        User user = userService.findByUsername(chatMessage.getSender());
        System.out.println("[CHAT] Sender: " + chatMessage.getSender());
        if (user != null) {
            System.out.println("[CHAT] Role: " + user.getRole());
        } else {
            System.out.println("[CHAT] User not found!");
        }
        if (user != null && "Admin".equalsIgnoreCase(user.getRole())) {
            chatMessage.setRole("Nhân viên hỗ trợ");
        } else {
            chatMessage.setRole("Khách hàng");
        }
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public Message addUser(@Payload Message chatMessage, 
                          SimpMessageHeaderAccessor headerAccessor) {
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        User user = userService.findByUsername(chatMessage.getSender());
        System.out.println("[JOIN] Sender: " + chatMessage.getSender());
        if (user != null) {
            System.out.println("[JOIN] Role: " + user.getRole());
        } else {
            System.out.println("[JOIN] User not found!");
        }
        if (user != null && "Admin".equalsIgnoreCase(user.getRole())) {
            chatMessage.setRole("Nhân viên hỗ trợ");
        } else {
            chatMessage.setRole("Khách hàng");
        }
        return chatMessage;
    }
} 