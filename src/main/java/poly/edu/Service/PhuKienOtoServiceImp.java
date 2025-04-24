package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import poly.edu.DAO.PhuKienOtoDAO;
import poly.edu.Model.PhuKienOto;
import poly.edu.Repository.PhuKienOtoRepository;

@Service
@Transactional
public class PhuKienOtoServiceImp implements PhuKienOtoService {
    @Autowired
    private PhuKienOtoRepository PKrepo;

    @Autowired
    private PhuKienOtoDAO phuKienOtoDAO;

    @Override
    public PhuKienOto add(PhuKienOto p) {
        return phuKienOtoDAO.save(p);
    }

    @Override
    public boolean remove(Long id) {
        if (phuKienOtoDAO.existsById(id)) {
        	phuKienOtoDAO.deleteById(id);
            return true;
        }
        return false;
    }

    @Override
    public PhuKienOto findById(Long id) {
        return phuKienOtoDAO.findById(id).orElse(null); // Lấy từ DB, nếu không có thì trả về null
    }


    @Override
    public List<PhuKienOto> findAll() {
        return phuKienOtoDAO.findAll();
    }

    @Override
    public PhuKienOto update(PhuKienOto p) {
        if (phuKienOtoDAO.existsById(p.getAccessoryID())) {
            return phuKienOtoDAO.save(p);
        }
        return null;
    }

    @Override
    public void updateStock(Long accessoryId, int soLuong) {
        // Ví dụ triển khai updateStock: tìm entity, cập nhật, rồi save
        Optional<PhuKienOto> optionalProduct = PKrepo.findById(accessoryId);
        if (optionalProduct.isPresent()) {
            PhuKienOto product = optionalProduct.get();
            product.setSoLuong(soLuong); // Cập nhật số lượng mới
            save(product); // Lưu thay đổi
        } else {
            // Xử lý trường hợp không tìm thấy sản phẩm (ví dụ: log lỗi hoặc throw exception)
             throw new RuntimeException("Không tìm thấy phụ kiện với ID: " + accessoryId + " để cập nhật tồn kho.");
        }
    }

	@Override
	public PhuKienOto save(PhuKienOto p) {
		// TODO Auto-generated method stub
		return PKrepo.save(p);
	}


}
