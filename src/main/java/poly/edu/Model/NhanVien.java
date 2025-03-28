package poly.edu.Model;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "NhanVien") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class NhanVien implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "StaffID")
    private Long staffID;

    @Column(name = "TenNhanVien", nullable = false)
    private String tenNhanVien;

    @Column(name = "Email", unique = true, nullable = false)
    private String email;

    @Column(name = "SoDienThoai", unique = true, nullable = true)
    private Integer soDienThoai;

    @Column(name = "MatKhau", nullable = false)
    private String matKhau;

    @Column(name = "VaiTro", nullable = false)
    private Boolean vaiTro; // True: Quản lý, False: Nhân viên bình thường

}
