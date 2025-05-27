package poly.edu.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;
import poly.edu.Model.User;
import poly.edu.Model.Wishlist;
import poly.edu.Repository.PhuKienOtoRepository;
import poly.edu.Repository.SanPhamRepository;
import poly.edu.Service.UserService;
import poly.edu.Service.WishlistService;

@RestController
@RequestMapping("/api/wishlist")
public class WishlistApiController {

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

    @GetMapping("/count")
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

    @GetMapping("/items")
    public ResponseEntity<Map<String, Object>> getWishlistItems() {
        Map<String, Object> response = new HashMap<>();

        User currentUser = getCurrentUser();
        if (currentUser == null) {
            response.put("success", false);
            response.put("items", new ArrayList<>());
        } else {
            List<Wishlist> wishlistItems = wishlistService.getUserWishlist(currentUser);
            List<Map<String, Object>> items = new ArrayList<>();

            for (Wishlist item : wishlistItems) {
                Map<String, Object> itemData = new HashMap<>();
                if (item.getPhuKienOto() != null) {
                    itemData.put("accessoryId", item.getPhuKienOto().getAccessoryID());
                    itemData.put("type", "ACCESSORY");
                }
                if (item.getSanPham() != null) {
                    itemData.put("carId", item.getSanPham().getProductID());
                    itemData.put("type", "CAR");
                }
                items.add(itemData);
            }

            response.put("success", true);
            response.put("items", items);
        }

        return ResponseEntity.ok(response);
    }

    @PostMapping("/toggle")
    public ResponseEntity<Map<String, Object>> toggleWishlistItem(@RequestBody Map<String, Object> requestData) {
        Map<String, Object> response = new HashMap<>();

        // Debug logging
        System.out.println("Wishlist toggle request received: " + requestData);

        User currentUser = getCurrentUser();
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập để thêm vào danh sách yêu thích");
            System.out.println("User not logged in");
            return ResponseEntity.ok(response);
        }

        System.out.println("Current user: " + currentUser.getUsername());

        try {
            String productType = (String) requestData.get("productType");

            boolean isInWishlist = false;
            boolean operationSuccess = false;
            String message = "";
            if ("CAR".equals(productType)) {
                Integer carId = (Integer) requestData.get("carId");
                System.out.println("Processing CAR with ID: " + carId);
                if (carId != null) {
                    SanPham sanPham = sanPhamRepository.findById(Long.valueOf(carId)).orElse(null);
                    if (sanPham != null) {
                        System.out.println("Found car: " + sanPham.getTenSanPham());
                        isInWishlist = wishlistService.isCarInWishlist(currentUser, sanPham);
                        System.out.println("Is car in wishlist: " + isInWishlist);
                        if (isInWishlist) {
                            operationSuccess = wishlistService.removeCarFromWishlist(currentUser, sanPham);
                            message = operationSuccess ? "Đã xóa xe khỏi danh sách yêu thích!" : "Có lỗi xảy ra";
                        } else {
                            operationSuccess = wishlistService.addCarToWishlist(currentUser, sanPham);
                            message = operationSuccess ? "Đã thêm xe vào danh sách yêu thích!" : "Có lỗi xảy ra";
                        }
                        System.out.println("Operation success: " + operationSuccess);
                    } else {
                        System.out.println("Car not found with ID: " + carId);
                    }
                }
            } else if ("ACCESSORY".equals(productType)) {
                Long accessoryId = Long.valueOf(requestData.get("accessoryId").toString());
                System.out.println("Processing ACCESSORY with ID: " + accessoryId);
                if (accessoryId != null) {
                    PhuKienOto phuKien = phuKienOtoRepository.findById(Long.valueOf(accessoryId)).orElse(null);
                    if (phuKien != null) {
                        System.out.println("Found accessory: " + phuKien.getTenPhuKien());
                        isInWishlist = wishlistService.isAccessoryInWishlist(currentUser, phuKien);
                        System.out.println("Is accessory in wishlist: " + isInWishlist);
                        if (isInWishlist) {
                            operationSuccess = wishlistService.removeAccessoryFromWishlist(currentUser, phuKien);
                            message = operationSuccess ? "Đã xóa phụ kiện khỏi danh sách yêu thích!" : "Có lỗi xảy ra";
                        } else {
                            operationSuccess = wishlistService.addAccessoryToWishlist(currentUser, phuKien);
                            message = operationSuccess ? "Đã thêm phụ kiện vào danh sách yêu thích!" : "Có lỗi xảy ra";
                        }
                        System.out.println("Operation success: " + operationSuccess);
                    } else {
                        System.out.println("Accessory not found with ID: " + accessoryId);
                    }
                }
            }

            response.put("success", operationSuccess);
            response.put("message", message);
            response.put("added", !isInWishlist); // Return true if item was added, false if removed
            response.put("count", wishlistService.getWishlistCount(currentUser));

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra. Vui lòng thử lại!");
        }

        return ResponseEntity.ok(response);
    }
}
