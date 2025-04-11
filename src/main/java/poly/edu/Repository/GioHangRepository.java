package poly.edu.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import poly.edu.Model.GioHang;
import poly.edu.Model.KhachHang;
import poly.edu.Model.PhuKienOto;

import java.util.List;
import java.util.Optional;

@Repository
public interface GioHangRepository extends JpaRepository<GioHang, Long> {

    // Tìm giỏ hàng theo khách hàng
    Optional<GioHang> findByKhachHang(KhachHang khachHang);

    // Tìm giỏ hàng theo ID khách hàng
    @Query("SELECT gh FROM GioHang gh WHERE gh.khachHang.userID = :userId")
    Optional<GioHang> findByKhachHangId(@Param("userId") Long userId);

    // Tìm tất cả sản phẩm trong giỏ hàng của một khách hàng
    @Query("SELECT gh FROM GioHang gh WHERE gh.khachHang.userID = :userId")
    List<GioHang> findAllByKhachHangId(@Param("userId") Long userId);

    // Tìm giỏ hàng chứa sản phẩm cụ thể của khách hàng
    @Query("SELECT gh FROM GioHang gh WHERE gh.khachHang.userID = :userId AND gh.phuKienOto.accessoryID = :accessoryId")
    Optional<GioHang> findByKhachHangAndPhuKien(@Param("userId") Long userId, 
                                              @Param("accessoryId") Long accessoryId);

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    @Modifying
    @Query("UPDATE GioHang gh SET gh.soLuong = :soLuong WHERE gh.cartID = :cartId")
    void updateSoLuong(@Param("cartId") Long cartId, @Param("soLuong") int soLuong);

    // Xóa sản phẩm khỏi giỏ hàng
    @Modifying
    @Query("DELETE FROM GioHang gh WHERE gh.cartID = :cartId AND gh.khachHang.userID = :userId")
    void deleteByCartIdAndUserId(@Param("cartId") Long cartId, @Param("userId") Long userId);

    // Xóa tất cả sản phẩm trong giỏ hàng của khách hàng
    @Modifying
    @Query("DELETE FROM GioHang gh WHERE gh.khachHang.userID = :userId")
    void deleteAllByUserId(@Param("userId") Long userId);

    // Kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
    boolean existsByKhachHangAndPhuKienOto(KhachHang khachHang, PhuKienOto phuKienOto);
}