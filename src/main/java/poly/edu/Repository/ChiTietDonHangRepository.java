package poly.edu.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;

public interface ChiTietDonHangRepository extends JpaRepository<ChiTietDonHang, Long> {
    List<ChiTietDonHang> findByDonHang(DonHang donHang);
    
    List<ChiTietDonHang> findByDonHangOrderByOrderItemIDAsc(DonHang donHang);
}
