package poly.edu.DAO;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.SanPham;

public interface SanPhamDAO extends JpaRepository<SanPham, Long>{
//	List<SanPham> findByHangXe(Boolean trangThai);
    // Ví dụ: tìm xe theo hãng xe
    List<SanPham> findByHangXe(String hangXe);
    
    // Ví dụ: tìm xe theo tên xe
    List<SanPham> findByTenSanPham(String tenSanPham);
}
