package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import poly.edu.Model.DonHang;
import poly.edu.Model.ChiTietDonHang;
import poly.edu.Repository.DonHangRepository;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

@Controller
public class ThongkeController {

    @Autowired
    private DonHangRepository donHangRepository;

    @GetMapping("/thongke")
    public String thongKeDoanhThu(
        @RequestParam(value = "reportRange", required = false) String reportRange,
        Model model) {

        if (reportRange != null && !reportRange.isEmpty()) {
            try {
                // Thử phân tích ngày theo nhiều định dạng khác nhau
                String[] dates;
                Date startDate = null;
                Date endDate = null;
                
                // Debug logging
                System.out.println("Raw report range: " + reportRange);
                
                if (reportRange.contains(" to ")) {
                    dates = reportRange.split(" to ");
                } else if (reportRange.contains(" đến ")) {
                    dates = reportRange.split(" đến ");
                } else {
                    model.addAttribute("error", "Định dạng khoảng thời gian không hợp lệ: " + reportRange);
                    return "Admin/thongke";
                }
                
                if (dates.length == 2) {
                    String startDateStr = dates[0].trim();
                    String endDateStr = dates[1].trim();
                    
                    System.out.println("Start date string: " + startDateStr);
                    System.out.println("End date string: " + endDateStr);
                    
                    // Thay đổi thứ tự ưu tiên, đặt dd/MM/yyyy lên đầu tiên
                    List<SimpleDateFormat> formats = new ArrayList<>();
                    formats.add(new SimpleDateFormat("dd/MM/yyyy")); // Ưu tiên định dạng này trước
                    formats.add(new SimpleDateFormat("yyyy-MM-dd"));
                    formats.add(new SimpleDateFormat("MM/dd/yyyy"));
                    
                    boolean parseSuccess = false;
                    
                    for (SimpleDateFormat format : formats) {
                        try {
                            startDate = format.parse(startDateStr);
                            endDate = format.parse(endDateStr);
                            parseSuccess = true;
                            System.out.println("Phân tích thành công với định dạng: " + format.toPattern());
                            break;
                        } catch (ParseException e) {
                            // Thử định dạng tiếp theo
                            continue;
                        }
                    }
                    
                    if (!parseSuccess) {
                        model.addAttribute("error", "Không thể phân tích định dạng ngày. Vui lòng sử dụng định dạng dd/MM/yyyy hoặc yyyy-MM-dd.");
                        return "Admin/thongke";
                    }
                    
                    // Điều chỉnh endDate để bao gồm cả ngày kết thúc (23:59:59)
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(endDate);
                    calendar.set(Calendar.HOUR_OF_DAY, 23);
                    calendar.set(Calendar.MINUTE, 59);
                    calendar.set(Calendar.SECOND, 59);
                    endDate = calendar.getTime();

                    System.out.println("Ngày bắt đầu: " + startDate); // Log
                    System.out.println("Ngày kết thúc: " + endDate);   // Log

                    List<DonHang> donHangs = donHangRepository.findByNgayDatHangBetween(startDate, endDate);
                    System.out.println("Số lượng đơn hàng tìm thấy: " + donHangs.size()); // Log
                    
                    // Thêm thông tin tất cả đơn hàng để debug
                    model.addAttribute("totalOrders", donHangs.size());

                    List<DonHang> donHangDaGiao = donHangs.stream()
                            .filter(dh -> DonHang.TrangThai.DA_GIAO.equals(dh.getTrangThai()))
                            .collect(Collectors.toList());
                    System.out.println("Số lượng đơn hàng đã giao: " + donHangDaGiao.size()); // Log
                    
                    // Thêm thông tin đơn hàng đã giao để debug
                    model.addAttribute("deliveredOrders", donHangDaGiao.size());
                    
                    Map<String, BigDecimal> doanhThuTheoNgay = new HashMap<>();
                    SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");

                    for (DonHang donHang : donHangDaGiao) {
                        String ngay = dayFormat.format(donHang.getNgayDatHang());
                        BigDecimal tongThanhToan = donHang.getTongThanhToan();
                        doanhThuTheoNgay.put("\"" + ngay + "\"", doanhThuTheoNgay.getOrDefault("\"" + ngay + "\"", BigDecimal.ZERO).add(tongThanhToan));
                    }

                    System.out.println("Dữ liệu doanh thu theo ngày: " + doanhThuTheoNgay); // Log
                    
                    model.addAttribute("doanhThuTheoNgay", doanhThuTheoNgay);
                    
                    // Sử dụng định dạng yyyy-MM-dd cho hiển thị
                    SimpleDateFormat displayFormat = new SimpleDateFormat("yyyy-MM-dd");
                    model.addAttribute("startDate", displayFormat.format(startDate));
                    model.addAttribute("endDate", displayFormat.format(endDate));
                    
                    // Tính tổng doanh thu
                    BigDecimal tongDoanhThu = BigDecimal.ZERO;
                    for (BigDecimal value : doanhThuTheoNgay.values()) {
                        tongDoanhThu = tongDoanhThu.add(value);
                    }
                    model.addAttribute("tongDoanhThu", tongDoanhThu);
                    
                    // Nếu không có dữ liệu doanh thu, hiển thị thông báo cụ thể
                    if (doanhThuTheoNgay.isEmpty()) {
                        model.addAttribute("noDataMessage", "Không có dữ liệu doanh thu từ đơn hàng đã giao trong khoảng thời gian này.");
                    }

                } else {
                    model.addAttribute("error", "Khoảng thời gian không hợp lệ. Vui lòng chọn đúng định dạng.");
                }

            } catch (Exception e) {
                // Include the detailed error message and value that caused the problem
                model.addAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
                e.printStackTrace();
            }
        }

        return "Admin/thongke";
    }
    
