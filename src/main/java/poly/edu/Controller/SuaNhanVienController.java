package poly.edu.Controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import poly.edu.DAO.UserDAO;
import poly.edu.Model.User;

@Controller
public class SuaNhanVienController {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/suanhanvien")
    public String showEditEmployeePage(@RequestParam("id") Integer userId, Model model) {

        Optional<User> userOptional = userDAO.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
            return "Admin/suanhanvien";
        } else {
            // Xử lý trường hợp không tìm thấy user (ví dụ: hiển thị thông báo lỗi)
            return "error"; // Hoặc chuyển hướng đến trang danh sách người dùng
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
                                 Model model) {
        Optional<User> userOptional = userDAO.findById(id);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setHovaten(hovaten);
            user.setUsername(username);
            user.setSodienthoai(soDienThoai);
            user.setPassword(matKhau);
            user.setEmail(diaChiEmail);
            user.setRole(chucVu);

            userDAO.save(user);
            return "redirect:/quantri"; // Chuyển hướng về trang danh sách
        } else {
            // Xử lý trường hợp không tìm thấy user
            return "error";
        }
    }
}