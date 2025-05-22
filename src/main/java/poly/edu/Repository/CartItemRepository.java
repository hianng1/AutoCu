package poly.edu.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.GioHangChiTiet;

@Repository
public interface CartItemRepository extends JpaRepository<GioHangChiTiet, String> {

	/*
	 * Optional<GioHangChiTiet> findByCartIDandAccessoryID(Long CartID, Long
	 * AccessoryID);
	 */
}