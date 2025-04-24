package poly.edu.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import poly.edu.DAO.KhachHangDAO;
import poly.edu.Model.KhachHang;

@Controller
public class KhachHangController {

    @Autowired
    private KhachHangDAO khachHangDAO;

    @GetMapping("/khachhang")
    public String danhSachKhachHang(Model model) {
        List<KhachHang> khachHangs = khachHangDAO.findAll();

        model.addAttribute("khachHangs", khachHangs);
        return "Admin/danhsachkhachhang";
    }
}
