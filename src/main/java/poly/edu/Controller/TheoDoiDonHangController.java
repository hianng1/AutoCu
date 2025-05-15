package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Model.User;
import poly.edu.Repository.DonHangRepository;
import poly.edu.Service.ChiTietDonHangService;
import poly.edu.Service.UserService;

import java.util.List;
import java.util.Optional;

@Controller
public class TheoDoiDonHangController {

    @Autowired
    private ChiTietDonHangService chiTietDonHangService;

    @Autowired
    private DonHangRepository donHangRepository;

    @Autowired
    private UserService userService;

    // Hiển thị form theo dõi đơn hàng (GET request)
    @GetMapping("/theodoidonhang")
    public String hienThiFormTheoDoi(Model model, RedirectAttributes redirectAttributes) {
        // Kiểm tra đăng nhập
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            redirectAttributes.addFlashAttribute("loginMessage", "Vui lòng đăng nhập để theo dõi đơn hàng");
            return "redirect:/login";
        }

        // Lấy thông tin người dùng hiện tại
        String username = authentication.getName();
        User currentUser = userService.findByUsername(username);

        if (currentUser != null) {
            // Nếu đã đăng nhập, hiển thị đơn hàng của người dùng
            model.addAttribute("userInfo", currentUser);
        }

        return "theodoidonhang";
    }

    // Xử lý việc theo dõi đơn hàng sau khi submit form (GET request từ form)
    @GetMapping("/theodoidonhang/trangthai")
    public String hienThiTrangThaiDonHang(@RequestParam("orderid") Long orderId, Model model,
            RedirectAttributes redirectAttributes) {
        // Kiểm tra đăng nhập
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            redirectAttributes.addFlashAttribute("loginMessage", "Vui lòng đăng nhập để theo dõi đơn hàng");
            return "redirect:/login";
        }

        // Lấy thông tin người dùng hiện tại
        String username = authentication.getName();
        User currentUser = userService.findByUsername(username);
        model.addAttribute("userInfo", currentUser);

        // Lấy thông tin đơn hàng
        Optional<DonHang> donHangOpt = donHangRepository.findById(orderId);

        if (donHangOpt.isPresent()) {
            DonHang donHang = donHangOpt.get();

            // Kiểm tra đơn hàng có thuộc về người dùng hiện tại không
            if (donHang.getUser().getId().equals(currentUser.getId()) || "ADMIN".equals(currentUser.getRole())) {
                // Lấy chi tiết đơn hàng
                List<ChiTietDonHang> danhSachChiTiet = chiTietDonHangService.findByDonHang_OrderID(orderId);

                model.addAttribute("donHang", donHang);
                model.addAttribute("danhSachChiTiet", danhSachChiTiet);
                return "trangthaidonhang";
            } else {
                // Đơn hàng không thuộc về người dùng này
                model.addAttribute("errorMessage", "Bạn không có quyền xem đơn hàng này");
                return "theodoidonhang";
            }
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy thông tin cho mã đơn hàng: " + orderId);
            return "theodoidonhang";
        }
    }
}