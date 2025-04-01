package poly.edu.Model;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.*;

@Entity
@Table(name = "DanhMuc") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DanhMuc implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryID")
    private Long categoryID;

    @Column(name = "TenDanhMuc", nullable = false)
    private String tenDanhMuc;

    @Column(name = "MoTa")
    private String moTa; // Thuộc tính tùy chọn

    @OneToMany(mappedBy = "danhMuc", cascade = CascadeType.ALL)
    private List<SanPham> sanPhams; // Một danh mục có nhiều sản phẩm
    
    @OneToMany(mappedBy = "danhMuc", cascade = CascadeType.ALL)
    private List<PhuKienOto> phuKienOtos;

    public Long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
    }

    public String getTenDanhMuc() {
        return tenDanhMuc;
    }

    public void setTenDanhMuc(String tenDanhMuc) {
        this.tenDanhMuc = tenDanhMuc;
    }

    public List<SanPham> getSanPhams() {
        return sanPhams;
    }

    public void setSanPhams(List<SanPham> sanPhams) {
        this.sanPhams = sanPhams;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public List<PhuKienOto> getPhuKienOtos() {
        return phuKienOtos;
    }

    public void setPhuKienOtos(List<PhuKienOto> phuKienOtos) {
        this.phuKienOtos = phuKienOtos;
    }
}
