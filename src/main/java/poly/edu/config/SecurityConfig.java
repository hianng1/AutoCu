package poly.edu.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import poly.edu.Service.*;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
    private CustomUserDetailsService userDetailsService;
	
	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
	    return authenticationConfiguration.getAuthenticationManager();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
	    return new PasswordEncoder() {
	        @Override
	        public String encode(CharSequence rawPassword) {
	            return rawPassword.toString(); // Không mã hóa
	        }

	        @Override
	        public boolean matches(CharSequence rawPassword, String storedPassword) {
	            return rawPassword.toString().equals(storedPassword); // So sánh trực tiếp
	        }
	    };
	}


	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
	    http
	        .authorizeHttpRequests(auth -> auth
	            .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
	            .requestMatchers("/user/**").hasAuthority("ROLE_USER")
	            .anyRequest().permitAll()
	        )
	        .formLogin(login -> login
	            .loginPage("/login")
	            .loginProcessingUrl("/login")
	            .successHandler((request, response, authentication) -> { 
	                authentication.getAuthorities().forEach(grantedAuthority -> {
	                    try {
	                        if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
	                            response.sendRedirect("/admin");
	                        } else {
	                            response.sendRedirect("/user");
	                        }
	                    } catch (Exception e) {
	                        e.printStackTrace();
	                    }
	                });
	            })
	            .permitAll()
	        )
	        .logout(logout -> logout
	            .logoutUrl("/logout")
	            .logoutSuccessUrl("/")
	            .invalidateHttpSession(true)
	            .deleteCookies("JSESSIONID")
	        );

	    return http.build();
	}
	}

    
    
    
    

