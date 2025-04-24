package poly.edu.Service;

import java.util.List;

import poly.edu.Model.PhuKienOto;

public interface PhuKienOtoService {
	PhuKienOto save(PhuKienOto p);
    PhuKienOto add(PhuKienOto p);
    boolean remove(Long id);
    PhuKienOto findById(Long id);
    List<PhuKienOto> findAll();
    PhuKienOto update(PhuKienOto p);

    // Thêm phương thức cập nhật số lượng tồn kho
    void updateStock(Long accessoryId, int soLuong);
}

