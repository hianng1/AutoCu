package poly.edu.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.mapping.Collection;
import org.hibernate.sql.ast.tree.expression.Collation;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jakarta.servlet.http.HttpSession;
import poly.edu.Model.GioHang;
import poly.edu.Model.PhuKienOto;

@SessionScope
@Service
public class CartServiceImp implements CartService{
	Map<Long, GioHang> maps = new HashMap<Long, GioHang>();
	
	private void updateSession() {
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = attr.getRequest().getSession(true);
		session.setAttribute("CART_ITEMS", new ArrayList<>(maps.values()));
	}
	
	@Override
    public void add(GioHang item) {
        // Lấy AccessoryID từ sản phẩm trong giỏ hàng
        Long productId = item.getPhuKienOto().getAccessoryID(); 

        // Kiểm tra sản phẩm đã tồn tại trong giỏ chưa
        if (maps.containsKey(productId)) {
            // Nếu có, tăng số lượng
            GioHang existingItem = maps.get(productId);
            existingItem.setSoLuong(existingItem.getSoLuong() + 1);
        } else {
            // Nếu chưa, thêm mới vào giỏ
            maps.put(productId, item);
        }
        updateSession();
    }
	
	@Override
	public void remove(Long id) {
		maps.remove(id);
		updateSession();
	}
	
	@Override
	public GioHang update(long CartID, int SoLuong) {
		GioHang giohang = maps.get(CartID);
		giohang.setSoLuong(SoLuong);
		updateSession();
		return giohang;
	}
	
	@Override
	public void clear() {
		maps.clear();
		updateSession();
	}
	@Override
	public java.util.Collection<GioHang> getAllItems(){
		return maps.values();
	}
	@Override
	public int getCount() {
		return maps.values().size();
	}
	
	@Override
	public double getAmounts() {
	    return maps.values().stream().mapToDouble(item -> item.getSoLuong() * item.getGia()).sum();
	}
}
