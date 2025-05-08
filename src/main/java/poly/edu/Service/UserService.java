package poly.edu.Service;

import java.util.Optional;
import java.util.UUID;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // Import Transactional

import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    // Pattern for validating phone number - exactly 10 digits
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    // Đăng ký tài khoản - với mã hóa mật khẩu và kiểm tra số điện thoại
    @Transactional // Add Transactional annotation for database operations
    public String registerUser(String username, String rawPassword, String email,
                               String hovaten, String sodienthoai, String diaChi) {
        // Kiểm tra username đã tồn tại
        if (userRepository.existsByUsername(username)) {
            return "Tên người dùng đã tồn tại!";
        }
        
        // Kiểm tra email đã tồn tại
        if (userRepository.existsByEmail(email)) {
            return "Email đã được sử dụng!";
        }
        
        // Kiểm tra số điện thoại
        if (sodienthoai != null && !sodienthoai.isEmpty()) {
            // Kiểm tra số điện thoại đã tồn tại
            if (userRepository.existsBySodienthoai(sodienthoai)) {
                return "Số điện thoại đã được sử dụng!";
            }
            
            // Kiểm tra định dạng số điện thoại (10 số)
            if (!PHONE_PATTERN.matcher(sodienthoai).matches()) {
                return "Số điện thoại phải có đúng 10 chữ số!";
            }
        }
        
        // Kiểm tra họ tên
        if (hovaten == null || hovaten.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }
        
        // Kiểm tra mật khẩu
        if (rawPassword == null || rawPassword.length() < 6) {
             return "Mật khẩu phải có ít nhất 6 ký tự!";
        }
        

        User newUser = new User();
        newUser.setUsername(username);
        // Mã hóa mật khẩu trước khi lưu
        newUser.setPassword(passwordEncoder.encode(rawPassword));
        newUser.setEmail(email);
        newUser.setHovaten(hovaten);
        newUser.setSodienthoai(sodienthoai != null ? sodienthoai : null);
        newUser.setDiaChi(diaChi);
        newUser.setRole("ADMIN"); //"ADMIN"

        userRepository.save(newUser);
        return "Đăng ký thành công!";
    }

    // Xử lý quên mật khẩu - với mã hóa mật khẩu mới
    @Transactional
    public String handleForgotPassword(String email) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            String newRawPassword = generateRandomPassword();
            // Mã hóa mật khẩu trước khi lưu
            user.setPassword(passwordEncoder.encode(newRawPassword));
            userRepository.save(user);
            // Lưu ý: Gửi mật khẩu thô qua email là không an toàn.
            // Nên gửi link đặt lại mật khẩu có token hết hạn.
            emailService.sendResetPasswordEmail(user, newRawPassword); // Cần cải thiện logic này
            return "Mật khẩu mới đã được gửi vào email của bạn!";
        }
        return "Email không tồn tại trong hệ thống.";
    }

    // Đổi mật khẩu - với mã hóa và so sánh mật khẩu an toàn
    @Transactional
    public String changePassword(Integer userId, String currentRawPassword, String newRawPassword) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return "Người dùng không tồn tại!";
        }

        // So sánh mật khẩu hiện tại với mật khẩu đã mã hóa trong cơ sở dữ liệu
        if (!passwordEncoder.matches(currentRawPassword, user.getPassword())) {
            return "Mật khẩu hiện tại không đúng!";
        }

        if (newRawPassword == null || newRawPassword.length() < 6) {
            return "Mật khẩu mới phải có ít nhất 6 ký tự!";
        }

        // Mã hóa mật khẩu mới trước khi lưu
        user.setPassword(passwordEncoder.encode(newRawPassword));
         
        userRepository.save(user);
        return "Mật khẩu đã được cập nhật thành công!";
    }

    // *** PHƯƠNG THỨC MỚI ĐỂ CẬP NHẬT THÔNG TIN PROFILE ***
    @Transactional // Add Transactional annotation
    public String updateProfile(Integer userId, String fullname, String email, String address, String phone) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (!userOptional.isPresent()) {
            return "Người dùng không tồn tại."; // User not found
        }

        User user = userOptional.get();

        // Optional: Add validation for input fields here
        if (fullname == null || fullname.trim().isEmpty()) {
             return "Họ tên không được để trống!";
        }
        // Add more validation as needed (e.g., email format, phone format)

        // Update fields
        user.setHovaten(fullname);
        user.setEmail(email);
        user.setDiaChi(address);
        user.setSodienthoai(phone);

        // Note: Password and Role are NOT updated here.
        // Password should be updated via the changePassword method.
        // Role should typically not be user-editable.

        try {
            userRepository.save(user);
            return "Cập nhật thông tin thành công!";
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace(); // Replace with proper logging
            return "Đã xảy ra lỗi khi cập nhật thông tin.";
        }
    }

    // Tạo mật khẩu ngẫu nhiên cho chức năng quên mật khẩu
    private String generateRandomPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }
}