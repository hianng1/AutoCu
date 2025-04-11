package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import poly.edu.DAO.KhachHangDAO;
import poly.edu.Model.KhachHang;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class XoaKhachHangController {

    @Autowired
    private KhachHangDAO khachHangDAO;

    @PostMapping("/xoakhachhang")
    public String xoaKhachHang(@RequestParam("userID") Long userID, RedirectAttributes redirectAttributes) { // Changed Integer to Long
        try {
            // Tìm khách hàng theo ID
            KhachHang khachHang = khachHangDAO.findById(userID).orElse(null);

            if (khachHang != null) {
                // Xóa khách hàng
                khachHangDAO.delete(khachHang);
                redirectAttributes.addFlashAttribute("message", "Xóa khách hàng thành công.");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy khách hàng với ID: " + userID);
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Đã xảy ra lỗi khi xóa khách hàng: " + e.getMessage());
        }

        // Chuyển hướng về trang danh sách khách hàng
        return "redirect:/khachhang"; // Thay thế bằng URL thực tế của bạn
    }
}