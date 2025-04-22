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
}
