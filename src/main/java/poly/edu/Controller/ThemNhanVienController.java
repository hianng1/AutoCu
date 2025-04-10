package poly.edu.Controller;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ThemNhanVienController {

    @Autowired
    private UserRepository userRepository;

    private static final Logger logger = LoggerFactory.getLogger(ThemNhanVienController.class);

    @GetMapping("/themnhanvien")
    public String showAddEmployeePage() {
        return "Admin/themnhanvien";
    }

    @PostMapping("/themnhanvien")
    public String addEmployee(@RequestParam("ho") String ho,
                              @RequestParam("ten") String ten,
                              @RequestParam("username") String username,
                              @RequestParam("matKhau") String matKhau,
                              @RequestParam("diaChiEmail") String diaChiEmail,
                              @RequestParam("xacNhanMatKhau") String xacNhanMatKhau,
                              @RequestParam("chucVu") String chucVu,
                              @RequestParam(value = "soDienThoai", required = false) String soDienThoai,
                              Model model) {

     

        String hovaten = ho + " " + ten;
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(matKhau);
        newUser.setEmail(diaChiEmail);
        newUser.setRole(chucVu);
        newUser.setHovaten(hovaten);
        newUser.setSodienthoai(soDienThoai);

        try {
            userRepository.save(newUser);
            model.addAttribute("message", "Thêm tài khoản thành công!");
        } catch (DataIntegrityViolationException e) {
            // Kiểm tra xem lỗi có phải do vi phạm ràng buộc UNIQUE không
            if (e.getMessage().contains("constraint [users_username_key]")) {
                model.addAttribute("error", "Lỗi: Tên người dùng đã tồn tại. Vui lòng chọn tên người dùng khác.");
            } else if (e.getMessage().contains("constraint [users_email_key]")) {
                model.addAttribute("error", "Lỗi: Địa chỉ email đã tồn tại. Vui lòng sử dụng địa chỉ email khác.");
            } else {
                // Nếu không phải lỗi trùng username hoặc email, có thể là lỗi khác
                model.addAttribute("error", "Lỗi: Đã xảy ra lỗi khi thêm người dùng. Vui lòng thử lại sau.");
                logger.error("Lỗi DataIntegrityViolationException không xác định: {}", e.getMessage());
            }
            return "Admin/themnhanvien";
        } catch (Exception e) {
            // Bắt các lỗi khác (ví dụ: lỗi kết nối cơ sở dữ liệu)
            model.addAttribute("error", "Lỗi: Đã xảy ra lỗi khi thêm người dùng. Vui lòng thử lại sau.");
            logger.error("Lỗi không xác định: {}", e.getMessage());
            return "Admin/themnhanvien";
        }

        return "Admin/themnhanvien";
    }
}