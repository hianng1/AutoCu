package poly.edu.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.SanPham;
@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, Long> {
    List<SanPham> findByDanhMuc_CategoryIDAndProductIDNot(Long categoryID, Long productID);
}
