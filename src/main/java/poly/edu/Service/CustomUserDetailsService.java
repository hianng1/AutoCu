package poly.edu.Service; // Hoặc package 'config', 'security', ... tùy cấu trúc dự án của bạn

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import poly.edu.Model.User; // Import lớp User model của bạn
import poly.edu.Repository.UserRepository; // Import UserRepository

/**
 * Lớp triển khai UserDetailsService của Spring Security.
 * Lớp này có nhiệm vụ tải thông tin chi tiết của người dùng
 * dựa trên tên đăng nhập trong quá trình xác thực.
 * Spring Security sẽ tự động sử dụng bean này nếu nó tồn tại.
 */
@Service // Đánh dấu đây là một Service Bean để Spring tự động quét và quản lý
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository; // Inject UserRepository để tương tác với cơ sở dữ liệu

    /**
     * Phương thức này được gọi bởi Spring Security khi một người dùng cố gắng đăng nhập.
     * Nó nhận tên đăng nhập và phải trả về đối tượng UserDetails chứa
     * thông tin cần thiết cho quá trình xác thực (username, password, quyền hạn, trạng thái tài khoản).
     *
     * @param username Tên đăng nhập mà người dùng đã nhập vào form.
     * @return Đối tượng UserDetails chứa thông tin của người dùng.
     * @throws UsernameNotFoundException Nếu không tìm thấy người dùng với tên đăng nhập đã cho.
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. Tìm người dùng trong cơ sở dữ liệu bằng UserRepository
        User user = userRepository.findByUsername(username);

        // 2. Kiểm tra nếu không tìm thấy người dùng
        if (user == null) {
            // Ném ngoại lệ UsernameNotFoundException để báo cho Spring Security biết
            // người dùng không tồn tại. Spring Security sẽ xử lý ngoại lệ này
            // và chuyển hướng đến failureUrl đã cấu hình (ví dụ: /login?error).
            throw new UsernameNotFoundException("Không tìm thấy người dùng với tên đăng nhập: " + username);
        }

        // 3. Nếu tìm thấy người dùng, trả về đối tượng UserDetails.
        //    !! QUAN TRỌNG: Ở đây, chúng ta giả định lớp poly.edu.Model.User của bạn
        //    !! đã implement interface org.springframework.security.core.userdetails.UserDetails.
        //    !! Nếu chưa, bạn cần sửa lớp User hoặc tạo một lớp riêng implements UserDetails
        //    !! và copy thông tin từ đối tượng User tìm được.
        return user; // Trả về đối tượng User (đã implement UserDetails)

        /*
        // Ví dụ nếu lớp User của bạn KHÔNG implement UserDetails, bạn cần tạo UserDetails thủ công:
        return new org.springframework.security.core.userdetails.User(
            user.getUsername(), // Tên đăng nhập
            user.getPassword(), // Mật khẩu ĐÃ MÃ HÓA từ DB
            // Lấy danh sách quyền hạn (Authorities) từ người dùng.
            // Giả định User model có phương thức getRole() trả về chuỗi "USER" hoặc "ADMIN".
            // SimpleGrantedAuthority là cách biểu diễn quyền hạn trong Spring Security.
            // Cần import org.springframework.security.core.authority.SimpleGrantedAuthority;
            // Cần import java.util.Collection; và java.util.Collections;
            user.getAuthorities() // Giả định User model có phương thức này trả về Collection<GrantedAuthority>

            // Các tham số trạng thái tài khoản (true = không bị ảnh hưởng bởi trạng thái đó)
            // Bạn nên lấy các giá trị này từ User model nếu có các trường tương ứng trong DB
            // , user.isAccountNonExpired()
            // , user.isAccountNonLocked()
            // , user.isCredentialsNonExpired()
            // , user.isEnabled()
        );
        */
    }
}