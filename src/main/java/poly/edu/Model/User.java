package poly.edu.Model;

// Import các lớp Java Collection
import java.util.Collection;
import java.util.Collections; // Cần cho Collections.singletonList
import java.util.Date;

// Import các lớp của Spring Security UserDetails
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
// Import Lombok (giữ nguyên)
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users") // Tên bảng
@Getter // Lombok tạo getters
@Setter // Lombok tạo setters
@NoArgsConstructor // Lombok tạo constructor rỗng
@AllArgsConstructor // Lombok tạo constructor với tất cả fields
// THÊM "implements UserDetails"
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // Sử dụng Integer hoặc Long tùy theo cấu hình DB của bạn

    @Column(nullable = false, unique = true)
    private String username; // Tên đăng nhập

    @Column(nullable = false)
    private String password; // Mật khẩu (ĐÃ MÃ HÓA)

    @Column(nullable = false)
    private String role; // Vai trò: "ADMIN" hoặc "USER"

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name = "sodienthoai", unique = true, nullable = false)
    private String sodienthoai;

    @Column(name = "hovaten", columnDefinition = "nvarchar(255)")
    private String hovaten;

    @Column(name = "DiaChi", nullable = false, length = 255, columnDefinition = "nvarchar(255)")
    private String diaChi;

    // Thêm các trường cho xác thực email
    @Column(name = "verification_token")
    private String verificationToken;

    @Column(name = "token_expiry")
    private Date tokenExpiry;

    @Column(name = "enabled", nullable = false)
    private boolean enabled = false; // Mặc định là false cho đến khi email được xác thực

    // --- TRIỂN KHAI CÁC PHƯƠNG THỨC BẮT BUỘC CỦA UserDetails ---

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Phương thức này trả về danh sách các quyền hạn (GrantedAuthority) của người
        // dùng.
        // Chúng ta sử dụng trường 'role' để tạo quyền hạn.
        // Spring Security thường mong đợi vai trò có tiền tố "ROLE_".
        if (this.role == null || this.role.isEmpty()) {
            // Trả về danh sách rỗng nếu người dùng không có vai trò nào
            return Collections.emptyList();
        }
        // Tạo một SimpleGrantedAuthority từ vai trò của người dùng.
        // Thêm tiền tố "ROLE_" vào vai trò lấy từ DB.
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + this.role));

        // Nếu vai trò trong DB của bạn đã là "ROLE_USER", "ROLE_ADMIN" đầy đủ,
        // thì chỉ cần: return Collections.singletonList(new
        // SimpleGrantedAuthority(this.role));
    }

    // Lombok @Getter đã tạo getPassword(), nhưng bạn vẫn cần khai báo nó trong
    // interface
    // @Override
    // public String getPassword() { return password; }

    // Lombok @Getter đã tạo getUsername(), nhưng bạn vẫn cần khai báo nó trong
    // interface
    // @Override
    // public String getUsername() { return username; }

    @Override
    public boolean isAccountNonExpired() {
        // Trả về true nếu tài khoản không hết hạn.
        // Nếu bạn không có logic quản lý hết hạn tài khoản, cứ để true.
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        // Trả về true nếu tài khoản không bị khóa.
        // Nếu bạn không có logic khóa tài khoản, cứ để true.
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        // Trả về true nếu thông tin xác thực (mật khẩu) không hết hạn.
        // Nếu bạn không có logic yêu cầu đổi mật khẩu định kỳ, cứ để true.
        return true;
    }

    @Override
    public boolean isEnabled() {
        // Trả về giá trị trường enabled để kiểm tra tài khoản đã được xác thực chưa
        return enabled;
    }

    // Lombok đã tạo Getters, Setters, NoArgsConstructor, AllArgsConstructor.
    // Nếu bạn cần các constructor tùy chỉnh khác, hãy thêm chúng vào đây.

    // Không cần ghi đè lại getUsername() và getPassword() nếu Lombok đã tạo chúng
    // và chữ ký phương thức khớp với UserDetails.

}