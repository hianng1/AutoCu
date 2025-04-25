package poly.edu.Service;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder; // Import PasswordEncoder
import org.springframework.stereotype.Service;

import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder; // Inject PasswordEncoder Bean

    // Không cần inject EmailService ở đây nếu nó chỉ được dùng trong handleForgotPassword
     @Autowired
     private EmailService emailService;


    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    // Đăng ký tài khoản - SỬA để MÃ HÓA mật khẩu
    public String registerUser(String username, String rawPassword, String email, // Đổi tên password thành rawPassword cho rõ
                               String hovaten, String sodienthoai, String diaChi) {
        if (userRepository.existsByUsername(username)) {
            return "Tên người dùng đã tồn tại!";
        }
        if (userRepository.existsByEmail(email)) {
            return "Email đã được sử dụng!";
        }
        if (hovaten == null || hovaten.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }
        // Kiểm tra độ dài mật khẩu tối thiểu (tùy chọn)
        if (rawPassword == null || rawPassword.length() < 6) { // Ví dụ độ dài tối thiểu 6
             return "Mật khẩu phải có ít nhất 6 ký tự!";
        }


        User newUser = new User();
        newUser.setUsername(username);
        // *** MÃ HÓA MẬT KHẨU TRƯỚC KHI LƯU ***
        newUser.setPassword(passwordEncoder.encode(rawPassword)); // Sử dụng PasswordEncoder
        newUser.setEmail(email);
        newUser.setHovaten(hovaten);
        newUser.setSodienthoai(sodienthoai != null ? sodienthoai : null);
        newUser.setDiaChi(diaChi);
        newUser.setRole("ADMIN"); // Mặc định là USER

        userRepository.save(newUser);
        return "Đăng ký thành công!";
    }

    // *** XÓA PHƯƠNG THỨC authenticate() ***
    // Spring Security sẽ đảm nhiệm việc xác thực bằng UserDetailsService và PasswordEncoder

    // Xử lý quên mật khẩu - SỬA để MÃ HÓA mật khẩu mới
    public String handleForgotPassword(String email) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            String newRawPassword = generateRandomPassword(); // Tạo mật khẩu thô mới
            // *** MÃ HÓA MẬT KHẨU MỚI TRƯỚC KHI LƯU ***
            user.setPassword(passwordEncoder.encode(newRawPassword)); // Mã hóa và lưu
            userRepository.save(user);
            // Lưu ý: Gửi mật khẩu thô qua email là không an toàn trong môi trường thực tế.
            // Nên gửi link đặt lại mật khẩu có token hết hạn.
            emailService.sendResetPasswordEmail(user, newRawPassword); // Gửi mật khẩu thô mới qua email (Cần cải thiện logic này)
            return "Mật khẩu mới đã được gửi vào email của bạn!";
        }
        return "Email không tồn tại trong hệ thống.";
    }

    // Đổi mật khẩu - SỬA để so sánh mật khẩu an toàn và mã hóa mật khẩu mới
    public String changePassword(Long userId, String currentRawPassword, String newRawPassword) { // Đổi tên param
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return "Người dùng không tồn tại!";
        }

        // *** SO SÁNH MẬT KHẨU HIỆN TẠI BẰNG PasswordEncoder ***
        // Sử dụng matches() để so sánh mật khẩu thô với mật khẩu đã mã hóa trong DB
        if (!passwordEncoder.matches(currentRawPassword, user.getPassword())) {
            return "Mật khẩu hiện tại không đúng!";
        }

        // Kiểm tra độ dài mật khẩu mới (tùy chọn)
         if (newRawPassword == null || newRawPassword.length() < 6) { // Ví dụ độ dài tối thiểu 6
              return "Mật khẩu mới phải có ít nhất 6 ký tự!";
         }

        // *** MÃ HÓA MẬT KHẨU MỚI TRƯỚC KHI LƯU ***
        user.setPassword(passwordEncoder.encode(newRawPassword)); // Mã hóa và lưu
        userRepository.save(user);
        return "Mật khẩu đã được cập nhật thành công!";
    }

    private String generateRandomPassword() {
        // Tạo mật khẩu ngẫu nhiên
        return UUID.randomUUID().toString().substring(0, 8);
    }
}