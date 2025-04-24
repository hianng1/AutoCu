package poly.edu.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import poly.edu.Model.GioHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;

@Repository
public interface GioHangRepository extends JpaRepository<GioHang, Long> {
	GioHang findByUserAndPhuKienOto(User user, PhuKienOto phuKienOto);

    @Query("SELECT gh FROM GioHang gh WHERE gh.user = :user")
    List<GioHang> findByUser(@Param("user") User user);

    int deleteAllByUser(User user);

    // Tìm giỏ hàng theo ID user
    @Query("SELECT gh FROM GioHang gh WHERE gh.user.id = :userId")
    Optional<GioHang> findByUserId(@Param("userId") Long userId);

    // Tìm tất cả sản phẩm trong giỏ hàng của một user
    @Query("SELECT gh FROM GioHang gh WHERE gh.user.id = :userId")
    List<GioHang> findAllByUserId(@Param("userId") Long userId);

    // Tìm giỏ hàng chứa sản phẩm cụ thể của user
    @Query("SELECT gh FROM GioHang gh WHERE gh.user.id = :userId AND gh.phuKienOto.accessoryID = :accessoryId")
    Optional<GioHang> findByUserAndPhuKien(@Param("userId") Integer userId,
                                         @Param("accessoryId") Long accessoryId);

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    @Modifying
    @Query("UPDATE GioHang gh SET gh.soLuong = :soLuong WHERE gh.cartID = :cartId")
    void updateSoLuong(@Param("cartId") Long cartId, @Param("soLuong") int soLuong);

    // Xóa sản phẩm khỏi giỏ hàng
    @Modifying
    @Query("DELETE FROM GioHang gh WHERE gh.cartID = :cartId AND gh.user.id = :userId")
    void deleteByCartIdAndUserId(@Param("cartId") Long cartId, @Param("userId") Long userId);

    // Xóa tất cả sản phẩm trong giỏ hàng của user
    @Modifying
    @Query("DELETE FROM GioHang gh WHERE gh.user.id = :userId")
    void deleteAllByUserId(@Param("userId") Long userId);

    // Kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
    boolean existsByUserAndPhuKienOto(User user, PhuKienOto phuKienOto);
}