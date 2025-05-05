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
    @GetMapping(value = {"/", "/trangchu"}, produces = "text/html; charset=UTF-8") // Map cả "/" và "/trangchu"
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

            // Bạn có thể lấy thông tin người dùng đã đăng nhập ở đây nếu cần hiển thị trên trang chủ
            // Bằng cách sử dụng SecurityContextHolder, giống như trong CartController
            // Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            // if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal())) {
            //      String username = authentication.getName();
            //      User loggedInUser = userService.findByUsername(username); // Cần UserService hoặc UserRepository
            //      model.addAttribute("userInfo", loggedInUser);
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
                            @RequestParam String email,
                            @RequestParam String hovaten,
                            @RequestParam(required = true) String sodienthoai,
                            @RequestParam String soNha,
                            @RequestParam String phuongXa,
                            @RequestParam String quanHuyen,
                            @RequestParam String tinhThanh,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        // Kết hợp các phần thông tin địa chỉ để tạo thành địa chỉ đầy đủ
        String diaChiFull = String.join(", ", soNha, phuongXa, quanHuyen, tinhThanh);

        // Gọi service để thực hiện đăng ký
        // Lưu ý: UserService.registerUser cần mã hóa mật khẩu trước khi lưu vào DB
        String result = userService.registerUser(username, password, email, hovaten, sodienthoai, diaChiFull);

        if ("Đăng ký thành công!".equals(result)) {
            redirectAttributes.addFlashAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/login"; // Chuyển hướng đến trang login nếu đăng ký thành công
        }

        // Nếu đăng ký thất bại, gửi thông báo lỗi tới model và trả về trang đăng ký
        model.addAttribute("message", result);
        // Giữ lại các giá trị đã nhập để người dùng không phải nhập lại (tùy chọn, cần thêm logic)
        // model.addAttribute("username", username);
        // ... các field khác ...
        return "register"; // Nếu đăng ký thất bại, vẫn ở trang đăng ký
    }

    // --- Đăng nhập ---
    // Hiển thị form đăng nhập
    // Spring Security sẽ chuyển hướng đến đây nếu cần xác thực hoặc đăng nhập thất bại
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
    // Spring Security Filter Chain sẽ xử lý request POST đến /login (hoặc /j_spring_security_check)

    // *** XÓA PHƯƠNG THỨC @GetMapping("/logout") xử lý logout thủ công ***
    // Spring Security Filter Chain sẽ xử lý request GET/POST đến /logout

    // *** XÓA PHƯƠNG THỨC @GetMapping("/home") sau khi login thành công ***
    // SecurityConfig.defaultSuccessUrl sẽ xử lý chuyển hướng sau login

    // --- Quên và đổi mật khẩu (Giữ lại) ---
    // Giữ nguyên các phương thức forgot-password và change-password
    // (Vì đây là logic riêng của ứng dụng, không phải luồng xác thực chính của Spring Security)

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestParam String email, Model model, RedirectAttributes redirectAttributes) {
        // Lưu ý: handleForgotPassword cần gửi email và có thể tạo token đặt lại mật khẩu
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
        // Lưu ý: changePassword cần kiểm tra mật khẩu hiện tại (nếu không phải luồng quên MK)
        // và mã hóa mật khẩu mới trước khi lưu
        String result = userService.changePassword(userId, currentPassword, newPassword); // Cần điều chỉnh service method

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
        // Lấy thông tin user hiện tại từ SecurityContextHolder nếu cần hiển thị trên trang admin
        // Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
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
             phone
         );

         // Handle the result from the service
         if (updateResult.equals("Cập nhật thông tin thành công!")) {
             redirectAttributes.addFlashAttribute("successMessage", updateResult);
         } else {
             redirectAttributes.addFlashAttribute("errorMessage", updateResult);
         }

         // Redirect back to the profile page to show the updated info or message
         return "redirect:/profile";
     }
     
     @Autowired
     private DanhMucService categoryService;
     
     @GetMapping("/cars")
     public String showUsedCarsPage(
             @RequestParam(value = "category", required = false) String categoryName,
             Model model) {

         List<SanPham> carsList; // Danh sách xe sẽ được hiển thị
         
         // Lấy danh sách danh mục loại 'xe' để hiển thị bộ lọc trên trang JSP
         // Sử dụng phương thức từ CategoryService nếu có
         List<DanhMuc> carCategories = categoryService.getCategoriesByLoai("xe");
         // Hoặc nếu CategoryService chỉ có getAllCategories():
         // List<DanhMuc> allCategories = categoryService.getAllCategories();
         // List<DanhMuc> carCategories = allCategories.stream()
         //                                 .filter(cat -> "xe".equals(cat.getLoai()))
         //                                 .collect(java.util.stream.Collectors.toList());


         if (categoryName != null && !categoryName.isEmpty()) {
             // Bước 1: Tìm đối tượng DanhMuc dựa trên tên danh mục từ request
             Optional<DanhMuc> selectedCategoryOpt = categoryService.getCategoryByName(categoryName);

             if (selectedCategoryOpt.isPresent()) {
                 // Bước 2: Nếu tìm thấy danh mục, lấy đối tượng DanhMuc
                 DanhMuc selectedCategory = selectedCategoryOpt.get();
                 // Bước 3: Gọi SanPhamService để lấy xe thuộc danh mục này và có loại là 'xe'
                 // Truyền ĐỐI TƯỢNG DanhMuc và loại ('xe')
                 carsList = sanPhamService.getProductsByCategoryAndType(selectedCategory, "xe");
             } else {
                 // Nếu tên danh mục không hợp lệ hoặc không tìm thấy, hiển thị tất cả xe
                 System.err.println("Danh mục xe '" + categoryName + "' không tìm thấy. Hiển thị tất cả xe.");
                 carsList = sanPhamService.getAllCars(); // Hiển thị tất cả xe
                 // Hoặc bạn có thể trả về danh sách rỗng và thêm thông báo lỗi vào model
                 // carsList = java.util.Collections.emptyList();
                 // model.addAttribute("errorMessage", "Danh mục '" + categoryName + "' không tồn tại.");
             }

         } else {
             // Nếu không có tham số 'category' trong URL, lấy tất cả xe
             carsList = sanPhamService.getAllCars();
         }

         // Add dữ liệu vào model để truyền sang JSP
         model.addAttribute("allCarsList", carsList); // Đảm bảo tên attribute khớp với tên dùng trong JSP
         model.addAttribute("categoriesList", carCategories); // Truyền danh mục xe cho JSP (để tạo link lọc)

         // Trả về tên view (tên file JSP không có .jsp)
         return "used_cars"; // Đảm bảo bạn có file used_cars.jsp trong thư mục views
     }

     // Handler cho trang Phụ Kiện Ô Tô
     @GetMapping("/accessories")
     public String showAccessoriesPage(
              @RequestParam(value = "category", required = false) String categoryName,
             Model model) {

         // >>> Danh sách chứa các đối tượng PhuKienOto <<<
         List<PhuKienOto> accessoriesList;

          // Lấy danh sách danh mục loại 'phu_kien' để hiển thị bộ lọc trên trang JSP
          // Sử dụng phương thức từ CategoryService
         List<DanhMuc> accessoryCategories = categoryService.getCategoriesByLoai("phu_kien");
          // Hoặc nếu CategoryService chỉ có getAllCategories():
          // List<DanhMuc> allCategories = categoryService.getAllCategories();
          // List<DanhMuc> accessoryCategories = allCategories.stream()
          //                                 .filter(cat -> "phu_kien".equals(cat.getLoai()))
          //                                 .collect(java.util.stream.Collectors.toList());


         if (categoryName != null && !categoryName.isEmpty()) {
              // Bước 1: Tìm đối tượng DanhMuc dựa trên tên danh mục từ request
             Optional<DanhMuc> selectedCategoryOpt = categoryService.getCategoryByName(categoryName);

             if (selectedCategoryOpt.isPresent()) {
                 // Bước 2: Nếu tìm thấy danh mục, lấy đối tượng DanhMuc
                 DanhMuc selectedCategory = selectedCategoryOpt.get();
                 // Bước 3: Gọi >>> PhuKienOtoService <<< để lấy phụ kiện thuộc danh mục này
                 // Giả định PhuKienOtoService có phương thức getAccessoriesByCategory(DanhMuc danhMuc)
                  accessoriesList = phuKienOtoService.getAccessoriesByCategory(selectedCategory);
             } else {
                  // Nếu tên danh mục không hợp lệ hoặc không tìm thấy, hiển thị tất cả phụ kiện
                  System.err.println("Danh mục phụ kiện '" + categoryName + "' không tìm thấy. Hiển thị tất cả phụ kiện.");
                  // >>> Gọi findAll() từ PhuKienOtoService <<<
                  accessoriesList = phuKienOtoService.findAll(); // Hiển thị tất cả phụ kiện
                  // Hoặc bạn có thể trả về danh sách rỗng và thêm thông báo lỗi vào model
                  // accessoriesList = java.util.Collections.emptyList();
                  // model.addAttribute("errorMessage", "Danh mục '" + categoryName + "' không tồn tại.");
             }

         } else {
              // Nếu không có tham số 'category' trong URL, lấy tất cả phụ kiện
              // >>> Gọi findAll() từ PhuKienOtoService <<<
              accessoriesList = phuKienOtoService.findAll();
          }

          // Add dữ liệu vào model để truyền sang JSP
          // >>> Tên attribute khớp với tên dùng trong JSP: "allAccessoriesList" <<<
          model.addAttribute("allAccessoriesList", accessoriesList);
          // Truyền danh mục phụ kiện cho JSP (để tạo link lọc)
          model.addAttribute("categoriesList", accessoryCategories);

          // Trả về tên view (tên file JSP không có .jsp)
          return "accessories"; // Đảm bảo bạn có file accessories.jsp trong thư mục views
      }

     // Bạn có thể thêm các handler khác tại đây, ví dụ:
     // @GetMapping("/details/{id}") để hiển thị chi tiết sản phẩm
     // @PostMapping("/cart/add/{id}") để thêm vào giỏ hàng (như trong trang chủ)


     
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
}