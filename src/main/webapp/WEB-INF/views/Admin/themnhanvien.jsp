<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý User</title>
    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .sidebar-heading span {
            font-size: 1.25rem;
            /* Tăng kích thước chữ, bạn có thể điều chỉnh giá trị này */
            font-weight: bold; /* Tùy chọn: làm chữ đậm hơn */
        }

        /* Sidebar */
        .sidebar {
            background-color: #fff;
            border-right: 1px solid #1677FF;
            padding: 20px;
        }

        .sidebar .nav-link {
            padding: 0.5rem 1rem;
            color: #333;
            position: relative;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .sidebar .nav-link:hover {
            background-color: #f0f0f0; /* Màu nền khi hover */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Hiệu ứng layout */
            z-index: 1; /* Đảm bảo item được hiển thị trên cùng */
        }

        /* Thay đổi màu chữ của "Quản lý user" */
        .sidebar h5 {
            color: #1677FF;
        }

        .main-content h2 {
            color: #1677FF;
        }

        .sidebar .nav-link {
            padding: 0.5rem 1rem;
            color: #333;
        }

        .sidebar .nav-link:hover {
            background-color: #1677FF;
        }

        .sidebar .nav-link.active {
            background-color: #007bff;
            color: #fff;
        }

        .sidebar .nav-item {
            margin-bottom: 0.25rem;
        }

        /* Main Content */
        .main-content {
            padding: 20px;
        }

        .table {
            background-color: #fff; /* Màu nền trắng cho toàn bộ bảng */
        }

        .table-responsive {
            overflow-x: auto;
        }

        .text-danger {
            color: red;
            font-size: 0.8rem; /* Nhỏ hơn một chút so với text field */
        }

        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="position-sticky">
                <h6
                        class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                    <span>Quản lý user</span>
                </h6>
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="#"> Quản
                            trị </a></li>
                    <li class="nav-item"><a class="nav-link" href="#"> Tài
                            khoản </a></li>
                    <li class="nav-item"><a class="nav-link" href="#"
                                              data-bs-toggle="collapse" data-bs-target="#thongTinTaiKhoan">
                        Thông tin tài khoản <i class="fas fa-caret-down"></i>
                    </a>
                        <div class="collapse show" id="thongTinTaiKhoan">
                            <ul class="nav flex-column ps-3">
                                <li class="nav-item"><a class="nav-link"
                                                        href="">
                                    Quản Trị </a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Thông
                                    tin người dùng</a></li>
                                <li class="nav-item"><a class="nav-link"
                                                        href="${pageContext.request.contextPath}/themnhanvien">
                                    Thêm Nhân Viên </a></li>


                            </ul>
                        </div></li>
                    <li class="nav-item"><a class="nav-link" href="/quantri"> Quản
                            lý user </a></li>
                    <li class="nav-item"><a class="nav-link" href="#"> Khác </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="d-flex justify-content-between align-items-center">
                <h2>Thêm tài khoản nhân viên</h2>
                <form class="d-flex">
                    <div class="input-group">
                        <input class="form-control" type="search" placeholder="Tìm kiếm"
                               aria-label="Search">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="form-container mt-4">
                <h3>Thông tin</h3>
                <form action="${pageContext.request.contextPath}/themnhanvien" method="post"
                      onsubmit="return validateForm()">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ho" class="form-label">Họ</label>
                            <input type="text" class="form-control" id="ho" name="ho" placeholder="Nhập Họ">
                            <span id="hoError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ten" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="ten" name="ten" placeholder="Nhập Tên">
                            <span id="tenError" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="Nhập tên đăng nhập">
                            <span id="usernameError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="matKhau" class="form-label">Mật khẩu</label>
                            <div class="password-container">
                                <input type="password" class="form-control" id="matKhau" name="matKhau"
                                       placeholder="Nhập mật khẩu">
                                <span class="password-toggle" onclick="togglePasswordVisibility('matKhau')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                            </div>
                            <span id="matKhauError" class="text-danger"></span>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="diaChiEmail" class="form-label">Địa chỉ email</label>
                            <input type="email" class="form-control" id="diaChiEmail" name="diaChiEmail"
                                   placeholder="Nhập địa chỉ ">
                            <span id="diaChiEmailError" class="text-danger"></span>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="xacNhanMatKhau" class="form-label">Xác nhận mật
                                khẩu</label>
                            <div class="password-container">
                                <input type="password" class="form-control" id="xacNhanMatKhau" name="xacNhanMatKhau"
                                       placeholder="Nhập lại mật khẩu">
                                <span class="password-toggle" onclick="togglePasswordVisibility('xacNhanMatKhau')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                            </div>
                            <span id="xacNhanMatKhauError" class="text-danger"></span>
                        </div>

                    </div>


                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="chucVu" class="form-label">Chức vụ</label>
                            <select class="form-select" id="chucVu" name="chucVu"
                                    onchange="togglePhoneNumberField(this)">
                                <option value="Admin">Admin</option>
                                <option value="USER">USER</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3" id="soDienThoaiRow">  <!-- ID ở đây -->
                            <label for="soDienThoai" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai"
                                   placeholder="Nhập số điện thoại">
                            <span id="soDienThoaiError" class="text-danger"></span>
                        </div>
                    </div>


                    <button type="submit" class="btn btn-primary">Thêm</button>
                </form>
            </div>
        </main>
    </div>
</div>

<script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<script>
    function togglePhoneNumberField(selectElement) {
        var soDienThoaiRow = document.getElementById("soDienThoaiRow");
        var selectedValue = selectElement.value;

        if (selectedValue === "USER") {
            soDienThoaiRow.style.display = "none";
        } else {
            soDienThoaiRow.style.display = "block";
        }
    }

    function togglePasswordVisibility(inputId) {
        var input = document.getElementById(inputId);
        var icon = input.parentNode.querySelector('.password-toggle i');
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = "password";
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    function validateForm() {
        var ho = document.getElementById("ho").value;
        var ten = document.getElementById("ten").value;
        var username = document.getElementById("username").value;
        var matKhau = document.getElementById("matKhau").value;
        var xacNhanMatKhau = document.getElementById("xacNhanMatKhau").value;

        // Lấy các phần tử span để hiển thị lỗi
        var hoError = document.getElementById("hoError");
        var tenError = document.getElementById("tenError");
        var usernameError = document.getElementById("usernameError");
        var matKhauError = document.getElementById("matKhauError");
        var xacNhanMatKhauError = document.getElementById("xacNhanMatKhauError");

        // Reset các thông báo lỗi trước đó
        hoError.textContent = "";
        tenError.textContent = "";
        usernameError.textContent = "";
        matKhauError.textContent = "";
        xacNhanMatKhauError.textContent = "";

        var isValid = true; // Biến để theo dõi xem form có hợp lệ hay không

        if (ho === "") {
            hoError.textContent = "Vui lòng nhập họ.";
            isValid = false;
        } else if (!/^[a-zA-Z\s]+$/.test(ho)) {
            hoError.textContent = "Họ chỉ được chứa chữ cái và khoảng trắng.";
            isValid = false;
        }
        if (ten === "") {
            tenError.textContent = "Vui lòng nhập tên.";
            isValid = false;
        }
        if (username === "") {
            usernameError.textContent = "Vui lòng nhập tên đăng nhập.";
            isValid = false;
        }
        if (matKhau === "") {
            matKhauError.textContent = "Vui lòng nhập mật khẩu.";
            isValid = false;
        }
        if (xacNhanMatKhau === "") {
            xacNhanMatKhauError.textContent = "Vui lòng nhập xác nhận mật khẩu.";
            isValid = false;
        }

        if (matKhau !== xacNhanMatKhau) {
            xacNhanMatKhauError.textContent = "Mật khẩu và xác nhận mật khẩu không khớp.";
            isValid = false;
        }

        return isValid; // Trả về true nếu form hợp lệ, false nếu không
    }

    // Gọi hàm togglePhoneNumberField() khi trang được tải để thiết lập trạng thái ban đầu
    window.onload = function () {
        togglePhoneNumberField(document.getElementById("chucVu"));
    };
</script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">

</script>
</body>
</html>