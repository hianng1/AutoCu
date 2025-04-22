package poly.edu.Service;

import java.util.HashMap;
import java.util.Map;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.mapping.Collection;
import org.hibernate.sql.ast.tree.expression.Collation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jakarta.servlet.http.HttpSession;
import poly.edu.Model.*;
import poly.edu.Repository.GioHangRepository;
import poly.edu.Repository.UserRepository;

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
	public BigDecimal getAmounts() {
	    return maps.values().stream()
	        .map(item -> BigDecimal.valueOf(item.getSoLuong()).multiply(item.getGia()))
	        .reduce(BigDecimal.ZERO, BigDecimal::add);
	}
	
	  @Autowired private GioHangRepository ghRepo;
	  
	  @Override public List<GioHang> getGioHangByUser(User user) { return
	  ghRepo.findByUser(user); }
	 

	/*
	 * @Autowired private GioHangRepository gioHangRepository;
	 * 
	 * @Override public List<GioHang> getGioHangByUser(String username) { // Triển
	 * khai logic lấy giỏ hàng theo username return
	 * gioHangRepository.findByUser_Username(username); }
	 */
	  @Autowired
	  private GioHangRepository gioHangRepository;
	  @Autowired
		private UserRepository userRepo;
	  public void xoaGioHangSauKhiDatHang(String username) {
		    User user = userRepo.findByUsername(username)
		            .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng: " + username));

		    gioHangRepository.deleteAllByUser(user);
		}
}
