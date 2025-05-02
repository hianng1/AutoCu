<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- Dọn dẹp các import không cần thiết trên trang login --%>
<%-- @page import="java.util.List" --%>
<%-- @page import="poly.edu.Model.PhuKienOto" --%>
<%-- @page import="java.text.NumberFormat" --%>
<%-- @page import="java.util.Locale" --%>
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
    <%-- Chỉ cần một phiên bản Bootstrap CSS --%>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous">

	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
      /* Giữ lại các style cần thiết cho trang login */
      .card:hover {
        transform: translateY(-5px);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      }
      /* Các style khác liên quan đến login form nếu có */
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />

    <div class="container mt-5"> <%-- Thêm margin top để form không bị dính vào header --%>
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card login-card">
                    <div class="card-body p-4">
                        <h2 class="text-center mb-4">Đăng Nhập</h2>

                        <%-- THÊM KHỐI HIỂN THỊ THÔNG BÁO VÀ LỖI TẠI ĐÂY --%>
                        <%-- Hiển thị thông báo thành công (ví dụ: sau đăng ký hoặc đăng xuất) --%>
                        <c:if test="${not empty message}">
                            <div class="alert alert-info alert-dismissible fade show" role="alert">
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <%-- Hiển thị thông báo lỗi (ví dụ: sai tên đăng nhập/mật khẩu từ Spring Security) --%>
                         <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <%-- KẾT THÚC KHỐI HIỂN THỊ THÔNG BÁO VÀ LỖI --%>


                        <%-- Form gửi dữ liệu đăng nhập dạng POST đến URL /login --%>
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <input type="text"
                                       class="form-control form-control-lg"
                                       id="username"
                                       name="username" <%-- Tên biến "username" là chuẩn cho Spring Security --%>
                                       placeholder="Nhập tên đăng nhập"
                                       required>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password"
                                       class="form-control form-control-lg"
                                       id="password"
                                       name="password" <%-- Tên biến "password" là chuẩn cho Spring Security --%>
                                       placeholder="Nhập mật khẩu"
                                       required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg w-100 mb-3">
                                Đăng nhập
                            </button>
                            <div class="text-end mb-4">
                                <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">Quên mật khẩu?</a>
                            </div>
                        </form>

                        <!-- <div class="social-login d-flex gap-3 mb-4">
                            <a href="#" class="btn btn-outline-primary flex-fill">
                                <i class="fab fa-facebook"></i> Facebook
                            </a>
                            <a href="#" class="btn btn-outline-danger flex-fill">
                                <i class="fab fa-google"></i> Google
                            </a>
                        </div> -->

                        <div class="text-center">
                            <span class="text-muted">Chưa có tài khoản? </span>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-success btn-sm ms-2">
                                Đăng ký ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>