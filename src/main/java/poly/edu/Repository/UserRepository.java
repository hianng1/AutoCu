package poly.edu.Repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import poly.edu.Model.User;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    
    boolean existsByUsername(String username); // Kiểm tra username đã tồn tại chưa
    boolean existsByEmail(String email); // Kiểm tra email đã tồn tại chưa
}
