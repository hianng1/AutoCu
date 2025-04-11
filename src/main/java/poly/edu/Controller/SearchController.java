package poly.edu.Controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import poly.edu.DAO.PhuKienOtoDAO;
import poly.edu.Model.PhuKienOto;

@Controller
public class SearchController {

    @Autowired
    private PhuKienOtoDAO phuKienOtoDAO;

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String keyword, Model model) {
        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Chỉ trim() từ khóa, không thêm % vì đã được xử lý trong query
                String searchKeyword = keyword.trim();
                List<PhuKienOto> searchResults = phuKienOtoDAO.findByTenPhuKienContaining(searchKeyword);
                model.addAttribute("searchResults", searchResults);
                model.addAttribute("keyword", searchKeyword);
            } else {
                model.addAttribute("searchResults", null);
                model.addAttribute("keyword", "");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tìm kiếm: " + e.getMessage());
            model.addAttribute("searchResults", null);
            model.addAttribute("keyword", keyword != null ? keyword.trim() : "");
        }
        return "search";
    }
} 