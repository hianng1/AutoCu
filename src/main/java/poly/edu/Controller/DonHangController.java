package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import poly.edu.Model.*;
import poly.edu.Repository.UserRepository;
import poly.edu.Service.CartService;
import poly.edu.Service.DonHangService;
import poly.edu.Service.UserService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/don-hang")
public class DonHangController {

    @Autowired
    private DonHangService donHangService;

    @Autowired
    private CartService gioHangService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepo;

    // Hiển thị trang thanh toán
    @GetMapping("/thanh-toan")
    public String showCheckoutPage(HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            if (user == null) {
                return "redirect:/login";
            }

            List<GioHang> cartItems = gioHangService.getGioHangByUser(user);

            if (cartItems == null || cartItems.isEmpty()) {
                return "redirect:/gio-hang?empty";
            }

            BigDecimal tongTien = cartItems.stream()
                    .map(item -> item.getGia().multiply(BigDecimal.valueOf(item.getSoLuong())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            model.addAttribute("user", user);
            model.addAttribute("cartItems", cartItems);
            model.addAttribute("tongTien", tongTien);
            model.addAttribute("donHangRequest", new DonHangRequest());

            return "customer/checkout";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải trang thanh toán: " + e.getMessage());
            return "redirect:/gio-hang";
        }
    }

    @PostMapping("/xu-ly-thanh-toan")
    @ResponseBody
    public ResponseEntity<?> processPayment(HttpServletRequest request, @RequestBody DonHangRequest donHangRequest) {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            if (user == null) {
                return ResponseEntity.status(401).body(Map.of("message", "Bạn chưa đăng nhập"));
            }

            List<GioHang> cartItems = gioHangService.getGioHangByUser(user);

            if (cartItems == null || cartItems.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of("message", "Giỏ hàng trống"));
            }

            DonHang donHang = donHangService.taoDonHangTam(
                    user,
                    donHangRequest.getHoTen(),
                    donHangRequest.getSoDienThoai(),
                    donHangRequest.getDiaChi(),
                    donHangRequest.getGhiChu(),
                    donHangRequest.getPhuongThucVanChuyen(),
                    donHangRequest.getPhuongThucThanhToan(),
                    cartItems
            );

            donHangService.luuDonHang(donHangRequest, user.getUsername());
            gioHangService.xoaGioHangSauKhiDatHang(user.getUsername());

            return ResponseEntity.ok().body(Map.of(
                    "message", "Đặt hàng thành công",
                    "orderId", donHang.getOrderID()
            ));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                    "message", "Lỗi khi xử lý thanh toán: " + e.getMessage()
            ));
        }
    }

    @GetMapping("/thanh-cong/{orderId}")
    public String showOrderSuccess(@PathVariable Long orderId, HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            if (user == null) return "redirect:/dang-nhap";

            DonHang donHang = donHangService.getDonHangByIdAndUser(orderId, user.getUsername());
            model.addAttribute("donHang", donHang);
            return "customer/order-success";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi hiển thị đơn hàng: " + e.getMessage());
            return "redirect:/don-hang/danh-sach";
        }
    }

    @GetMapping("/danh-sach")
    public String orderList(HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            if (user == null) return "redirect:/dang-nhap";

            List<DonHang> donHangs = donHangService.getDonHangByUser(user.getUsername());
            model.addAttribute("donHangs", donHangs);
            return "customer/order-list";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải danh sách đơn hàng: " + e.getMessage());
            return "redirect:/";
        }
    }

    @GetMapping("/chi-tiet/{orderId}")
    public String orderDetail(@PathVariable Long orderId, HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            if (user == null) return "redirect:/dang-nhap";

            DonHang donHang = donHangService.getDonHangByIdAndUser(orderId, user.getUsername());
            model.addAttribute("donHang", donHang);
            return "customer/order-detail";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải chi tiết đơn hàng: " + e.getMessage());
            return "redirect:/don-hang/danh-sach";
        }
    }

    @ControllerAdvice
    public class GlobalExceptionHandler {
        @ExceptionHandler(IllegalStateException.class)
        public ResponseEntity<?> handleSessionException(IllegalStateException ex, HttpServletRequest request) {
            System.err.println("ERROR URL: " + request.getRequestURL());
            System.err.println("Query Params: " + request.getQueryString());
            ex.printStackTrace();
            return ResponseEntity.badRequest().body("Invalid request");
        }
    }
}
