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

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

import poly.edu.Model.DonHang;
import poly.edu.Model.KhachHang;
import poly.edu.Repository.KhachHangRepository;
import poly.edu.Service.CartService;
import poly.edu.Service.DonHangService;

import jakarta.servlet.http.HttpServletRequest;
import poly.edu.Model.DonHang;
import poly.edu.Model.GioHang;
import poly.edu.Model.KhachHang;
import poly.edu.Model.PhuKienOto;
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

	
	
	@GetMapping("/checkout")
    public String showCheckout(Model model) {
        if (cartService.getAllItems().isEmpty()) {
            return "redirect:/cart/views";
        }

        model.addAttribute("CART_ITEMS", cartService.getAllItems());
        model.addAttribute("TOTAL", cartService.getAmounts());
        model.addAttribute("donHang", new DonHang()); // Đối tượng DonHang để binding form
        
        return "checkout"; // Trả về view checkout.html
    }

	@PostMapping("/checkout")
	public String processCheckout(
	        @RequestParam(value = "tenKhachHang", required = false) String tenKhachHang,
	        @RequestParam(value = "soDienThoai", required = false) String soDienThoai,
	        @RequestParam(value = "diaChi", required = false) String diaChi,
	        RedirectAttributes redirectAttributes) {

	    try {
	        KhachHang khachHang = null;

	        // Nếu khách đã đăng nhập, lấy từ database
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
	            String email = auth.getName();
	            Optional<KhachHang> optionalKhachHang = khachHangRepository.findByEmail(email);
	            if (optionalKhachHang.isPresent()) {
	                khachHang = optionalKhachHang.get();
	            }
	        }

	        // Nếu khách không đăng nhập, kiểm tra thông tin nhập vào
	        if (khachHang == null) {
	            if (tenKhachHang == null || tenKhachHang.isEmpty() || 
	                soDienThoai == null || soDienThoai.isEmpty() || 
	                diaChi == null || diaChi.isEmpty()) {
	                redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin.");
	                return "redirect:/checkout";
	            }
	            // Tạo đối tượng khách hàng tạm thời
	            khachHang = new KhachHang();
	            khachHang.setTenKhachHang(tenKhachHang);
	            khachHang.setSoDienThoai(soDienThoai);
	            khachHang.setDiaChi(diaChi);
	        }

	        // Tạo đơn hàng
	        DonHang donHang = new DonHang();
	        donHang.setKhachHang(khachHang);
	        donHang.setTongGiaTri(cartService.getAmounts());

	        // Lưu đơn hàng
	        donHangService.taoDonHang(donHang, cartService.getAllItems());

	        // Xóa giỏ hàng sau khi đặt hàng thành công
	        cartService.clear();

	        redirectAttributes.addFlashAttribute("successMessage", "Đặt hàng thành công!");
	        return "redirect:/order-success";
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi đặt hàng: " + e.getMessage());
	        return "redirect:/checkout";
	    }
	}


    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }
	 
	 
}
