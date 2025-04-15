package poly.edu.Model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role; // ADMIN hoặc USER

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name = "sodienthoai", unique = true, nullable = false) // Thêm cột số điện thoại
    private String sodienthoai;

    @Column(name = "hovaten", columnDefinition = "nvarchar(255)") // Thêm cột họ và tên
    private String hovaten;	
    
    @Column(name = "DiaChi", nullable = false, length = 255, columnDefinition = "nvarchar(255)")
    private String diaChi;
    
}
