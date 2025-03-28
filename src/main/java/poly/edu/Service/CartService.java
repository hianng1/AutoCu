package poly.edu.Service;

import poly.edu.Model.GioHang;

public interface CartService {

	double getAmounts();

	int getCount();

	java.util.Collection<GioHang> getAllItems();

	void clear();

	GioHang update(long CartID, int SoLuong);

	void remove(Long id);

	void add(GioHang item);

}
