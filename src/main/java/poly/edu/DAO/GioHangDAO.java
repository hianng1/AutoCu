package poly.edu.DAO;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.GioHang;
import poly.edu.Model.KhachHang;
import poly.edu.Model.PhuKienOto;

public interface GioHangDAO extends JpaRepository<GioHang, Long>{
//	List<SanPham> findByHangXe(Boolean trangThai);
    // Ví dụ: tìm xe theo hãng xe
    List<GioHang> findBycartID(Long cartID);
    Optional<GioHang> findByKhachHang(KhachHang khachHang);
    
}