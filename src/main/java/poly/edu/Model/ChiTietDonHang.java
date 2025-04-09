package poly.edu.Model;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "ChiTietDonHang") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChiTietDonHang implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Tự động tăng ID nếu cần
    @Column(name = "OrderItemID")
    private Long orderItemID;

    @ManyToOne
    @JoinColumn(name = "OrderID", nullable = false, referencedColumnName = "OrderID") // Liên kết với bảng DonHang
    private DonHang donHang;

    @ManyToOne
    @JoinColumn(name = "AccessoryID", nullable = false, referencedColumnName = "AccessoryID") // Liên kết với bảng SanPham
    private PhuKienOto phuKienOto;

    @Column(name = "SoLuong", nullable = false)
    private Integer soLuong;

}
