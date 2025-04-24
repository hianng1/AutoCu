package poly.edu.Controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// Bỏ import org.slf4j.Logger; // Đã bỏ
// Bỏ import org.slf4j.LoggerFactory; // Đã bỏ

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession; // Giữ lại nếu còn cần cho helper method hoặc lý do khác
import jakarta.transaction.Transactional;
import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Model.DonHang.TrangThai;
import poly.edu.Model.GioHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Repository.KhachHangRepository;
import poly.edu.Service.CartService;
import poly.edu.Service.DonHangService;
import poly.edu.Service.PhuKienOtoService;
import poly.edu.Service.UserService;

@Controller
@RequestMapping("/cart")
public class CartController {
    // Bỏ private static final Logger logger = org.slf4j.LoggerFactory.getLogger(CartController.class); // Đã bỏ

    @Autowired
    private PhuKienOtoService phuKienOtoService;

    @Autowired
    private CartService cartService;

    @Autowired
    private DonHangService donHangService;

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private UserService userService;

    // --- Phương thức lấy User từ Session (Helper Method) ---
    // Giữ lại nếu bạn vẫn dùng ở đâu đó, nhưng không dùng trong controller này nữa sau sửa đổi
    private User getLoggedInUserFromSession(HttpSession session) {
        return (User) session.getAttribute("loggedInUser");
    }
    // --------------------------------------


