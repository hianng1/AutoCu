package poly.edu.Model;

import java.io.Serializable;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
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

}
