package poly.edu.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import poly.edu.Model.PhuKienOto;
import poly.edu.Service.PhuKienOtoService;

@Controller
public class DetailController {

    @Autowired
    private PhuKienOtoService phuKienOtoService;

    @GetMapping("/detail1")
    public ModelAndView showDetail(@RequestParam("accessoryID") Long accessoryID) {
        ModelAndView modelAndView = new ModelAndView("detail1");

        // Lấy thông tin phụ kiện từ service
        PhuKienOto phukien = phuKienOtoService.findById(accessoryID);

        // Kiểm tra xem phụ kiện có tồn tại không
        if (phukien == null) {
            // Xử lý trường hợp không tìm thấy phụ kiện, ví dụ: chuyển hướng đến trang lỗi
            return new ModelAndView("error");
        }

        // Thêm thông tin phụ kiện vào model
        modelAndView.addObject("phukien", phukien);

        return modelAndView;
    }
}