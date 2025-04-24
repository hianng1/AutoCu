package poly.edu.DAO;

import java.util.List;

//Trong UserDAO (interface)
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import poly.edu.Model.User;

public interface UserDAO extends JpaRepository<User, Integer> {
 @Query("SELECT u FROM User u ORDER BY u.id ASC")
 List<User> findAllOrderByIdAsc();
}



