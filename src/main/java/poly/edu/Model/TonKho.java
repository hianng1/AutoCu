package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
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

    @Column(name = "ViTriKho", nullable = false, columnDefinition = "nvarchar(255)")
    private String viTriKho;

    @Column(name = "SoLuong", nullable = false)
    private Integer soLuong;

    @Column(name = "NgayCapNhat", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date ngayCapNhat;

}
