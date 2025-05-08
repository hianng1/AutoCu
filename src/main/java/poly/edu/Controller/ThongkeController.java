package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import poly.edu.Model.DonHang;
import poly.edu.Repository.DonHangRepository;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Controller
public class ThongkeController {

    @Autowired
    private DonHangRepository donHangRepository;

    @GetMapping("/thongke")
    public String thongKeDoanhThu(
        @RequestParam(value = "reportRange", required = false) String reportRange,
        Model model) {

        if (reportRange != null && !reportRange.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-M-d");
            Date startDate = null;
            Date endDate = null;

            try {
                String[] dates = reportRange.split(" to ");
                if (dates.length == 2) {
                    String startDateStr = dates[0].trim();
                    String endDateStr = dates[1].trim();
                    startDate = dateFormat.parse(startDateStr);
                    endDate = dateFormat.parse(endDateStr);

                    System.out.println("Ngày bắt đầu: " + startDate); // Log
                    System.out.println("Ngày kết thúc: " + endDate);   // Log

                    List<DonHang> donHangs = donHangRepository.findByNgayDatHangBetween(startDate, endDate);
                    System.out.println("Số lượng đơn hàng tìm thấy: " + donHangs.size()); // Log

                    List<DonHang> donHangDaGiao = donHangs.stream()
                            .filter(dh -> DonHang.TrangThai.DA_GIAO.equals(dh.getTrangThai()))
                            .collect(Collectors.toList());
                    System.out.println("Số lượng đơn hàng đã giao: " + donHangDaGiao.size()); // Log

                    Map<String, BigDecimal> doanhThuTheoNgay = new HashMap<>();
                    SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");

                    for (DonHang donHang : donHangDaGiao) {
                        String ngay = dayFormat.format(donHang.getNgayDatHang());
                        BigDecimal tongThanhToan = donHang.getTongThanhToan();
                        doanhThuTheoNgay.put("\"" + ngay + "\"", doanhThuTheoNgay.getOrDefault("\"" + ngay + "\"", BigDecimal.ZERO).add(tongThanhToan));
                    }

                    System.out.println("Dữ liệu doanh thu theo ngày: " + doanhThuTheoNgay); // Log
                    model.addAttribute("doanhThuTheoNgay", doanhThuTheoNgay);
                    model.addAttribute("startDate", dateFormat.format(startDate));
                    model.addAttribute("endDate", dateFormat.format(endDate));

                } else {
                    model.addAttribute("error", "Khoảng thời gian không hợp lệ. Vui lòng chọn đúng định dạng.");
                }

            } catch (ParseException e) {
                model.addAttribute("error", "Định dạng ngày không hợp lệ. Vui lòng chọn đúng định dạngプター-MM-DD.");
            }
        }

        return "Admin/thongke";
    }
}