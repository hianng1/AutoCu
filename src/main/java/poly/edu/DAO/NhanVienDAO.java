package poly.edu.DAO;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.NhanVien;


public interface NhanVienDAO extends JpaRepository<NhanVien, Long>{

    // Ví dụ: tìm xe theo tên xe
    List<NhanVien> findByTenNhanVien(String tenNhanVien);
    List<NhanVien> findByStaffID(Long staffID);

}
