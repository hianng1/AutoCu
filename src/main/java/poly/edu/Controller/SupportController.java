package poly.edu.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import poly.edu.DAO.DanhMucDAO;
import poly.edu.DAO.SanPhamDAO;
import poly.edu.Model.DanhMuc;
import poly.edu.Model.User;
import poly.edu.Service.EmailService;

@Controller
public class SupportController {

    @Autowired
    private DanhMucDAO danhMucDAO;

    @Autowired
    private SanPhamDAO sanPhamDAO;

    @Autowired
    private EmailService emailService;

    /**
     * Hiển thị trang hỗ trợ khách hàng
     */
    @GetMapping("/support")
    public String showSupportPage(Model model, HttpSession session) {
        try {
            // Lấy danh sách danh mục để hiển thị ở menu
            List<DanhMuc> danhMucList = danhMucDAO.findAll();
            model.addAttribute("danhMucList", danhMucList);

            // Lấy thông tin người dùng đã đăng nhập (nếu có)
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser != null) {
                model.addAttribute("loggedInUser", loggedInUser);
                // Điền sẵn thông tin cho form nếu người dùng đã đăng nhập
                model.addAttribute("name", loggedInUser.getHovaten());
                model.addAttribute("email", loggedInUser.getEmail());
                model.addAttribute("phone", loggedInUser.getSodienthoai());
            }

            return "support";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải trang hỗ trợ: " + e.getMessage());
            return "support";
        }
    }

    /**
     * Xử lý gửi yêu cầu hỗ trợ
     */
    @PostMapping("/support/submit")
    public String submitSupportRequest(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam String subject,
            @RequestParam String message,
            Model model,
            RedirectAttributes redirectAttributes) {

        try {
            // Gửi email thông báo
            emailService.sendSupportRequestEmail(name, email, phone, subject, message);

            // Thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage",
                    "Cảm ơn bạn đã gửi yêu cầu hỗ trợ. Chúng tôi đã gửi email xác nhận và sẽ liên hệ lại trong thời gian sớm nhất!");

            return "redirect:/support";
        } catch (Exception e) {
            // Thông báo lỗi
            model.addAttribute("error", "Đã xảy ra lỗi khi gửi yêu cầu: " + e.getMessage());

            // Giữ lại thông tin người dùng đã nhập
            model.addAttribute("name", name);
            model.addAttribute("email", email);
            model.addAttribute("phone", phone);
            model.addAttribute("subject", subject);
            model.addAttribute("message", message);

            return "support";
        }
    }
}