// poly.edu.Service.DonHangService
package poly.edu.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import poly.edu.Model.DonHang;
import poly.edu.Model.DonHang.TrangThai; // Import Enum TrangThai
import poly.edu.Model.User;

public interface DonHangService {

    // Phương thức save (thêm mới hoặc cập nhật)
    DonHang save(DonHang order);

    // Phương thức tìm theo ID
    Optional<DonHang> findById(Long id);

    // Phương thức xóa theo ID
    void deleteById(Long id); // Thêm phương thức xóa

    // Phương thức tìm tất cả
    List<DonHang> findAll();

    // Phương thức tìm theo ID và người dùng
    Optional<DonHang> findByOrderIDAndUser(Long orderID, User user);

    // Tìm đơn hàng theo người dùng
    List<DonHang> findByUser(User user);

    // Tìm đơn hàng theo người dùng (phân trang)
    Page<DonHang> findByUser(User user, Pageable pageable);

    // Tìm đơn hàng theo trạng thái (sử dụng Enum TrangThai)
    List<DonHang> findByTrangThai(TrangThai trangThai); // Sử dụng Enum

    // Tìm đơn hàng trong khoảng thời gian
    List<DonHang> findByNgayDatHangBetween(Date startDate, Date endDate);

    // Tìm đơn hàng theo người dùng và trạng thái (sử dụng Enum TrangThai)
    List<DonHang> findByUserAndTrangThai(User user, TrangThai trangThai); // Sử dụng Enum

    // Đếm số đơn hàng theo trạng thái (sử dụng Enum TrangThai)
    Long countByTrangThai(TrangThai trangThai); // Sử dụng Enum

    // Tìm đơn hàng với tổng thanh toán cao nhất (Top N)
    List<DonHang> findTopByOrderByTongThanhToanDesc(Pageable pageable);

    // Thống kê doanh thu theo tháng
    List<Object[]> getMonthlyRevenue(int year);

    // Tìm đơn hàng có chứa sản phẩm phụ kiện cụ thể
    List<DonHang> findByProductId(Long accessoryID);

    // ... Thêm các phương thức Service khác nếu cần logic nghiệp vụ phức tạp hơn
}