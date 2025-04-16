package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;
import poly.edu.Model.PhuKienOto;
import poly.edu.Repository.PhuKienOtoRepository;
import poly.edu.DAO.PhuKienOtoDAO;

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
        // Tìm phụ kiện theo ID từ repository
        Optional<PhuKienOto> accessory = PKrepo.findById(accessoryId);

        if (accessory.isPresent()) {
            // Lấy đối tượng phụ kiện
            PhuKienOto existingAccessory = accessory.get();
            
            // Cập nhật số lượng của phụ kiện
            existingAccessory.setSoLuong(existingAccessory.getSoLuong() + soLuong);

            // Lưu lại phụ kiện đã cập nhật vào cơ sở dữ liệu
            PKrepo.save(existingAccessory);
        } else {
            throw new IllegalArgumentException("Không tìm thấy phụ kiện với ID: " + accessoryId);
        }
    }


}
