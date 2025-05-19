package poly.edu.Controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.edu.Model.DanhGia;
import poly.edu.Model.DonHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Repository.DanhGiaRepository;
import poly.edu.Repository.DonHangRepository;
import poly.edu.Service.PhuKienOtoService;
import poly.edu.Service.UserService;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private PhuKienOtoService phuKienOtoService;

    @Autowired
    private DanhGiaRepository danhGiaRepository;

    @Autowired
    private DonHangRepository donHangRepository;

    @Autowired
    private UserService userService;

    // Change the URL path to avoid conflict
    @GetMapping("/user-reviews")
    public String getMyReviews(Model model, RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem đánh giá của bạn");
            return "redirect:/login";
        }

        List<DanhGia> userReviews = danhGiaRepository.findByUser(currentUser);
        model.addAttribute("userReviews", userReviews);
        return "product/my-reviews";
    }

    // Change URL path to avoid conflict with DanhGiaController
    @GetMapping("/create/{productId}")
    public String showWriteReviewForm(@PathVariable Long productId,
            @RequestParam(required = false) Long orderId,
            Model model,
            RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đánh giá sản phẩm");
            return "redirect:/login";
        }

        // Find the product
        PhuKienOto product = phuKienOtoService.findById(productId).orElse(null);
        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại");
            return "redirect:/user/review-eligible";
        }

        // Check if user has purchased this product and order is delivered
        boolean canReview = false;
        if (orderId != null) {
            DonHang order = donHangRepository.findById(orderId).orElse(null);
            if (order != null && order.getUser().equals(currentUser) &&
                    order.getTrangThai() == DonHang.TrangThai.DA_GIAO) {
                canReview = true;
            }
        } else {
            // Check if user has any delivered order with this product
            List<DonHang> deliveredOrders = donHangRepository.findByUserAndTrangThai(
                    currentUser, DonHang.TrangThai.DA_GIAO);
            for (DonHang order : deliveredOrders) {
                if (order.getChiTietDonHangs().stream().anyMatch(item -> item.getPhuKienOto() != null
                        && item.getPhuKienOto().getAccessoryID().equals(productId))) {
                    canReview = true;
                    orderId = order.getOrderID();
                    break;
                }
            }
        }

        if (!canReview) {
            redirectAttributes.addFlashAttribute("error",
                    "Bạn chỉ có thể đánh giá sản phẩm đã mua và được giao thành công");
            return "redirect:/user/review-eligible";
        }

        // Check if the user has already reviewed this product
        List<DanhGia> existingReviews = danhGiaRepository.findByUserAndPhuKienOto(currentUser, product);
        if (!existingReviews.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Bạn đã đánh giá sản phẩm này rồi");
            return "redirect:/reviews/user-reviews"; // Updated redirect path
        }

        model.addAttribute("product", product);
        model.addAttribute("orderId", orderId);

        return "product/write-review";
    }

    // Submit a product review
    @PostMapping("/submit")
    public String submitReview(@RequestParam Long productId,
            @RequestParam Long orderId,
            @RequestParam int rating,
            @RequestParam String content,
            RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đánh giá sản phẩm");
            return "redirect:/login";
        }

        // Find the product
        PhuKienOto product = phuKienOtoService.findById(productId).orElse(null);
        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại");
            return "redirect:/user/review-eligible";
        }

        // Find the order
        DonHang order = donHangRepository.findById(orderId).orElse(null);
        if (order == null || !order.getUser().equals(currentUser) ||
                order.getTrangThai() != DonHang.TrangThai.DA_GIAO) {
            redirectAttributes.addFlashAttribute("error", "Không thể tìm thấy đơn hàng hợp lệ");
            return "redirect:/user/review-eligible";
        }

        // Check for duplicate review
        DanhGia existingReview = danhGiaRepository.findByOrderAndProductAndUser(
                orderId, productId, currentUser.getId());

        if (existingReview != null) {
            redirectAttributes.addFlashAttribute("error", "Bạn đã đánh giá sản phẩm này trong đơn hàng này rồi");
            return "redirect:/reviews/user-reviews"; // Updated redirect path
        }

        // Create and save the review
        DanhGia review = new DanhGia();
        review.setUser(currentUser);
        review.setPhuKienOto(product);
        review.setDonHang(order);
        review.setSaoDanhGia(rating);
        review.setNoiDung(content);
        review.setNgayDanhGia(new Date());
        review.setHienThi(true); // Show review by default

        danhGiaRepository.save(review);

        redirectAttributes.addFlashAttribute("success", "Cảm ơn bạn đã đánh giá sản phẩm!");
        return "redirect:/reviews/user-reviews"; // Updated redirect path
    }

    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() ||
                "anonymousUser".equals(authentication.getPrincipal())) {
            return null;
        }
        String username = authentication.getName();
        return userService.findByUsername(username);
    }
}
