
  package poly.edu.Controller;
  import org.springframework.security.core.Authentication;
  import org.springframework.beans.factory.annotation.Autowired; import
  org.springframework.stereotype.Controller; import
  org.springframework.ui.Model; import
  org.springframework.web.bind.annotation.*; import
  org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import
  poly.edu.Model.*; import poly.edu.Service.DonHangService; import
  poly.edu.Service.PhuKienOtoService;
  
  import javax.servlet.http.HttpSession;
  
  import java.math.BigDecimal; import java.util.Date; import java.util.List;
  import java.util.stream.Collectors;
  
  @Controller
  @RequestMapping("/checkout")
  public class CheckoutController {

      @Autowired
      private PhuKienOtoService phuKienOtoService;

      @Autowired
      private DonHangService donHangService;

      @GetMapping
      public String showCheckoutPage(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
          // Lấy session, tạo mới nếu chưa có
          jakarta.servlet.http.HttpSession session = request.getSession(true);  // sử dụng true để đảm bảo session luôn tồn tại
          
          // Kiểm tra nếu session không tồn tại hoặc không có thông tin người dùng trong session
          if (session.getAttribute("user") == null) {
              return "redirect:/login?redirect=checkout";  // nếu chưa đăng nhập, chuyển hướng đến trang login
          }
          

          // Kiểm tra giỏ hàng
          List<GioHang> cartItems = (List<GioHang>) session.getAttribute("cartItems");
          if (cartItems == null || cartItems.isEmpty()) {
              redirectAttributes.addFlashAttribute("error", "Giỏ hàng của bạn đang trống.");
              return "redirect:/cart/views";
          }

          // Kiểm tra từng sản phẩm trong giỏ hàng
          for (GioHang item : cartItems) {
              PhuKienOto phuKien = phuKienOtoService.findById(item.getPhuKienOto().getAccessoryID());
              if (phuKien == null) {
                  redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại trong hệ thống.");
                  return "redirect:/cart";
              }

              if (phuKien.getSoLuong() < item.getSoLuong()) {
                  redirectAttributes.addFlashAttribute("error",
                          String.format("Sản phẩm %s chỉ còn %d sản phẩm trong kho.",
                                  phuKien.getTenPhuKien(), phuKien.getSoLuong()));
                  return "redirect:/cart";
              }
          }

          // Tính tổng giá trị giỏ hàng
          double subtotal = calculateSubtotal(cartItems);
          model.addAttribute("cartItems", cartItems);
          model.addAttribute("subtotal", subtotal);

          // Lấy thông tin người dùng từ session
          model.addAttribute("user", session.getAttribute("user"));

          return "checkout";
      }


      @PostMapping
      @Transactional
      public String processCheckout(
              @RequestParam String fullName,
              @RequestParam String phone,
              @RequestParam String address,
              @RequestParam(required = false) String note,
              @RequestParam String shippingMethod,
              @RequestParam String paymentMethod,
              HttpSession session,  // Sử dụng HttpSession để lấy thông tin người dùng
              RedirectAttributes redirectAttributes) {

          List<GioHang> cartItems = (List<GioHang>) session.getAttribute("cartItems");
          if (cartItems == null || cartItems.isEmpty()) {
              redirectAttributes.addFlashAttribute("error", "Giỏ hàng của bạn đang trống.");
              return "redirect:/cart";
          }

          // Lấy user từ session thay vì Spring Security
          User user = (User) session.getAttribute("user");
          if (user == null) {
              redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đặt hàng.");
              return "redirect:/login?redirect=checkout";
          }

          try {
              for (GioHang item : cartItems) {
                  PhuKienOto phuKien = phuKienOtoService.findById(item.getPhuKienOto().getAccessoryID());
                  if (phuKien == null || phuKien.getSoLuong() < item.getSoLuong()) {
                      redirectAttributes.addFlashAttribute("error",
                              String.format("Sản phẩm %s không đủ hàng trong kho.",
                                      item.getPhuKienOto().getTenPhuKien()));
                      return "redirect:/cart";
                  }
              }

              BigDecimal shippingFee = "fast".equals(shippingMethod) ? new BigDecimal("30000") : BigDecimal.ZERO;

              DonHang donHang = new DonHang();
              donHang.setUser(user);
              donHang.setHoTen(fullName);
              donHang.setSoDienThoai(phone);
              donHang.setDiaChi(address);
              donHang.setGhiChu(note);
              donHang.setPhuongThucVanChuyen(shippingMethod);
              donHang.setPhuongThucThanhToan(paymentMethod);
              donHang.setNgayDatHang(new Date());
              donHang.setTrangThai(DonHang.TrangThai.CHO_XAC_NHAN.name());
              donHang.setPhiVanChuyen(shippingFee);
              donHang.setDaThanhToan(false);

              List<ChiTietDonHang> chiTietDonHangs = convertToChiTietDonHangs(cartItems, donHang);
              donHang.setChiTietDonHangs(chiTietDonHangs);
              donHang.tinhTongTien();

              DonHang savedOrder = donHangService.taoDonHang(donHang, cartItems);

              // Cập nhật tồn kho
              for (ChiTietDonHang item : chiTietDonHangs) {
                  phuKienOtoService.updateStock(item.getPhuKienOto().getAccessoryID(), item.getSoLuong());
              }

              // Xoá giỏ hàng khỏi session sau khi đặt hàng thành công
              session.removeAttribute("cartItems");
              redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công!");
              redirectAttributes.addFlashAttribute("orderId", savedOrder.getOrderID());

              return "redirect:/order/success";

          } catch (Exception e) {
              redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng. Vui lòng thử lại.");
              return "redirect:/checkout";
          }
      }

      private double calculateSubtotal(List<GioHang> cartItems) {
          return cartItems.stream()
                  .mapToDouble(item -> item.getPhuKienOto().getGia() * item.getSoLuong())
                  .sum();
      }

      private List<ChiTietDonHang> convertToChiTietDonHangs(List<GioHang> cartItems, DonHang donHang) {
          return cartItems.stream().map(cartItem -> {
              ChiTietDonHang chiTiet = new ChiTietDonHang();
              chiTiet.setDonHang(donHang);
              chiTiet.setPhuKienOto(cartItem.getPhuKienOto());
              chiTiet.setSoLuong(cartItem.getSoLuong());
              chiTiet.setDonGia(BigDecimal.valueOf(cartItem.getPhuKienOto().getGia()));
              return chiTiet;
          }).collect(Collectors.toList());
      }
  }

 