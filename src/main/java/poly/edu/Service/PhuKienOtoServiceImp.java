package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.PhuKienOto;
import poly.edu.Repository.DanhGiaRepository;
import poly.edu.Repository.PhuKienOtoRepository;

@Service
public class PhuKienOtoServiceImp implements PhuKienOtoService {

    private final PhuKienOtoRepository phuKienOtoRepository;
    private final DanhGiaRepository danhGiaRepository;

    @Autowired
    public PhuKienOtoServiceImp(PhuKienOtoRepository phuKienOtoRepository, DanhGiaRepository danhGiaRepository) {
        this.phuKienOtoRepository = phuKienOtoRepository;
        this.danhGiaRepository = danhGiaRepository;
    }

    @Override
    public PhuKienOto add(PhuKienOto phuKien) {
        return phuKienOtoRepository.save(phuKien);
    }

    @Override
    public void remove(Long id) {
        phuKienOtoRepository.deleteById(id);
    }

    @Override
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

    @Override
    public List<PhuKienOto> findAll() {
        List<PhuKienOto> allAccessories = phuKienOtoRepository.findAll();

        // Add rating data to each product
        for (PhuKienOto accessory : allAccessories) {
            Double avgRating = danhGiaRepository.calculateAverageRating(accessory);
            Integer ratingCount = danhGiaRepository.countRatingsByPhuKienOto(accessory);

            accessory.setRatingData(
                    avgRating != null ? avgRating : 0.0,
                    ratingCount != null ? ratingCount : 0);
        }

        return allAccessories;
    }

    @Override
    public PhuKienOto update(PhuKienOto phuKien) {
        if (phuKien.getAccessoryID() == null) {
            throw new IllegalArgumentException("Cannot update an accessory without an ID");
        }
        return phuKienOtoRepository.save(phuKien);
    }

    @Override
    public boolean updateStock(Long id, int quantity) {
        Optional<PhuKienOto> optionalPhuKien = phuKienOtoRepository.findById(id);
        if (optionalPhuKien.isPresent()) {
            PhuKienOto phuKien = optionalPhuKien.get();

            // Ensure we don't go below 0
            int newQuantity = Math.max(0, phuKien.getSoLuong() - quantity);
            phuKien.setSoLuong(newQuantity);

            phuKienOtoRepository.save(phuKien);
            return true;
        }
        return false;
    }

    @Override
    public PhuKienOto save(PhuKienOto phuKien) {
        return phuKienOtoRepository.save(phuKien);
    }

    @Override
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
}
