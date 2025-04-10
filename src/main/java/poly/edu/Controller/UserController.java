package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import poly.edu.DAO.UserDAO;
import poly.edu.Model.User;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/quantri")
    public String danhSachNguoiDung(Model model) {
        List<User> users = userDAO.findAll(); // Lấy *tất cả* user
        model.addAttribute("users", users);
        return "Admin/quantri";
    }
}