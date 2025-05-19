package poly.edu.Controller;

import java.util.List;
import java.util.Optional; // Có thể bỏ nếu không còn dùng Optional<User> trong controller này

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// Bỏ import jakarta.servlet.http.HttpSession; // Không còn quản lý session thủ công ở đây

import poly.edu.DAO.DanhMucDAO;
import poly.edu.DAO.KhachHangDAO;
import poly.edu.DAO.MaKhuyenMaiDAO;
import poly.edu.DAO.NhanVienDAO;
import poly.edu.DAO.PhuKienOtoDAO;
import poly.edu.DAO.SanPhamDAO;
import poly.edu.DAO.UserDAO;
import poly.edu.Model.DanhMuc;
import poly.edu.Model.HinhAnhSanPham;
import poly.edu.Model.KhachHang;
import poly.edu.Model.MaKhuyenMai;
import poly.edu.Model.NhanVien;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;
import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;
import poly.edu.Service.DanhMucService;
import poly.edu.Service.PhuKienOtoService;
import poly.edu.Service.SanPhamService;
import poly.edu.Service.UserService; // Giữ lại nếu UserService có các phương thức khác được dùng

@Controller
public class HomeController {

    @Autowired
    private DanhMucDAO danhMucDAO;
    @Autowired
    private SanPhamDAO sanPhamDAO;
    @Autowired
    private NhanVienDAO nhanVienDAO;
    @Autowired
    private KhachHangDAO KhachHangDAO;
    @Autowired
    private MaKhuyenMaiDAO maKhuyenMaiDAO;
    @Autowired
    private PhuKienOtoDAO phuKienOtoDAO;
    @Autowired
    private SanPhamService sanPhamService;
    @Autowired
    private PhuKienOtoService phuKienOtoService;

    // Sử dụng UserService cho các tác vụ khác (đăng ký, quên/đổi mật khẩu)
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository; // Giữ lại nếu cần cho forgot password

    // Trang chủ công khai (có thể hiển thị thông tin chung)
    // SecurityConfig sẽ quyết định ai có quyền truy cập
    @GetMapping(value = { "/", "/trangchu" }, produces = "text/html; charset=UTF-8") // Map cả "/" và "/trangchu"
    public String home(Model model) {
        try {
            List<SanPham> sanPhamList = sanPhamDAO.findAll();
            model.addAttribute("sanPhamList", sanPhamList);
            List<DanhMuc> danhMucList = danhMucDAO.findAll();
            model.addAttribute("danhMucList", danhMucList);
            List<NhanVien> nhanVienList = nhanVienDAO.findAll();
            model.addAttribute("nhanVienList", nhanVienList);
            List<KhachHang> khachHangList = KhachHangDAO.findAll();
            model.addAttribute("khachHangList", khachHangList);
            List<MaKhuyenMai> maKhuyenMaiList = maKhuyenMaiDAO.findAll();
            model.addAttribute("maKhuyenMaiList", maKhuyenMaiList);
            List<PhuKienOto> phuKienOtoList = phuKienOtoService.findAll();
            model.addAttribute("phuKienOtoList", phuKienOtoList);

            // Bạn có thể lấy thông tin người dùng đã đăng nhập ở đây nếu cần hiển thị trên
            // trang chủ
            // Bằng cách sử dụng SecurityContextHolder, giống như trong CartController
            // Authentication authentication =
            // SecurityContextHolder.getContext().getAuthentication();
            // if (authentication != null && authentication.isAuthenticated() &&
            // !"anonymousUser".equals(authentication.getPrincipal())) {
            // String username = authentication.getName();
            // User loggedInUser = userService.findByUsername(username); // Cần UserService
            // hoặc UserRepository
            // model.addAttribute("userInfo", loggedInUser);
            // }

        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
        }
        return "index2"; // Trả về view index2.jsp (theo cấu hình properties)
    }

