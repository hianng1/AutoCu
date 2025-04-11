package poly.edu.DAO;

//Trong UserDAO (interface)
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import poly.edu.Model.User;

public interface UserDAO extends JpaRepository<User, Integer> {
 @Query("SELECT u FROM User u ORDER BY u.id ASC")
 List<User> findAllOrderByIdAsc();
}



