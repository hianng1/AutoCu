package poly.edu.Controller;

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
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Repository.PhuKienOtoRepository;
import poly.edu.Service.DanhGiaService;
import poly.edu.Service.UserService;

@Controller
@RequestMapping("/danh-gia") // Change base path to avoid conflicts
public class DanhGiaController {

    @Autowired
    private DanhGiaService danhGiaService;

    @Autowired
    private UserService userService;

    @Autowired
    private PhuKienOtoRepository phuKienOtoRepository;

    // Show all reviews for a product
    @GetMapping("/product/{productId}")
    public String showProductReviews(@PathVariable Long productId, Model model) {
        PhuKienOto product = phuKienOtoRepository.findById(productId).orElse(null);

        if (product == null) {
            return "redirect:/";
        }

        List<DanhGia> reviews = danhGiaService.getReviewsForProduct(product);
        double averageRating = danhGiaService.getAverageRatingForProduct(product);
        int reviewCount = danhGiaService.getReviewCountForProduct(product);

        model.addAttribute("product", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("averageRating", averageRating);
        model.addAttribute("reviewCount", reviewCount);

        // Check if current user can review this product
        User currentUser = getCurrentUser();
        if (currentUser != null) {
            boolean canReview = danhGiaService.canUserReviewProduct(currentUser, productId);
            model.addAttribute("canReview", canReview);
        }

        return "product/reviews";
    }

    // Show review form for a product
    @GetMapping("/write/{productId}")
    public String showReviewForm(@PathVariable Long productId,
            @RequestParam Long orderId,
            Model model) {
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            return "redirect:/login";
        }

        PhuKienOto product = phuKienOtoRepository.findById(productId).orElse(null);

        if (product == null) {
            return "redirect:/";
        }

        model.addAttribute("product", product);
        model.addAttribute("orderId", orderId);
        return "product/write-review";
    }

    // Submit a review
    @PostMapping("/submit")
    public String submitReview(@RequestParam Long productId,
            @RequestParam Long orderId,
            @RequestParam Integer rating,
            @RequestParam String content,
            RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            return "redirect:/login";
        }

        String result = danhGiaService.createOrUpdateReview(currentUser, productId, orderId, rating, content);

        if (result.contains("thành công")) {
            redirectAttributes.addFlashAttribute("successMessage", result);
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", result);
        }

        return "redirect:/danh-gia/product/" + productId;
    }

    // Show all products eligible for review by current user
    @GetMapping("/my-reviews")
    public String showEligibleProducts(Model model) {
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            return "redirect:/login";
        }

        List<PhuKienOto> eligibleProducts = danhGiaService.getProductsEligibleForReview(currentUser);
        model.addAttribute("eligibleProducts", eligibleProducts);

        return "user/eligible-reviews";
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
