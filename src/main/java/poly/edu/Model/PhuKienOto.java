package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

	@Entity
	@Table(name = "PhuKienOto") // Tên bảng trong CSDL
	@Data
	@NoArgsConstructor
	@AllArgsConstructor
	public class PhuKienOto implements Serializable {

	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(name = "AccessoryID")
	    private Long accessoryID;

	    @Column(name = "TenPhuKien", nullable = false)
	    private String tenPhuKien;

	    @Column(name = "MoTa")
	    private String moTa; // Mô tả chi tiết phụ kiện

	    @Column(name = "Gia", nullable = false)
	    private Double gia;
	    
	    @Column(name = "SoLuong", nullable = false)
	    private Integer soLuong;

	    @Column(name = "HangSanXuat", nullable = false)
	    private String hangSanXuat;
	    
	    @Column(name = "AnhDaiDien", nullable = false)
	    private String anhDaiDien;

	    @ManyToOne(cascade = CascadeType.ALL)
	    @JoinColumn(name = "CategoryID", nullable = false, referencedColumnName = "CategoryID") // Liên kết với bảng danh mục
	    private DanhMuc danhMuc;

		

	    
	}

