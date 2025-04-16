package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import poly.edu.Model.*;
import poly.edu.Service.DonHangService;
import poly.edu.Service.PhuKienOtoService;

import javax.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    @Autowired
    private DonHangService donHangService;

    @Autowired
    private PhuKienOtoService phuKienOtoService;

    @GetMapping
    public String showCheckoutPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login?redirect=checkout";
        }

        List<GioHang> cartItems = (List<GioHang>) session.getAttribute("cartItems");
        if (cartItems == null || cartItems.isEmpty()) {
            return "redirect:/cart";
        }

        for (GioHang item : cartItems) {
            PhuKienOto phuKien = phuKienOtoService.findById(item.getPhuKienOto().getAccessoryID());
            if (phuKien.getSoLuong() < item.getSoLuong()) {
                model.addAttribute("error", "Sản phẩm " + phuKien.getTenPhuKien() + " chỉ còn " + phuKien.getSoLuong() + " sản phẩm");
                return "redirect:/cart";
            }
        }

        double subtotal = calculateSubtotal(cartItems);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("user", user);

        return "checkout";
    }

    @PostMapping
    public String processCheckout(
            @RequestParam String fullName,
            @RequestParam String phone,
            @RequestParam String address,
            @RequestParam(required = false) String note,
            @RequestParam String shippingMethod,
            @RequestParam String paymentMethod,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<GioHang> cartItems = (List<GioHang>) session.getAttribute("cartItems");
        if (cartItems == null || cartItems.isEmpty()) {
            return "redirect:/cart";
        }

        try {
            // Kiểm tra số lượng tồn kho trước khi xử lý
            for (GioHang item : cartItems) {
                PhuKienOto phuKien = phuKienOtoService.findById(item.getPhuKienOto().getAccessoryID());
                if (phuKien.getSoLuong() < item.getSoLuong()) {
                    redirectAttributes.addFlashAttribute("error", 
                        "Sản phẩm " + phuKien.getTenPhuKien() + " chỉ còn " + phuKien.getSoLuong() + " sản phẩm");
                    return "redirect:/cart";
                }
            }

            BigDecimal subtotal = BigDecimal.valueOf(calculateSubtotal(cartItems));
            BigDecimal shippingFee = "fast".equals(shippingMethod) ? new BigDecimal("30000") : BigDecimal.ZERO;
            BigDecimal total = subtotal.add(shippingFee);
            
            DonHang donHang = new DonHang();
            donHang.setUser(user);
            donHang.setHoTen(fullName);
            donHang.setSoDienThoai(phone);
            donHang.setDiaChi(address);
            donHang.setGhiChu(note);
            donHang.setPhuongThucVanChuyen(shippingMethod);
            donHang.setPhuongThucThanhToan(paymentMethod);
            donHang.setNgayDatHang(new Date());
            donHang.setTrangThai(DonHang.TrangThai.CHO_XAC_NHAN.name());
            donHang.setPhiVanChuyen(shippingFee);
            donHang.setDaThanhToan(false);

            List<ChiTietDonHang> chiTietDonHangs = convertToChiTietDonHangs(cartItems, donHang);
            donHang.setChiTietDonHangs(chiTietDonHangs);
            donHang.tinhTongTien();

            // Tạo đơn hàng trong transaction để đảm bảo tính toàn vẹn dữ liệu
            DonHang savedOrder = donHangService.taoDonHang(donHang, cartItems);

            // Cập nhật số lượng tồn kho
            for (ChiTietDonHang item : chiTietDonHangs) {
                phuKienOtoService.updateStock(item.getPhuKienOto().getAccessoryID(), item.getSoLuong());
            }

            // Xóa giỏ hàng chỉ khi mọi thứ thành công
            session.removeAttribute("cartItems");

            redirectAttributes.addFlashAttribute("orderId", savedOrder.getOrderID());
            return "redirect:/order/success";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            return "redirect:/checkout";
        }
    }

    private double calculateSubtotal(List<GioHang> cartItems) {
        return cartItems.stream()
                .mapToDouble(item -> item.getPhuKienOto().getGia() * item.getSoLuong())
                .sum();
    }

    private List<ChiTietDonHang> convertToChiTietDonHangs(List<GioHang> cartItems, DonHang donHang) {
    	
        return cartItems.stream().map(cartItem -> {
            ChiTietDonHang chiTiet = new ChiTietDonHang();
            BigDecimal donGia = BigDecimal.valueOf(cartItem.getPhuKienOto().getGia());
            chiTiet.setDonHang(donHang);
            chiTiet.setPhuKienOto(cartItem.getPhuKienOto());
            chiTiet.setSoLuong(cartItem.getSoLuong());
            chiTiet.setDonGia(donGia);
            return chiTiet;
        }).collect(Collectors.toList());
    }

	/*
	 * private String createVnPayPaymentUrl(DonHang order) { return
	 * "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html" + "?vnp_Amount=" + (int)
	 * (order.getTongThanhToan() * 100) + "&vnp_Command=pay" + "&vnp_CreateDate=" +
	 * System.currentTimeMillis() + "&vnp_CurrCode=VND" + "&vnp_IpAddr=127.0.0.1" +
	 * "&vnp_Locale=vn" + "&vnp_OrderInfo=Thanh+toan+don+hang+" + order.getOrderID()
	 * + "&vnp_OrderType=other" +
	 * "&vnp_ReturnUrl=http://yourdomain.com/payment/vnpay/return" +
	 * "&vnp_TmnCode=YOUR_TMN_CODE" + "&vnp_TxnRef=" + order.getOrderID() +
	 * "&vnp_Version=2.1.0"; }
	 */
}