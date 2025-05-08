<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <style>
        .card:hover {
            transform: translateY(-5px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .card-img-top, img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        button:hover {
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />

    <main class="container py-5">
    	 <c:if test="${not empty message}">
	        <div class="alert alert-danger alert-dismissible fade show" role="alert">
	            ${message}
	            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	        </div>
	    </c:if>
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h2 class="card-title text-center mb-4">Đăng Ký Tài Khoản</h2>
                        <form id="registerForm" action="/register" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                                <div class="invalid-feedback">Vui lòng nhập tên đăng nhập</div>
                            </div>
                            <div class="mb-3">
							    <label for="password" class="form-label">Mật khẩu</label>
							    <input type="password" class="form-control" name="password" id="password" required pattern="(?=.*[a-z])(?=.*[A-Z]).{6,}">
							    <div class="form-text" style="color: red;">Mật khẩu ít nhất 6 ký tự và chứa ít nhất một chữ hoa và một chữ thường.</div>
							    <div class="invalid-feedback">Vui lòng nhập mật khẩu hợp lệ (ít nhất 6 ký tự và chứa ít nhất một chữ hoa và một chữ thường).</div>
							</div>
                            <div class="mb-3">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" name="hovaten" required>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên</div>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ (vd: example@domain.com)</div>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phone" name="sodienthoai" pattern="[0-9]{10}" required>
                                <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (10 số)</div>
                            </div>
                            <div class="mb-3">
                                <label for="soNha" class="form-label">Số nhà/Đường</label>
                                <input type="text" class="form-control" id="soNha" name="soNha" required>
                                <div class="invalid-feedback">Vui lòng nhập số nhà</div>
                            </div>
								<div class="mb-3">
								    <label for="tinhThanh" class="form-label">Tỉnh/Thành phố</label>
								    <input type="text" class="form-control" id="tinhThanh" name="tinhThanh" required>
								    <div class="invalid-feedback">Vui lòng nhập tỉnh/thành phố</div>
								</div>

								<div class="mb-3">
								    <label for="quanHuyen" class="form-label">Quận/Huyện</label>
								    <input type="text" class="form-control" id="quanHuyen" name="quanHuyen" required>
								    <div class="invalid-feedback">Vui lòng nhập quận/huyện</div>
								</div>

								<div class="mb-3">
								    <label for="phuongXa" class="form-label">Phường/Xã</label>
								    <input type="text" class="form-control" id="phuongXa" name="phuongXa" required>
								    <div class="invalid-feedback">Vui lòng nhập phường/xã</div>
								</div>

                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-user-plus me-2"></i> Đăng ký
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (() => {
            'use strict'

            // Lấy tất cả các form cần xác thực
            const forms = document.querySelectorAll('.needs-validation')

            // Lặp qua chúng và ngăn chặn việc gửi
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    // Kiểm tra thêm điều kiện cho mật khẩu
                    const passwordInput = form.querySelector('#password');
                    if (passwordInput) {
                        const passwordValue = passwordInput.value;
                        const hasUpperCase = /[A-Z]/.test(passwordValue);
                        const hasLowerCase = /[a-z]/.test(passwordValue);
                        const isLongEnough = passwordValue.length >= 6;

                        if (!isLongEnough || !hasUpperCase || !hasLowerCase) {
                            passwordInput.classList.add('is-invalid');
                            event.preventDefault();
                            event.stopPropagation();
                        } else {
                            passwordInput.classList.remove('is-invalid');
                        }
                    }

                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</body>
</html>