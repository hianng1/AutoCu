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

}
