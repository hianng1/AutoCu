package poly.edu.Controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.SanPham;
import poly.edu.Repository.DanhMucRepository;
import poly.edu.Repository.HinhAnhSanPhamRepository;
import poly.edu.Repository.SanPhamRepository;
import poly.edu.Service.SanPhamService;

@Controller
@RequestMapping("/sanpham")
public class SanPhamController {

    @Autowired
    private SanPhamService sanPhamService;

    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Autowired
    private DanhMucRepository danhMucRepository;

    @Autowired
    private HinhAnhSanPhamRepository hinhAnhSanPhamRepository;

    @Value("${upload.path}")
    private String uploadDir;

    // Hiển thị danh sách sản phẩm
    @GetMapping
    public String listSanPham(Model model) {
        model.addAttribute("dsSanPham", sanPhamService.getAllSanPham());
        return "sanpham/list"; // Trả về trang list.jsp
    }

    // Hiển thị form thêm sản phẩm
    @GetMapping("/them")
    public String showFormThem(Model model) {
        model.addAttribute("sanPham", new SanPham());
        model.addAttribute("danhMucs", sanPhamService.getAllDanhMuc());
        return "sanpham/form"; // Trả về trang form.jsp
    }

    @PostMapping("/saveSanPham")
    public String saveSanPham(@ModelAttribute SanPham sanPham,
            @RequestParam("categoryID") Long categoryID,
            @RequestParam("file") MultipartFile file) {
        try {
            // Kiểm tra nếu có upload file
            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();

                // Tạo đường dẫn tuyệt đối tới thư mục lưu ảnh
                Path uploadPath = Paths.get(uploadDir);

                // Tạo thư mục nếu chưa tồn tại
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                // Đường dẫn file đầy đủ
                Path filePath = uploadPath.resolve(fileName);

                // Ghi file vào ổ đĩa
                Files.write(filePath, file.getBytes());

                // Lưu tên file vào DB
                sanPham.setAnhDaiDien(fileName);
            }

            // Gán danh mục
            DanhMuc danhMuc = danhMucRepository.findById(categoryID).orElse(null);
            sanPham.setDanhMuc(danhMuc);

            // Lưu hoặc cập nhật
            sanPhamRepository.save(sanPham);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/sanpham";
    }

    // Hiển thị form sửa sản phẩm
    @GetMapping("/sua/{productID}")
    public String showFormSua(@PathVariable("productID") Long productID, Model model) {
        model.addAttribute("sanPham", sanPhamService.getSanPhamById(productID).orElse(null));
        model.addAttribute("danhMucs", sanPhamService.getAllDanhMuc());
        return "sanpham/form";
    }

    // Xóa sản phẩm
    @GetMapping("/xoa/{productID}")
    public String deleteSanPham(@PathVariable("productID") Long productID) {
        sanPhamService.deleteSanPham(productID);
        return "redirect:/sanpham";
    }
}
