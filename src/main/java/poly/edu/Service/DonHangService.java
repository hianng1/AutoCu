package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import poly.edu.Model.*;
import poly.edu.Repository.*;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DonHangService {
    
    private final DonHangRepository donHangRepository;
    private final ChiTietDonHangRepository chiTietDonHangRepository;
    private final PhuKienOtoRepository phuKienOtoRepository;
    private final GioHangRepository gioHangRepository;

    @Autowired
    public DonHangService(DonHangRepository donHangRepository,
                         ChiTietDonHangRepository chiTietDonHangRepository,
                         PhuKienOtoRepository phuKienOtoRepository,
                         GioHangRepository gioHangRepository) {
        this.donHangRepository = donHangRepository;
        this.chiTietDonHangRepository = chiTietDonHangRepository;
        this.phuKienOtoRepository = phuKienOtoRepository;
        this.gioHangRepository = gioHangRepository;
    }

    @Transactional
    public DonHang taoDonHang(DonHang donHang, Collection<GioHang> collection) {
        // 1. Validate dữ liệu đầu vào
        validateInput(donHang, collection);

        // 2. Chuẩn bị thông tin đơn hàng
        prepareDonHangInfo(donHang);

        // 3. Tính toán tổng giá trị đơn hàng và kiểm tra tồn kho
        BigDecimal tongGiaTri = calculateTotalAndCheckInventory(collection);

        // 4. Lưu đơn hàng với tổng giá trị
        donHang.setTongThanhToan(tongGiaTri);
        DonHang savedDonHang = donHangRepository.save(donHang);

        // 5. Xử lý chi tiết đơn hàng và cập nhật tồn kho
        processOrderDetails(collection, savedDonHang);

        // 6. Xóa các mục trong giỏ hàng đã được đặt
		/* clearCartItems(gioHangItems); */

        return savedDonHang;
    }

    private void validateInput(DonHang donHang, Collection<GioHang> collection) {
        if (donHang.getUser() == null) {
            throw new IllegalArgumentException("Thông tin khách hàng không được để trống");
        }
        
        if (collection == null || collection.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng không có sản phẩm để đặt hàng");
        }
    }

    private void prepareDonHangInfo(DonHang donHang) {
        donHang.setNgayDatHang(new Date());
        donHang.setTrangThai("DANG_XU_LY");
        donHang.setDaThanhToan(false); // Mặc định chưa thanh toán
    }

    private BigDecimal calculateTotalAndCheckInventory(Collection<GioHang> collection) {
        return collection.stream()
                .map(item -> {
                    PhuKienOto phuKien = phuKienOtoRepository.findById(item.getPhuKienOto().getAccessoryID())
                            .orElseThrow(() -> new RuntimeException("Phụ kiện không tồn tại: ID " + item.getPhuKienOto().getAccessoryID()));
                    
                    if (phuKien.getSoLuong() < item.getSoLuong()) {
                        throw new RuntimeException("Số lượng tồn kho không đủ cho sản phẩm: " + phuKien.getTenPhuKien());
                    }
                    
                    return BigDecimal.valueOf(phuKien.getGia()).multiply(BigDecimal.valueOf(item.getSoLuong()));
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private void processOrderDetails(Collection<GioHang> collection, DonHang donHang) {
        List<ChiTietDonHang> chiTietDonHangs = collection.stream()
                .map(item -> {
                    PhuKienOto phuKien = phuKienOtoRepository.findById(item.getPhuKienOto().getAccessoryID())
                            .orElseThrow(() -> new RuntimeException("Phụ kiện không tồn tại"));
                    
                    // Cập nhật số lượng tồn kho
                    phuKien.setSoLuong(phuKien.getSoLuong() - item.getSoLuong());
                    phuKienOtoRepository.save(phuKien);
                    
                    // Tạo chi tiết đơn hàng
                    ChiTietDonHang chiTiet = new ChiTietDonHang();
                    chiTiet.setDonHang(donHang);
                    chiTiet.setPhuKienOto(phuKien);
                    chiTiet.setSoLuong(item.getSoLuong());
                    
                    return chiTiet;
                })
                .collect(Collectors.toList());
        
        // Lưu tất cả chi tiết đơn hàng cùng lúc
        chiTietDonHangRepository.saveAll(chiTietDonHangs);
    }

	/*
	 * private void clearCartItems(List<GioHang> gioHangItems) { List<Long>
	 * cartItemIds = gioHangItems.stream() .map(GioHang::getId)
	 * .collect(Collectors.toList());
	 * 
	 * gioHangRepository.deleteAllById(cartItemIds); }
	 */

    // Các phương thức bổ sung có thể thêm ở đây
    
    @Transactional
    public DonHang save(DonHang donHang, Collection<GioHang> collection) {
        // 1. Validate dữ liệu đầu vào
        validateInput(donHang, collection);

        // 2. Chuẩn bị thông tin đơn hàng
        prepareDonHangInfo(donHang);

        // 3. Tính toán tổng giá trị đơn hàng và kiểm tra tồn kho
        BigDecimal tongGiaTri = calculateTotalAndCheckInventory(collection);

        // 4. Lưu đơn hàng với tổng giá trị
        donHang.setTongThanhToan(tongGiaTri);
        DonHang savedDonHang = donHangRepository.save(donHang);

        // 5. Xử lý chi tiết đơn hàng và cập nhật tồn kho
        processOrderDetails(collection, savedDonHang);

        // 6. Xóa các mục trong giỏ hàng đã được đặt
    	/* clearCartItems(gioHangItems); */

        return savedDonHang;
    }
}