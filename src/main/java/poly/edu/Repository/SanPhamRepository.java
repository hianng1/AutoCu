package poly.edu.Repository;

import java.util.List;
import java.util.Optional; // Cần import Optional nếu phương thức trả về Optional (như findById từ JpaRepository)

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.SanPham; // Đảm bảo đúng package của Entity SanPham
import poly.edu.Model.DanhMuc; // >>> THÊM DÒNG IMPORT NÀY <<< Đảm bảo đúng package của Entity DanhMuc

@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, Long> {

    // Phương thức hiện có của bạn
    List<SanPham> findByDanhMuc_CategoryIDAndProductIDNot(Long categoryID, Long productID);

    // --- THÊM CÁC PHƯƠNG THỨC MỚI DƯỚI ĐÂY ---

    /**
     * Tìm tất cả SanPham có DanhMuc liên kết có thuộc tính 'loai' khớp với giá trị được cung cấp.
     * Spring Data JPA tự động tạo truy vấn dựa trên tên phương thức.
     * Yêu cầu trong Entity SanPham có thuộc tính DanhMuc (ví dụ: private DanhMuc danhMuc;)
     * và trong Entity DanhMuc có thuộc tính loai (ví dụ: private String loai;).
     */
    List<SanPham> findByDanhMuc_Loai(String loai);

    /**
     * Tìm tất cả SanPham thuộc một DanhMuc cụ thể VÀ có DanhMuc liên kết có thuộc tính 'loai' khớp.
     * Hữu ích khi bạn muốn lọc sản phẩm của một loại cụ thể (ví dụ: xe) trong một danh mục cụ thể (ví dụ: Sedan).
     */
    List<SanPham> findByDanhMuc_LoaiAndDanhMuc(String loai, DanhMuc danhMuc);

     /**
      * Tìm tất cả SanPham liên kết trực tiếp với một đối tượng DanhMuc cụ thể.
      * Đôi khi đơn giản hơn findByDanhMuc_LoaiAndDanhMuc nếu bạn đã có sẵn đối tượng DanhMuc và chỉ cần lọc theo nó.
      */
     List<SanPham> findByDanhMuc(DanhMuc danhMuc);


    // --- Các phương thức sẵn có từ JpaRepository (không cần khai báo lại, nhưng liệt kê để dễ hình dung) ---
    // List<T> findAll();
    // Optional<T> findById(ID id);
    // boolean existsById(ID id);
    // long count();
    // void deleteById(ID id);
    // void delete(T entity);
    // void deleteAll(Iterable<? extends T> entities);
    // void deleteAll();
    // <S extends T> S save(S entity);
    // <S extends T> List<S> saveAll(Iterable<S> entities);
}