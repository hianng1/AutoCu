package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import poly.edu.Service.UserService;

@Controller
public class VerificationController {

    private static final Logger logger = LoggerFactory.getLogger(VerificationController.class);

    @Autowired
    private UserService userService;

    // Xử lý xác thực từ link trong email
    @GetMapping("/verify")
    public String verifyAccount(@RequestParam("token") String token, Model model) {
        logger.info("Processing verification request with token: {}", token);
        String result = userService.verifyAccount(token);
        logger.info("Verification result: {}", result);

        model.addAttribute("message", result);
        model.addAttribute("loginUrl", "/login");
        return "verify-result";
    }

    // Hiển thị form gửi lại email xác thực
    @GetMapping("/resend-verification")
    public String showResendVerificationForm() {
        return "resend-verification";
    }

    // Xử lý yêu cầu gửi lại email xác thực
    @PostMapping("/resend-verification")
    public String resendVerification(@RequestParam("email") String email, Model model) {
        logger.info("Processing resend verification request for email: {}", email);
        String result = userService.resendVerificationEmail(email);
        logger.info("Resend verification result: {}", result);

        model.addAttribute("message", result);
        return "resend-verification";
    }
}
