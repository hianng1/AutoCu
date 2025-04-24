package poly.edu.Model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DonHangRequest {
    private String hoTen;
    private String soDienThoai;
    private String diaChi;
    private String ghiChu;
    private String phuongThucVanChuyen;
    private String phuongThucThanhToan;
    private double tongTienHang;
    private double phiVanChuyen;
    private double tongThanhToan;
}