    @GetMapping("/views")
    // Bỏ HttpSession session nếu không dùng getLoggedInUserFromSession
    // public String viewCart(Model model, HttpSession session) { // Phiên bản cũ
    public String viewCart(Model model) { // Phiên bản mới không dùng session param

        // *** SỬA: Chỉ dùng SecurityContextHolder để lấy thông tin người dùng đăng nhập ***
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User loggedInUser = null;
         if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal())) {
             String username = authentication.getName();
             loggedInUser = userService.findByUsername(username);
         }

        if (loggedInUser == null) {
            // Nếu user không tồn tại trong SecurityContext (chưa đăng nhập), chuyển hướng đến trang đăng nhập
            return "redirect:/login";
        }

        // Lấy giỏ hàng từ database DỰA VÀO USER LẤY TỪ SecurityContextHolder
        List<GioHang> cartItems = cartService.getGioHangByUser(loggedInUser);
        model.addAttribute("CART_ITEMS", cartItems);

        // Tính tổng tiền CHỈ CỦA GIỎ HÀNG CỦA USER NÀY
        BigDecimal total = BigDecimal.ZERO;
        if (cartItems != null) { // Kiểm tra null list trước khi dùng stream
            total = cartItems.stream()
                .map(item -> {
                    // Kiểm tra null cho item, gia, soLuong để tránh lỗi
                    BigDecimal price = item.getGia() != null ? item.getGia() : BigDecimal.ZERO;
                    int quantity = item.getSoLuong() >= 0 ? item.getSoLuong() : 0;
                    return price.multiply(BigDecimal.valueOf(quantity));
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        }

        model.addAttribute("TOTAL", total);

        // Thêm thông tin user vào model
        model.addAttribute("userInfo", loggedInUser);


        // Trả về tên view (cart.html hoặc cart.jsp)
        return "cart";
    }


    @PostMapping("/add/{id}")
    public String addToCart(@PathVariable("id") Long id,
                          @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                          HttpServletRequest request,
                          RedirectAttributes redirectAttributes) {
        try {
            // *** Sử dụng SecurityContextHolder để lấy thông tin người dùng đăng nhập ***
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            // Kiểm tra xem người dùng đã xác thực chưa và không phải là "anonymousUser"
            if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để thêm vào giỏ hàng.");
                return "redirect:/login";
            }

            String username = authentication.getName();
            User user = userService.findByUsername(username);

             if (user == null) {
                 // Trường hợp hiếm: Đã xác thực nhưng không tìm thấy User trong DB
                 // logger.error("Logged in user with username {} not found in database.", username); // Bỏ logger
                 redirectAttributes.addFlashAttribute("error", "Không tìm thấy thông tin người dùng.");
                 return "redirect:/login"; // Hoặc trang lỗi khác
             }
            // *** Kết thúc lấy User từ SecurityContextHolder ***


            // --- Các kiểm tra sản phẩm và tồn kho ---
            PhuKienOto product = phuKienOtoService.findById(id);
            if (product == null) {
                redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại.");
                return getPreviousPageUrl(request);
            }

            if (quantity <= 0) {
                redirectAttributes.addFlashAttribute("error", "Số lượng phải lớn hơn 0.");
                return getPreviousPageUrl(request);
            }

            if (product.getSoLuong() < quantity) {
                redirectAttributes.addFlashAttribute("error",
                    "Số lượng vượt quá tồn kho. Chỉ còn " + product.getSoLuong() + " sản phẩm.");
                return getPreviousPageUrl(request);
            }

            // --- Gọi service để thêm/cập nhật item ---
            GioHang cartItem = new GioHang();
            cartItem.setPhuKienOto(product);
            cartItem.setUser(user);
            cartItem.setSoLuong(quantity);
            cartItem.setGia(BigDecimal.valueOf(product.getGia()));

            cartService.add(cartItem);

            redirectAttributes.addFlashAttribute("success", "Đã thêm sản phẩm vào giỏ hàng!");

        } catch (IllegalStateException e) {
             // Catch specific exception from service if user is unexpectedly null there
             // logger.error("IllegalStateException from CartService: {}", e.getMessage()); // Bỏ logger
             redirectAttributes.addFlashAttribute("error", e.getMessage());
             return "redirect:/login"; // Redirect to login if service says user not logged in
        }
        catch (Exception e) {
            // logger.error("Lỗi khi thêm vào giỏ hàng", e); // Bỏ logger
            redirectAttributes.addFlashAttribute("error", "Lỗi khi thêm vào giỏ hàng: " + e.getMessage());
        }

        return "redirect:/cart/views"; // Chuyển hướng về trang giỏ hàng
    }

    @PostMapping("/update")
    public String updateCartItem(@RequestParam("id") Long id,
                                 @RequestParam("soLuong") int quantity,
                                 RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra người dùng đăng nhập
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
             if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
                 redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để cập nhật giỏ hàng.");
                 return "redirect:/login";
             }
            // Service update method should ideally check user ownership too

            GioHang updatedItem = cartService.update(id, quantity);
            if (updatedItem == null) {
                redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại trong giỏ hàng.");
            } else {
                 redirectAttributes.addFlashAttribute("success", "Đã cập nhật số lượng sản phẩm.");
            }
        } catch (Exception e) {
            // logger.error("Lỗi khi cập nhật giỏ hàng", e); // Bỏ logger
            redirectAttributes.addFlashAttribute("error", "Lỗi khi cập nhật giỏ hàng: " + e.getMessage());
        }
        return "redirect:/cart/views";
    }

    @GetMapping("/remove/{id}")
    public String removeCartItem(@PathVariable("id") Long id,
                                 RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra người dùng đăng nhập
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
             if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
                 redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xóa sản phẩm khỏi giỏ hàng.");
                 return "redirect:/login";
             }
            // Service remove method should ideally check user ownership too

            cartService.remove(id);
            redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng.");
        } catch (Exception e) {
            // logger.error("Lỗi khi xóa khỏi giỏ hàng", e); // Bỏ logger
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa khỏi giỏ hàng: " + e.getMessage());
        }
        return "redirect:/cart/views";
    }
    
    @PostMapping("/checkout")
    @jakarta.transaction.Transactional
    public String processCheckout(RedirectAttributes redirectAttributes) {

        try {
            // --- Lấy thông tin người dùng hiện tại ---
            User user = getCurrentUser();

            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đặt hàng.");
                return "redirect:/login";
            }

            // --- Lấy giỏ hàng của người dùng từ Service ---
            List<GioHang> cartItems = cartService.getGioHangByUser(user);

            if (cartItems == null || cartItems.isEmpty()) {
                 redirectAttributes.addFlashAttribute("error", "Giỏ hàng của bạn đang trống.");
                 return "redirect:/cart/views";
            }

            // --- Lấy thông tin đơn hàng từ Profile người dùng và/hoặc giá trị mặc định ---
            String shippingAddress = user.getDiaChi();
            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                 redirectAttributes.addFlashAttribute("error", "Vui lòng cập nhật địa chỉ giao hàng trong hồ sơ của bạn trước khi đặt hàng.");
                 return "redirect:/profile/edit";
            }

            String paymentMethod = "CashOnDelivery";
            String shippingMethod = "standard";
            String note = null;


            // --- Bắt đầu tạo đối tượng đơn hàng ---
            DonHang order = new DonHang();
            order.setUser(user);
            order.setNgayDatHang(new Date());
            order.setPhuongThucThanhToan(paymentMethod);
            order.setDiaChiGiaoHang(shippingAddress);
            order.setTrangThai(TrangThai.CHO_XAC_NHAN);
            order.setPhuongThucVanChuyen(shippingMethod);
            order.setGhiChu(note);
            order.setDaThanhToan(false);

            order.setChiTietDonHangs(new ArrayList<>());

            BigDecimal itemsTotal = BigDecimal.ZERO; // Tổng tiền hàng tạm thời (chưa phí ship)

            // --- Vòng lặp qua các mục trong giỏ hàng để tạo ChiTietDonHang và cập nhật tồn kho sản phẩm ---
            for (GioHang cartItem : cartItems) {
                  PhuKienOto product = cartItem.getPhuKienOto();

                  // Kiểm tra số lượng tồn kho
                  if (product.getSoLuong() < cartItem.getSoLuong()) {
                       redirectAttributes.addFlashAttribute("error", "Sản phẩm '" + product.getTenPhuKien() + "' không đủ số lượng trong kho. Vui lòng điều chỉnh giỏ hàng.");
                       return "redirect:/cart/views";
                  }

                // Tạo ChiTietDonHang cho mỗi mục trong giỏ hàng
                ChiTietDonHang orderDetail = new ChiTietDonHang();
                orderDetail.setDonHang(order);
                orderDetail.setPhuKienOto(product);
                orderDetail.setSoLuong(cartItem.getSoLuong());
                orderDetail.setDonGia(cartItem.getGia());

                // ** SỬA LỖI: Thiết lập giá trị cho ten_san_pham và thanh_tien **
                // Đảm bảo lớp ChiTietDonHang có các phương thức setTenSanPham() và setThanhTien()
                orderDetail.setTenSanPham(product.getTenPhuKien()); // <-- Lấy tên từ PhuKienOto
                // Tính thành tiền cho mục này: Đơn giá * Số lượng
                orderDetail.setThanhTien(cartItem.getGia().multiply(BigDecimal.valueOf(cartItem.getSoLuong()))); // <-- Tính và set thành tiền


                order.getChiTietDonHangs().add(orderDetail);

                // Cập nhật số lượng tồn kho của sản phẩm trong DB
                product.setSoLuong(product.getSoLuong() - cartItem.getSoLuong());
                phuKienOtoService.save(product);


                // Cộng dồn vào tổng tiền hàng (chỉ tiền sản phẩm)
                itemsTotal = itemsTotal.add(orderDetail.getThanhTien()); // <-- Cộng dồn từ ThanhTien đã tính
            }

            // --- Tính phí vận chuyển và Tổng tiền cuối cùng ---
             BigDecimal shippingFee = BigDecimal.ZERO;
             try {
                 shippingFee = calculateShippingFee(shippingMethod, itemsTotal);
             } catch (Exception e) {
                 // Xử lý lỗi tính phí ship
                 redirectAttributes.addFlashAttribute("error", "Lỗi khi tính phí vận chuyển.");
                 return "redirect:/cart/views";
             }

            order.setPhiVanChuyen(shippingFee);
            order.setTongThanhToan(itemsTotal.add(shippingFee));

            // --- Lưu đơn hàng vào cơ sở dữ liệu ---
            DonHang savedOrder = donHangService.save(order);

            // --- Xóa giỏ hàng của người dùng sau khi đặt hàng thành công ---
            cartService.clear();

            // --- Chuyển hướng đến trang thông báo đặt hàng thành công ---
            redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công! Mã đơn hàng của bạn là: " + savedOrder.getOrderID());
            return "redirect:/trangchu"; // <-- REDIRECT VỀ TRANG CHỦ

        } catch (Exception e) {
            // ** PHẦN DEBUG TẠM THỜI - BẠN CÓ THỂ BỎ HOẶC COMMENT SAU KHI SỬA LỖI GỐC **
            System.err.println("-----------------------------------------------------");
            System.err.println("DEBUG: Original Exception caught in processCheckout:");
            e.printStackTrace(System.err);
            System.err.println("-----------------------------------------------------");

            // --- Xử lý lỗi tổng quát trong quá trình đặt hàng ---
            redirectAttributes.addFlashAttribute("error", "Đã xảy ra lỗi trong quá trình đặt hàng. Vui lòng thử lại.");
            return "redirect:/cart/views";
        }
    }


    // ** Helper method để lấy User hiện tại từ Security Context **
    // Đảm bảo phương thức này tồn tại và hoạt động đúng
    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getPrincipal().equals("anonymousUser")) {
            return null;
        }
        Object principal = authentication.getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }
        // Sử dụng userService để tìm đối tượng User đầy đủ từ username
        return userService.findByUsername(username);
    }


     // ** Phương thức helper (hoặc gọi Service khác) để tính phí vận chuyển **
     // Bạn cần triển khai logic tính phí vận chuyển thực tế ở đây hoặc trong một Service khác
     private BigDecimal calculateShippingFee(String shippingMethod, BigDecimal itemsTotal) {
         // logger.info("Calculating shipping fee for method {} and items total {}", shippingMethod, itemsTotal); // Bỏ logger
         // --- Logic tính phí vận chuyển thực tế ---
         // Ví dụ đơn giản:
         if ("express".equalsIgnoreCase(shippingMethod)) { // So sánh không phân biệt hoa thường
             return new BigDecimal("50000"); // Phí ship nhanh cố định
         } else { // standard hoặc các trường hợp khác
             return new BigDecimal("20000"); // Phí ship chuẩn cố định
         }
         // Logic phức tạp hơn có thể dựa vào itemsTotal, địa chỉ giao hàng, v.v.
     }


    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }

    private String getPreviousPageUrl(HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null && !referer.isEmpty() ? referer : "/");
    }
}