package poly.edu.Controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Admin")
public class AdminController {
    @GetMapping
    public String index(Model model) {
        return "Admin/quantri";
    }
        @GetMapping("/themnhanvien")
        public String showAddEmployeePage() {
            return "views/Admin/themnhanvien";
        }
        @GetMapping("/suanhanvien")
        public String editEmployeePage() {
            return "views/Admin/suanhanvien";
        }
}

