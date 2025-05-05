package poly.edu.Repository;


import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
	Optional<User>findById(Integer id);
    User findByUsername(String username);
    User findByEmail(String email);
    
    List<User> findAll();

    boolean existsByUsername(String username); // Kiểm tra username đã tồn tại chưa
    boolean existsByEmail(String email); // Kiểm tra email đã tồn tại chưa
    
}
