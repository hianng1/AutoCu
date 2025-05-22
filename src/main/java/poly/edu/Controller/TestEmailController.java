package poly.edu.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestEmailController {

    private static final Logger logger = LoggerFactory.getLogger(TestEmailController.class);

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/test-email")
    public String sendTestEmail(@RequestParam String to) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject("AutoCu - Test Email");
            message.setText(
                    "This is a test email from your AutoCu application. If you receive this, your email configuration is working!");

            logger.info("Attempting to send test email to: {}", to);
            mailSender.send(message);
            logger.info("Test email sent successfully to: {}", to);

            return "Test email sent successfully to " + to;
        } catch (Exception e) {
            logger.error("Failed to send test email", e);
            return "Error sending test email: " + e.getMessage();
        }
    }
}
