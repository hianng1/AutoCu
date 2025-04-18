<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.PhuKienOto" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Bootstrap CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		crossorigin="anonymous">
	
	<!-- Font Awesome CSS -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
	    
    <style>
      .card:hover {
        transform: translateY(-5px);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      }
      .card-img-top {
	    width: 100%;
	    height: 180px; 
	    object-fit: cover;
	  }
	  img {
		  width: 100%;
		  height: 200px;
		  object-fit: cover; /* Giữ tỷ lệ ảnh */
		}
		button:hover {
		  transition: background-color 0.3s ease;
		}
		
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/common/header.jsp" />

    <%-- <div class="container mt-5">
        <h2 class="text-center">Đăng Nhập</h2>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" class="mx-auto w-50 border p-4 rounded shadow">
            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập:</label>
                <input type="text" name="username" id="username" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
        </form>
    </div> --%>
    
    <!-- <h2>Đăng Nhập</h2>
    <form action="/login" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required><br>
        <input type="password" name="password" placeholder="Mật khẩu" required><br>
        <button type="submit">Đăng nhập</button>
    </form>
    <a href="/register">Đăng ký</a> -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card login-card">
                    <div class="card-body p-4">
                        <h2 class="text-center mb-4">Đăng Nhập</h2>
                        <form action="/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <input type="text" 
                                       class="form-control form-control-lg" 
                                       id="username" 
                                       name="username" 
                                       placeholder="Nhập tên đăng nhập"
                                       required>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password" 
                                       class="form-control form-control-lg" 
                                       id="password" 
                                       name="password" 
                                       placeholder="Nhập mật khẩu"
                                       required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg w-100 mb-3">
                                Đăng nhập
                            </button>
                            <div class="text-end mb-4">
                                <a href="/forgot-password" class="text-decoration-none">Quên mật khẩu?</a>
                            </div>
                        </form>

                        <div class="text-center mb-4">
                            <span class="text-muted">Hoặc đăng nhập bằng</span>
                        </div>
                        
                        <div class="social-login d-flex gap-3 mb-4">
                            <a href="#" class="btn btn-outline-primary flex-fill">
                                <i class="fab fa-facebook"></i> Facebook
                            </a>
                            <a href="#" class="btn btn-outline-danger flex-fill">
                                <i class="fab fa-google"></i> Google
                            </a>
                        </div>

                        <div class="text-center">
                            <span class="text-muted">Chưa có tài khoản? </span>
                            <a href="/register" class="btn btn-outline-success btn-sm ms-2">
                                Đăng ký ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/common/footer.jsp" />
</body>
</html>
