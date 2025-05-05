package poly.edu.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import poly.edu.Model.TicketHoTro;
import poly.edu.Repository.TicketHoTroRepository;

@Service
public class TicketHoTroServiceImp implements TicketHoTroService {
    @Autowired
    private TicketHoTroRepository ticketHoTroRepository;

    @Override
    public TicketHoTro save(TicketHoTro ticket) {
        return ticketHoTroRepository.save(ticket);
    }
} 