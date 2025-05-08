package poly.edu.Controller;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Repository.ChiTietDonHangRepository;
import poly.edu.Repository.DonHangRepository;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itextpdf.text.Document;

import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;



import java.util.stream.Stream;




@Controller
@RequestMapping("/donhang")
@RequiredArgsConstructor
public class DonHangController {

    private final DonHangRepository donHangRepo;


    @Autowired
    private DonHangRepository donHangRepository; 
    
    @Autowired
    private ChiTietDonHangRepository chiTietDonHangRepository;

    // ✅ Hiển thị danh sách đơn hàng với lọc theo trạng thái
    @GetMapping
    public String listDonHang(@RequestParam(name = "trangThai", required = false) DonHang.TrangThai trangThai, Model model) {
        List<DonHang> danhSach;

        if (trangThai != null) {
            danhSach = donHangRepo.findByTrangThai(trangThai);
        } else {
            danhSach = donHangRepo.findAll();
        }

        model.addAttribute("donHangs", danhSach);
        model.addAttribute("trangThaiSelected", trangThai);
        model.addAttribute("trangThais", DonHang.TrangThai.values());
        return "Admin/Quanlydonhang"; // trỏ tới file quanlydonhang
    }

    // ✅ Cập nhật trạng thái đơn hàng
    @PostMapping("/update/{id}")
    public String updateTrangThai(@PathVariable("id") Long id, @RequestParam("trangThai") DonHang.TrangThai trangThai) {
        DonHang donHang = donHangRepo.findById(id).orElse(null);
        if (donHang != null) {
            donHang.setTrangThai(trangThai);
            donHangRepo.save(donHang);
        }
        return "redirect:/donhang";
    }
    @GetMapping("/chitiet/{id}")
    public String xemChiTietDonHang(@PathVariable("id") Long id, Model model) {
        DonHang donHang = donHangRepository.findById(id).orElse(null);
        if (donHang == null) {
            return "redirect:/donhang";
        }

        List<ChiTietDonHang> chiTietDonHangs = chiTietDonHangRepository.findByDonHangOrderByOrderItemIDAsc(donHang);
        model.addAttribute("donHang", donHang);
        model.addAttribute("chiTietDonHangs", chiTietDonHangs);

        return "Admin/chitietdonhang"; // Trang JSP
    }

    @GetMapping("/api/donhang/thongke")
    public Map<String, Object> thongKeDonHang() {
        List<Object[]> thongKeList = donHangRepository.thongKeDonHangTheoTrangThai();

        // Chuẩn bị labels và data cho biểu đồ
        List<String> labels = new java.util.ArrayList<>();
        List<Long> data = new java.util.ArrayList<>();

        for (Object[] row : thongKeList) {
            DonHang.TrangThai trangThai = (DonHang.TrangThai) row[0];
            Long soLuong = (Long) row[1];

            labels.add(trangThai.getMoTa()); // Lấy mô tả tiếng Việt
            data.add(soLuong);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("labels", labels);
        response.put("data", data);

        return response; // JSON: { labels: [...], data: [...] }
    }
    // xuất hóa đơn 
    @RequestMapping(value = "/xuatpdf/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    public ResponseEntity<byte[]> xuatHoaDonPdf(@PathVariable("id") Long id) {
        try {
            DonHang donHang = donHangRepository.findById(id).orElse(null);
            if (donHang == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            List<ChiTietDonHang> chiTietDonHangs = chiTietDonHangRepository.findByDonHangOrderByOrderItemIDAsc(donHang);

            // Tạo PDF vào ByteArrayOutputStream thay vì file
            byte[] pdfBytes = exportToPdfBytes(donHang, chiTietDonHangs);
            
            // Tạo header cho phản hồi để yêu cầu browser tải xuống file
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "hoadon_" + id + ".pdf");
            headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
            
            // Trả về file PDF để browser tự động tải xuống
            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    // Phương thức tạo PDF và trả về mảng byte
    public byte[] exportToPdfBytes(DonHang donHang, List<ChiTietDonHang> chiTietDonHangs) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();
        PdfWriter.getInstance(document, baos);
        document.open();

        Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
        Paragraph title = new Paragraph("Chi tiết đơn hàng #" + donHang.getOrderID(), font);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        document.add(new Paragraph("Ngày đặt: " + donHang.getNgayDatHang()));
        document.add(new Paragraph("Trạng thái: " + donHang.getTrangThai().getMoTa()));
        document.add(new Paragraph(" "));

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);

        Stream.of("ID", "Tên sản phẩm", "Số lượng", "Đơn giá", "Thành tiền").forEach(headerTitle -> {
            PdfPCell header = new PdfPCell();
            header.setPhrase(new Phrase(headerTitle));
            table.addCell(header);
        });

        for (ChiTietDonHang ct : chiTietDonHangs) {
            table.addCell(String.valueOf(ct.getOrderItemID()));
            table.addCell(ct.getTenSanPham());
            table.addCell(String.valueOf(ct.getSoLuong()));
            table.addCell(String.valueOf(ct.getDonGia()));
            table.addCell(String.valueOf(ct.getThanhTien()));
        }

        document.add(table);
        document.close();
        
        return baos.toByteArray();
    }



}
