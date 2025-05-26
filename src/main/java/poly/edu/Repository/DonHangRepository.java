package poly.edu.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import poly.edu.Model.DonHang;
import poly.edu.Model.User;

@Repository
public interface DonHangRepository extends JpaRepository<DonHang, Long> {

    @Query("SELECT d.trangThai, COUNT(d) FROM DonHang d GROUP BY d.trangThai")
    List<Object[]> thongKeDonHangTheoTrangThai();

    // Tìm đơn hàng theo ID và người dùng
    Optional<DonHang> findByOrderIDAndUser(Long orderID, User user);

    // Tìm đơn hàng theo người dùng (giữ lại phương thức này và bỏ findAllByUser)
    List<DonHang> findByUser(User user);

    // Tìm đơn hàng theo người dùng (phân trang) - Giữ nguyên vì chữ ký khác
    // findByUser List
    Page<DonHang> findByUser(User user, Pageable pageable);

    // Tìm đơn hàng theo trạng thái - Sử dụng kiểu Enum DonHang.TrangThai
    List<DonHang> findByTrangThai(DonHang.TrangThai trangThai); // <-- Sửa từ String

    // Tìm đơn hàng trong khoảng thời gian - Giữ nguyên
    List<DonHang> findByNgayDatHangBetween(Date startDate, Date endDate);

    // Tìm đơn hàng theo khoảng thời gian và trạng thái - Mới thêm
    List<DonHang> findByNgayDatHangBetweenAndTrangThai(Date startDate, Date endDate, DonHang.TrangThai trangThai);

    // Tìm đơn hàng theo người dùng và trạng thái - Sử dụng kiểu Enum
    // DonHang.TrangThai
    List<DonHang> findByUserAndTrangThai(User user, DonHang.TrangThai trangThai); // <-- Sửa từ String

    // Đếm số đơn hàng theo trạng thái - Sử dụng kiểu Enum DonHang.TrangThai
    Long countByTrangThai(DonHang.TrangThai trangThai); // <-- Sửa từ String // Tìm đơn hàng đã giao theo người dùng -
                                                        // Phương thức mới thêm
    // Phương thức đã trùng với findByUserAndTrangThai ở trên nên không cần định
    // nghĩa lại

    // Tìm đơn hàng với tổng thanh toán cao nhất (Top N) - Giữ nguyên
    // Phương thức này sẽ dùng Pageable để giới hạn số lượng kết quả (top N)
    @Query("SELECT d FROM DonHang d ORDER BY d.tongThanhToan DESC")
    List<DonHang> findTopByOrderByTongThanhToanDesc(Pageable pageable);

    // Thống kê doanh thu theo tháng - Giữ nguyên
    @Query("SELECT MONTH(d.ngayDatHang) as month, SUM(d.tongThanhToan) as revenue " +
            "FROM DonHang d " +
            "WHERE YEAR(d.ngayDatHang) = ?1 " +
            "GROUP BY MONTH(d.ngayDatHang)")
    List<Object[]> getMonthlyRevenue(int year);

    // Tìm đơn hàng có chứa sản phẩm phụ kiện cụ thể - Giữ nguyên
    @Query("SELECT DISTINCT d FROM DonHang d JOIN d.chiTietDonHangs c WHERE c.phuKienOto.accessoryID = ?1")
    List<DonHang> findByProductId(Long accessoryID);

    // Tìm đơn hàng theo người dùng, sắp xếp theo ngày đặt hàng giảm dần
    List<DonHang> findByUserOrderByNgayDatHangDesc(User user);

    // *** Đã loại bỏ phương thức sau vì trùng lặp chức năng với findByUser(User
    // user) ***
    // List<DonHang> findAllByUser(User user);
}