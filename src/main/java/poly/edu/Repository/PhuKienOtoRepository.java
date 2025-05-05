package poly.edu.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.PhuKienOto;

@Repository
public interface PhuKienOtoRepository extends JpaRepository<PhuKienOto, Long> {


	@Override
	Optional<PhuKienOto> findById(Long accessoryID);
    // Tìm phụ kiện theo tên (Ví dụ: nếu bạn cần tìm phụ kiện theo tên)
    Optional<PhuKienOto> findByTenPhuKien(String tenPhuKien);

    // Tìm phụ kiện theo loại (nếu cần tìm theo loại)
	/* List<PhuKienOto> findByLoai(String loai); */
    List<PhuKienOto> findByDanhMuc(DanhMuc danhMuc);
    // Nếu cần cập nhật, bạn có thể sử dụng phương thức save() của JpaRepository để lưu đối tượng
    // Spring Data JPA sẽ tự động xử lý việc lưu hoặc cập nhật
	}

