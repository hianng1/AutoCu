package poly.edu.Service;

import java.math.BigDecimal;
import java.util.List;

import poly.edu.Model.GioHang;
import poly.edu.Model.User;

public interface CartService {
	List<GioHang> getGioHangByUser(User user);

	BigDecimal getAmounts();

	int getCount();

	java.util.Collection<GioHang> getAllItems();

	void clear();

	GioHang update(long CartID, int SoLuong);

	void remove(Long id);

	void add(GioHang item);
	
	void xoaGioHangSauKhiDatHang(String username);
}
