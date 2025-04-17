package poly.edu.Model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "HinhAnhSanPham")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class HinhAnhSanPham {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fileName;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private SanPham sanPham;
}
