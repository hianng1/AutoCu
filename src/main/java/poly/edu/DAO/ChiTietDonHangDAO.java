package poly.edu.DAO;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.ChiTietDonHang;

@Repository
public interface ChiTietDonHangDAO extends JpaRepository<ChiTietDonHang, Long> {
    List<ChiTietDonHang> findByDonHang_OrderID(Long orderId);
}