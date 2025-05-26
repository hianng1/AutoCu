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
