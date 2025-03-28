package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;
import poly.edu.Model.PhuKienOto;
import poly.edu.DAO.PhuKienOtoDAO;

@Service
@Transactional
public class PhuKienOtoServiceImp implements PhuKienOtoService {
    
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
}
