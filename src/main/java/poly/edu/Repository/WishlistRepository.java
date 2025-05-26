package poly.edu.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;
import poly.edu.Model.User;
import poly.edu.Model.Wishlist;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {

    // Find all wishlist items for a user
    List<Wishlist> findByUserOrderByNgayThemDesc(User user);

    // Find specific wishlist item by user and accessory
    Optional<Wishlist> findByUserAndPhuKienOto(User user, PhuKienOto phuKienOto);

    // Find specific wishlist item by user and car
    Optional<Wishlist> findByUserAndSanPham(User user, SanPham sanPham);

    // Check if accessory is in wishlist
    boolean existsByUserAndPhuKienOto(User user, PhuKienOto phuKienOto);

    // Check if car is in wishlist
    boolean existsByUserAndSanPham(User user, SanPham sanPham);

    // Count wishlist items by user
    long countByUser(User user);

    // Get wishlist items by type
    List<Wishlist> findByUserAndLoaiSanPhamOrderByNgayThemDesc(User user, String loaiSanPham);

    // Delete by user and accessory
    void deleteByUserAndPhuKienOto(User user, PhuKienOto phuKienOto);

    // Delete by user and car
    void deleteByUserAndSanPham(User user, SanPham sanPham);

    // Get wishlist statistics
    @Query("SELECT COUNT(w) FROM Wishlist w WHERE w.user = :user AND w.loaiSanPham = :type")
    long countByUserAndType(@Param("user") User user, @Param("type") String type);
}
