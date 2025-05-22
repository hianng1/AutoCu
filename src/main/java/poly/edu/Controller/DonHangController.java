package poly.edu.Controller;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import lombok.RequiredArgsConstructor;
import poly.edu.Model.ChiTietDonHang;
import poly.edu.Model.DonHang;
import poly.edu.Repository.ChiTietDonHangRepository;
import poly.edu.Repository.DonHangRepository;

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
    public String listDonHang(@RequestParam(name = "trangThai", required = false) DonHang.TrangThai trangThai,
            Model model) {
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
    @RequestMapping(value = "/xuatpdf/{id}", method = { RequestMethod.POST, RequestMethod.GET })
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
        PdfWriter writer = PdfWriter.getInstance(document, baos);
        document.open();

        // Thiết lập font hỗ trợ tiếng Việt
        BaseFont baseFont = BaseFont.createFont("c:\\windows\\fonts\\arial.ttf", BaseFont.IDENTITY_H,
                BaseFont.EMBEDDED);

        // Thiết lập fonts với Unicode support
        Font titleFont = new Font(baseFont, 20, Font.BOLD, new BaseColor(44, 62, 80));
        Font headerFont = new Font(baseFont, 12, Font.BOLD, new BaseColor(44, 62, 80));
        Font normalFont = new Font(baseFont, 10, Font.NORMAL);
        Font boldFont = new Font(baseFont, 10, Font.BOLD);
        Font smallFont = new Font(baseFont, 8, Font.NORMAL);
        Font smallBoldFont = new Font(baseFont, 8, Font.BOLD);
        Font largeBoldFont = new Font(baseFont, 14, Font.BOLD, new BaseColor(231, 76, 60));

        // Thêm tiêu đề và logo
        Paragraph companyName = new Paragraph("AUTO CŨ - XE MÁY & Ô TÔ", titleFont);
        companyName.setAlignment(Element.ALIGN_CENTER);
        document.add(companyName);

        Paragraph companyDetails = new Paragraph(
                "Địa chỉ: 123 Nguyễn Văn Linh, Quận 7, TP.HCM\nĐiện thoại: (028) 5267 3916 - Email: info@autocu.com.vn\nWebsite: www.autocu.com.vn",
                smallFont);
        companyDetails.setAlignment(Element.ALIGN_CENTER);
        document.add(companyDetails);

        // Thêm đường kẻ ngang
        com.itextpdf.text.pdf.draw.LineSeparator ls = new com.itextpdf.text.pdf.draw.LineSeparator();
        ls.setLineColor(new BaseColor(189, 195, 199));
        document.add(new Chunk(ls));

        // Tiêu đề hóa đơn
        Paragraph title = new Paragraph("HÓA ĐƠN BÁN HÀNG", headerFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingBefore(10);
        title.setSpacingAfter(10);
        document.add(title);

        // Mã đơn hàng và ngày đặt
        PdfPTable infoTable = new PdfPTable(2);
        infoTable.setWidthPercentage(100);
        infoTable.setSpacingBefore(10);
        infoTable.setSpacingAfter(10);

        PdfPCell cell;

        // Mã đơn hàng
        cell = new PdfPCell(new Phrase("MÃ ĐƠN HÀNG: #" + donHang.getOrderID(), headerFont));
        cell.setBorder(0);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        infoTable.addCell(cell);

        // Ngày đặt hàng
        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        cell = new PdfPCell(new Phrase("NGÀY ĐẶT: " + dateFormat.format(donHang.getNgayDatHang()), headerFont));
        cell.setBorder(0);
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        infoTable.addCell(cell);

        document.add(infoTable);

        // Thông tin khách hàng và đơn hàng
        PdfPTable customerOrderTable = new PdfPTable(2);
        customerOrderTable.setWidthPercentage(100);
        customerOrderTable.setSpacingBefore(10);
        float[] columnWidths = { 1f, 1f };
        customerOrderTable.setWidths(columnWidths);

        // Thông tin khách hàng
        PdfPTable customerTable = new PdfPTable(1);
        customerTable.setWidthPercentage(100);

        cell = new PdfPCell(new Phrase("THÔNG TIN KHÁCH HÀNG", boldFont));
        cell.setBackgroundColor(new BaseColor(236, 240, 241));
        cell.setPadding(5);
        customerTable.addCell(cell);

        cell = new PdfPCell();
        cell.setPadding(5);

        Paragraph customerInfo = new Paragraph();
        customerInfo.add(new Chunk("Tên khách hàng: ", boldFont));
        customerInfo.add(new Chunk(donHang.getUser().getHovaten(), normalFont));
        customerInfo.add(Chunk.NEWLINE);

        customerInfo.add(new Chunk("Số điện thoại: ", boldFont));
        customerInfo.add(new Chunk(donHang.getUser().getSodienthoai(), normalFont));
        customerInfo.add(Chunk.NEWLINE);

        customerInfo.add(new Chunk("Email: ", boldFont));
        customerInfo.add(new Chunk(donHang.getUser().getEmail(), normalFont));
        customerInfo.add(Chunk.NEWLINE);

        customerInfo.add(new Chunk("Địa chỉ giao hàng: ", boldFont));
        customerInfo.add(new Chunk(donHang.getDiaChiGiaoHang(), normalFont));

        cell.addElement(customerInfo);
        customerTable.addCell(cell);

        PdfPCell customerCell = new PdfPCell(customerTable);
        customerCell.setBorder(0);
        customerOrderTable.addCell(customerCell);

        // Thông tin đơn hàng
        PdfPTable orderTable = new PdfPTable(1);
        orderTable.setWidthPercentage(100);

        cell = new PdfPCell(new Phrase("THÔNG TIN ĐƠN HÀNG", boldFont));
        cell.setBackgroundColor(new BaseColor(236, 240, 241));
        cell.setPadding(5);
        orderTable.addCell(cell);

        cell = new PdfPCell();
        cell.setPadding(5);

        Paragraph orderInfo = new Paragraph();
        orderInfo.add(new Chunk("Trạng thái: ", boldFont));
        orderInfo.add(new Chunk(donHang.getTrangThai().getMoTa(), normalFont));
        orderInfo.add(Chunk.NEWLINE);

        orderInfo.add(new Chunk("Phương thức vận chuyển: ", boldFont));
        orderInfo.add(new Chunk(donHang.getPhuongThucVanChuyen(), normalFont));
        orderInfo.add(Chunk.NEWLINE);

        orderInfo.add(new Chunk("Phương thức thanh toán: ", boldFont));
        orderInfo.add(new Chunk(donHang.getPhuongThucThanhToan(), normalFont));
        orderInfo.add(Chunk.NEWLINE);

        orderInfo.add(new Chunk("Đã thanh toán: ", boldFont));
        orderInfo.add(new Chunk(donHang.isDaThanhToan() ? "Có" : "Chưa", normalFont));

        if (donHang.getGhiChu() != null && !donHang.getGhiChu().isEmpty()) {
            orderInfo.add(Chunk.NEWLINE);
            orderInfo.add(new Chunk("Ghi chú: ", boldFont));
            orderInfo.add(new Chunk(donHang.getGhiChu(), normalFont));
        }

        cell.addElement(orderInfo);
        orderTable.addCell(cell);

        PdfPCell orderCell = new PdfPCell(orderTable);
        orderCell.setBorder(0);
        customerOrderTable.addCell(orderCell);

        document.add(customerOrderTable);

        // Tiêu đề chi tiết đơn hàng
        Paragraph detailsTitle = new Paragraph("CHI TIẾT SẢN PHẨM", headerFont);
        detailsTitle.setAlignment(Element.ALIGN_LEFT);
        detailsTitle.setSpacingBefore(15);
        detailsTitle.setSpacingAfter(10);
        document.add(detailsTitle);

        // Bảng chi tiết đơn hàng
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);

        // Thiết lập độ rộng các cột
        float[] columnProductWidths = { 0.5f, 2f, 0.5f, 1f, 1f };
        table.setWidths(columnProductWidths);

        // Headers
        String[] headers = { "ID", "Tên sản phẩm", "Số lượng", "Đơn giá", "Thành tiền" };
        for (String header : headers) {
            cell = new PdfPCell(new Phrase(header, boldFont));
            cell.setBackgroundColor(new BaseColor(52, 152, 219));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setPadding(5);
            cell.setBorderColor(new BaseColor(189, 195, 199));
            table.addCell(cell);
        }

        // Dữ liệu sản phẩm
        java.text.NumberFormat currencyFormat = java.text.NumberFormat
                .getCurrencyInstance(new java.util.Locale("vi", "VN"));

        for (ChiTietDonHang ct : chiTietDonHangs) {
            // ID
            cell = new PdfPCell(new Phrase(String.valueOf(ct.getOrderItemID()), normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            cell.setBorderColor(new BaseColor(189, 195, 199));
            table.addCell(cell);

            // Tên sản phẩm
            cell = new PdfPCell(new Phrase(ct.getTenSanPham(), normalFont));
            cell.setPadding(5);
            cell.setBorderColor(new BaseColor(189, 195, 199));
            table.addCell(cell);

            // Số lượng
            cell = new PdfPCell(new Phrase(String.valueOf(ct.getSoLuong()), normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            cell.setBorderColor(new BaseColor(189, 195, 199));
            table.addCell(cell);

            // Đơn giá
            String donGiaStr = currencyFormat.format(ct.getDonGia()).replace("₫", "đ");
            cell = new PdfPCell(new Phrase(donGiaStr, normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setPadding(5);
            cell.setBorderColor(new BaseColor(189, 195, 199));
            table.addCell(cell);

            // Thành tiền
            String thanhTienStr = currencyFormat.format(ct.getThanhTien()).replace("₫", "đ");
            cell = new PdfPCell(new Phrase(thanhTienStr, normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setPadding(5);
            cell.setBorderColor(new BaseColor(189, 195, 199));
            table.addCell(cell);
        }

        document.add(table);

        // Tổng hợp thanh toán
        PdfPTable summaryTable = new PdfPTable(2);
        summaryTable.setWidthPercentage(50);
        summaryTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
        summaryTable.setSpacingBefore(15);

        // Phí vận chuyển (Removing the "Tổng tiền hàng" section)
        cell = new PdfPCell(new Phrase("Phí vận chuyển:", boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        cell.setBorder(0);
        cell.setPadding(5);
        summaryTable.addCell(cell);

        String phiVanChuyenStr = currencyFormat.format(donHang.getPhiVanChuyen()).replace("₫", "đ");
        cell = new PdfPCell(new Phrase(phiVanChuyenStr, normalFont));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        cell.setBorder(0);
        cell.setPadding(5);
        summaryTable.addCell(cell);

        // Vẽ đường kẻ
        cell = new PdfPCell(new Phrase(""));
        cell.setBorder(Rectangle.BOTTOM);
        cell.setBorderColor(new BaseColor(189, 195, 199));
        cell.setPadding(2);
        summaryTable.addCell(cell);

        cell = new PdfPCell(new Phrase(""));
        cell.setBorder(Rectangle.BOTTOM);
        cell.setBorderColor(new BaseColor(189, 195, 199));
        cell.setPadding(2);
        summaryTable.addCell(cell);

        // Tổng thanh toán
        cell = new PdfPCell(new Phrase("TỔNG THANH TOÁN:", largeBoldFont));
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        cell.setBorder(0);
        cell.setPadding(5);
        summaryTable.addCell(cell);

        String tongThanhToanStr = currencyFormat.format(donHang.getTongThanhToan()).replace("₫", "đ");
        cell = new PdfPCell(new Phrase(tongThanhToanStr, largeBoldFont));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        cell.setBorder(0);
        cell.setPadding(5);
        summaryTable.addCell(cell);

        document.add(summaryTable);

        // Thêm chân trang
        Paragraph footer = new Paragraph();
        footer.add(Chunk.NEWLINE);
        footer.add(Chunk.NEWLINE);
        footer.add(new Chunk("Cảm ơn quý khách đã mua hàng tại AUTO CŨ!", boldFont));
        footer.add(Chunk.NEWLINE);
        footer.add(new Chunk("Mọi thắc mắc và yêu cầu hỗ trợ vui lòng liên hệ:", normalFont));
        footer.add(Chunk.NEWLINE);
        footer.add(new Chunk("Hotline: +84 382 948 198 - Email: hotro@autocu.com.vn", normalFont));
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(30);
        document.add(footer);

        document.close();

        return baos.toByteArray();
    }

}
