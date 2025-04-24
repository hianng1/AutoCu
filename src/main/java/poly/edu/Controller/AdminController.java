package poly.edu.Controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.edu.DAO.UserDAO;
import poly.edu.Model.User;

@Controller
@RequestMapping("/Admin")
public class AdminController {
	@Autowired
    private UserDAO userDAO;

    @GetMapping

    public String danhSachNguoiDung(Model model) {
    	List<User> users = userDAO.findAll(); // Lấy *tất cả* user
        model.addAttribute("users", users);
        return "Admin/quantri";
    }
        @GetMapping("/themnhanvien")
        public String showAddEmployeePage() {
            return "Admin/themnhanvien";
        }
        @GetMapping("/suanhanvien")
        public String editEmployeePage() {
            return "Admin/suanhanvien";
        }





}

