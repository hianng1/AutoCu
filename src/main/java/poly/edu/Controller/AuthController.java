package poly.edu.Controller;

import jakarta.servlet.http.HttpSession;
import poly.edu.Model.User;
import poly.edu.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // Hiển thị form đăng ký
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        return "register";
    }

    // Xử lý đăng ký
    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String email,
                           @RequestParam String fullName,
                           @RequestParam(required = false) Integer phoneNumber, // không bắt buộc nhập
                           Model model,
                           RedirectAttributes redirectAttributes) {
        String result = userService.registerUser(username, password, email,fullName,phoneNumber);

        if (result.equals("Đăng ký thành công!")) {
            redirectAttributes.addFlashAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/login"; // Chuyển hướng đến trang login
        }

        model.addAttribute("message", result);
        return "register"; // Nếu đăng ký thất bại, vẫn ở trang đăng ký
    }

    // Hiển thị form đăng nhập
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "message", required = false) String message, Model model) {
        if (message != null && !message.isEmpty()) {
            model.addAttribute("message", message);
        }
        return "login";
    }

    // Xử lý đăng nhập
    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        Optional<User> user = userService.authenticate(username, password);

        if (user.isPresent()) {
            session.setAttribute("loggedInUser", user.get());
            return "redirect:/home"; // Chuyển hướng đến trang chủ sau khi đăng nhập
        } else {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            return "login"; // Nếu sai thông tin, quay lại trang đăng nhập
        }
    }

    // Xử lý đăng xuất
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // Hiển thị trang home sau khi đăng nhập thành công
    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/login"; // Nếu chưa đăng nhập, quay lại trang đăng nhập
        }

        model.addAttribute("user", loggedInUser);

        if ("ADMIN".equals(loggedInUser.getRole())) {
            return "admin_home"; // Chuyển đến trang admin nếu là admin
        } else {
            return "index2";  // Chuyển đến trang user nếu là user thường
        }
    }
}