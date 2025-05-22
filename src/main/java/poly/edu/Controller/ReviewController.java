package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.edu.Model.DanhGia;
import poly.edu.Model.DonHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Repository.DanhGiaRepository;
import poly.edu.Repository.DonHangRepository;
import poly.edu.Repository.PhuKienOtoRepository;
import poly.edu.Service.DanhGiaService;
import poly.edu.Service.UserService;

import java.util.*;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private DanhGiaService danhGiaService;

    @Autowired
    private DanhGiaRepository danhGiaRepository;

    @Autowired
    private PhuKienOtoRepository phuKienOtoRepository;

    @Autowired
    private DonHangRepository donHangRepository;

    @Autowired
    private UserService userService;

    // Get the current logged in user
    private User getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return null;
        }
        String username = auth.getName();
        return userService.findByUsername(username);
    }

    @GetMapping("/user-reviews")
    public String getMyReviews(Model model) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Using the implemented repository method
        List<DanhGia> myReviews = danhGiaRepository.findByUserOrderByNgayDanhGiaDesc(currentUser);
        model.addAttribute("reviews", myReviews);

        return "product/my-reviews";
    }

    @GetMapping("/write")
    public String showReviewForm(
            @RequestParam("productId") Long productId,
            @RequestParam("orderId") Long orderId,
            Model model) {

        User currentUser = getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Verify the product and order
        Optional<PhuKienOto> productOpt = phuKienOtoRepository.findById(productId);
        Optional<DonHang> orderOpt = donHangRepository.findById(orderId);

        if (!productOpt.isPresent() || !orderOpt.isPresent()) {
            return "redirect:/user/review-eligible";
        }

        PhuKienOto product = productOpt.get();
        DonHang order = orderOpt.get();

        // Verify that the order belongs to the current user
        if (!order.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/user/review-eligible";
        }

        // Verify that the product is in the order
        boolean productInOrder = false;
        for (var item : order.getChiTietDonHangs()) {
            if (item.getPhuKienOto() != null && item.getPhuKienOto().getAccessoryID().equals(productId)) {
                productInOrder = true;
                break;
            }
        }

        if (!productInOrder) {
            return "redirect:/user/review-eligible";
        }

        // Check if there's an existing review to edit
        DanhGia existingReview = danhGiaRepository.findByOrderAndProductAndUser(
                orderId, productId, currentUser.getId());

        model.addAttribute("product", product);
        model.addAttribute("orderId", orderId);
        model.addAttribute("review", existingReview != null ? existingReview : new DanhGia());
        model.addAttribute("isEdit", existingReview != null);

        return "product/write-review";
    }

    @PostMapping("/submit")
    public String submitReview(
            @RequestParam("productId") Long productId,
            @RequestParam("orderId") Long orderId,
            @RequestParam("rating") Integer rating,
            @RequestParam("content") String content,
            RedirectAttributes redirectAttributes) {

        User currentUser = getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Call the service to create or update the review
        String result = danhGiaService.createOrUpdateReview(
                currentUser, productId, orderId, rating, content);

        if (result.startsWith("Đánh giá") || result.startsWith("Cập nhật")) {
            // Success message
            redirectAttributes.addFlashAttribute("message", result);
            return "redirect:/reviews/user-reviews";
        } else {
            // Error message
            redirectAttributes.addFlashAttribute("error", result);
            return "redirect:/user/review-eligible";
        }
    }

    @GetMapping("/edit/{id}")
    public String editReview(@PathVariable("id") Long reviewId, Model model) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        Optional<DanhGia> reviewOpt = danhGiaRepository.findById(reviewId);
        if (!reviewOpt.isPresent()) {
            return "redirect:/reviews/user-reviews";
        }

        DanhGia review = reviewOpt.get();

        // Check if the review belongs to the current user
        if (!review.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/reviews/user-reviews";
        }

        model.addAttribute("product", review.getPhuKienOto());
        model.addAttribute("orderId", review.getDonHang().getOrderID());
        model.addAttribute("review", review);
        model.addAttribute("isEdit", true);

        return "product/write-review";
    }

    @GetMapping("/product/{id}")
    public String getProductReviews(@PathVariable("id") Long productId, Model model) {
        Optional<PhuKienOto> productOpt = phuKienOtoRepository.findById(productId);
        if (!productOpt.isPresent()) {
            return "redirect:/";
        }

        PhuKienOto product = productOpt.get();
        List<DanhGia> reviews = danhGiaRepository.findByPhuKienOtoAndHienThiTrue(product);

        // Calculate average rating and counts per star
        double avgRating = danhGiaService.getAverageRatingForProduct(product);
        int reviewCount = danhGiaService.getReviewCountForProduct(product);

        Map<Integer, Long> ratingCounts = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            final int starRating = i;
            long count = reviews.stream()
                    .filter(r -> r.getSaoDanhGia() == starRating)
                    .count();
            ratingCounts.put(i, count);
        }

        model.addAttribute("product", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("avgRating", avgRating);
        model.addAttribute("reviewCount", reviewCount);
        model.addAttribute("ratingCounts", ratingCounts);

        // Check if the current user can review this product
        User currentUser = getCurrentUser();
        boolean canReview = false;
        if (currentUser != null) {
            canReview = danhGiaService.canUserReviewProduct(currentUser, productId);
        }
        model.addAttribute("canReview", canReview);

        return "product/reviews";
    }
}
