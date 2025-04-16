package poly.edu.Model;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "KhachHang") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class KhachHang implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserID", updatable = false, nullable = false)
    private Long userID;

    @Column(name = "TenKhachHang", nullable = false, length = 100, columnDefinition = "nvarchar(100)")
    private String tenKhachHang;

    @Column(name = "Email", unique = true, nullable = false, length = 100, columnDefinition = "nvarchar(100)")
    private String email;

    @Column(name = "SoDienThoai", unique = true, nullable = true, length = 15, columnDefinition = "nvarchar(15)")
    private String soDienThoai; 

    @Column(name = "MatKhau", nullable = false, length = 255)
    private String matKhau;

    @Column(name = "DiaChi", nullable = false, length = 255, columnDefinition = "nvarchar(255)")
    private String diaChi;

    @Column(name = "VaiTro", nullable = false)
    private Boolean vaiTro; // `true` = Admin, `false` = User

    // Quan hệ với bảng GioHang
    @OneToOne
    @JoinColumn(name = "UserID")
    private GioHang gioHang;

}
