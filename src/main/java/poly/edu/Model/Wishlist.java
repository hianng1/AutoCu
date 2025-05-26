package poly.edu.Model;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Wishlist")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Wishlist implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "WishlistID")
    private Long wishlistID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "AccessoryID", referencedColumnName = "AccessoryID")
    private PhuKienOto phuKienOto;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ProductID", referencedColumnName = "ProductID")
    private SanPham sanPham;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "NgayThem", nullable = false)
    private Date ngayThem = new Date();

    @Column(name = "LoaiSanPham", nullable = false, length = 20)
    private String loaiSanPham; // "PHUKIEN" hoặc "XE"

    // Constructor for PhuKienOto
    public Wishlist(User user, PhuKienOto phuKienOto) {
        this.user = user;
        this.phuKienOto = phuKienOto;
        this.loaiSanPham = "PHUKIEN";
        this.ngayThem = new Date();
    }

    // Constructor for SanPham (cars)
    public Wishlist(User user, SanPham sanPham) {
        this.user = user;
        this.sanPham = sanPham;
        this.loaiSanPham = "XE";
        this.ngayThem = new Date();
    }
}