    @GetMapping("/thongke/banhang")
    public String thongKeBanHang(
            @RequestParam(value = "startDate", required = false) String startDateStr,
            @RequestParam(value = "endDate", required = false) String endDateStr,
            Model model) {
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate;
        Date endDate;
        
        try {
            // Nếu không có tham số ngày, sử dụng 30 ngày gần nhất
            if (startDateStr == null || endDateStr == null) {
                endDate = new Date(); // Ngày hiện tại
                
                // Tính ngày bắt đầu (30 ngày trước)
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(endDate);
                calendar.add(Calendar.DAY_OF_MONTH, -30);
                startDate = calendar.getTime();
            } else {
                // Sử dụng các ngày từ request params
                startDate = dateFormat.parse(startDateStr);
                endDate = dateFormat.parse(endDateStr);
            }
            
            // Lấy danh sách đơn hàng trong khoảng thời gian
            List<DonHang> allDonHangs = donHangRepository.findByNgayDatHangBetween(startDate, endDate);
            
            // Lấy danh sách đơn hàng đã giao trong khoảng thời gian
            List<DonHang> donHangsDaGiao = donHangRepository.findByNgayDatHangBetweenAndTrangThai(
                startDate, endDate, DonHang.TrangThai.DA_GIAO);
            
            // Tính tổng doanh thu từ đơn hàng đã giao
            BigDecimal tongDoanhThu = BigDecimal.ZERO;
            int tongSoLuongSanPham = 0;
            
            // Tính toán các chỉ số thống kê khác
            for (DonHang donHang : donHangsDaGiao) {
                tongDoanhThu = tongDoanhThu.add(donHang.getTongThanhToan());
                for (ChiTietDonHang chiTiet : donHang.getChiTietDonHangs()) {
                    tongSoLuongSanPham += chiTiet.getSoLuong();
                }
            }
            
            // Thống kê đơn hàng theo trạng thái
            Map<DonHang.TrangThai, Long> thongKeTheoTrangThai = new HashMap<>();
            for (DonHang.TrangThai trangThai : DonHang.TrangThai.values()) {
                long count = allDonHangs.stream()
                    .filter(dh -> trangThai.equals(dh.getTrangThai()))
                    .count();
                thongKeTheoTrangThai.put(trangThai, count);
            }
            
            // Thống kê doanh thu theo ngày
            Map<String, Object> thongKeTheoNgay = new HashMap<>();
            SimpleDateFormat dayFormat = new SimpleDateFormat("dd/MM");
            Map<String, BigDecimal> doanhThuTheoNgay = new HashMap<>();
            Map<String, Integer> donHangTheoNgay = new HashMap<>();
            Map<String, Integer> sanPhamTheoNgay = new HashMap<>();
            
            // Tạo danh sách chi tiết doanh thu theo ngày
            List<Map<String, Object>> chiTietTheoNgay = new ArrayList<>();
            
            // Duyệt đơn hàng để thống kê theo ngày
            for (DonHang donHang : donHangsDaGiao) {
                String ngay = dayFormat.format(donHang.getNgayDatHang());
                
                // Cập nhật doanh thu theo ngày
                BigDecimal doanhThuNgay = doanhThuTheoNgay.getOrDefault(ngay, BigDecimal.ZERO);
                doanhThuNgay = doanhThuNgay.add(donHang.getTongThanhToan());
                doanhThuTheoNgay.put(ngay, doanhThuNgay);
                
                // Cập nhật số đơn hàng theo ngày
                donHangTheoNgay.put(ngay, donHangTheoNgay.getOrDefault(ngay, 0) + 1);
                
                // Đếm số sản phẩm theo ngày
                int soSanPham = 0;
                for (ChiTietDonHang chiTiet : donHang.getChiTietDonHangs()) {
                    soSanPham += chiTiet.getSoLuong();
                }
                sanPhamTheoNgay.put(ngay, sanPhamTheoNgay.getOrDefault(ngay, 0) + soSanPham);
                
                // Thêm chi tiết ngày vào danh sách nếu chưa có
                boolean ngayDaTonTai = chiTietTheoNgay.stream()
                    .anyMatch(item -> item.get("ngay").equals(ngay));
                
                if (!ngayDaTonTai) {
                    Map<String, Object> chiTiet = new HashMap<>();
                    chiTiet.put("ngay", ngay);
                    chiTiet.put("doanhThu", doanhThuNgay);
                    chiTiet.put("soDonHang", donHangTheoNgay.get(ngay));
                    chiTiet.put("soSanPham", sanPhamTheoNgay.get(ngay));
                    chiTietTheoNgay.add(chiTiet);
                } else {
                    // Cập nhật chi tiết ngày đã tồn tại
                    for (Map<String, Object> chiTiet : chiTietTheoNgay) {
                        if (chiTiet.get("ngay").equals(ngay)) {
                            chiTiet.put("doanhThu", doanhThuNgay);
                            chiTiet.put("soDonHang", donHangTheoNgay.get(ngay));
                            chiTiet.put("soSanPham", sanPhamTheoNgay.get(ngay));
                            break;
                        }
                    }
                }
            }
            
            // Truyền dữ liệu đến view
            model.addAttribute("tongDoanhThu", tongDoanhThu);
            model.addAttribute("tongSoDonHang", donHangsDaGiao.size());
            model.addAttribute("tongSoLuongSanPham", tongSoLuongSanPham);
            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);
            model.addAttribute("thongKeTheoTrangThai", thongKeTheoTrangThai);
            model.addAttribute("doanhThuTheoNgay", doanhThuTheoNgay);
            model.addAttribute("chiTietTheoNgay", chiTietTheoNgay);
            
            // Chuyển dữ liệu sang định dạng JSON cho biểu đồ
            model.addAttribute("labelsDoanhThu", doanhThuTheoNgay.keySet());
            model.addAttribute("dataDoanhThu", doanhThuTheoNgay.values());
            
            // Labels và data cho biểu đồ trạng thái đơn hàng
            List<String> labelsTrangThai = new ArrayList<>();
            List<Long> dataTrangThai = new ArrayList<>();
            
            for (Map.Entry<DonHang.TrangThai, Long> entry : thongKeTheoTrangThai.entrySet()) {
                labelsTrangThai.add(entry.getKey().getMoTa());
                dataTrangThai.add(entry.getValue());
            }
            
            model.addAttribute("labelsTrangThai", labelsTrangThai);
            model.addAttribute("dataTrangThai", dataTrangThai);
            
        } catch (ParseException e) {
            model.addAttribute("error", "Lỗi định dạng ngày: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            model.addAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            e.printStackTrace();
        }
        
        return "Admin/thongke-banhang";
    }
}