package poly.edu.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.DanhMuc;
import poly.edu.Model.PhuKienOto;

@Repository
public interface PhuKienOtoRepository extends JpaRepository<PhuKienOto, Long> {

}