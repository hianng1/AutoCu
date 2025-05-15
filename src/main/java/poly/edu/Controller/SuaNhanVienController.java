package poly.edu.Controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.edu.DAO.UserDAO;
import poly.edu.Model.User;

@Controller
public class SuaNhanVienController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/suanhanvien")
    public String showEditEmployeePage(@RequestParam("id") Integer userId, Model model) {
        Optional<User> userOptional = userDAO.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
            // Không gửi mật khẩu đã mã hóa để hiển thị (thay vào đó để trống)
            model.addAttribute("matKhauHienThi", "");
            return "Admin/suanhanvien";
        } else {
            // Xử lý trường hợp không tìm thấy user
            return "error";
        }
    }

    @PostMapping("/suanhanvien")
    public String updateEmployee(@RequestParam("id") Integer id,
            @RequestParam("hovaten") String hovaten,
            @RequestParam("username") String username,
            @RequestParam("soDienThoai") String soDienThoai,
            @RequestParam("matKhau") String matKhau,
            @RequestParam("diaChiEmail") String diaChiEmail,
            @RequestParam("chucVu") String chucVu,
            RedirectAttributes redirectAttributes) {

        try {
            Optional<User> userOptional = userDAO.findById(id);
            if (userOptional.isPresent()) {
                User user = userOptional.get();
                user.setHovaten(hovaten);
                user.setUsername(username);
                user.setSodienthoai(soDienThoai);
                user.setEmail(diaChiEmail);
                user.setRole(chucVu);

                // Debug: In ra console để kiểm tra giá trị mật khẩu nhận được
                System.out.println("Mật khẩu nhận được: [" + matKhau + "]");

                // Chỉ cập nhật mật khẩu nếu người dùng đã nhập mật khẩu mới
                if (matKhau != null && !matKhau.trim().isEmpty()) {
                    // Mã hóa mật khẩu mới trước khi lưu
                    String encodedPassword = passwordEncoder.encode(matKhau);
                    System.out.println("Mật khẩu đã mã hóa: " + encodedPassword);
                    user.setPassword(encodedPassword);
                }

                userDAO.save(user);
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thông tin nhân viên thành công");
                return "redirect:/quantri";
            } else {
                // Xử lý trường hợp không tìm thấy user
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin nhân viên");
                return "redirect:/quantri";
            }
        } catch (Exception e) {
            // Xử lý ngoại lệ và ghi log
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi cập nhật: " + e.getMessage());
            return "redirect:/quantri";
        }
    }
}