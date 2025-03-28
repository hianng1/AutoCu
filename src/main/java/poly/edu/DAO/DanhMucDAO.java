package poly.edu.DAO;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.SanPham;

public interface DanhMucDAO extends JpaRepository<DanhMuc, Long>{

    // Ví dụ: tìm xe theo tên xe
    List<SanPham> findByTenDanhMuc(String tenDanhMuc);
}
