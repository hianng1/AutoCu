package poly.edu.Model;

import java.io.Serializable;
import java.math.BigDecimal;
// Bỏ import không dùng: List, Map, ArrayList, HashMap, GioHangChiTiet

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter; // Nên dùng Getter/Setter thay @Data cho Entity
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "GioHang")
@Getter             // Sử dụng Getter/Setter thay cho @Data để kiểm soát tốt hơn
@Setter
@ToString(exclude = {"user", "phuKienOto"}) // Tránh vòng lặp vô hạn khi toString
@NoArgsConstructor
@AllArgsConstructor
public class GioHang implements Serializable {

    private static final long serialVersionUID = 1L; // Nên thêm serialVersionUID

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CartID") // Tên cột có thể không cần nếu dùng naming strategy
    private Long cartID;

    // Quan hệ: Nhiều mục giỏ hàng thuộc về MỘT User
    @ManyToOne(fetch = FetchType.LAZY) // LAZY loading thường tốt hơn cho performance
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false) // Đổi tên cột join, nullable=false vì mục giỏ hàng phải thuộc về ai đó
    private User user;

    // Quan hệ: Nhiều mục giỏ hàng có thể trỏ đến MỘT Sản phẩm
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "phu_kien_oto_id", referencedColumnName = "AccessoryID", nullable = false) // Đổi tên cột join, nullable=false
    private PhuKienOto phuKienOto;

    @Column(name = "SoLuong", nullable = false)
    private int soLuong; // Số lượng sản phẩm trong giỏ

    // *** Thêm trường GIA để lưu giá tại thời điểm thêm vào giỏ ***
    @Column(name = "gia", nullable = false, precision = 19, scale = 4) // precision và scale tùy theo yêu cầu tiền tệ
    private BigDecimal gia;

    // Bỏ MaKhuyenMai ở đây, nên xử lý ở cấp độ Đơn hàng hoặc tổng Giỏ hàng
    // @ManyToOne(...)
    // private MaKhuyenMai maKhuyenMai;

    // Bỏ GioHangChiTiets vì GioHang này đã là một dòng chi tiết rồi
    // @OneToMany(...)
    // private List<GioHangChiTiet> gioHangChiTiets = new ArrayList<>();

    // Bỏ phương thức getGia() tính toán động
    // public BigDecimal getGia() { ... }

    // --- Constructors, Getters, Setters được tạo bởi Lombok ---

    // Nên xem xét việc implement equals() và hashCode() chỉ dựa trên cartID
    @Override
    public boolean equals(Object o) {
        if (this == o) {
			return true;
		}
        if (!(o instanceof GioHang )) {
			return false;
		}
        return cartID != null && cartID.equals(((GioHang) o).getCartID());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode(); // Hoặc return 31; nếu ID có thể null ban đầu
    }
}