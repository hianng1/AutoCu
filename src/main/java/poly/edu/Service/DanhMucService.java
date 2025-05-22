package poly.edu.Service;

import java.util.List;
import java.util.Optional; // Import Optional

import poly.edu.Model.DanhMuc; // Đảm bảo đúng package của Model DanhMuc

public interface DanhMucService {

    // Lấy tất cả danh mục
    List<DanhMuc> getAllCategories();

    // Lấy danh mục theo loại ('xe', 'phu_kien')
    List<DanhMuc> getCategoriesByLoai(String loai);

    // Lấy danh mục xe
    List<DanhMuc> getCarCategories();

    // Lấy danh mục phụ kiện
    List<DanhMuc> getAccessoryCategories();

    // Lấy danh mục theo tên (để hỗ trợ lọc từ Controller)
    // Sử dụng Optional vì có thể không tìm thấy danh mục
    Optional<DanhMuc> getCategoryByName(String name);

    // Lấy danh mục theo ID (nếu cần cho các thao tác khác)
    Optional<DanhMuc> getCategoryById(Long id);

    // Có thể thêm các phương thức khác như save, delete nếu cần quản lý danh mục
    // DanhMuc saveCategory(DanhMuc danhMuc);
    // void deleteCategory(Long id);
}