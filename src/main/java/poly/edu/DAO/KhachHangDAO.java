package poly.edu.DAO;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.KhachHang;

public interface KhachHangDAO extends JpaRepository<KhachHang, Long>{

    // Ví dụ: tìm xe theo tên xe
    List<KhachHang> findBySoDienThoai(String soDienThoai);
    List<KhachHang> findByEmail(String email);
    List<KhachHang> findByUserID(Long userID);
    Optional<KhachHang> findByTenKhachHang(String tenKhachHang);

}
