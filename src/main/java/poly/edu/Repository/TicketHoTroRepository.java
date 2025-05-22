package poly.edu.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.TicketHoTro;

@Repository
public interface TicketHoTroRepository extends JpaRepository<TicketHoTro, Long> {
}