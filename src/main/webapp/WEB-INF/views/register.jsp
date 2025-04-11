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
    <!-- <h2>Đăng Ký</h2>
    <form action="/register" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required><br>
        <input type="password" name="password" placeholder="Mật khẩu" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <button type="submit">Đăng ký</button>
    </form>
    <a href="/login">Đăng nhập</a> -->
    <div class="container-fluid d-flex justify-content-center align-items-center">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-lg">
                <div class="card-body p-5">
                    <h2 class="card-title text-center mb-4">Đăng Ký</h2>
                    <form action="/register" method="post">
                        <div class="mb-3">
                            <input type="text" 
                                   class="form-control form-control-lg" 
                                   name="username" 
                                   placeholder="Tên đăng nhập" 
                                   required>
                        </div>
                        <div class="mb-3">
                            <input type="password" 
                                   class="form-control form-control-lg" 
                                   name="password" 
                                   placeholder="Mật khẩu" 
                                   required>
                        </div>
                        <div class="mb-3">
						    <input type="text" 
						           class="form-control form-control-lg" 
						           name="hovaten" 
						           placeholder="Họ và tên" 
						           required>
						</div>
                        
                        <div class="mb-4">
                            <input type="email" 
                                   class="form-control form-control-lg" 
                                   name="email" 
                                   placeholder="Email" 
                                   required>
                        </div>
                        <div class="mb-3">
						    <input type="text" 
						       class="form-control form-control-lg" 
						       name="sodienthoai" 
						       placeholder="Số điện thoại (không bắt buộc)">
						</div>
                        <button type="submit" 
                                class="btn btn-primary btn-lg w-100 mb-3">
                            Đăng ký
                        </button>
                    </form>
                    <div class="text-center">
                        <span class="text-muted">Đã có tài khoản?</span>
                        <a href="/login" class="link-primary text-decoration-none">
                            Đăng nhập ngay
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/common/footer.jsp" />
</body>
</html>
