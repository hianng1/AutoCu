package poly.edu.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import poly.edu.Model.DonHang;
import poly.edu.Model.User;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface DonHangRepository extends JpaRepository<DonHang, Long> {
	Optional<DonHang> findByOrderIDAndUser(Long orderID, User user);
    
	// Tìm đơn hàng theo người dùng
    List<DonHang> findByUser(User user);
    
    List<DonHang> findAllByUser(User user);

    // Tìm đơn hàng theo người dùng (phân trang)
    Page<DonHang> findByUser(User user, Pageable pageable);

    // Tìm đơn hàng theo trạng thái
    List<DonHang> findByTrangThai(String trangThai);

    // Tìm đơn hàng trong khoảng thời gian
    List<DonHang> findByNgayDatHangBetween(Date startDate, Date endDate);

    // Tìm đơn hàng theo người dùng và trạng thái
    List<DonHang> findByUserAndTrangThai(User user, String trangThai);

    // Đếm số đơn hàng theo trạng thái
    Long countByTrangThai(String trangThai);

    // Tìm đơn hàng với tổng thanh toán cao nhất
    @Query("SELECT d FROM DonHang d ORDER BY d.tongThanhToan DESC")
    List<DonHang> findTopByOrderByTongThanhToanDesc(Pageable pageable);

    // Thống kê doanh thu theo tháng
    @Query("SELECT MONTH(d.ngayDatHang) as month, SUM(d.tongThanhToan) as revenue " +
           "FROM DonHang d " +
           "WHERE YEAR(d.ngayDatHang) = ?1 " +
           "GROUP BY MONTH(d.ngayDatHang)")
    List<Object[]> getMonthlyRevenue(int year);

    // Tìm đơn hàng có chứa sản phẩm phụ kiện cụ thể
    @Query("SELECT DISTINCT d FROM DonHang d JOIN d.chiTietDonHangs c WHERE c.phuKienOto.accessoryID = ?1")
    List<DonHang> findByProductId(Long accessoryID);
}
