package poly.edu.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Model.PhuKienOto;

@Repository
public interface ChiTietDonHangRepository extends JpaRepository<ChiTietDonHang, Long> {
    // ... các phương thức khác ...

    List<ChiTietDonHang> findByDonHangOrderByOrderItemIDAsc(DonHang donHang);

    List<ChiTietDonHang> findByDonHang(DonHang donHang);

    List<ChiTietDonHang> findByPhuKienOto(PhuKienOto phuKienOto);
}