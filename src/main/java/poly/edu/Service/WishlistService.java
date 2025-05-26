package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;
import poly.edu.Model.User;
import poly.edu.Model.Wishlist;
import poly.edu.Repository.WishlistRepository;

@Service
@Transactional
public class WishlistService {

    @Autowired
    private WishlistRepository wishlistRepository;

    // Add accessory to wishlist
    public boolean addAccessoryToWishlist(User user, PhuKienOto phuKienOto) {
        if (!wishlistRepository.existsByUserAndPhuKienOto(user, phuKienOto)) {
            Wishlist wishlist = new Wishlist(user, phuKienOto);
            wishlistRepository.save(wishlist);
            return true;
        }
        return false; // Already in wishlist
    }

    // Add car to wishlist
    public boolean addCarToWishlist(User user, SanPham sanPham) {
        if (!wishlistRepository.existsByUserAndSanPham(user, sanPham)) {
            Wishlist wishlist = new Wishlist(user, sanPham);
            wishlistRepository.save(wishlist);
            return true;
        }
        return false; // Already in wishlist
    }

    // Remove accessory from wishlist
    public boolean removeAccessoryFromWishlist(User user, PhuKienOto phuKienOto) {
        Optional<Wishlist> wishlist = wishlistRepository.findByUserAndPhuKienOto(user, phuKienOto);
        if (wishlist.isPresent()) {
            wishlistRepository.delete(wishlist.get());
            return true;
        }
        return false;
    }

    // Remove car from wishlist
    public boolean removeCarFromWishlist(User user, SanPham sanPham) {
        Optional<Wishlist> wishlist = wishlistRepository.findByUserAndSanPham(user, sanPham);
        if (wishlist.isPresent()) {
            wishlistRepository.delete(wishlist.get());
            return true;
        }
        return false;
    }

    // Toggle accessory in wishlist
    public boolean toggleAccessoryInWishlist(User user, PhuKienOto phuKienOto) {
        if (wishlistRepository.existsByUserAndPhuKienOto(user, phuKienOto)) {
            removeAccessoryFromWishlist(user, phuKienOto);
            return false; // Removed
        } else {
            addAccessoryToWishlist(user, phuKienOto);
            return true; // Added
        }
    }

    // Toggle car in wishlist
    public boolean toggleCarInWishlist(User user, SanPham sanPham) {
        if (wishlistRepository.existsByUserAndSanPham(user, sanPham)) {
            removeCarFromWishlist(user, sanPham);
            return false; // Removed
        } else {
            addCarToWishlist(user, sanPham);
            return true; // Added
        }
    }

    // Get all wishlist items for user
    public List<Wishlist> getUserWishlist(User user) {
        return wishlistRepository.findByUserOrderByNgayThemDesc(user);
    }

    // Get wishlist items by type
    public List<Wishlist> getUserWishlistByType(User user, String type) {
        return wishlistRepository.findByUserAndLoaiSanPhamOrderByNgayThemDesc(user, type);
    }

    // Check if accessory is in wishlist
    public boolean isAccessoryInWishlist(User user, PhuKienOto phuKienOto) {
        return wishlistRepository.existsByUserAndPhuKienOto(user, phuKienOto);
    }

    // Check if car is in wishlist
    public boolean isCarInWishlist(User user, SanPham sanPham) {
        return wishlistRepository.existsByUserAndSanPham(user, sanPham);
    }

    // Get wishlist count
    public long getWishlistCount(User user) {
        return wishlistRepository.countByUser(user);
    }

    // Get wishlist count by type
    public long getWishlistCountByType(User user, String type) {
        return wishlistRepository.countByUserAndType(user, type);
    }

    // Clear all wishlist items for user
    public void clearUserWishlist(User user) {
        List<Wishlist> wishlistItems = wishlistRepository.findByUserOrderByNgayThemDesc(user);
        wishlistRepository.deleteAll(wishlistItems);
    }
}
