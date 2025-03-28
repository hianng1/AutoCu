package poly.edu.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import poly.edu.DAO.KhachHangDAO;
import poly.edu.Model.KhachHang;

import java.util.Optional;

@Service
public class UserService {
    private final KhachHangDAO userRepository;


    public UserService(KhachHangDAO userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
     
    }

    public Optional<KhachHang> findByTenKhachHang(String tenKhachHang) {
        return userRepository.findByTenKhachHang(tenKhachHang);
    }

    public void registerUser(KhachHang user) {
    	user.setMatKhau(user.getMatKhau()); // Lưu mật khẩu trực tiếp

		user.setVaiTro(false);/* USER */ // Mặc định là USER
        userRepository.save(user);
    }
    
}
