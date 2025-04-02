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

import jakarta.servlet.http.HttpServletRequest;
import poly.edu.Model.GioHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Service.CartService;
import poly.edu.Service.PhuKienOtoService;

@Controller
@RequestMapping("cart")
public class CartController {
	@Autowired
	PhuKienOtoService phuKienOtoService;

	@Autowired
	CartService cartService;

	/*
	 * @Autowired DonHangService donHangService;
	 */

	// Hiển thị giỏ hàng
	@GetMapping("views")
	public String viewsCart(Model model) {
		model.addAttribute("CART_ITEMS", cartService.getAllItems());
		model.addAttribute("TOTAL", cartService.getAmounts());
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

	
	/*
	 * @GetMapping("/checkout") public String showCheckout(Model model) { // Kiểm
	 * tra giỏ hàng có sản phẩm không if (cartService.getAllItems().isEmpty()) {
	 * return "redirect:/cart/views"; }
	 * 
	 * model.addAttribute("CART_ITEMS", cartService.getAllItems());
	 * model.addAttribute("TOTAL", cartService.getAmounts());
	 * model.addAttribute("donHang", new DonHang()); // Thêm đối tượng DonHang để
	 * bind form
	 * 
	 * return "checkout"; // Trả về view checkout.html }
	 * 
	 * // Xử lý thanh toán
	 * 
	 * @PostMapping("/checkout") public String processCheckout(
	 * 
	 * @RequestParam("tenKhachHang") String tenKhachHang,
	 * 
	 * @RequestParam("soDienThoai") String soDienThoai,
	 * 
	 * @RequestParam("diaChi") String diaChi,
	 * 
	 * @RequestParam("ghiChu") String ghiChu,
	 * 
	 * @RequestParam("phuongThucThanhToan") String phuongThucThanhToan,
	 * RedirectAttributes redirectAttributes) {
	 * 
	 * // Kiểm tra thông tin bắt buộc if (tenKhachHang.isEmpty() ||
	 * soDienThoai.isEmpty() || diaChi.isEmpty()) {
	 * redirectAttributes.addFlashAttribute("errorMessage",
	 * "Vui lòng điền đầy đủ thông tin bắt buộc"); return "redirect:/cart/checkout";
	 * }
	 * 
	 * try { // Tạo đơn hàng từ thông tin giỏ hàng DonHang donHang = new DonHang();
	 * donHang.setTenKhachHang(tenKhachHang); donHang.setSoDienThoai(soDienThoai);
	 * donHang.setDiaChi(diaChi); donHang.setGhiChu(ghiChu);
	 * donHang.setPhuongThucThanhToan(phuongThucThanhToan);
	 * donHang.setTongTien(cartService.getAmounts());
	 * 
	 * // Lưu đơn hàng và chi tiết đơn hàng donHangService.taoDonHang(donHang,
	 * cartService.getAllItems());
	 * 
	 * // Xóa giỏ hàng sau khi đặt hàng thành công cartService.clear();
	 * 
	 * redirectAttributes.addFlashAttribute("successMessage",
	 * "Đặt hàng thành công! Cảm ơn bạn đã mua sắm"); return
	 * "redirect:/cart/order-success"; // Chuyển đến trang thông báo thành công }
	 * catch (Exception e) { redirectAttributes.addFlashAttribute("errorMessage",
	 * "Có lỗi xảy ra khi đặt hàng: " + e.getMessage()); return
	 * "redirect:/cart/checkout"; } }
	 * 
	 * // Trang thông báo đặt hàng thành công
	 * 
	 * @GetMapping("/order-success") public String orderSuccess() { return
	 * "order-success"; }
	 */
	 
}
