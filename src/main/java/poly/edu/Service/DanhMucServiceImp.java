package poly.edu.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import poly.edu.Model.DanhMuc; // Đảm bảo đúng package của Model DanhMuc
import poly.edu.Repository.DanhMucRepository; // Đảm bảo đúng package của Repository DanhMuc

@Service // Đánh dấu đây là một Spring Service
public class DanhMucServiceImp implements DanhMucService {

    private final DanhMucRepository danhMucRepository;

    // Sử dụng Constructor Injection là cách được khuyến khích hơn Field Injection (@Autowired trên thuộc tính)
    @Autowired
    public DanhMucServiceImp(DanhMucRepository danhMucRepository) {
        this.danhMucRepository = danhMucRepository;
    }

    @Override
    public List<DanhMuc> getAllCategories() {
        return danhMucRepository.findAll(); // Sử dụng phương thức có sẵn của JpaRepository
    }

    @Override
    public List<DanhMuc> getCategoriesByLoai(String loai) {
        return danhMucRepository.findByLoai(loai); // Sử dụng phương thức custom bạn đã định nghĩa
    }

    @Override
    public List<DanhMuc> getCarCategories() {
        return danhMucRepository.findByLoai("xe"); // Gọi phương thức custom với tham số "xe"
    }

    @Override
    public List<DanhMuc> getAccessoryCategories() {
        return danhMucRepository.findByLoai("phu_kien"); // Gọi phương thức custom với tham số "phu_kien"
    }

    @Override
    public Optional<DanhMuc> getCategoryByName(String name) {
         // Để tìm theo tên hiệu quả, bạn nên thêm phương thức findByTenDanhMuc(String tenDanhMuc) vào Repository
         // Nếu bạn đã thêm, hãy sử dụng nó:
         // return danhMucRepository.findByTenDanhMuc(name);

         // Nếu chưa thêm phương thức vào Repository, bạn có thể tìm kiếm trong danh sách getAllCategories() (kém hiệu quả hơn với dữ liệu lớn)
         return danhMucRepository.findAll().stream()
                 .filter(cat -> cat.getTenDanhMuc() != null && cat.getTenDanhMuc().equalsIgnoreCase(name))
                 .findFirst(); // Lấy phần tử đầu tiên tìm thấy
    }

    @Override
    public Optional<DanhMuc> getCategoryById(Long id) {
        return danhMucRepository.findById(id); // Sử dụng phương thức có sẵn của JpaRepository
    }

    // Implement các phương thức save, delete... nếu có trong Interface
    // @Override
    // @Transactional // Đảm bảo giao dịch
    // public DanhMuc saveCategory(DanhMuc danhMuc) {
    //     return danhMucRepository.save(danhMuc);
    // }

    // @Override
    // @Transactional
    // public void deleteCategory(Long id) {
    //     danhMucRepository.deleteById(id);
    // }
}