    // --- Đăng ký ---
    // Hiển thị form đăng ký
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        return "register";
    }

    // Xử lý đăng ký (Vẫn giữ lại vì Spring Security không xử lý đăng ký mặc định)
    @PostMapping("/register")
    public String register(@RequestParam String username,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String email,
            @RequestParam String hovaten,
            @RequestParam(required = true) String sodienthoai,
            @RequestParam String soNha,
            @RequestParam String tenDuong,
            @RequestParam String phuongXa,
            @RequestParam String quanHuyen,
            @RequestParam String tinhThanh,
            Model model,
            RedirectAttributes redirectAttributes) {

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            model.addAttribute("message", "Mật khẩu xác nhận không khớp");
            return "register";
        }

        // Combine address components into full address
        String diaChiFull = String.format("%s, %s, %s, %s, %s", soNha, tenDuong, phuongXa, quanHuyen, tinhThanh);

        // Call service to register user
        String result = userService.registerUser(username, password, email, hovaten, sodienthoai, diaChiFull);

        if ("Đăng ký thành công!".equals(result)) {
            redirectAttributes.addFlashAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/login";
        }

        // If registration fails, send error message to model and return to registration
        // page
        model.addAttribute("message", result);
        return "register";
    }

    // --- Đăng nhập ---
    // Hiển thị form đăng nhập
    // Spring Security sẽ chuyển hướng đến đây nếu cần xác thực hoặc đăng nhập thất
    // bại
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "error", required = false) String error, // Thêm param error từ Spring Security
            @RequestParam(value = "logout", required = false) String logout, // Thêm param logout từ Spring Security
            Model model) {
        if (message != null && !message.isEmpty()) {
            model.addAttribute("message", message);
        }
        // Xử lý thông báo lỗi từ Spring Security khi đăng nhập thất bại
        if (error != null) {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!"); // Hoặc thông báo tùy chỉnh
        }
        // Xử lý thông báo đăng xuất thành công từ Spring Security
        if (logout != null) {
            model.addAttribute("message", "Bạn đã đăng xuất thành công.");
        }
        return "login"; // Trả về view login.jsp
    }

    // *** XÓA PHƯƠNG THỨC @PostMapping("/login") xử lý login thủ công ***
    // Spring Security Filter Chain sẽ xử lý request POST đến /login (hoặc
    // /j_spring_security_check)

    // *** XÓA PHƯƠNG THỨC @GetMapping("/logout") xử lý logout thủ công ***
    // Spring Security Filter Chain sẽ xử lý request GET/POST đến /logout

    // *** XÓA PHƯƠNG THỨC @GetMapping("/home") sau khi login thành công ***
    // SecurityConfig.defaultSuccessUrl sẽ xử lý chuyển hướng sau login

    // --- Quên và đổi mật khẩu (Giữ lại) ---
    // Giữ nguyên các phương thức forgot-password và change-password
    // (Vì đây là logic riêng của ứng dụng, không phải luồng xác thực chính của
    // Spring Security)

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestParam String email, Model model, RedirectAttributes redirectAttributes) {
        // Lưu ý: handleForgotPassword cần gửi email và có thể tạo token đặt lại mật
        // khẩu
        String result = userService.handleForgotPassword(email);
        if (result.contains("đã được gửi")) {
            User user = userRepository.findByEmail(email); // Cần tìm user để lấy ID
            if (user != null) {
                redirectAttributes.addFlashAttribute("message", result);
                // Chuyển hướng đến trang đổi mật khẩu, truyền userId hoặc token bảo mật hơn
                return "redirect:/change-password?userId=" + user.getId(); // Giả định getId() là getUserID()
            } else {
                model.addAttribute("message", "Không tìm thấy người dùng với email này.");
                return "forgot-password";
            }

        } else {
            model.addAttribute("message", result);
            return "forgot-password";
        }
    }

    @GetMapping("/change-password")
    public String showChangePasswordPage(@RequestParam Long userId, Model model) {
        model.addAttribute("userId", userId);
        return "change-password";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam Integer userId,
            @RequestParam String currentPassword, // Có thể không cần nếu luồng là "quên MK"
            @RequestParam String newPassword,
            Model model, RedirectAttributes redirectAttributes) {
        // Lưu ý: changePassword cần kiểm tra mật khẩu hiện tại (nếu không phải luồng
        // quên MK)
        // và mã hóa mật khẩu mới trước khi lưu
        String result = userService.changePassword(userId, currentPassword, newPassword); // Cần điều chỉnh service
                                                                                          // method

        if (result.contains("thành công")) {
            redirectAttributes.addFlashAttribute("message", result);
            return "redirect:/login"; // Chuyển hướng về trang login sau khi đổi MK thành công
        } else {
            model.addAttribute("message", result);
            model.addAttribute("userId", userId);
            // Có thể cần thêm các param khác nếu form đổi mật khẩu yêu cầu
            return "change-password";
        }
    }

    // --- Các phương thức khác ---
    @Autowired
    private UserDAO userDAO; // Giữ lại nếu cần

    @GetMapping("/quantri") // URL cho trang admin/quản trị
    // SecurityConfig cần cấu hình để chỉ cho phép user có ROLE_ADMIN truy cập
    public String danhSachNguoiDung(Model model) {
        // Lấy thông tin user hiện tại từ SecurityContextHolder nếu cần hiển thị trên
        // trang admin
        // Authentication authentication =
        // SecurityContextHolder.getContext().getAuthentication();
        // ... lấy user từ username ...
        // model.addAttribute("userInfo", loggedInUser);

        List<User> users = userDAO.findAll();
        model.addAttribute("users", users);
        return "Admin/quantri"; // Trả về view trang quản trị
    }

    // Trang chi tiết sản phẩm (có thể công khai)
    @GetMapping("/details/{productId}") // URL chi tiết sản phẩm
    public String getDetailsByProductId(@PathVariable("productId") Long productId, Model model) {
        // Logic lấy chi tiết sản phẩm
        // ... (code hiện tại của bạn) ...

        List<SanPham> details = sanPhamDAO.findByProductId(productId);

        if (!details.isEmpty()) {
            SanPham sanPham = details.get(0);
            Long categoryID = sanPham.getDanhMuc().getCategoryID();

            List<HinhAnhSanPham> hinhAnhList = sanPham.getHinhAnhSanPhams();

            // logger debug (nếu bạn muốn thêm logger lại)
            // System.out.println("CategoryID: " + categoryID);
            // System.out.println("ProductID: " + productId);
            // System.out.println("Số ảnh: " + hinhAnhList.size());

            List<SanPham> sanPhamTuongTu = sanPhamService.getSanPhamTuongTu(categoryID, productId);

            model.addAttribute("sanPhamTuongTu", sanPhamTuongTu);
            model.addAttribute("hinhAnhList", hinhAnhList);
        }

        model.addAttribute("details", details);
        return "Detail";
    }

    @GetMapping("/contact")
    public String showContactPage(Model model) {
        return "contact";
    }

    // Your existing /profile GET mapping
    @GetMapping("/profile")
    public String showProfile(Model model, RedirectAttributes redirectAttributes) {
        User user = getCurrentUser();

        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập");
            return "redirect:/login"; // Assuming you have a /login endpoint
        }

        model.addAttribute("userInfo", user);
        // Check for flash attributes (success or error messages from update)
        if (redirectAttributes.getFlashAttributes().containsKey("successMessage")) {
            model.addAttribute("successMessage", redirectAttributes.getFlashAttributes().get("successMessage"));
        }
        if (redirectAttributes.getFlashAttributes().containsKey("errorMessage")) {
            model.addAttribute("errorMessage", redirectAttributes.getFlashAttributes().get("errorMessage"));
        }

        return "profile"; // Return the name of your JSP file
    }

    // *** NEW POST MAPPING FOR PROFILE UPDATE ***
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("fullname") String fullname,
            @RequestParam("email") String email,
            @RequestParam("address") String address,
            @RequestParam("phone") String phone,
            RedirectAttributes redirectAttributes,
            Model model) { // Include Model to potentially add error/success if not redirecting

        User currentUser = getCurrentUser(); // Get the currently logged-in user

        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Phiên đăng nhập đã hết hạn hoặc người dùng không tồn tại.");
            return "redirect:/login"; // Redirect to login if user is not found
        }

        // Call the new updateProfile method from your UserService
        // Pass the user's ID and the received data
        String updateResult = userService.updateProfile(
                currentUser.getId(), // Assuming your User model has an getId() method
                fullname,
                email,
                address,
                phone);

        // Handle the result from the service
        if (updateResult.equals("Cập nhật thông tin thành công!")) {
            redirectAttributes.addFlashAttribute("successMessage", updateResult);
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", updateResult);
        }

        // Redirect back to the profile page to show the updated info or message
        return "redirect:/profile";
    }

    // Add this new method to handle password changes from the profile page
    @PostMapping("/profile/change-password")
    public String changePasswordFromProfile(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes redirectAttributes) {

        // Get the current user
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Phiên đăng nhập đã hết hạn hoặc người dùng không tồn tại.");
            return "redirect:/login";
        }

        // Verify password confirmation
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mật khẩu xác nhận không khớp với mật khẩu mới.");
            return "redirect:/profile";
        }

        // Change password using the existing service method
        String result = userService.changePassword(currentUser.getId(), currentPassword, newPassword);

        if (result.contains("thành công")) {
            redirectAttributes.addFlashAttribute("successMessage", result);
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", result);
        }

        return "redirect:/profile";
    }

    @Autowired
    private DanhMucService categoryService;

    @GetMapping("/cars")
    public String showUsedCarsPage(
            @RequestParam(value = "category", required = false) String categoryName,
            @RequestParam(value = "yearFrom", required = false) Integer yearFrom,
            @RequestParam(value = "yearTo", required = false) Integer yearTo,
            @RequestParam(value = "fuelType", required = false) String fuelType,
            @RequestParam(value = "sort", required = false) String sort,
            Model model) {

        List<SanPham> carsList; // Danh sách xe sẽ được hiển thị

        // Lấy danh sách danh mục loại 'xe' để hiển thị bộ lọc
        List<DanhMuc> carCategories = categoryService.getCategoriesByLoai("xe");

        // Base query - sẽ được điều chỉnh dựa trên các tham số
        carsList = sanPhamService.getAllCars();

        // Apply Category Filter
        if (categoryName != null && !categoryName.isEmpty()) {
            Optional<DanhMuc> selectedCategoryOpt = categoryService.getCategoryByName(categoryName);
            if (selectedCategoryOpt.isPresent()) {
                DanhMuc selectedCategory = selectedCategoryOpt.get();
                carsList = sanPhamService.getProductsByCategoryAndType(selectedCategory, "xe");
            }
        }

        // Apply Price Filter - REMOVED since gia field no longer exists
        // if (priceMax != null) {
        // double maxPrice = priceMax * 1000000.0; // Convert to VND (if slider uses
        // millions)
        // carsList = carsList.stream()
        // .filter(car -> car.getGia() <= maxPrice)
        // .collect(java.util.stream.Collectors.toList());
        // }

        // Apply Year Filter
        if (yearFrom != null) {
            final int yearFromValue = yearFrom;
            carsList = carsList.stream()
                    .filter(car -> {
                        if (car.getNgaySanXuat() != null) {
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            cal.setTime(car.getNgaySanXuat());
                            return cal.get(java.util.Calendar.YEAR) >= yearFromValue;
                        }
                        return false;
                    })
                    .collect(java.util.stream.Collectors.toList());
        }

        if (yearTo != null) {
            final int yearToValue = yearTo;
            carsList = carsList.stream()
                    .filter(car -> {
                        if (car.getNgaySanXuat() != null) {
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            cal.setTime(car.getNgaySanXuat());
                            return cal.get(java.util.Calendar.YEAR) <= yearToValue;
                        }
                        return false;
                    })
                    .collect(java.util.stream.Collectors.toList());
        }

        // Apply Fuel Type Filter
        if (fuelType != null && !fuelType.isEmpty()) {
            carsList = carsList.stream()
                    .filter(car -> fuelType.equals(car.getNhienLieu()))
                    .collect(java.util.stream.Collectors.toList());
        }

        // Apply Sorting - MODIFIED to remove price-related sorting
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                // Remove price-based sorting options
                // case "price-desc":
                // carsList.sort((car1, car2) -> Double.compare(car2.getGia(), car1.getGia()));
                // break;
                // case "price-asc":
                // carsList.sort((car1, car2) -> Double.compare(car1.getGia(), car2.getGia()));
                // break;
                case "year-desc":
                    carsList.sort((car1, car2) -> {
                        if (car1.getNgaySanXuat() == null)
                            return 1;
                        if (car2.getNgaySanXuat() == null)
                            return -1;
                        return car2.getNgaySanXuat().compareTo(car1.getNgaySanXuat());
                    });
                    break;
                default:
                    // No sorting or default sorting
                    break;
            }
        }

        // Add dữ liệu vào model
        model.addAttribute("allCarsList", carsList);
        model.addAttribute("categoriesList", carCategories);

        return "used_cars";
    }

    // Handler cho trang Phụ Kiện Ô Tô
    @GetMapping("/accessories")
    public String showAccessoriesPage(
            @RequestParam(value = "category", required = false) String categoryName,
            @RequestParam(value = "priceMax", required = false) Integer priceMax,
            @RequestParam(value = "brand", required = false) String brand,
            @RequestParam(value = "rating", required = false) Integer rating,
            @RequestParam(value = "sort", required = false) String sort,
            Model model) {

        List<PhuKienOto> accessoriesList;

        // Lấy danh sách danh mục loại 'phu_kien'
        List<DanhMuc> accessoryCategories = categoryService.getCategoriesByLoai("phu_kien");

        // Base query
        accessoriesList = phuKienOtoService.findAll();

        // Apply Category Filter
        if (categoryName != null && !categoryName.isEmpty()) {
            Optional<DanhMuc> selectedCategoryOpt = categoryService.getCategoryByName(categoryName);
            if (selectedCategoryOpt.isPresent()) {
                DanhMuc selectedCategory = selectedCategoryOpt.get();
                accessoriesList = phuKienOtoService.getAccessoriesByCategory(selectedCategory);
            }
        }

        // Apply Price Filter
        if (priceMax != null) {
            final double maxPrice = priceMax.doubleValue();
            accessoriesList = accessoriesList.stream()
                    .filter(accessory -> accessory.getGia() <= maxPrice)
                    .collect(java.util.stream.Collectors.toList());
        }

        // Apply Brand Filter
        if (brand != null && !brand.isEmpty()) {
            accessoriesList = accessoriesList.stream()
                    .filter(accessory -> brand.equals(accessory.getHangSanXuat()))
                    .collect(java.util.stream.Collectors.toList());
        }

        // Apply Rating Filter - Note: This assumes you have rating data in your model
        // If you don't have actual ratings, you might want to comment this out or
        // implement mock ratings
        if (rating != null) {
            // For demonstration purposes, we'll filter randomly based on rating
            // In a real app, you would filter based on actual ratings from reviews
            final int ratingValue = rating;
            accessoriesList = accessoriesList.stream()
                    .filter(accessory -> {
                        // Mock implementation - in real app, replace with actual rating logic
                        return accessory.getAccessoryID() % 5 + 1 >= ratingValue;
                    })
                    .collect(java.util.stream.Collectors.toList());
        }

        // Apply Sorting
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "price-desc":
                    accessoriesList.sort((a1, a2) -> Double.compare(a2.getGia(), a1.getGia()));
                    break;
                case "price-asc":
                    accessoriesList.sort((a1, a2) -> Double.compare(a1.getGia(), a2.getGia()));
                    break;
                case "rating-desc":
                    // Mock rating sort - replace with actual rating logic in real app
                    accessoriesList.sort((a1, a2) -> {
                        long mockRating1 = a1.getAccessoryID() % 5 + 1;
                        long mockRating2 = a2.getAccessoryID() % 5 + 1;
                        return Long.compare(mockRating2, mockRating1);
                    });
                    break;
                case "popular":
                    // Mock popularity sort - replace with actual popularity data in real app
                    java.util.Collections.shuffle(accessoriesList); // Simple random sort for demo purposes
                    break;
                default:
                    // No sorting or default sorting
                    break;
            }
        }

        model.addAttribute("allAccessoriesList", accessoriesList);
        model.addAttribute("categoriesList", accessoryCategories);

        return "accessories";
    }

    // Bạn có thể thêm các handler khác tại đây, ví dụ:
    // @GetMapping("/details/{id}") để hiển thị chi tiết sản phẩm
    // @PostMapping("/cart/add/{id}") để thêm vào giỏ hàng (như trong trang chủ)

    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
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
}