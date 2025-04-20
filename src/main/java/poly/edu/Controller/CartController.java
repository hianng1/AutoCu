package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Model.KhachHang;
import poly.edu.Repository.KhachHangRepository;
import poly.edu.Service.CartService;
import poly.edu.Service.DonHangService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import poly.edu.Model.DonHang;
import poly.edu.Model.GioHang;
import poly.edu.Model.KhachHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Service.CartService;
import poly.edu.Service.DonHangService;
import poly.edu.Service.PhuKienOtoService;

@Controller
@RequestMapping("cart")
public class CartController {
	@Autowired
	PhuKienOtoService phuKienOtoService;

	@Autowired
	CartService cartService;

	@Autowired
	DonHangService donHangService;
	
	@Autowired
	KhachHangRepository khachHangRepository;
	 

	// Hiển thị giỏ hàng
	@GetMapping("views")
	public String viewsCart(Model model, HttpServletRequest request) {
	    // Lấy thông tin giỏ hàng
	    model.addAttribute("CART_ITEMS", cartService.getAllItems());
	    model.addAttribute("TOTAL", cartService.getAmounts());
	    
	    // Lấy thông tin người dùng từ session - sửa thành loggedInUser
	    jakarta.servlet.http.HttpSession session = request.getSession();
	    User user = (User) session.getAttribute("loggedInUser"); // Thay đổi ở đây
	    if (user != null) {
	        model.addAttribute("userInfo", user);
	    }
	    
	    return "cart";
	}

	// Thêm phụ kiện vào giỏ hàng
	/*
	 * @GetMapping("/add/{id}") public String addCart(@PathVariable("id") Long id) {
	 * PhuKienOto pk = phuKienOtoService.findById(id); if (pk != null) { GioHang
	 * item = new GioHang(); item.setPhuKienOto(pk); item.setSoLuong(1); // Đặt số
	 * lượng ban đầu cartService.add(item); } return "redirect:/cart/views"; }
	 */
	@GetMapping("/add/{id}")
	public String addCart(@PathVariable("id") Long id, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		PhuKienOto pk = phuKienOtoService.findById(id);
		if (pk != null) {
			GioHang item = new GioHang();
			item.setPhuKienOto(pk);
			item.setSoLuong(1);
			cartService.add(item);

			// Thêm thông báo thành công
			redirectAttributes.addFlashAttribute("successMessage", "Đã thêm vào giỏ hàng!");
		} else {
			redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm không tồn tại!");
		}

		// Lấy URL trang trước đó từ header "Referer"
		String referer = request.getHeader("Referer");
		return "redirect:" + (referer != null ? referer : "/trangchu");
	}

	@PostMapping("update")
	public String update(@RequestParam("id") long id, @RequestParam("soLuong") Integer soLuong) {
		cartService.update(id, soLuong);
		return "redirect:/cart/views";
	}

	@GetMapping("clear")
	public String clearCart() {
		cartService.clear();
		return "redirect:/cart/views";
	}

