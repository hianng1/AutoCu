package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.PhuKienOto;

public interface PhuKienOtoService {
    
    PhuKienOto add(PhuKienOto phuKien);
    
    void remove(Long id);
    
    Optional<PhuKienOto> findById(Long id);
    
    List<PhuKienOto> findAll();
    
    PhuKienOto update(PhuKienOto phuKien);
    
    boolean updateStock(Long id, int quantity);
    
    PhuKienOto save(PhuKienOto phuKien);
    
    List<PhuKienOto> getAccessoriesByCategory(DanhMuc category);
}
        for (PhuKienOto accessory : allAccessories) {
            Double avgRating = danhGiaRepository.calculateAverageRating(accessory);
            Integer ratingCount = danhGiaRepository.countRatingsByPhuKienOto(accessory);

            accessory.setRatingData(
                    avgRating != null ? avgRating : 0.0,
                    ratingCount != null ? ratingCount : 0);
        }

        return allAccessories;
    }

    public Optional<PhuKienOto> findById(Long id) {
        Optional<PhuKienOto> accessoryOpt = phuKienOtoRepository.findById(id);

        if (accessoryOpt.isPresent()) {
            PhuKienOto accessory = accessoryOpt.get();
            Double avgRating = danhGiaRepository.calculateAverageRating(accessory);
            Integer ratingCount = danhGiaRepository.countRatingsByPhuKienOto(accessory);

            accessory.setRatingData(
                    avgRating != null ? avgRating : 0.0,
                    ratingCount != null ? ratingCount : 0);
        }

        return accessoryOpt;
    }

    public List<PhuKienOto> getAccessoriesByCategory(DanhMuc category) {
        List<PhuKienOto> accessories = phuKienOtoRepository.findByDanhMuc(category);

        // Add rating data to each product
        for (PhuKienOto accessory : accessories) {
            Double avgRating = danhGiaRepository.calculateAverageRating(accessory);
            Integer ratingCount = danhGiaRepository.countRatingsByPhuKienOto(accessory);

            accessory.setRatingData(
                    avgRating != null ? avgRating : 0.0,
                    ratingCount != null ? ratingCount : 0);
        }

        return accessories;
    }

    PhuKienOto save(PhuKienOto p) {
        // TODO Auto-generated method stub
        return null;
    }

    PhuKienOto add(PhuKienOto p) {
        // TODO Auto-generated method stub
        return null;
    }

    boolean remove(Long id) {
        // TODO Auto-generated method stub
        return false;
    }

    PhuKienOto findById(Long id) {
        // TODO Auto-generated method stub
        return null;
    }

    List<PhuKienOto> findAll() {
        // TODO Auto-generated method stub
        return null;
    }

    PhuKienOto update(PhuKienOto p) {
        // TODO Auto-generated method stub
        return null;
    }

    void updateStock(Long accessoryId, int soLuong) {
        // TODO Auto-generated method stub

    }
}
