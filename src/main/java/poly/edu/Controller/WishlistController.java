package poly.edu.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;
import poly.edu.Model.User;
import poly.edu.Model.Wishlist;
import poly.edu.Repository.PhuKienOtoRepository;
import poly.edu.Repository.SanPhamRepository;
import poly.edu.Service.UserService;
import poly.edu.Service.WishlistService;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    private WishlistService wishlistService;

    @Autowired
    private UserService userService;

    @Autowired
    private PhuKienOtoRepository phuKienOtoRepository;

    @Autowired
    private SanPhamRepository sanPhamRepository;

    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() ||
                "anonymousUser".equals(authentication.getPrincipal())) {
            return null;
        }
        String username = authentication.getName();
        return userService.findByUsername(username);
    }

    // Show wishlist page
    @GetMapping
    public String showWishlist(@RequestParam(defaultValue = "all") String type, Model model,
            RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem danh sách yêu thích");
            return "redirect:/login";
        }

        List<Wishlist> wishlistItems;
        if ("PHUKIEN".equals(type)) {
            wishlistItems = wishlistService.getUserWishlistByType(currentUser, "PHUKIEN");
        } else if ("XE".equals(type)) {
            wishlistItems = wishlistService.getUserWishlistByType(currentUser, "XE");
        } else {
            wishlistItems = wishlistService.getUserWishlist(currentUser);
        }

        // Get counts for tabs
        long totalCount = wishlistService.getWishlistCount(currentUser);
        long accessoryCount = wishlistService.getWishlistCountByType(currentUser, "PHUKIEN");
        long carCount = wishlistService.getWishlistCountByType(currentUser, "XE");

        model.addAttribute("wishlistItems", wishlistItems);
        model.addAttribute("activeType", type);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("accessoryCount", accessoryCount);
        model.addAttribute("carCount", carCount);

        return "wishlist";
    }

    // Add accessory to wishlist (AJAX)
    @PostMapping("/add/accessory/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addAccessoryToWishlist(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập để thêm vào danh sách yêu thích");
            return ResponseEntity.ok(response);
        }

        PhuKienOto phuKienOto = phuKienOtoRepository.findById(id).orElse(null);
        if (phuKienOto == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy sản phẩm");
            return ResponseEntity.ok(response);
        }

        boolean added = wishlistService.toggleAccessoryInWishlist(currentUser, phuKienOto);
        response.put("success", true);
        response.put("added", added);
        response.put("message", added ? "Đã thêm vào danh sách yêu thích" : "Đã xóa khỏi danh sách yêu thích");
        response.put("wishlistCount", wishlistService.getWishlistCount(currentUser));

        return ResponseEntity.ok(response);
    }

    // Add car to wishlist (AJAX)
    @PostMapping("/add/car/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addCarToWishlist(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập để thêm vào danh sách yêu thích");
            return ResponseEntity.ok(response);
        }

        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham == null) {
            response.put("success", false);
            response.put("message", "Không tìm thấy sản phẩm");
            return ResponseEntity.ok(response);
        }

        boolean added = wishlistService.toggleCarInWishlist(currentUser, sanPham);
        response.put("success", true);
        response.put("added", added);
        response.put("message", added ? "Đã thêm vào danh sách yêu thích" : "Đã xóa khỏi danh sách yêu thích");
        response.put("wishlistCount", wishlistService.getWishlistCount(currentUser));

        return ResponseEntity.ok(response);
    }

    // Remove item from wishlist
    @PostMapping("/remove/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeFromWishlist(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập");
            return ResponseEntity.ok(response);
        }

        // Find wishlist item by ID and remove it
        try {
            List<Wishlist> userWishlist = wishlistService.getUserWishlist(currentUser);
            Wishlist itemToRemove = userWishlist.stream()
                    .filter(item -> item.getWishlistID().equals(id))
                    .findFirst()
                    .orElse(null);

            if (itemToRemove != null) {
                if (itemToRemove.getPhuKienOto() != null) {
                    wishlistService.removeAccessoryFromWishlist(currentUser, itemToRemove.getPhuKienOto());
                } else if (itemToRemove.getSanPham() != null) {
                    wishlistService.removeCarFromWishlist(currentUser, itemToRemove.getSanPham());
                }
                response.put("success", true);
                response.put("message", "Đã xóa khỏi danh sách yêu thích");
                response.put("wishlistCount", wishlistService.getWishlistCount(currentUser));
            } else {
                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm trong danh sách yêu thích");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra khi xóa sản phẩm");
        }

        return ResponseEntity.ok(response);
    }

    // Clear all wishlist items
    @PostMapping("/clear")
    public String clearWishlist(RedirectAttributes redirectAttributes) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập");
            return "redirect:/login";
        }

        try {
            wishlistService.clearUserWishlist(currentUser);
            redirectAttributes.addFlashAttribute("success", "Đã xóa tất cả sản phẩm khỏi danh sách yêu thích");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi xóa danh sách yêu thích");
        }

        return "redirect:/wishlist";
    }

    // Get wishlist count (AJAX)
    @GetMapping("/count")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getWishlistCount() {
        Map<String, Object> response = new HashMap<>();
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            response.put("count", 0);
        } else {
            response.put("count", wishlistService.getWishlistCount(currentUser));
        }

        return ResponseEntity.ok(response);
    }

    // Check if item is in wishlist (AJAX)
    @GetMapping("/check/accessory/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkAccessoryInWishlist(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            response.put("inWishlist", false);
        } else {
            PhuKienOto phuKienOto = phuKienOtoRepository.findById(id).orElse(null);
            if (phuKienOto != null) {
                response.put("inWishlist", wishlistService.isAccessoryInWishlist(currentUser, phuKienOto));
            } else {
                response.put("inWishlist", false);
            }
        }

        return ResponseEntity.ok(response);
    }

    // Check if car is in wishlist (AJAX)
    @GetMapping("/check/car/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkCarInWishlist(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = getCurrentUser();

        if (currentUser == null) {
            response.put("inWishlist", false);
        } else {
            SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
            if (sanPham != null) {
                response.put("inWishlist", wishlistService.isCarInWishlist(currentUser, sanPham));
            } else {
                response.put("inWishlist", false);
            }
        }

        return ResponseEntity.ok(response);
    } // API endpoints for AJAX calls

    @PostMapping("/api/wishlist/toggle")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleWishlistItem(@RequestBody Map<String, Object> requestBody) {
        Map<String, Object> response = new HashMap<>();

        User currentUser = getCurrentUser();
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "User not authenticated");
            return ResponseEntity.ok(response);
        }

        String productType = (String) requestBody.get("productType");
        boolean added = false;

        try {
            if ("ACCESSORY".equals(productType)) {
                Long accessoryId = Long.valueOf(requestBody.get("accessoryId").toString());
                PhuKienOto phuKienOto = phuKienOtoRepository.findById(accessoryId).orElse(null);
                if (phuKienOto != null) {
                    added = wishlistService.toggleAccessoryInWishlist(currentUser, phuKienOto);
                }
            } else if ("CAR".equals(productType)) {
                Long carId = Long.valueOf(requestBody.get("carId").toString());
                SanPham sanPham = sanPhamRepository.findById(carId).orElse(null);
                if (sanPham != null) {
                    added = wishlistService.toggleCarInWishlist(currentUser, sanPham);
                }
            }

            response.put("success", true);
            response.put("added", added);
            response.put("count", wishlistService.getWishlistCount(currentUser));
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error occurred while updating wishlist");
        }
        return ResponseEntity.ok(response);
    }
}
