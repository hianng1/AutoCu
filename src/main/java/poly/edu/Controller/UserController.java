package poly.edu.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DanhGia;
import poly.edu.Model.DonHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Repository.DanhGiaRepository;
import poly.edu.Repository.DonHangRepository;
import poly.edu.Service.DanhGiaService;
import poly.edu.Service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private DonHangRepository donHangRepository;

	@Autowired
	private DanhGiaService danhGiaService;

	@Autowired
	private DanhGiaRepository danhGiaRepository;

	private User getCurrentUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || !authentication.isAuthenticated() ||
				"anonymousUser".equals(authentication.getPrincipal())) {
			return null;
		}
		String username = authentication.getName();
		return userService.findByUsername(username);
	}

	@GetMapping("/orders")
	public String viewOrders(Model model, RedirectAttributes redirectAttributes) {
		User currentUser = getCurrentUser();
		if (currentUser == null) {
			redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem đơn hàng");
			return "redirect:/login";
		}

		List<DonHang> allOrders = donHangRepository.findByUser(currentUser);
		model.addAttribute("orders", allOrders);
		return "user/orders";
	}

	@GetMapping("/orders/delivered")
	public String viewDeliveredOrders(Model model, RedirectAttributes redirectAttributes) {
		User currentUser = getCurrentUser();
		if (currentUser == null) {
			redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem đơn hàng");
			return "redirect:/login";
		}

		List<DonHang> deliveredOrders = donHangRepository.findByUserAndTrangThai(currentUser,
				DonHang.TrangThai.DA_GIAO);

		// Create map to track which products have been reviewed
		Map<Long, Boolean> reviewedProductMap = new HashMap<>();

		// For each delivered order, check which products have been reviewed
		for (DonHang order : deliveredOrders) {
			for (ChiTietDonHang detail : order.getChiTietDonHangs()) {
				if (detail.getPhuKienOto() != null) {
					Long productId = detail.getPhuKienOto().getAccessoryID();
					List<DanhGia> reviews = danhGiaRepository.findByUserAndPhuKienOto(currentUser,
							detail.getPhuKienOto());

					// Consider product reviewed if user has at least one review for it
					reviewedProductMap.put(productId, !reviews.isEmpty());
				}
			}
		}

		model.addAttribute("orders", deliveredOrders);
		model.addAttribute("reviewedProductMap", reviewedProductMap);
		return "user/delivered-orders";
	}

	@GetMapping("/review-eligible")
	public String showEligibleProducts(Model model, RedirectAttributes redirectAttributes) {
		User currentUser = getCurrentUser();

		if (currentUser == null) {
			redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để viết đánh giá");
			return "redirect:/login";
		}

		// Get all delivered orders for this user
		List<DonHang> deliveredOrders = donHangRepository.findByUserAndTrangThai(currentUser,
				DonHang.TrangThai.DA_GIAO);

		// Get all products from these orders
		List<PhuKienOto> orderProducts = new ArrayList<>();
		Map<Long, Long> productToOrderMap = new HashMap<>(); // Maps product IDs to order IDs

		for (DonHang order : deliveredOrders) {
			for (ChiTietDonHang detail : order.getChiTietDonHangs()) {
				if (detail.getPhuKienOto() != null) {
					PhuKienOto product = detail.getPhuKienOto();

					// Check if user has already reviewed this product
					List<DanhGia> reviews = danhGiaRepository.findByUserAndPhuKienOto(currentUser, product);

					if (reviews.isEmpty()) {
						// Only add products that haven't been reviewed yet
						orderProducts.add(product);
						productToOrderMap.put(product.getAccessoryID(), order.getOrderID());
					}
				}
			}
		}

		model.addAttribute("eligibleProducts", orderProducts);
		model.addAttribute("productToOrderMap", productToOrderMap);

		return "user/eligible-reviews";
	}

	@GetMapping("/write-review/{productId}/{orderId}")
	public String showWriteReviewForm(@PathVariable Long productId,
			@PathVariable Long orderId,
			Model model,
			RedirectAttributes redirectAttributes) {
		User currentUser = getCurrentUser();

		if (currentUser == null) {
			redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để viết đánh giá");
			return "redirect:/login";
		}

		// Check if user has permission to review this product from this order
		boolean canReview = danhGiaService.canUserReviewProduct(currentUser, productId);

		if (!canReview) {
			redirectAttributes.addFlashAttribute("error",
					"Bạn không thể đánh giá sản phẩm này hoặc đơn hàng chưa được giao");
			return "redirect:/user/orders";
		}

		// Forward to the review form using the new URL
		return "redirect:/reviews/create/" + productId + "?orderId=" + orderId;
	}
}