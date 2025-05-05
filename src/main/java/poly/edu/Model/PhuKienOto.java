package poly.edu.Model;

import java.io.Serializable;
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
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
		
	}