	@GetMapping("del/{id}")
	public String removeCart(@PathVariable("id") Long id) {
		cartService.remove(id);
		return "redirect:/cart/views";
	}

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }
	
	/*
	 * @Autowired private DonHangService donHangService;
	 * 
	 * @Autowired private PhuKienOtoService phuKienOtoService;
	 */

	/*
	 * @GetMapping("/checkout") public String showCheckoutPage(HttpServletRequest
	 * request, Model model, RedirectAttributes redirectAttributes) { HttpSession
	 * session = (HttpSession) request.getSession(false); if (session == null) {
	 * return "redirect:/login?redirect=checkout"; }
	 * 
	 * User user = (User) session.getAttribute("user"); if (user == null) { return
	 * "redirect:/login?redirect=checkout"; }
	 * 
	 * List<GioHang> cartItems = (List<GioHang>) session.getAttribute("cartItems");
	 * if (cartItems == null || cartItems.isEmpty()) { return "redirect:/cart"; }
	 * 
	 * for (GioHang item : cartItems) { PhuKienOto phuKien =
	 * phuKienOtoService.findById(item.getPhuKienOto().getAccessoryID()); if
	 * (phuKien == null) { redirectAttributes.addFlashAttribute("error",
	 * "Sản phẩm không tồn tại"); return "redirect:/cart"; }
	 * 
	 * if (phuKien.getSoLuong() < item.getSoLuong()) {
	 * redirectAttributes.addFlashAttribute("error", "Sản phẩm " +
	 * phuKien.getTenPhuKien() + " chỉ còn " + phuKien.getSoLuong() + " sản phẩm");
	 * return "redirect:/cart"; } }
	 * 
	 * double subtotal = calculateSubtotal(cartItems);
	 * model.addAttribute("cartItems", cartItems); model.addAttribute("subtotal",
	 * subtotal); model.addAttribute("user", user);
	 * 
	 * return "checkout"; }
	 * 
	 * 
	 * @PostMapping
	 * 
	 * @Transactional public String processCheckout(
	 * 
	 * @RequestParam String fullName,
	 * 
	 * @RequestParam String phone,
	 * 
	 * @RequestParam String address,
	 * 
	 * @RequestParam(required = false) String note,
	 * 
	 * @RequestParam String shippingMethod,
	 * 
	 * @RequestParam String paymentMethod, HttpSession session, RedirectAttributes
	 * redirectAttributes, Authentication authentication) {
	 * 
	 * // 1. Kiểm tra và lấy giỏ hàng từ session List<GioHang> cartItems =
	 * (List<GioHang>) session.getAttribute("cartItems"); if (cartItems == null ||
	 * cartItems.isEmpty()) { redirectAttributes.addFlashAttribute("error",
	 * "Giỏ hàng của bạn đang trống"); return "redirect:/cart"; }
	 * 
	 * // 2. Lấy thông tin user User user; try { user = (User)
	 * authentication.getPrincipal(); } catch (Exception e) {
	 * redirectAttributes.addFlashAttribute("error",
	 * "Không thể xác thực người dùng."); return "redirect:/login"; }
	 * 
	 * try { // 3. Kiểm tra tồn kho for (GioHang item : cartItems) { PhuKienOto
	 * phuKien = phuKienOtoService.findById(item.getPhuKienOto().getAccessoryID());
	 * if (phuKien == null || phuKien.getSoLuong() < item.getSoLuong()) {
	 * redirectAttributes.addFlashAttribute("error",
	 * String.format("Sản phẩm %s không đủ hàng",
	 * item.getPhuKienOto().getTenPhuKien())); return "redirect:/cart"; } }
	 * 
	 * // 4. Tính phí và tạo đơn hàng BigDecimal shippingFee =
	 * "fast".equals(shippingMethod) ? new BigDecimal("30000") : BigDecimal.ZERO;
	 * DonHang donHang = new DonHang(); donHang.setUser(user);
	 * donHang.setHoTen(fullName); donHang.setSoDienThoai(phone);
	 * donHang.setDiaChi(address); donHang.setGhiChu(note);
	 * donHang.setPhuongThucVanChuyen(shippingMethod);
	 * donHang.setPhuongThucThanhToan(paymentMethod); donHang.setNgayDatHang(new
	 * Date()); donHang.setTrangThai(DonHang.TrangThai.CHO_XAC_NHAN.name());
	 * donHang.setPhiVanChuyen(shippingFee); donHang.setDaThanhToan(false);
	 * 
	 * List<ChiTietDonHang> chiTietDonHangs = convertToChiTietDonHangs(cartItems,
	 * donHang); donHang.setChiTietDonHangs(chiTietDonHangs);
	 * donHang.tinhTongTien();
	 * 
	 * DonHang savedOrder = donHangService.taoDonHang(donHang, cartItems);
	 * 
	 * for (ChiTietDonHang item : chiTietDonHangs) {
	 * phuKienOtoService.updateStock(item.getPhuKienOto().getAccessoryID(),
	 * item.getSoLuong()); }
	 * 
	 * session.removeAttribute("cartItems");
	 * redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công!");
	 * redirectAttributes.addFlashAttribute("orderId", savedOrder.getOrderID());
	 * return "redirect:/order/success";
	 * 
	 * } catch (Exception e) { redirectAttributes.addFlashAttribute("error",
	 * "Có lỗi xảy ra khi xử lý đơn hàng."); return "redirect:/checkout"; } }
	 * 
	 * private double calculateSubtotal(List<GioHang> cartItems) { return
	 * cartItems.stream() .mapToDouble(item -> item.getPhuKienOto().getGia() *
	 * item.getSoLuong()) .sum(); }
	 * 
	 * private List<ChiTietDonHang> convertToChiTietDonHangs(List<GioHang>
	 * cartItems, DonHang donHang) {
	 * 
	 * return cartItems.stream().map(cartItem -> { ChiTietDonHang chiTiet = new
	 * ChiTietDonHang(); BigDecimal donGia =
	 * BigDecimal.valueOf(cartItem.getPhuKienOto().getGia());
	 * chiTiet.setDonHang(donHang); chiTiet.setPhuKienOto(cartItem.getPhuKienOto());
	 * chiTiet.setSoLuong(cartItem.getSoLuong()); chiTiet.setDonGia(donGia); return
	 * chiTiet; }).collect(Collectors.toList()); }
	 */
	 
}
