package poly.edu.Model;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "GioHangChiTiet") // Tên bảng trong CSDL
@Data
@NoArgsConstructor
@AllArgsConstructor
public class GioHangChiTiet implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.UUID) // Hoặc GenerationType.IDENTITY nếu dùng số nguyên
	@Column(name = "CartItemID", updatable = false, nullable = false)
	private String cartItemID;


    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "CartID", nullable = false, referencedColumnName = "CartID") // Liên kết với bảng Giỏ Hàng
    private GioHang gioHang;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "AccessoryID", nullable = false, referencedColumnName = "AccessoryID") // Liên kết với bảng Sản Phẩm
    private PhuKienOto phuKienOto;

    @Column(name = "SoLuong", nullable = false)
    private Integer soLuong;

    public String getCartItemID() {
        return cartItemID;
    }

    public void setCartItemID(String cartItemID) {
        this.cartItemID = cartItemID;
    }

    public GioHang getGioHang() {
        return gioHang;
    }

    public void setGioHang(GioHang gioHang) {
        this.gioHang = gioHang;
    }

    public PhuKienOto getPhuKienOto() {
        return phuKienOto;
    }

    public void setPhuKienOto(PhuKienOto phuKienOto) {
        this.phuKienOto = phuKienOto;
    }

    public Integer getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(Integer soLuong) {
        this.soLuong = soLuong;
    }
}
