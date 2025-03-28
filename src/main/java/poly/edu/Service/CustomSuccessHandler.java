package poly.edu.Service;

import java.io.IOException;
import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
	                                    Authentication authentication) throws IOException, ServletException {
	    Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
	    
	    for (GrantedAuthority authority : authorities) {
	        String role = authority.getAuthority();
	        System.out.println("Đã đăng nhập với quyền: " + role); // In log kiểm tra

	        if (role.equals("ROLE_ADMIN") || role.equals(true)) {
	            response.sendRedirect("/admin");
	            return;
	        } else if (role.equals("ROLE_USER") || role.equals(false)) {
	            response.sendRedirect("/user");
	            return;
	        }
	    }
	    response.sendRedirect("login");
	}

}
