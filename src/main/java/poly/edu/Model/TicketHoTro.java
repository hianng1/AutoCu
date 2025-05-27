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
    @JoinColumn(name = "UserID", nullable = true, referencedColumnName = "id") // Liên kết với khách hàng
    private User user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "StaffID", nullable = true, referencedColumnName = "StaffID") // Nhân viên hỗ trợ
    private NhanVien nhanVien;

    @Column(name = "MoTaVanDe", nullable = false, length = 1000, columnDefinition = "nvarchar(255)")
    private String moTaVanDe;

    @Column(name = "TrangThai", nullable = false, columnDefinition = "nvarchar(255)")
    private String trangThai; // (Pending, In Progress, Resolved, Closed)

    @Column(name = "NgayTao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayTao;

    @Column(name = "NgayCapNhat")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayCapNhat;

}

