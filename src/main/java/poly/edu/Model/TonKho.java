package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "TonKho")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TonKho implements Serializable {
    @Id
    @Column(name = "InventoryID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long inventoryID;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "AccessoryID", nullable = true, referencedColumnName = "AccessoryID") // Liên kết với phụ kiện ô tô
    private PhuKienOto phuKienOTo;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "StaffID", nullable = true, referencedColumnName = "StaffID") // Nhân viên phụ trách kho
    private NhanVien nhanVien;

    @Column(name = "ViTriKho", nullable = false)
    private String viTriKho;

    @Column(name = "SoLuong", nullable = false)
    private Integer soLuong;

    @Column(name = "NgayCapNhat", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date ngayCapNhat;

}
