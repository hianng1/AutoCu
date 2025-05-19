package poly.edu.Service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DanhGia;
import poly.edu.Model.DonHang;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.User;
import poly.edu.Repository.ChiTietDonHangRepository;
import poly.edu.Repository.DanhGiaRepository;
import poly.edu.Repository.DonHangRepository;
import poly.edu.Repository.PhuKienOtoRepository;

@Service
public class DanhGiaService {

    @Autowired
    private DanhGiaRepository danhGiaRepository;

    @Autowired
    private PhuKienOtoRepository phuKienOtoRepository;

    @Autowired
    private DonHangRepository donHangRepository;

    @Autowired
    private ChiTietDonHangRepository chiTietDonHangRepository;

    /**
     * Get all visible reviews for a product
     */
    public List<DanhGia> getReviewsForProduct(PhuKienOto phuKienOto) {
        return danhGiaRepository.findByPhuKienOtoAndHienThiTrue(phuKienOto);
    }

    /**
     * Calculate average rating for a product
     */
    public double getAverageRatingForProduct(PhuKienOto phuKienOto) {
        Double avgRating = danhGiaRepository.calculateAverageRating(phuKienOto);
        return avgRating != null ? avgRating : 0.0;
    }

    /**
     * Get count of ratings for a product
     */
    public int getReviewCountForProduct(PhuKienOto phuKienOto) {
        Integer count = danhGiaRepository.countRatingsByPhuKienOto(phuKienOto);
        return count != null ? count : 0;
    }

    /**
     * Create or update a product review
     */
    @Transactional
    public String createOrUpdateReview(User user, Long productId, Long orderId, Integer rating, String content) {
        if (rating < 1 || rating > 5) {
            return "Đánh giá sao phải từ 1-5";
        }

        // Check if the product exists
        PhuKienOto product = phuKienOtoRepository.findById(productId).orElse(null);
        if (product == null) {
            return "Không tìm thấy sản phẩm";
        }

        // Check if the order exists
        DonHang order = donHangRepository.findById(orderId).orElse(null);
        if (order == null) {
            return "Không tìm thấy đơn hàng";
        }

        // Check if the order belongs to the user
        if (!order.getUser().getId().equals(user.getId())) {
            return "Bạn không có quyền đánh giá sản phẩm này";
        }

        // Check if the order is delivered
        if (order.getTrangThai() != DonHang.TrangThai.DA_GIAO) {
            return "Bạn chỉ có thể đánh giá sản phẩm sau khi đơn hàng đã được giao";
        }

        // Check if the product is in the order
        boolean productInOrder = false;
        for (ChiTietDonHang item : order.getChiTietDonHangs()) {
            if (item.getPhuKienOto() != null && item.getPhuKienOto().getAccessoryID().equals(productId)) {
                productInOrder = true;
                break;
            }
        }

        if (!productInOrder) {
            return "Sản phẩm này không có trong đơn hàng của bạn";
        }

        // Check if user already reviewed this product in this order
        DanhGia existingReview = danhGiaRepository.findByOrderAndProductAndUser(orderId, productId, user.getId());

        if (existingReview != null) {
            // Update existing review
            existingReview.setSaoDanhGia(rating);
            existingReview.setNoiDung(content);
            existingReview.setNgayDanhGia(new Date());
            danhGiaRepository.save(existingReview);
            return "Cập nhật đánh giá thành công";
        } else {
            // Create new review
            DanhGia newReview = new DanhGia();
            newReview.setUser(user);
            newReview.setPhuKienOto(product);
            newReview.setDonHang(order);
            newReview.setSaoDanhGia(rating);
            newReview.setNoiDung(content);
            newReview.setNgayDanhGia(new Date());
            newReview.setHienThi(true);
            danhGiaRepository.save(newReview);
            return "Đánh giá của bạn đã được gửi thành công";
        }
    }

    /**
     * Check if user can review a product (has ordered and received it)
     */
    public boolean canUserReviewProduct(User user, Long productId) {
        if (user == null || productId == null) {
            return false;
        }

        // Get all delivered orders for this user using the correct method name
        List<DonHang> deliveredOrders = donHangRepository.findByUserAndTrangThai(user, DonHang.TrangThai.DA_GIAO);

        for (DonHang order : deliveredOrders) {
            for (ChiTietDonHang item : order.getChiTietDonHangs()) {
                if (item.getPhuKienOto() != null && item.getPhuKienOto().getAccessoryID().equals(productId)) {
                    return true;
                }
            }
        }

        return false;
    }

    /**
     * Get products eligible for review by a user (ordered, delivered, not yet
     * reviewed)
     */
    public List<PhuKienOto> getProductsEligibleForReview(User user) {
        if (user == null) {
            return List.of();
        }

        // If you need to use findProductsEligibleForReview method from
        // DanhGiaRepository
        // make sure it's properly defined there with correct parameter types
        return danhGiaRepository.findProductsEligibleForReview(user.getId(), DonHang.TrangThai.DA_GIAO);
    }
}
