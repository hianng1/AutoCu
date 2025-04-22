package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;

import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    // Đăng ký tài khoản
    public String registerUser(String username, String password, String email, String hovaten, String sodienthoai, String diaChi) {
        Optional<User> existingUser = userRepository.findByUsername(username);

        if (userRepository.existsByUsername(username)) {
            return "Tên người dùng đã tồn tại!";
        }
        if (userRepository.existsByEmail(email)) {
            return "Email đã được sử dụng!";
        }
        if (hovaten == null || hovaten.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password); // Không mã hóa mật khẩu
        newUser.setEmail(email);
        newUser.setHovaten(hovaten);
        if (sodienthoai != null) { // Nếu người dùng nhập thì mới lưu
            newUser.setSodienthoai(sodienthoai);
        } else {
            newUser.setSodienthoai(null); // Không nhập thì để null
        }
        newUser.setDiaChi(diaChi);
        newUser.setRole("USER"); // Mặc định là USER

        userRepository.save(newUser);
        return "Đăng ký thành công!";
    }

    // Kiểm tra đăng nhập
    public Optional<User> authenticate(String username, String password) {
        Optional<User> user = userRepository.findByUsername(username);
        return user.filter(u -> u.getPassword().equals(password)); // Kiểm tra mật khẩu
    }
    
    @Autowired
    private EmailService emailService;

    public String handleForgotPassword(String email) {
        Optional<User> userOptional = userRepository.findByEmail(email);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            String newPassword = generateRandomPassword();
            user.setPassword(newPassword);
            userRepository.save(user);
            emailService.sendResetPasswordEmail(user, newPassword);
            return "Mật khẩu mới đã được gửi vào email của bạn!";
        } else {
            return "Email không tồn tại trong hệ thống.";
        }
    }

    public String changePassword(Long userId, String currentPassword, String newPassword) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getPassword().equals(currentPassword)) {
                user.setPassword(newPassword);
                userRepository.save(user);
                return "Mật khẩu đã được cập nhật thành công!";
            } else {
                return "Mật khẩu hiện tại không đúng!";
            }
        } else {
            return "Người dùng không tồn tại!";
        }
    }

    private String generateRandomPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }
    
    
    
    
    
    
}