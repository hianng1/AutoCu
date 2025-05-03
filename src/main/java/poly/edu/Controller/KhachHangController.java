package poly.edu.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import poly.edu.DAO.KhachHangDAO;
import poly.edu.Model.KhachHang;
import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;

@Controller
public class KhachHangController {

    @Autowired
    private KhachHangDAO khachHangDAO;
    
    @Autowired
    private UserRepository userRepo;

    @GetMapping("/khachhang")
    public String danhSachKhachHang(Model model) {
        List<User> user = userRepo.findAll();

        model.addAttribute("khachHangs", user);
        return "Admin/danhsachkhachhang";
    }
}
