package poly.edu.Model;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    @Column(name = "TenDanhMuc", nullable = false, columnDefinition = "nvarchar(255)")
    private String tenDanhMuc;

    @Column(name = "MoTa", columnDefinition = "nvarchar(255)")
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
