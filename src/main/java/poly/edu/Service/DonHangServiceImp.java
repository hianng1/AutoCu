package poly.edu.Service; // Thay thế bằng package thực tế của bạn

import java.util.Date;
import java.util.List;
import java.util.Optional; // Import Optional

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // Cần thiết cho các thao tác DB

import poly.edu.Model.DonHang; // Import model DonHang
import poly.edu.Model.DonHang.TrangThai;
import poly.edu.Model.User;
import poly.edu.Repository.DonHangRepository; // Import DonHangRepository


@Service // Đánh dấu đây là Service
public class DonHangServiceImp implements DonHangService { // Đảm bảo implements DonHangService

	 private final DonHangRepository donHangRepository; // Field để giữ instance của Repository

	    // Constructor Injection: Cách khuyến khích để Inject Repository
	    @Autowired
	    public DonHangServiceImp(DonHangRepository donHangRepository) {
	        this.donHangRepository = donHangRepository;
	    }

	    // Triển khai tất cả các phương thức từ interface DonHangService

	    @Override
	    public DonHang save(DonHang order) {
	        // Logic nghiệp vụ thêm/cập nhật (nếu có) có thể viết ở đây trước khi gọi repo.save
	        return donHangRepository.save(order);
	        // Logic sau khi lưu (nếu có)
	    }

	    @Override
	    @Transactional(readOnly = true) // Đánh dấu chỉ đọc để tối ưu
	    public Optional<DonHang> findById(Long id) {
	        return donHangRepository.findById(id);
	    }

	    @Override
	    public void deleteById(Long id) {
	        // Logic nghiệp vụ trước khi xóa (ví dụ: kiểm tra trạng thái)
	        donHangRepository.deleteById(id);
	        // Logic sau khi xóa
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findAll() {
	        return donHangRepository.findAll();
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public Optional<DonHang> findByOrderIDAndUser(Long orderID, User user) {
	        return donHangRepository.findByOrderIDAndUser(orderID, user);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findByUser(User user) {
	        return donHangRepository.findByUser(user);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public Page<DonHang> findByUser(User user, Pageable pageable) {
	        return donHangRepository.findByUser(user, pageable);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findByTrangThai(TrangThai trangThai) {
	        return donHangRepository.findByTrangThai(trangThai);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findByNgayDatHangBetween(Date startDate, Date endDate) {
	        return donHangRepository.findByNgayDatHangBetween(startDate, endDate);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findByUserAndTrangThai(User user, TrangThai trangThai) {
	        return donHangRepository.findByUserAndTrangThai(user, trangThai);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public Long countByTrangThai(TrangThai trangThai) {
	        return donHangRepository.countByTrangThai(trangThai);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findTopByOrderByTongThanhToanDesc(Pageable pageable) {
	        return donHangRepository.findTopByOrderByTongThanhToanDesc(pageable);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<Object[]> getMonthlyRevenue(int year) {
	        return donHangRepository.getMonthlyRevenue(year);
	    }

	    @Override
	    @Transactional(readOnly = true)
	    public List<DonHang> findByProductId(Long accessoryID) {
	        return donHangRepository.findByProductId(accessoryID);
	    }

	    // ... Thêm triển khai cho các phương thức khác nếu bạn có

	    // Ví dụ: Phương thức nghiệp vụ phức tạp hơn có thể dùng kết hợp nhiều thao tác từ Repository
	    // @Transactional
	    // public DonHang processOrderUpdate(Long orderId, TrangThai newStatus) {
	    //     DonHang order = findById(orderId).orElseThrow(() -> new RuntimeException("Order not found"));
	    //     // Kiểm tra điều kiện chuyển trạng thái
	    //     // ...
	    //     order.setTrangThai(newStatus);
	    //     return save(order); // Lưu thay đổi trạng thái
	    // }


}