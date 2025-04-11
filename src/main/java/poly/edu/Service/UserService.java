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

    // Đăng ký tài khoản
    public String registerUser(String username, String password, String email, String hovaten, String sodienthoai) {
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
        newUser.setRole("ADMIN"); // Mặc định là USER

        userRepository.save(newUser);
        return "Đăng ký thành công!";
    }

    // Kiểm tra đăng nhập
    public Optional<User> authenticate(String username, String password) {
        Optional<User> user = userRepository.findByUsername(username);
        return user.filter(u -> u.getPassword().equals(password)); // Kiểm tra mật khẩu
    }
    
    
    
    
    
    
    
	/* gủi mail */
 
	/*
	 * @Autowired private EmailService emailService; // Đảm bảo rằng bạn đã cấu hình
	 * dịch vụ email
	 * 
	 * // Kiểm tra email trong cơ sở dữ liệu và gửi email quên mật khẩu public
	 * String handleForgotPassword(String email) { Optional<User> userOptional =
	 * userRepository.findByEmail(email);
	 * 
	 * if (userOptional.isPresent()) { User user = userOptional.get(); // Tạo mật
	 * khẩu mới ngẫu nhiên và cập nhật String newPassword =
	 * generateRandomPassword(); user.setPassword(newPassword);
	 * 
	 * // Cập nhật mật khẩu mới vào cơ sở dữ liệu userRepository.save(user);
	 * 
	 * // Gửi email với mật khẩu mới emailService.sendResetPasswordEmail(user,
	 * newPassword); return "Mật khẩu mới đã được gửi vào email của bạn!"; } else {
	 * return "Email không tồn tại trong hệ thống."; } }
	 * 
	 * // Tạo mật khẩu ngẫu nhiên private String generateRandomPassword() { return
	 * UUID.randomUUID().toString().substring(0, 8); // Mật khẩu ngẫu nhiên dài 8 ký
	 * tự }
	 * 
	 * // Kiểm tra mật khẩu hiện tại và cập nhật mật khẩu mới public String
	 * changePassword(Long userId, String currentPassword, String newPassword) {
	 * Optional<User> userOptional = userRepository.findById(userId);
	 * 
	 * if (userOptional.isPresent()) { User user = userOptional.get(); if
	 * (user.getPassword().equals(currentPassword)) { user.setPassword(newPassword);
	 * userRepository.save(user); return "Mật khẩu đã được cập nhật thành công!"; }
	 * else { return "Mật khẩu hiện tại không đúng!"; } } else { return
	 * "Người dùng không tồn tại!"; } }
	 */
    // quên mật khẩu gửi mail
    
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