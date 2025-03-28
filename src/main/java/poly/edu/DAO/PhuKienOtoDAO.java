package poly.edu.DAO;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import poly.edu.Model.PhuKienOto;

import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;

public interface PhuKienOtoDAO extends JpaRepository<PhuKienOto, Long>{
	
    // Ví dụ: tìm xe theo tên xe
    List<PhuKienOto> findByTenPhuKien(String tenPhuKien);
    Optional<PhuKienOto> findById(Long id);
    
}
