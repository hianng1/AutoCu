package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.SanPham;
import poly.edu.Repository.DanhMucRepository;
import poly.edu.Repository.SanPhamRepository;

@Service
public class SanPhamService {
	@Autowired
    private DanhMucRepository danhMucRepository;
    @Autowired
    private SanPhamRepository sanPhamRepository; // Inject repository

    public List<SanPham> getSanPhamTuongTu(Long categoryID, Long productId) {
        return sanPhamRepository.findByDanhMuc_CategoryIDAndProductIDNot(categoryID, productId);
    }
    public List<SanPham> getAllSanPham() {
        return sanPhamRepository.findAll();
    }
    public List<SanPham> findAll() {
        return sanPhamRepository.findAll(); // Lấy danh sách từ DB
    }
    public Optional<SanPham> getSanPhamById(Long productID) {
        return sanPhamRepository.findById(productID);
    }

    public void saveSanPham(SanPham sanPham, Long categoryID) {
        sanPham.setDanhMuc(danhMucRepository.findById(categoryID).orElse(null));
        sanPhamRepository.save(sanPham);
    }



    public void deleteSanPham(Long productID) {
        sanPhamRepository.deleteById(productID);
    }

    public List<DanhMuc> getAllDanhMuc() {
        return danhMucRepository.findAll();
    }

}

