<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <!-- Các thẻ meta và CSS như cũ -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Nhân Viên</title>
    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <!-- Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-style.css">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp">
            <jsp:param name="activeMenu" value="user" />
        </jsp:include>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <div class="d-flex justify-content-between align-items-center">
                <h2>Sửa thông tin nhân viên</h2>
                <form class="d-flex">
                    <div class="input-group">
                        <input class="form-control" type="search" placeholder="Tìm kiếm" aria-label="Search">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

            <div class="form-container mt-4">
                <h3>Thông tin</h3>
                <form action="${pageContext.request.contextPath}/suanhanvien" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="id" value="${user.id}">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="hovaten" class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" id="hovaten" name="hovaten" placeholder="Nhập họ và tên" value="${user.hovaten}">
                            <span id="hovatenError" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tên đăng nhập" value="${user.username}">
                            <span id="usernameError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6 mb-3" id="soDienThoaiRow">
                            <label for="soDienThoai" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" placeholder="Nhập số điện thoại" value="${user.sodienthoai}">
                            <span id="soDienThoaiError" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="matKhau" class="form-label">Mật khẩu</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="matKhau" name="matKhau" placeholder="Nhập mật khẩu" value="${user.password}">
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="fas fa-eye" aria-hidden="true"></i>
                                </button>
                            </div>
                            <span id="matKhauError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="diaChiEmail" class="form-label">Địa chỉ email</label>
                            <input type="email" class="form-control" id="diaChiEmail" name="diaChiEmail" placeholder="Nhập địa chỉ email" value="${user.email}">
                            <span id="diaChiEmailError" class="text-danger"></span>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="chucVu" class="form-label">Chức vụ</label>
                        <select class="form-select" id="chucVu" name="chucVu" onchange="togglePhoneNumberField(this)">
                            <option value="admin" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                            <option value="user" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
                        </select>
                    </div>

                    <button type="button" class="btn btn-secondary">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </form>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePhoneNumberField(selectElement) {
        var soDienThoaiRow = document.getElementById("soDienThoaiRow");
        var selectedValue = selectElement.value;

        if (selectedValue === "user") {
            soDienThoaiRow.style.display = "none";
        } else {
            soDienThoaiRow.style.display = "block";
        }
    }

    function validateForm() {
        var hovaten = document.getElementById("hovaten").value;
        var username = document.getElementById("username").value;
        var soDienThoai = document.getElementById("soDienThoai").value;
        var matKhau = document.getElementById("matKhau").value;
        var diaChiEmail = document.getElementById("diaChiEmail").value;

        var hovatenError = document.getElementById("hovatenError");
        var usernameError = document.getElementById("usernameError");
        var soDienThoaiError = document.getElementById("soDienThoaiError");
        var matKhauError = document.getElementById("matKhauError");
        var diaChiEmailError = document.getElementById("diaChiEmailError");

        hovatenError.textContent = "";
        usernameError.textContent = "";
        soDienThoaiError.textContent = "";
        matKhauError.textContent = "";
        diaChiEmailError.textContent = "";

        var isValid = true;

        if (hovaten === "") {
            hovatenError.textContent = "Vui lòng nhập họ và tên.";
            isValid = false;
        }
         if (username === "") {
            usernameError.textContent = "Vui lòng nhập tên đăng nhập.";
            isValid = false;
        }
        if (soDienThoai === "") {
            soDienThoaiError.textContent = "Vui lòng nhập số điện thoại.";
            isValid = false;
        }
        if (matKhau === "") {
            matKhauError.textContent = "Vui lòng nhập mật khẩu.";
            isValid = false;
        }
        if (diaChiEmail === "") {
            diaChiEmailError.textContent = "Vui lòng nhập địa chỉ email.";
            isValid = false;
        }

        return isValid;
    }

    window.onload = function() {
        togglePhoneNumberField(document.getElementById("chucVu"));
    };

    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#matKhau');

    togglePassword.addEventListener('click', function (e) {
        // Đảo ngược kiểu input
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        // Thay đổi biểu tượng con mắt
        this.querySelector('i').classList.toggle('fa-eye');
        this.querySelector('i').classList.toggle('fa-eye-slash');
    });
    // JavaScript để xử lý collapse sidebar menu
    var triggerTabList = [].slice.call(document.querySelectorAll('#sidebar a[data-bs-toggle="collapse"]'))
    triggerTabList.forEach(function (triggerEl) {
        triggerEl.addEventListener('click', function (event) {
            event.preventDefault()
        })
    })
</script>
</body>
</html>