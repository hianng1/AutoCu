package poly.edu.Service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import poly.edu.Model.GioHang;
import poly.edu.Model.User;

@Service
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
