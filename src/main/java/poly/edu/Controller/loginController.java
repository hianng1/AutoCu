/*
 * package poly.edu.Controller;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.security.authentication.AuthenticationManager; import
 * org.springframework.security.authentication.
 * UsernamePasswordAuthenticationToken; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.*; import
 * org.springframework.web.servlet.mvc.support.RedirectAttributes; import
 * poly.edu.Service.*; import poly.edu.Model.*; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.security.core.Authentication;
 * 
 * import java.security.Principal; import java.util.Optional;
 * 
 * @Controller public class loginController { private final UserService
 * userService;
 * 
 * @Autowired public loginController(UserService userService,
 * AuthenticationManager authenticationManager) { this.userService =
 * userService; this.authenticationManager = authenticationManager; }
 * 
 * @Autowired private AuthenticationManager authenticationManager;
 * 
 * public loginController(UserService userService) { this.userService =
 * userService; }
 * 
 * @GetMapping("/register") public String showRegisterPage(Model model) { if
 * (!model.containsAttribute("user")) { model.addAttribute("user", new
 * KhachHang()); } return "register"; }
 * 
 * @PostMapping("/register") public String register(@ModelAttribute KhachHang
 * user, RedirectAttributes redirectAttributes) { if
 * (userService.findByTenKhachHang(user.getTenKhachHang()).isPresent()) {
 * redirectAttributes.addFlashAttribute("error", "Tên đăng nhập đã tồn tại!");
 * redirectAttributes.addFlashAttribute("user", user); return
 * "redirect:/register"; } userService.registerUser(user); return
 * "redirect:/login"; }
 * 
 * @GetMapping("/login") public String showLoginForm() { return "login"; }
 * 
 * @GetMapping("/user") public String showUserForm(Model model, Principal
 * principal) { model.addAttribute("username", principal.getName()); return
 * "index2"; }
 * 
 * @GetMapping("/admin") public String showAdminForm(Model model) {
 * model.addAttribute("admin", "Bạn đang trong trang admin"); return "admin1"; }
 * 
 * @PostMapping("/login") public String login(@RequestParam String
 * tenKhachHang, @RequestParam String MatKhau, Model model) { try {
 * Authentication auth = authenticationManager.authenticate( new
 * UsernamePasswordAuthenticationToken(tenKhachHang, MatKhau));
 * 
 * Optional<KhachHang> user = userService.findByTenKhachHang(tenKhachHang);
 * 
 * if (user.isPresent()) { if (user.get().getVaiTro().equals(true)) { return
 * "redirect:/admin"; } else { return "redirect:/user"; } } } catch (Exception
 * e) { model.addAttribute("error", "Sai tài khoản hoặc mật khẩu!"); return
 * "login"; } return "login"; } }
 */