package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import poly.edu.DAO.KhachHangDAO;
import poly.edu.Model.KhachHang;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import java.util.List;
import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private KhachHangDAO userRepository; // Sửa lại từ UserDetailsRepositoryReactiveAuthenticationManager
    
	/* Optional<KhachHang> findByTenKhachHang(String tenKhachHang); */
    @Override
    public UserDetails loadUserByUsername(String tenKhachHang) throws UsernameNotFoundException {
        KhachHang user = userRepository.findByTenKhachHang(tenKhachHang)
            .orElseThrow(() -> new UsernameNotFoundException("User không tồn tại!"));

        return new org.springframework.security.core.userdetails.User(
            user.getTenKhachHang(),
            user.getMatKhau(),
            List.of(new SimpleGrantedAuthority("ROLE_" + user.getVaiTro())) // Thêm ROLE_ vào trước
        );
    }

}
