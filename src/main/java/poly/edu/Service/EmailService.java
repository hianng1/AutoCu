package poly.edu.Service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import poly.edu.Model.User;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    // Gửi email reset mật khẩu
	/*
	 * public void sendResetPasswordEmail(User user, String newPassword) {
	 * SimpleMailMessage message = new SimpleMailMessage();
	 * message.setFrom("thiembinh16@gmail.com"); message.setTo(user.getEmail());
	 * message.setSubject("Khôi phục mật khẩu"); message.setText("Xin chào " +
	 * user.getUsername() + ",\n\n" + "Mật khẩu mới của bạn là: " + newPassword +
	 * "\n" + "Vui lòng đăng nhập và thay đổi mật khẩu của bạn.");
	 * mailSender.send(message); }
	 */
    // thông báo về mail
	public void sendResetPasswordEmail(User user, /* String recipientEmail, */ String newPassword) {
        SimpleMailMessage message = new SimpleMailMessage();
		/* message.setTo(recipientEmail); */
        message.setTo(user.getEmail());
        message.setSubject("Khôi phục mật khẩu");
        message.setText("Xin chào,"+user.getUsername()+"\n\n" +
                        "Mật khẩu mới của bạn là: " + newPassword + "\n" +
                        "Vui lòng đăng nhập và đổi mật khẩu.");
        // KHÔNG setFrom thủ công nếu đang dùng Gmail
        mailSender.send(message);
    }
    
    
    
    
	/*
	 * // Gửi email xác nhận sau khi đổi mật khẩu thành công public void
	 * sendPasswordChangeConfirmationEmail(User user) { SimpleMailMessage message =
	 * new SimpleMailMessage(); message.setFrom("thiembinh16@gmail.com");
	 * message.setTo(user.getEmail());
	 * message.setSubject("Xác nhận thay đổi mật khẩu"); message.setText("Xin chào "
	 * + user.getUsername() + ",\n\n" +
	 * "Mật khẩu của bạn đã được thay đổi thành công.\n" +
	 * "Vui lòng liên hệ với chúng tôi nếu bạn gặp bất kỳ vấn đề nào.");
	 * 
	 * mailSender.send(message); }
	 */
}

