package poly.edu.Model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList; // Import ArrayList if not already there
import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode; // Import EqualsAndHashCode
import lombok.NoArgsConstructor;
import lombok.ToString; // Import ToString

@Entity
@Table(name = "DonHang")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DonHang implements Serializable {

    // Enum cho trạng thái đơn hàng - Đặt trong class DonHang là phù hợp
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


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderID")
    private Long orderID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id", nullable = false) // Assuming User's ID column is named 'id'
    @ToString.Exclude // Exclude from Lombok's ToString to prevent issues
    @EqualsAndHashCode.Exclude // Exclude from Lombok's EqualsAndHashCode
    private User user;

    @Column(name = "GhiChu", columnDefinition = "NVARCHAR(500)")
    private String ghiChu;

    @Column(name = "DiaChiGiaoHang", columnDefinition = "NVARCHAR(MAX)", nullable = false) // <-- THÊM TRƯỜNG ĐỊA CHỈ
    private String diaChiGiaoHang;


    @Column(name = "PhuongThucVanChuyen", nullable = false, length = 50)
    private String phuongThucVanChuyen; // "standard" hoặc "fast"

    @Column(name = "PhuongThucThanhToan", nullable = false, length = 50)
    private String phuongThucThanhToan; // "cod", "bank", "vnpay"

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "NgayDatHang", nullable = false)
    private Date ngayDatHang = new Date();

    // Thay đổi kiểu dữ liệu sang Enum và map với DB bằng String
    @Enumerated(EnumType.STRING)
    @Column(name = "TrangThai", nullable = false, length = 50)
    private TrangThai trangThai = TrangThai.CHO_XAC_NHAN; // Sử dụng Enum và gán giá trị mặc định


    @Column(name = "TongTienHang", precision = 19, scale = 2, nullable = false)
    private BigDecimal tongTienHang = BigDecimal.ZERO; // Khởi tạo mặc định

    @Column(name = "PhiVanChuyen", precision = 19, scale = 2, nullable = false)
    private BigDecimal phiVanChuyen = BigDecimal.ZERO;

    @Column(name = "TongThanhToan", precision = 19, scale = 2, nullable = false)
    private BigDecimal tongThanhToan = BigDecimal.ZERO; // Khởi tạo mặc định

    @Column(name = "DaThanhToan", nullable = false)
    private boolean daThanhToan = false;

    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude // Exclude from Lombok's ToString to prevent issues
    @EqualsAndHashCode.Exclude // Exclude from Lombok's EqualsAndHashCode
    private List<ChiTietDonHang> chiTietDonHangs = new ArrayList<>(); // Khởi tạo list rỗng mặc định


    // Phương thức tiện ích để tính toán tổng tiền dựa trên chi tiết đơn hàng và phí vận chuyển
    // Đảm bảo rằng chiTietDonHangs đã được thêm vào order và phiVanChuyen đã được set trước khi gọi method này
    public void tinhTongTien() {
        BigDecimal calculatedTongTienHang = BigDecimal.ZERO;
        if (this.chiTietDonHangs != null) {
            for (ChiTietDonHang ct : this.chiTietDonHangs) {
                 // Kiểm tra null cho donGia trong trường hợp ChiTietDonHang chưa được set đầy đủ
                BigDecimal donGia = ct.getDonGia() != null ? ct.getDonGia() : BigDecimal.ZERO;
                BigDecimal thanhTien = donGia.multiply(BigDecimal.valueOf(ct.getSoLuong()));
                calculatedTongTienHang = calculatedTongTienHang.add(thanhTien);
            }
        }
        this.tongTienHang = calculatedTongTienHang;

        // Tính tổng thanh toán = tổng tiền hàng + phí vận chuyển
        // Đảm bảo phiVanChuyen không null (đã được xử lý bởi default value)
        this.tongThanhToan = this.tongTienHang.add(this.phiVanChuyen);
    }

    // Getter và Setter (Lombok @Data tự tạo)
    // Riêng cho Enum TrangThai, có thể thêm getters/setters thủ công nếu cần logic đặc biệt,
    // nhưng Lombok @Data đã tạo sẵn getTrangThai() và setTrangThai(TrangThai trangThai).
    // Nếu bạn muốn lấy mô tả, dùng getTrangThai().getMoTa();
}