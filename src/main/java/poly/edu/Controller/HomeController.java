package poly.edu.Controller;

import java.util.List;
import java.util.Optional;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import poly.edu.DAO.DanhMucDAO;
import poly.edu.DAO.KhachHangDAO;
import poly.edu.DAO.MaKhuyenMaiDAO;
import poly.edu.DAO.NhanVienDAO;
import poly.edu.DAO.PhuKienOtoDAO;
import poly.edu.DAO.SanPhamDAO;
import poly.edu.DAO.UserDAO;
import poly.edu.Model.*;
import poly.edu.Repository.UserRepository;
import poly.edu.Service.PhuKienOtoService;
import poly.edu.Service.SanPhamService;
import poly.edu.Service.UserService;

@Controller
public class HomeController {
	
	@Autowired
    private DanhMucDAO danhMucDAO;
    @Autowired
    private SanPhamDAO sanPhamDAO;
    @Autowired
    private NhanVienDAO nhanVienDAO;
    @Autowired
    private KhachHangDAO KhachHangDAO;
    @Autowired
    private MaKhuyenMaiDAO maKhuyenMaiDAO;
    @Autowired
    private PhuKienOtoDAO phuKienOtoDAO;
    @Autowired

    private SanPhamService sanPhamService;
    @Autowired
    private PhuKienOtoService phuKienOtoService;
    @GetMapping(value = "/trangchu", produces = "text/html; charset=UTF-8")
    public String home(Model model) {
        try {
            List<SanPham> sanPhamList = sanPhamDAO.findAll();
            model.addAttribute("sanPhamList", sanPhamList);
            List<DanhMuc> danhMucList = danhMucDAO.findAll();
            model.addAttribute("danhMucList", danhMucList);
            List<NhanVien> nhanVienList = nhanVienDAO.findAll();
            model.addAttribute("nhanVienList", nhanVienList);
            List<KhachHang> khachHangList = KhachHangDAO.findAll();
            model.addAttribute("khachHangList", khachHangList);
            List<MaKhuyenMai> maKhuyenMaiList = maKhuyenMaiDAO.findAll();
            model.addAttribute("maKhuyenMaiList", maKhuyenMaiList);
            List<PhuKienOto> phuKienOtoList = phuKienOtoService.findAll();
            model.addAttribute("phuKienOtoList", phuKienOtoList);


            
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
        }
        return "index2";
    }
    @GetMapping("/checkout")
    public String checkoutPage(Model model) {
        // Gán dữ liệu nếu cần
		/* model.addAttribute("title", "Trang thanh toán"); */
        
        // Trả về file templates/checkout.html
        return "checkout";
    }
    
    //test
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
                           @RequestParam String hovaten,
                           @RequestParam(required = true) String sodienthoai,
                           @RequestParam String soNha,
                           @RequestParam String phuongXa,
                           @RequestParam String quanHuyen,
                           @RequestParam String tinhThanh,
                           Model model,
                           RedirectAttributes redirectAttributes) {
        // Kết hợp các phần thông tin địa chỉ để tạo thành địa chỉ đầy đủ
        String diaChiFull = String.join(", ", soNha, phuongXa, quanHuyen, tinhThanh);
        
        // Gọi service để thực hiện đăng ký
        String result = userService.registerUser(username, password, email, hovaten, sodienthoai, diaChiFull);
        
        // Kiểm tra kết quả trả về từ service
        if ("Đăng ký thành công!".equals(result)) {
            redirectAttributes.addFlashAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/login"; // Chuyển hướng đến trang login nếu đăng ký thành công
        }

        // Nếu đăng ký thất bại, gửi thông báo lỗi tới model và trả về trang đăng ký
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
            return "redirect:/quantri"; // Chuyển đến trang admin nếu là admin
        } else {
            return "redirect:/trangchu";  // Chuyển đến trang user nếu là user thường
        }
    }
    @Autowired
    private UserDAO userDAO;
	
    @GetMapping
    public String danhSachNguoiDung(Model model) {
    	List<User> users = userDAO.findAll(); // Lấy *tất cả* user
        model.addAttribute("users", users);
        return "Admin/quantri";
    }
    
    
    
    @GetMapping("/details/{productId}")
    public String getDetailsByProductId(@PathVariable("productId") Long productId, Model model) {
        List<SanPham> details = sanPhamDAO.findByProductId(productId);

        if (!details.isEmpty()) {
            SanPham sanPham = details.get(0);
            Long categoryID = sanPham.getDanhMuc().getCategoryID(); // Dùng kiểu Long

            // 🛠 Debug
            System.out.println("CategoryID: " + categoryID);
            System.out.println("ProductID: " + productId);

            List<SanPham> sanPhamTuongTu = sanPhamService.getSanPhamTuongTu(categoryID, productId);
            System.out.println("Số sản phẩm tương tự: " + sanPhamTuongTu.size());

            model.addAttribute("sanPhamTuongTu", sanPhamTuongTu);
        }

        model.addAttribute("details", details);
        return "Detail";
    }

    
    
    
    
    // sử lý quên mật khẩu và đôi mật khẩu 
    

 // Quên mật khẩu
	/*
	 * @PostMapping("/forgot-password") public String forgotPassword(@RequestParam
	 * String email, Model model) { String result =
	 * userService.handleForgotPassword(email); model.addAttribute("message",
	 * result); return "forgot-password"; // Quay lại trang quên mật khẩu với thông
	 * báo kết quả }
	 * 
	 * @PostMapping("/change-password") public String changePassword(@RequestParam
	 * Long userId,
	 * 
	 * @RequestParam String currentPassword,
	 * 
	 * @RequestParam String newPassword, Model model) { String result =
	 * userService.changePassword(userId, currentPassword, newPassword);
	 * model.addAttribute("message", result); // Thêm thông báo kết quả vào model
	 * model.addAttribute("userId", userId); // Truyền lại userId để giữ giá trị
	 * trong form return "change-password"; // Quay lại trang đổi mật khẩu với thông
	 * báo kết quả }
	 * 
	 * // Hiển thị trang đổi mật khẩu
	 * 
	 * @GetMapping("/change-password") public String
	 * showChangePasswordPage(@RequestParam Long userId, Model model) {
	 * model.addAttribute("userId", userId); // Truyền userId vào model để hiển thị
	 * trong form return "change-password"; }
	 * 
	 * 
	 * @GetMapping("/forgot-password") public String showForgotPasswordPage() {
	 * return "forgot-password"; // Trả về trang quên mật khẩu }
	 */
    
    
// phần gửi mail với đổi mât khẩu 

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestParam String email, Model model, RedirectAttributes redirectAttributes) {
        String result = userService.handleForgotPassword(email);
        if (result.contains("đã được gửi")) {
            User user = userRepository.findByEmail(email).get();
            redirectAttributes.addFlashAttribute("message", result);
            return "redirect:/change-password?userId=" + user.getId();
        } else {
            model.addAttribute("message", result);
            return "forgot-password";
        }
    }

    @GetMapping("/change-password")
    public String showChangePasswordPage(@RequestParam Long userId, Model model) {
        model.addAttribute("userId", userId);
        return "change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam Long userId,
                                 @RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 Model model, RedirectAttributes redirectAttributes) {
        String result = userService.changePassword(userId, currentPassword, newPassword);
        if (result.contains("thành công")) {
            redirectAttributes.addFlashAttribute("message", result);
            return "redirect:/login";
        } else {
            model.addAttribute("message", result);
            model.addAttribute("userId", userId);
            return "change-password";
        }
    }
    
    
    
    
    
    
}
