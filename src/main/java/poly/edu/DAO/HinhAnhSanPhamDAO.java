package poly.edu.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.HinhAnhSanPham;

@Repository
public interface HinhAnhSanPhamDAO extends JpaRepository<HinhAnhSanPham, Long> {
    // Có thể thêm các phương thức truy vấn tùy chỉnh nếu cần
}
