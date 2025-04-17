package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import poly.edu.Model.HinhAnhSanPham;
import poly.edu.Repository.HinhAnhSanPhamRepository;

@Service
public class HinhAnhSanPhamService {

    @Autowired
    private HinhAnhSanPhamRepository hinhAnhSanPhamRepository; // Inject repository của HinhAnhSanPham

    public void saveHinhAnhSanPham(HinhAnhSanPham hinhAnhSanPham) {
        hinhAnhSanPhamRepository.save(hinhAnhSanPham);
    }
}
