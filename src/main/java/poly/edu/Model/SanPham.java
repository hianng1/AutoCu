package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "SanPham")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SanPham implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductID")
    private Long productID;

    @Column(name = "TenSanPham", nullable = false)
    private String tenSanPham;
    
    @Column(name = "SoGhe")
    private Integer soGhe;
    
    @Column(name = "TruyenDong")
    private String truyenDong;
    
    @Column(name = "NhienLieu")
    private String nhienLieu;
    
    @Column(name = "DiaDiemLayXe")
    private String diaDiemLayXe;
    
    @Column(name = "HangXe")
    private String hangXe;

    @Column(name = "Gia", nullable = false)
    private Double gia;

    @Column(name = "SoLuongTrongKho")
    private Integer soLuongTrongKho;

    @Temporal(TemporalType.DATE)
    @Column(name = "NgaySanXuat")
    private Date ngaySanXuat;
    
    @Column(name = "BaoHanh")
    private String baoHanh;
    
    @Column(name = "AnhDaiDien")
    private String anhDaiDien;

    @ManyToOne(cascade = CascadeType.MERGE) // Thêm cascade
    @JoinColumn(name = "CategoryID", nullable = false, referencedColumnName = "CategoryID")
    private DanhMuc danhMuc;

    public Long getProductID() {
        return productID;
    }

    public void setProductID(Long productID) {
        this.productID = productID;
    }

    public String getTenSanPham() {
        return tenSanPham;
    }

    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    public Integer getSoGhe() {
        return soGhe;
    }

    public void setSoGhe(Integer soGhe) {
        this.soGhe = soGhe;
    }

    public String getTruyenDong() {
        return truyenDong;
    }

    public void setTruyenDong(String truyenDong) {
        this.truyenDong = truyenDong;
    }

    public String getNhienLieu() {
        return nhienLieu;
    }

    public void setNhienLieu(String nhienLieu) {
        this.nhienLieu = nhienLieu;
    }

    public String getDiaDiemLayXe() {
        return diaDiemLayXe;
    }

    public void setDiaDiemLayXe(String diaDiemLayXe) {
        this.diaDiemLayXe = diaDiemLayXe;
    }

    public String getHangXe() {
        return hangXe;
    }

    public void setHangXe(String hangXe) {
        this.hangXe = hangXe;
    }

    public Double getGia() {
        return gia;
    }

    public void setGia(Double gia) {
        this.gia = gia;
    }

    public Integer getSoLuongTrongKho() {
        return soLuongTrongKho;
    }

    public void setSoLuongTrongKho(Integer soLuongTrongKho) {
        this.soLuongTrongKho = soLuongTrongKho;
    }

    public Date getNgaySanXuat() {
        return ngaySanXuat;
    }

    public void setNgaySanXuat(Date ngaySanXuat) {
        this.ngaySanXuat = ngaySanXuat;
    }

    public String getBaoHanh() {
        return baoHanh;
    }

    public void setBaoHanh(String baoHanh) {
        this.baoHanh = baoHanh;
    }

    public String getAnhDaiDien() {
        return anhDaiDien;
    }

    public void setAnhDaiDien(String anhDaiDien) {
        this.anhDaiDien = anhDaiDien;
    }

    public DanhMuc getDanhMuc() {
        return danhMuc;
    }

    public void setDanhMuc(DanhMuc danhMuc) {
        this.danhMuc = danhMuc;
    }
}
