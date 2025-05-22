package poly.edu.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import poly.edu.DAO.PhuKienOtoDAO;
import poly.edu.DAO.SanPhamDAO;
import poly.edu.Model.PhuKienOto;
import poly.edu.Model.SanPham;

@Controller
public class SearchController {

    @Autowired
    private PhuKienOtoDAO phuKienOtoDAO;

    @Autowired
    private SanPhamDAO sanPhamDAO;

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String keyword,
                          @RequestParam(required = false, defaultValue = "all") String type,
                          Model model) {
        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Chỉ trim() từ khóa, không thêm % vì đã được xử lý trong query
                String searchKeyword = keyword.trim();

                // Danh sách kết quả cho phụ kiện và xe
                List<PhuKienOto> phuKienResults = new ArrayList<>();
                List<SanPham> sanPhamResults = new ArrayList<>();

                // Tìm kiếm theo loại được chọn
                if ("all".equals(type) || "phukien".equals(type)) {
                    phuKienResults = phuKienOtoDAO.findByTenPhuKienContaining(searchKeyword);
                }

                if ("all".equals(type) || "xe".equals(type)) {
                    sanPhamResults = sanPhamDAO.searchByKeyword(searchKeyword);
                }

                // Thêm kết quả vào model
                model.addAttribute("phuKienResults", phuKienResults);
                model.addAttribute("sanPhamResults", sanPhamResults);
                model.addAttribute("totalResults", phuKienResults.size() + sanPhamResults.size());
                model.addAttribute("keyword", searchKeyword);
                model.addAttribute("type", type);
            } else {
                model.addAttribute("phuKienResults", new ArrayList<>());
                model.addAttribute("sanPhamResults", new ArrayList<>());
                model.addAttribute("totalResults", 0);
                model.addAttribute("keyword", "");
                model.addAttribute("type", type);
            }
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tìm kiếm: " + e.getMessage());
            model.addAttribute("phuKienResults", new ArrayList<>());
            model.addAttribute("sanPhamResults", new ArrayList<>());
            model.addAttribute("totalResults", 0);
            model.addAttribute("keyword", keyword != null ? keyword.trim() : "");
            model.addAttribute("type", type);
        }
        return "search";
    }
}