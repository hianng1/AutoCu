package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "DonHang") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DonHang implements Serializable {
    @Id
    @Column(name = "OrderID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderID;

    @ManyToOne
    @JoinColumn(name = "UserID", nullable = false, referencedColumnName = "UserID") // Liên kết với bảng KhachHang
    private KhachHang khachHang;

    @Temporal(TemporalType.DATE)
    @Column(name = "NgayDatHang", nullable = false)
    private Date ngayDatHang;

    @Column(name = "TrangThaiDon", nullable = false)
    private String trangThaiDon; // Ví dụ: "Chờ xử lý", "Đang giao", "Hoàn thành"

    @Column(name = "TongGiaTri", nullable = false)
    private Double tongGiaTri;

    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL)
    private List<ChiTietDonHang> chiTietDonHangs;

    public Long getOrderID() {
        return orderID;
    }

    public void setOrderID(Long orderID) {
        this.orderID = orderID;
    }

    public KhachHang getKhachHang() {
        return khachHang;
    }

    public void setKhachHang(KhachHang khachHang) {
        this.khachHang = khachHang;
    }

    public Date getNgayDatHang() {
        return ngayDatHang;
    }

    public void setNgayDatHang(Date ngayDatHang) {
        this.ngayDatHang = ngayDatHang;
    }

    public Double getTongGiaTri() {
        return tongGiaTri;
    }

    public void setTongGiaTri(Double tongGiaTri) {
        this.tongGiaTri = tongGiaTri;
    }

    public String getTrangThaiDon() {
        return trangThaiDon;
    }

    public void setTrangThaiDon(String trangThaiDon) {
        this.trangThaiDon = trangThaiDon;
    }

    public List<ChiTietDonHang> getChiTietDonHangs() {
        return chiTietDonHangs;
    }

    public void setChiTietDonHangs(List<ChiTietDonHang> chiTietDonHangs) {
        this.chiTietDonHangs = chiTietDonHangs;
    }
}
