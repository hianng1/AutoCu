package poly.edu.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ThongkeController {

    // Định tuyến tới trang hiển thị biểu đồ
    @GetMapping("/thongke")
    public String showCharts() {
        return "Admin/thongke"; // trả về tên của JSP hoặc HTML
    }
}
