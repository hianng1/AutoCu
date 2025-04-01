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

    @Column(name = "TenKhachHang", nullable = false, length = 100)
    private String tenKhachHang;

    @Column(name = "Email", unique = true, nullable = false, length = 100)
    private String email;

    @Column(name = "SoDienThoai", unique = true, nullable = true)
    private Integer soDienThoai; 

    @Column(name = "MatKhau", nullable = false, length = 255)
    private String matKhau;

    @Column(name = "DiaChi", nullable = false, length = 255)
    private String diaChi;

    @Column(name = "VaiTro", nullable = false)
    private Boolean vaiTro; // `true` = Admin, `false` = User

    // Quan hệ với bảng DonHang
    @OneToMany(mappedBy = "khachHang", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DonHang> donHangs;

    // Quan hệ với bảng GioHang
    @OneToOne
    @JoinColumn(name = "UserID")
    private GioHang gioHang;

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public String getTenKhachHang() {
        return tenKhachHang;
    }

    public void setTenKhachHang(String tenKhachHang) {
        this.tenKhachHang = tenKhachHang;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(Integer soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public Boolean getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(Boolean vaiTro) {
        this.vaiTro = vaiTro;
    }

    public List<DonHang> getDonHangs() {
        return donHangs;
    }

    public void setDonHangs(List<DonHang> donHangs) {
        this.donHangs = donHangs;
    }

    public GioHang getGioHang() {
        return gioHang;
    }

    public void setGioHang(GioHang gioHang) {
        this.gioHang = gioHang;
    }
}
