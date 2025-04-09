package poly.edu.DAO;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.GioHang;
import poly.edu.Model.GioHangChiTiet;
import poly.edu.Model.PhuKienOto;

@Repository
public interface GioHangChiTietDAO extends JpaRepository<GioHangChiTiet, Long> {

    // Tìm chi tiết giỏ hàng theo cartItemID
    List<GioHangChiTiet> findByCartItemID(Long cartItemID);

    // Tìm sản phẩm trong giỏ hàng theo GioHang và PhuKienOto
    Optional<GioHangChiTiet> findByGioHangAndPhuKienOto(GioHang gioHang, PhuKienOto phuKienOto);

    // Xóa một sản phẩm trong giỏ hàng theo GioHang và PhuKienOto
    void deleteByGioHangAndPhuKienOto(GioHang gioHang, PhuKienOto phuKienOto);

    // Xóa toàn bộ chi tiết giỏ hàng theo GioHang
    void deleteAllByGioHang(GioHang gioHang);
}
