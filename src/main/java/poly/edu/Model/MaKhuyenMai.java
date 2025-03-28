package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "MaKhuyenMai") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MaKhuyenMai implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CouponID")
    private Long couponID;

    @Column(name = "MaKhuyenMai", unique = true, nullable = false)
    private String maKhuyenMai;

    @Column(name = "PhanTramGiam", nullable = false)
    private Double phanTramGiam; // % giảm giá

    @Temporal(TemporalType.DATE)
    @Column(name = "HanSuDung", nullable = false)
    private Date hanSuDung;

}
