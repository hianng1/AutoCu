package poly.edu.DAO;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import poly.edu.Model.PhuKienOto;

@Repository
public interface PhuKienOtoDAO extends JpaRepository<PhuKienOto, Long> {
    @Query("SELECT p FROM PhuKienOto p WHERE LOWER(p.tenPhuKien) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<PhuKienOto> findByTenPhuKienContaining(@Param("keyword") String keyword);

    @Override
	Optional<PhuKienOto> findById(Long id);
}
