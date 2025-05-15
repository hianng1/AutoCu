<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Thông Tin Tài Khoản</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link
          rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin-style.css"
    />
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeMenu" value="taikhoan" />
            </jsp:include>
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-9 px-md-4 py-4">
                <h2 class="mb-4">Sửa Thông Tin Tài Khoản</h2>
                
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/suanhanvien" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="${user.id}">
                            
                            <div class="mb-3">
                                <label for="hovaten" class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" id="hovaten" name="hovaten" value="${user.hovaten}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="soDienThoai" class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" value="${user.sodienthoai}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="matKhau" class="form-label">Mật khẩu mới</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="matKhau" name="matKhau" 
                                           placeholder="Nhập mật khẩu mới (để trống nếu giữ nguyên)">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="far fa-eye"></i>
                                    </button>
                                </div>
                                <small class="text-muted">Để trống nếu không muốn thay đổi mật khẩu hiện tại</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="diaChiEmail" class="form-label">Địa chỉ email</label>
                                <input type="email" class="form-control" id="diaChiEmail" name="diaChiEmail" value="${user.email}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="chucVu" class="form-label">Chức vụ</label>
                                <select class="form-select" id="chucVu" name="chucVu" required>
                                    <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>
                                    <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Người dùng</option>
                                </select>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">Lưu</button>
                                <a href="${pageContext.request.contextPath}/quantri" class="btn btn-secondary">Hủy</a>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Bootstrap & jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('matKhau');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // Toggle eye icon
            const eyeIcon = this.querySelector('i');
            eyeIcon.classList.toggle('fa-eye');
            eyeIcon.classList.toggle('fa-eye-slash');
        });
        
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>