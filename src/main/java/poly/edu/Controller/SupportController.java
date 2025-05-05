package poly.edu.Controller;

import java.util.List;
import java.util.Date;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
import poly.edu.Service.UserService;
import poly.edu.Service.TicketHoTroService;
import poly.edu.Model.TicketHoTro;
import poly.edu.Repository.KhachHangRepository;
import poly.edu.Model.KhachHang;

@Controller
public class SupportController {

    @Autowired
    private DanhMucDAO danhMucDAO;

    @Autowired
    private SanPhamDAO sanPhamDAO;

    @Autowired
    private EmailService emailService;
    
    @Autowired 
    private UserService userService;

    @Autowired
    private TicketHoTroService ticketHoTroService;

    @Autowired
    private KhachHangRepository khachHangRepository;

    /**
     * Hiển thị trang hỗ trợ khách hàng
     */
    @GetMapping("/support")
    public String showSupportPage(Model model) { // Removed HttpSession session
        try {
            // Lấy danh sách danh mục để hiển thị ở menu (Giữ nguyên)
            // Giả định danhMucDAO là một dependency đã được inject
            // List<DanhMuc> danhMucList = danhMucDAO.findAll(); // Uncomment if you have DanhMucDAO
            // model.addAttribute("danhMucList", danhMucList); // Uncomment if you have DanhMucDAO

            // *** SỬA: Lấy thông tin người dùng từ SecurityContextHolder ***
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            User loggedInUser = null;

            // Kiểm tra nếu người dùng đã xác thực và không phải là người dùng ẩn danh mặc định của Spring Security
            if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal())) {
                 // Lấy username từ đối tượng xác thực
                 String username = authentication.getName();
                 // Sử dụng userService (giả định đã inject) để tìm thông tin người dùng đầy đủ
                 // Giả định userService có phương thức findByUsername
                 loggedInUser = userService.findByUsername(username); // Giả định userService đã được inject và có method findByUsername
             }

            // Nếu user tìm thấy (tức là người dùng đã đăng nhập thành công và tồn tại trong DB)
            if (loggedInUser != null) {
                model.addAttribute("loggedInUser", loggedInUser);
                // Điền sẵn thông tin cho form nếu người dùng đã đăng nhập
                model.addAttribute("name", loggedInUser.getHovaten()); // Sử dụng getHovaten() từ đối tượng User
                model.addAttribute("email", loggedInUser.getEmail());   // Sử dụng getEmail() từ đối tượng User
                model.addAttribute("phone", loggedInUser.getSodienthoai()); // Sử dụng getSodienthoai() từ đối tượng User
            }
            // Nếu loggedInUser là null, tức là chưa đăng nhập, các thuộc tính name, email, phone sẽ không được thêm vào model,
            // và form sẽ hiển thị trống, điều này là hành vi mong muốn cho người dùng chưa đăng nhập.

            // Trả về tên view (support.html hoặc support.jsp)
            return "support";
        } catch (Exception e) {
            // Xử lý lỗi (Giữ nguyên)
            model.addAttribute("error", "Lỗi khi tải trang hỗ trợ: " + e.getMessage());
            // Có thể log lỗi ra console hoặc file log
            e.printStackTrace();
            return "support"; // Vẫn trả về view support để hiển thị thông báo lỗi
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
            // Lấy user hiện tại nếu đã đăng nhập
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            User loggedInUser = null;
            if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal())) {
                String username = authentication.getName();
                loggedInUser = userService.findByUsername(username);
            }

            // Lưu ticket vào database
            TicketHoTro ticket = new TicketHoTro();
            ticket.setMoTaVanDe(message);
            ticket.setTrangThai("Pending");
            ticket.setNgayTao(new Date());
            ticket.setNgayCapNhat(new Date());
            if (loggedInUser != null) {
                // Lấy KhachHang từ email của User
                java.util.Optional<KhachHang> khachHangOpt = khachHangRepository.findByEmail(loggedInUser.getEmail());
                if (khachHangOpt.isPresent()) {
                    ticket.setKhachHang(khachHangOpt.get());
                } else {
                    model.addAttribute("error", "Không tìm thấy thông tin khách hàng.");
                    return "support";
                }
            } else {
                model.addAttribute("error", "Bạn cần đăng nhập để gửi yêu cầu hỗ trợ.");
                return "support";
            }
            ticketHoTroService.save(ticket);

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