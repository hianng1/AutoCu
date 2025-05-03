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
    
    @Column(name = "Loai", columnDefinition = "nvarchar(50)")
    private String loai;

    @OneToMany(mappedBy = "danhMuc", cascade = CascadeType.ALL)
    private List<SanPham> sanPhams; // Một danh mục có nhiều sản phẩm

    @OneToMany(mappedBy = "danhMuc", cascade = CascadeType.ALL)
    private List<PhuKienOto> phuKienOtos;

}
