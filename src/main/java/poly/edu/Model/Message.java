package poly.edu.Model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {
    private String sender;
    private String content;
    private MessageType type;
    private String role;

    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE
    }
}