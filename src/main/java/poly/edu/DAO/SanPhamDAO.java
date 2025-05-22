package poly.edu.DAO;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import poly.edu.Model.SanPham;

public interface SanPhamDAO extends JpaRepository<SanPham, Long> {

    // Tìm sản phẩm theo hãng xe
    List<SanPham> findByHangXe(String hangXe);

    // Tìm sản phẩm theo tên xe
    List<SanPham> findByTenSanPham(String tenSanPham);

    // Tìm sản phẩm theo ID
    @Query("SELECT d FROM SanPham d WHERE d.productID = :ProductID")
    List<SanPham> findByProductId(@Param("ProductID") Long ProductID);

    // Tìm sản phẩm tương tự theo danh mục (ngoại trừ sản phẩm hiện tại)
    @Query("SELECT sp FROM SanPham sp WHERE sp.danhMuc.categoryID = :categoryID AND sp.productID <> :productID")
    List<SanPham> findSanPhamTuongTu(@Param("categoryID") String categoryID, @Param("productID") String productID);

    // Tìm kiếm xe theo từ khóa (tìm trong tên sản phẩm)
    @Query("SELECT sp FROM SanPham sp WHERE LOWER(sp.tenSanPham) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<SanPham> findByTenSanPhamContaining(@Param("keyword") String keyword);

    // Tìm kiếm xe theo từ khóa (tìm trong tên sản phẩm hoặc hãng xe)
    @Query("SELECT sp FROM SanPham sp WHERE LOWER(sp.tenSanPham) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(sp.hangXe) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<SanPham> searchByKeyword(@Param("keyword") String keyword);
}
