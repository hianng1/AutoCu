package poly.edu.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import poly.edu.Model.DanhGia;
import poly.edu.Model.DonHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;

@Repository
public interface DanhGiaRepository extends JpaRepository<DanhGia, Long> {

    List<DanhGia> findByPhuKienOtoAndHienThiTrue(PhuKienOto phuKienOto);

    List<DanhGia> findByUserAndPhuKienOto(User user, PhuKienOto phuKienOto);

    @Query("SELECT AVG(d.saoDanhGia) FROM DanhGia d WHERE d.phuKienOto = ?1 AND d.hienThi = true")
    Double calculateAverageRating(PhuKienOto phuKienOto);

    @Query("SELECT COUNT(d) FROM DanhGia d WHERE d.phuKienOto = ?1 AND d.hienThi = true")
    Integer countRatingsByPhuKienOto(PhuKienOto phuKienOto);

    @Query("SELECT d FROM DanhGia d WHERE d.donHang.orderID = ?1 AND d.phuKienOto.accessoryID = ?2 AND d.user.id = ?3")
    DanhGia findByOrderAndProductAndUser(Long orderId, Long productId, Integer userId);

    // Fixed query: Use parameter instead of direct enum reference
    @Query("SELECT DISTINCT ct.phuKienOto FROM ChiTietDonHang ct " +
            "WHERE ct.donHang.user.id = :userId AND ct.donHang.trangThai = :status " +
            "AND NOT EXISTS (SELECT 1 FROM DanhGia d WHERE d.phuKienOto = ct.phuKienOto AND d.user.id = :userId)")
    List<PhuKienOto> findProductsEligibleForReview(@Param("userId") Integer userId,
            @Param("status") DonHang.TrangThai status);
}
