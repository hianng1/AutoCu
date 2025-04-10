package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import poly.edu.DAO.UserDAO;
import poly.edu.Model.User;

@Controller
public class XoaNhanVienController {

    @Autowired
    private UserDAO userDAO;

    @PostMapping("/xoanhanvien")
    public String xoaNhanVien(@RequestParam("id") Integer id) {
        // Tìm người dùng theo ID
        User user = userDAO.findById(id).orElse(null);

        if (user != null) {
            // Xóa người dùng
            userDAO.delete(user);
        }

        // Chuyển hướng về trang quản trị
        return "redirect:/quantri";
    }
}
