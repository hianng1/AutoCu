package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import poly.edu.Service.ChiTietDonHangService;
import poly.edu.Model.ChiTietDonHang;
import java.util.List;

@Controller
public class TheoDoiDonHangController {

    @Autowired
    private ChiTietDonHangService chiTietDonHangService;

    // Hiển thị form theo dõi đơn hàng (GET request)
    @GetMapping("/theodoidonhang")
    public String hienThiFormTheoDoi() {
        return "theodoidonhang";
    }

    // Xử lý việc theo dõi đơn hàng sau khi submit form (GET request từ form)
    @GetMapping("/theodoidonhang/trangthai")
    public String hienThiTrangThaiDonHang(@RequestParam("orderid") Long orderId, Model model) {
        List<ChiTietDonHang> danhSachChiTiet = chiTietDonHangService.findByDonHang_OrderID(orderId);

        if (danhSachChiTiet != null && !danhSachChiTiet.isEmpty()) {
            model.addAttribute("danhSachChiTiet", danhSachChiTiet);
            model.addAttribute("orderId", orderId); // Truyền orderId để hiển thị trên trang
            return "trangthaidonhang";
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy thông tin cho mã đơn hàng: " + orderId);
            return "theodoidonhang"; // Quay lại trang nhập mã nếu không tìm thấy
        }
    }
}