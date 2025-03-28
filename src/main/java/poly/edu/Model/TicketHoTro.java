package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "TicketHoTro")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TicketHoTro implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TicketID")
    private Long ticketID;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "UserID", nullable = false, referencedColumnName = "UserID") // Liên kết với khách hàng
    private KhachHang khachHang;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "StaffID", nullable = true, referencedColumnName = "StaffID") // Nhân viên hỗ trợ
    private NhanVien nhanVien;

    @Column(name = "MoTaVanDe", nullable = false, length = 1000)
    private String moTaVanDe;

    @Column(name = "TrangThai", nullable = false)
    private String trangThai; // (Pending, In Progress, Resolved, Closed)

    @Column(name = "NgayTao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTao;

    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

}

