package poly.edu.DAO;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.MaKhuyenMai;

public interface MaKhuyenMaiDAO extends JpaRepository<MaKhuyenMai, Long>{

    // Ví dụ: tìm xe theo tên xe
    List<MaKhuyenMai> findByMaKhuyenMai(String maKhuyenMai);
    List<MaKhuyenMai> findByPhanTramGiam(Double phanTramGiam);

}
