package poly.edu.Model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "PhuKienOto")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PhuKienOto implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "AccessoryID")
	private Long accessoryID;

	@Column(name = "TenPhuKien", nullable = false, columnDefinition = "nvarchar(255)")
	private String tenPhuKien;

	@Column(name = "MoTa", columnDefinition = "nvarchar(max)")
	private String moTa;

	@Column(name = "Gia", nullable = false)
	private Double gia;

	@Column(name = "SoLuong", nullable = false)
	private Integer soLuong;

	@Column(name = "HangSanXuat", nullable = false, columnDefinition = "nvarchar(255)")
	private String hangSanXuat;

	@Column(name = "AnhDaiDien", nullable = false, columnDefinition = "nvarchar(255)")
	private String anhDaiDien;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "CategoryID", nullable = false, referencedColumnName = "CategoryID")
	private DanhMuc danhMuc;

	@OneToMany(mappedBy = "phuKienOTo", cascade = CascadeType.REMOVE)
	private List<TonKho> tonKhos;

	// Add relationship to reviews
	@OneToMany(mappedBy = "phuKienOto", cascade = CascadeType.ALL)
	@ToString.Exclude
	@EqualsAndHashCode.Exclude
	private List<DanhGia> danhGias = new ArrayList<>();

	// Transient fields for rating calculation
	@Transient
	private Double trungBinhSao;

	@Transient
	private Integer soLuongDanhGia;

	// Method to get average rating
	public Double getTrungBinhSao() {
		if (trungBinhSao != null) {
			return trungBinhSao;
		}

		if (danhGias == null || danhGias.isEmpty()) {
			return 0.0;
		}

		double sum = 0.0;
		int count = 0;

		for (DanhGia danhGia : danhGias) {
			if (danhGia.isHienThi()) {
				sum += danhGia.getSaoDanhGia();
				count++;
			}
		}

		return count > 0 ? sum / count : 0.0;
	}

	// Method to get rating count
	public Integer getSoLuongDanhGia() {
		if (soLuongDanhGia != null) {
			return soLuongDanhGia;
		}

		if (danhGias == null) {
			return 0;
		}

		int count = 0;
		for (DanhGia danhGia : danhGias) {
			if (danhGia.isHienThi()) {
				count++;
			}
		}

		return count;
	}

	// Set rating data from external calculations
	public void setRatingData(Double avgRating, Integer ratingCount) {
		this.trungBinhSao = avgRating;
		this.soLuongDanhGia = ratingCount;
	}
}
