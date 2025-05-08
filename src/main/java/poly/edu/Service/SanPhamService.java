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
    
    public List<SanPham> getAllCars() {
        // Cần SanPhamRepository có phương thức findByDanhMuc_Loai(String loai);
        return sanPhamRepository.findByDanhMuc_Loai("xe");
    }

    /**
     * Lấy tất cả sản phẩm là Phụ kiện (có DanhMuc.loai = 'phu_kien').
     * Yêu cầu phương thức findByDanhMuc_Loai("phu_kien") trong SanPhamRepository.
     */
    public List<SanPham> getAllAccessories() {
        // Cần SanPhamRepository có phương thức findByDanhMuc_Loai(String loai);
        return sanPhamRepository.findByDanhMuc_Loai("phu_kien");
    }
    
    public List<SanPham> getProductsByCategoryAndType(DanhMuc danhMuc, String loai) {
        if (danhMuc == null) {
            // Xử lý trường hợp danh mục null, có thể trả về danh sách rỗng hoặc tất cả sản phẩm theo loại
            System.err.println("getProductsByCategoryAndType được gọi với DanhMuc null. Trả về tất cả sản phẩm theo loại.");
            return getProductsByType(loai); // Sử dụng phương thức hỗ trợ
        }
       // Cần SanPhamRepository có phương thức findByDanhMuc_LoaiAndDanhMuc(String loai, DanhMuc danhMuc);
       return sanPhamRepository.findByDanhMuc_LoaiAndDanhMuc(loai, danhMuc);
   }
    
    public List<SanPham> getProductsByType(String loai) {
        return sanPhamRepository.findByDanhMuc_Loai(loai);
    }

}

