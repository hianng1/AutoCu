package poly.edu.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "DonHang")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DonHang implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderID")
    private Long orderID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id", nullable = false)
    private User user;

    @Column(name = "HoTen", nullable = false, length = 100)
    private String hoTen;

    @Column(name = "SoDienThoai", nullable = false, length = 20)
    private String soDienThoai;

    @Column(name = "DiaChi", nullable = false, columnDefinition = "NVARCHAR(255)")
    private String diaChi;

    @Column(name = "GhiChu", columnDefinition = "NVARCHAR(500)")
    private String ghiChu;

    @Column(name = "PhuongThucVanChuyen", nullable = false, length = 50)
    private String phuongThucVanChuyen; // "standard" hoặc "fast"

    @Column(name = "PhuongThucThanhToan", nullable = false, length = 50)
    private String phuongThucThanhToan; // "cod", "bank", "vnpay"

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "NgayDatHang", nullable = false)
    private Date ngayDatHang = new Date();

    @Column(name = "TrangThai", nullable = false, length = 50)
    private String trangThai = "CHO_XAC_NHAN"; // Các trạng thái: CHO_XAC_NHAN, DANG_XU_LY, DANG_GIAO, DA_GIAO, DA_HUY

    @Column(name = "TongTienHang", precision = 19, scale = 2, nullable = false)
    private BigDecimal tongTienHang; // Tổng tiền hàng (chưa bao gồm phí vận chuyển)

    @Column(name = "PhiVanChuyen", precision = 19, scale = 2, nullable = false)
    private BigDecimal phiVanChuyen = BigDecimal.ZERO;

    @Column(name = "TongThanhToan", precision = 19, scale = 2, nullable = false)
    private BigDecimal tongThanhToan; // Tổng số tiền phải thanh toán

    @Column(name = "DaThanhToan", nullable = false)
    private boolean daThanhToan = false;

    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ChiTietDonHang> chiTietDonHangs;

    // Phương thức tiện ích
    public void tinhTongTien() {
        this.tongTienHang = BigDecimal.ZERO;
        if (chiTietDonHangs != null) {
            for (ChiTietDonHang ct : chiTietDonHangs) {
                BigDecimal gia = ct.getDonGia() != null ? ct.getDonGia() : BigDecimal.ZERO;
                BigDecimal thanhTien = gia.multiply(BigDecimal.valueOf(ct.getSoLuong()));
                this.tongTienHang = this.tongTienHang.add(thanhTien);
            }
        }
        this.tongThanhToan = this.tongTienHang.add(this.phiVanChuyen);
    }

    // Enum cho trạng thái đơn hàng
    public enum TrangThai {
        CHO_XAC_NHAN("Chờ xác nhận"),
        DANG_XU_LY("Đang xử lý"),
        DANG_GIAO("Đang giao"),
        DA_GIAO("Đã giao"),
        DA_HUY("Đã hủy");

        private final String moTa;

        TrangThai(String moTa) {
            this.moTa = moTa;
        }

        public String getMoTa() {
            return moTa;
        }
    }
}