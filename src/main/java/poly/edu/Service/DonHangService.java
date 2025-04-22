package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import poly.edu.Model.*;
import poly.edu.Repository.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class DonHangService {
	@Autowired
	private UserRepository userRepo;

    @Autowired
    private DonHangRepository donHangRepository;

    @Autowired
    private ChiTietDonHangRepository chiTietDonHangRepository;

    @Autowired
    private PhuKienOtoRepository phuKienOtoRepository;

    public DonHang taoDonHangTam(
        User user,
        String hoTen,
        String soDienThoai,
        String diaChi,
        String ghiChu,
        String phuongThucVanChuyen,
        String phuongThucThanhToan,
        List<GioHang> cartItems
    ) {
        DonHang donHang = new DonHang();

        // Set thông tin người dùng nếu có
        if (user != null) {
            donHang.setUser(user);
            hoTen = (hoTen == null || hoTen.isEmpty()) ? user.getHovaten() : hoTen;
            soDienThoai = (soDienThoai == null || soDienThoai.isEmpty()) ? user.getSodienthoai() : soDienThoai;
            diaChi = (diaChi == null || diaChi.isEmpty()) ? user.getDiaChi() : diaChi;
        }

        donHang.setHoTen(hoTen);
        donHang.setSoDienThoai(soDienThoai);
        donHang.setDiaChi(diaChi);
        donHang.setGhiChu(ghiChu);
        donHang.setPhuongThucVanChuyen(phuongThucVanChuyen);
        donHang.setPhuongThucThanhToan(phuongThucThanhToan);
        donHang.setTrangThai("CHO_XAC_NHAN");
        donHang.setDaThanhToan(false);
        donHang.setPhiVanChuyen(BigDecimal.ZERO);

        // Thêm chi tiết đơn hàng
        List<ChiTietDonHang> chiTietDonHangs = new ArrayList<>();

        for (GioHang item : cartItems) {
            PhuKienOto phuKien = phuKienOtoRepository.findById(item.getPhuKienOto().getAccessoryID())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ kiện với ID: " + item.getPhuKienOto().getAccessoryID()));

            ChiTietDonHang chiTiet = new ChiTietDonHang();
            chiTiet.setDonHang(donHang);
            chiTiet.setPhuKienOto(phuKien);
            chiTiet.setTenSanPham(phuKien.getTenPhuKien());
            chiTiet.setSoLuong(item.getSoLuong());
            chiTiet.setDonGia(BigDecimal.valueOf(phuKien.getGia()));

            chiTietDonHangs.add(chiTiet);
        }

        donHang.setChiTietDonHangs(chiTietDonHangs);
        donHang.tinhTongTien();

        return donHangRepository.save(donHang);
    }
    public void luuDonHang(DonHangRequest request, String username) {
        User user = userRepo.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        DonHang donHang = new DonHang();
        donHang.setUser(user);
        donHang.setHoTen(request.getHoTen());
        donHang.setSoDienThoai(request.getSoDienThoai());
        donHang.setDiaChi(request.getDiaChi());
        donHang.setGhiChu(request.getGhiChu());
        donHang.setPhuongThucVanChuyen(request.getPhuongThucVanChuyen());
        donHang.setPhuongThucThanhToan(request.getPhuongThucThanhToan());
        donHang.setTongTienHang(BigDecimal.valueOf(request.getTongTienHang())); 
        donHang.setPhiVanChuyen(BigDecimal.valueOf( request.getPhiVanChuyen())); 
        donHang.setTongThanhToan(BigDecimal.valueOf(request.getTongThanhToan()));
        donHang.setNgayDatHang(Date.from(LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant()));

        donHangRepository.save(donHang);
    }
    
    @Autowired
    private UserRepository userRepository;

    public DonHang getDonHangByIdAndUser(Long orderId, String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng: " + username));

        return donHangRepository.findByOrderIDAndUser(orderId, user)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId + " cho người dùng: " + username));
    }
    
    public List<DonHang> getDonHangByUser(String username) {
        User user = userRepository.findByUsername(username)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng: " + username));

        return donHangRepository.findAllByUser(user);
    }

}
