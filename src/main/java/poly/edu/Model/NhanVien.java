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

    public Long getStaffID() {
        return staffID;
    }

    public void setStaffID(Long staffID) {
        this.staffID = staffID;
    }

    public String getTenNhanVien() {
        return tenNhanVien;
    }

    public void setTenNhanVien(String tenNhanVien) {
        this.tenNhanVien = tenNhanVien;
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

    public Boolean getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(Boolean vaiTro) {
        this.vaiTro = vaiTro;
    }
}
