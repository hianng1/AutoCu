package poly.edu.Service;

import java.util.List;
import java.util.Optional;
import poly.edu.Model.PhuKienOto;

public interface PhuKienOtoService {
    PhuKienOto add(PhuKienOto p);
    boolean remove(Long id);
    PhuKienOto findById(Long id);
    List<PhuKienOto> findAll();
    PhuKienOto update(PhuKienOto p);
}
