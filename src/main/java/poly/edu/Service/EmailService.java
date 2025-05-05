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

    // Gửi email xác nhận yêu cầu hỗ trợ
    public void sendSupportRequestEmail(String name, String email, String phone, String subject, String message) {
        // Email gửi cho khách hàng
        sendConfirmationEmailToCustomer(name, email, subject);

        // Email gửi cho admin
        sendNotificationEmailToAdmin(name, email, phone, subject, message);
    }

    // Gửi email xác nhận cho khách hàng
    private void sendConfirmationEmailToCustomer(String name, String email, String subject) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("AutoCu - Xác nhận yêu cầu hỗ trợ");
        message.setText("Kính chào " + name + ",\n\n" +
                "Cảm ơn bạn đã gửi yêu cầu hỗ trợ đến AutoCu. Chúng tôi đã nhận được yêu cầu của bạn với chủ đề: " + subject + "\n\n" +
                "Đội ngũ hỗ trợ của chúng tôi sẽ xem xét và phản hồi trong thời gian sớm nhất, thông thường trong vòng 24 giờ làm việc.\n\n" +
                "Nếu bạn cần hỗ trợ khẩn cấp, vui lòng liên hệ hotline: +84 382 948 198\n\n" +
                "Trân trọng,\n" +
                "Đội ngũ hỗ trợ khách hàng AutoCu");

        mailSender.send(message);
    }

    // Gửi email thông báo cho admin
    private void sendNotificationEmailToAdmin(String name, String email, String phone, String subject, String messageContent) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo("thiembinh16@gmail.com"); // Email của admin
        message.setSubject("Yêu cầu hỗ trợ mới: " + subject);
        message.setText("Thông tin yêu cầu hỗ trợ mới:\n\n" +
                "Người gửi: " + name + "\n" +
                "Email: " + email + "\n" +
                "Số điện thoại: " + phone + "\n" +
                "Chủ đề: " + subject + "\n\n" +
                "Nội dung tin nhắn:\n" + messageContent + "\n\n" +
                "Vui lòng xử lý yêu cầu này trong thời gian sớm nhất.");

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

