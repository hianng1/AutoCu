package poly.edu.Controller;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import poly.edu.Model.DanhMuc;
import poly.edu.Model.PhuKienOto;
import poly.edu.Repository.DanhMucRepository;
import poly.edu.Repository.PhuKienOtoRepository;
@Controller
@RequestMapping("/phukien")
public class PhuKienOtoController {

    @Autowired
    private PhuKienOtoRepository pkRepo;

    @Autowired
    private DanhMucRepository danhMucRepo;
    @GetMapping("/list")
    public String list(Model model) {
        List<PhuKienOto> list = pkRepo.findAll();
        model.addAttribute("items", list);
        return "phukien/list"; // phải trỏ đúng tới file JSP
    }


    // Hiển thị form tạo mới phụ kiện
    @GetMapping("/form")
    public String createForm(Model model) {
        PhuKienOto phuKienOto = new PhuKienOto();
        List<DanhMuc> danhMucList = danhMucRepo.findAll();
        model.addAttribute("phuKienOto", phuKienOto);
        model.addAttribute("danhMucList", danhMucList);
        return "phukien/form";  // Tên file JSP cho form tạo mới
    }

    // Xử lý form tạo mới phụ kiện
    @PostMapping("/save")
    public String savePhuKien(@ModelAttribute PhuKienOto phuKienOto,
                              @RequestParam("file") MultipartFile file,
                              @RequestParam("categoryId") Long categoryId) {
        try {
            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                String uploadDir = "D:/uploads/images/";
                Path filePath = Paths.get(uploadDir, fileName);
                Files.createDirectories(filePath.getParent());
                Files.write(filePath, file.getBytes());
                phuKienOto.setAnhDaiDien(fileName);
            }

            // Gán DanhMuc theo ID nhập tay
            DanhMuc danhMuc = danhMucRepo.findById(categoryId).orElse(null);
            if (danhMuc != null) {
                phuKienOto.setDanhMuc(danhMuc);
            }

            pkRepo.save(phuKienOto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/phukien/list";
    }


    // Hiển thị form chỉnh sửa phụ kiện
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        PhuKienOto phuKienOto = pkRepo.findById(id).orElse(null);
        if (phuKienOto == null) {
            return "redirect:/phukien/list";  // Nếu không tìm thấy phụ kiện, quay lại danh sách
        }
        List<DanhMuc> danhMucList = danhMucRepo.findAll();
        model.addAttribute("phuKienOto", phuKienOto);
        model.addAttribute("danhMucList", danhMucList);
        return "phukien/form";  // Tên file JSP cho form chỉnh sửa
    }

    // Xử lý form chỉnh sửa phụ kiện
    @PostMapping("/update")
    public String update(@Valid @ModelAttribute PhuKienOto phuKienOto,
                         BindingResult result,
                         @RequestParam("image") MultipartFile image,
                         @RequestParam("categoryId") Long categoryId,
                         Model model) {

        if (result.hasErrors()) {
            List<DanhMuc> danhMucList = danhMucRepo.findAll();
            model.addAttribute("danhMucList", danhMucList);
            return "phukien/edit";  // Quay lại form nếu có lỗi
        }

        // Xử lý ảnh nếu có thay đổi
        if (!image.isEmpty()) {
            String imageName = image.getOriginalFilename();
            try {
                image.transferTo(new java.io.File("src/main/resources/static/images/" + imageName));
                phuKienOto.setAnhDaiDien(imageName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Cập nhật danh mục mới
        DanhMuc danhMuc = danhMucRepo.findById(categoryId).orElse(null);
        if (danhMuc != null) {
            phuKienOto.setDanhMuc(danhMuc);
        }

        pkRepo.save(phuKienOto);
        return "redirect:/phukien/list";
    }


    // Xử lý xóa phụ kiện
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        pkRepo.deleteById(id);
        return "redirect:/phukien/list";  // Quay lại danh sách sau khi xóa
    }
}


