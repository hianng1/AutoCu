package poly.edu.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import poly.edu.Model.DonHang;
import poly.edu.Model.KhachHang;

import java.util.Date;
import java.util.List;

@Repository
public interface DonHangRepository extends JpaRepository<DonHang, Long> {
    
    // Tìm đơn hàng theo khách hàng
    List<DonHang> findByKhachHang(KhachHang khachHang);
    
    // Tìm đơn hàng theo khách hàng (phân trang)
    Page<DonHang> findByKhachHang(KhachHang khachHang, Pageable pageable);
    
    // Tìm đơn hàng theo trạng thái
    List<DonHang> findByTrangThaiDon(String trangThai);
    
    // Tìm đơn hàng trong khoảng thời gian
	/* List<DonHang> findByNgayDatHangBetween(Date startDate, Date endDate); */
    
    // Tìm đơn hàng theo khách hàng và trạng thái
    List<DonHang> findByKhachHangAndTrangThaiDon(KhachHang khachHang, String trangThai);
    
    // Tìm đơn hàng có tổng giá trị lớn hơn
	/* List<DonHang> findByTongGiaTriGreaterThan(Double minValue); */
    
    // Đếm số đơn hàng theo trạng thái
    Long countByTrangThaiDon(String trangThai);
    
    // Tìm đơn hàng với tổng giá trị cao nhất
    @Query("SELECT d FROM DonHang d ORDER BY d.tongGiaTri DESC")
    List<DonHang> findTopByOrderByTongGiaTriDesc(Pageable pageable);
    
    // Thống kê doanh thu theo tháng
	/*
	 * @Query("SELECT MONTH(d.ngayDatHang) as month, SUM(d.tongGiaTri) as revenue "
	 * + "FROM DonHang d " + "WHERE YEAR(d.ngayDatHang) = ?1 " +
	 * "GROUP BY MONTH(d.ngayDatHang)") List<Object[]> getMonthlyRevenue(int year);
	 */
    
    // Tìm đơn hàng có chứa sản phẩm cụ thể (qua chi tiết đơn hàng)
    @Query("SELECT DISTINCT d FROM DonHang d JOIN d.chiTietDonHangs c WHERE c.phuKienOto.accessoryID = ?1")
    List<DonHang> findByProductId(Long accessoryID);
}