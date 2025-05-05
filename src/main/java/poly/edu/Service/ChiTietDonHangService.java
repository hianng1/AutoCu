package poly.edu.Service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import poly.edu.DAO.ChiTietDonHangDAO;

import poly.edu.Model.ChiTietDonHang;

@Service
public class ChiTietDonHangService {

    @Autowired
    private ChiTietDonHangDAO chiTietDonHangDAO;

    public List<ChiTietDonHang> findByDonHang_OrderID(Long orderId) {
        return chiTietDonHangDAO.findByDonHang_OrderID(orderId);
    }
}