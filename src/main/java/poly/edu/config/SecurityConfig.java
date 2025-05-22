package poly.edu.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration)
            throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/", "/trangchu", "/login", "/register", "/css/**", "/js/**", "/imgs/**",
                                "/products/**")
                        .permitAll()
                        .requestMatchers("/cart/**").authenticated()
                        .requestMatchers("/quantri").hasRole("ADMIN") // Hoặc .hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/verify", "/verify/**", "/resend-verification", "/register-success")
                        .permitAll() // Cho phép
                        // truy cập
                        // vào
                        // endpoints
                        // xác thực
                        // email
                        .anyRequest().permitAll() // Hoặc .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login") // Hoặc "/j_spring_security_check"
                        .usernameParameter("username")
                        .passwordParameter("password")
                        .defaultSuccessUrl("/trangchu", true) // Hoặc URL khác
                        .failureUrl("/login?error")
                        .permitAll())
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/trangchu?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID", "MY_APP_SESSION") // Đảm bảo tên cookie đúng
                        .permitAll())
                // --- Đảm bảo phần exceptionHandling được comment hoặc viết đúng cú pháp ---
                // Cách 1: Bình luận lại hoàn toàn nếu chưa cần cấu hình lỗi tùy chỉnh
                /*
                 * .exceptionHandling(exception -> {
                 * // Không cấu hình gì ở đây nếu bạn không cần xử lý lỗi tùy chỉnh
                 * // Nếu cần trang 403: exception.accessDeniedPage("/403");
                 * })
                 */
                // Cách 2: Viết đúng cú pháp nếu chỉ muốn trang 403
                // .exceptionHandling(exception -> exception.accessDeniedPage("/403"))

                .csrf(csrf -> csrf.disable()); // Tạm tắt CSRF

        return http.build();
    }

    // Bean UserDetailsService (phải tồn tại ở nơi khác và được đánh dấu @Service)
    // @Autowired // Không cần @Autowired ở đây
    // private UserDetailsService userDetailsService; // Khai báo để gợi nhớ
}