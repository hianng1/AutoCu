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
        	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-M-d"); // Sử dụng M và d viết thường
            Date startDate;
            Date endDate;

            try {
                String[] dates = reportRange.split(" to ");
                startDate = dateFormat.parse(dates[0]);
                endDate = dateFormat.parse(dates[1]);

                List<DonHang> donHangs = donHangRepository.findByNgayDatHangBetween(startDate, endDate);
                List<DonHang> donHangDaGiao = donHangs.stream()
                        .filter(dh -> DonHang.TrangThai.DA_GIAO.equals(dh.getTrangThai()))
                        .collect(Collectors.toList());

                Map<String, BigDecimal> doanhThuTheoNgay = new HashMap<>();
                SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");


for (DonHang donHang : donHangDaGiao) {
    String ngay = dayFormat.format(donHang.getNgayDatHang());
    BigDecimal tongThanhToan = donHang.getTongThanhToan();
    // Thêm dấu nháy kép vào key khi put vào map
    doanhThuTheoNgay.put("\"" + ngay + "\"", doanhThuTheoNgay.getOrDefault("\"" + ngay + "\"", BigDecimal.ZERO).add(tongThanhToan));
}

                model.addAttribute("doanhThuTheoNgay", doanhThuTheoNgay);
                model.addAttribute("startDate", dateFormat.format(startDate));
                model.addAttribute("endDate", dateFormat.format(endDate));

            } catch (ParseException e) {
                model.addAttribute("error", "Invalid date format");
            }
        }

        return "Admin/thongke";
    }}
