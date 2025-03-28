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
}
