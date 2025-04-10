package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Đăng ký tài khoản
    public String registerUser(String username, String password, String email, String hovaten, Integer sodienthoai) {
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
            newUser.setPhoneNumber(null); // Không nhập thì để null
        }
        newUser.setRole("USER"); // Mặc định là USER

        userRepository.save(newUser);
        return "Đăng ký thành công!";
    }

    // Kiểm tra đăng nhập
    public Optional<User> authenticate(String username, String password) {
        Optional<User> user = userRepository.findByUsername(username);
        return user.filter(u -> u.getPassword().equals(password)); // Kiểm tra mật khẩu
    }
}