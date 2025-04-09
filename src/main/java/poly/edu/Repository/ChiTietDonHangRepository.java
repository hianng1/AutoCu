package poly.edu.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;

public interface ChiTietDonHangRepository extends JpaRepository<ChiTietDonHang, Long> {
    List<ChiTietDonHang> findByDonHang(DonHang donHang);
}
