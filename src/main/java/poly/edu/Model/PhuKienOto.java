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

		public Long getAccessoryID() {
			return accessoryID;
		}

		public void setAccessoryID(Long accessoryID) {
			this.accessoryID = accessoryID;
		}

		public String getTenPhuKien() {
			return tenPhuKien;
		}

		public void setTenPhuKien(String tenPhuKien) {
			this.tenPhuKien = tenPhuKien;
		}

		public String getMoTa() {
			return moTa;
		}

		public void setMoTa(String moTa) {
			this.moTa = moTa;
		}

		public Double getGia() {
			return gia;
		}

		public void setGia(Double gia) {
			this.gia = gia;
		}

		public Integer getSoLuong() {
			return soLuong;
		}

		public void setSoLuong(Integer soLuong) {
			this.soLuong = soLuong;
		}

		public String getHangSanXuat() {
			return hangSanXuat;
		}

		public void setHangSanXuat(String hangSanXuat) {
			this.hangSanXuat = hangSanXuat;
		}

		public String getAnhDaiDien() {
			return anhDaiDien;
		}

		public void setAnhDaiDien(String anhDaiDien) {
			this.anhDaiDien = anhDaiDien;
		}

		public DanhMuc getDanhMuc() {
			return danhMuc;
		}

		public void setDanhMuc(DanhMuc danhMuc) {
			this.danhMuc = danhMuc;
		}
	}

