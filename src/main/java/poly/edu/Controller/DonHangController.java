package poly.edu.Controller;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Repository.ChiTietDonHangRepository;
import poly.edu.Repository.DonHangRepository;

import java.util.List;

@Controller
@RequestMapping("/donhang")
@RequiredArgsConstructor
public class DonHangController {

    private final DonHangRepository donHangRepo;
    
    @Autowired
    private DonHangRepository donHangRepository; 
    
    @Autowired
    private ChiTietDonHangRepository chiTietDonHangRepository;

    // ✅ Hiển thị danh sách đơn hàng với lọc theo trạng thái
    @GetMapping
    public String listDonHang(@RequestParam(name = "trangThai", required = false) DonHang.TrangThai trangThai, Model model) {
        List<DonHang> danhSach;

        if (trangThai != null) {
            danhSach = donHangRepo.findByTrangThai(trangThai);
        } else {
            danhSach = donHangRepo.findAll();
        }

        model.addAttribute("donHangs", danhSach);
        model.addAttribute("trangThaiSelected", trangThai);
        model.addAttribute("trangThais", DonHang.TrangThai.values());
        return "Admin/Quanlydonhang"; // trỏ tới file quanlydonhang
    }

    // ✅ Cập nhật trạng thái đơn hàng
    @PostMapping("/update/{id}")
    public String updateTrangThai(@PathVariable("id") Long id, @RequestParam("trangThai") DonHang.TrangThai trangThai) {
        DonHang donHang = donHangRepo.findById(id).orElse(null);
        if (donHang != null) {
            donHang.setTrangThai(trangThai);
            donHangRepo.save(donHang);
        }
        return "redirect:/donhang";
    }
    @GetMapping("/chitiet/{id}")
    public String xemChiTietDonHang(@PathVariable("id") Long id, Model model) {
        DonHang donHang = donHangRepository.findById(id).orElse(null);
        if (donHang == null) {
            return "redirect:/donhang";
        }

        List<ChiTietDonHang> chiTietDonHangs = chiTietDonHangRepository.findByDonHangOrderByOrderItemIDAsc(donHang);
        model.addAttribute("donHang", donHang);
        model.addAttribute("chiTietDonHangs", chiTietDonHangs);

        return "Admin/chitietdonhang"; // Trang JSP
    }

}
