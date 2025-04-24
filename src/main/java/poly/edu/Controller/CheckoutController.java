/*
 * package poly.edu.Controller;
 *
 * import org.springframework.http.ResponseEntity; import
 * org.springframework.http.HttpStatus; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.PostMapping; import poly.edu.Model.*;
 * import poly.edu.Service.DonHangService; import
 * poly.edu.Service.GioHangService; import poly.edu.Service.PhuKienOtoService;
 *
 * import jakarta.servlet.http.HttpSession; import
 * jakarta.transaction.Transactional; import java.math.BigDecimal; import
 * java.util.Date; import java.util.List; import java.util.stream.Collectors;
 *
 * @Controller public class CheckoutController {
 *
 * @Autowired private DonHangService donHangService;
 *
 * @Autowired private PhuKienOtoService phuKienOtoService;
 *
 * @Autowired private GioHangService gioHangService;
 *
 * @PostMapping("/checkout")
 *
 * @Transactional public ResponseEntity<String> checkout(HttpSession session) {
 * try { User user = (User) session.getAttribute("loggedInUser"); if (user ==
 * null) { return
 * ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Vui lòng đăng nhập"); }
 *
 * // Lấy thông tin giỏ hàng từ session hoặc service List<CartItem> cartItems =
 * gioHangService.getAllItems(); if (cartItems == null || cartItems.isEmpty()) {
 * return ResponseEntity.badRequest().body("Giỏ hàng trống"); }
 *
 * // Tính tổng tiền BigDecimal totalAmount = cartItems.stream() .map(item ->
 * item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
 * .reduce(BigDecimal.ZERO, BigDecimal::add);
 *
 * // Tạo đơn hàng mới DonHang donHang = new DonHang(); donHang.setUser(user);
 * donHang.setNgayDatHang(new Date()); donHang.setTrangThai("Đang xử lý");
 * donHang.setTongTien(totalAmount);
 * donHang.setDiaChiGiaoHang(user.getDiaChi());
 *
 * // Lưu đơn hàng DonHang savedDonHang = donHangService.saveDonHang(donHang);
 *
 * // Tạo chi tiết đơn hàng cho từng sản phẩm List<ChiTietDonHang>
 * chiTietDonHangs = cartItems.stream() .map(item -> { ChiTietDonHang chiTiet =
 * new ChiTietDonHang(); chiTiet.setDonHang(savedDonHang);
 * chiTiet.setPhuKienOto(item.getPhuKienOto());
 * chiTiet.setSoLuong(item.getQuantity()); chiTiet.setDonGia(item.getPrice());
 * chiTiet.setThanhTien(item.getPrice().multiply(BigDecimal.valueOf(item.
 * getQuantity()))); return chiTiet; }) .collect(Collectors.toList());
 *
 * // Lưu chi tiết đơn hàng
 * donHangService.saveAllChiTietDonHang(chiTietDonHangs);
 *
 * // Xóa giỏ hàng sau khi thanh toán gioHangService.clear();
 *
 * return ResponseEntity.ok("Thanh toán thành công. Mã đơn hàng: " +
 * savedDonHang.getMaDonHang()); } catch (Exception e) { e.printStackTrace();
 * return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
 * .body("Lỗi thanh toán: " + e.getMessage()); } } }
 */