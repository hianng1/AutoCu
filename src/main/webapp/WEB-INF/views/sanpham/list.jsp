<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
</style>
</head>
<body >
<div class="container-fluid">
<div class="row">
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
										href="${pageContext.request.contextPath}/views/Admin/quantri.jsp">
											Quản Trị </a></li>
									<li class="nav-item"><a class="nav-link" href="#">Thông
											tin người dùng</a></li>
									<li class="nav-item"><a class="nav-link"
										href="${pageContext.request.contextPath}/views/Admin/themnhanvien.jsp">
											Thêm Nhân Viên </a></li>

									<li class="nav-item"><a class="nav-link"
										href="${pageContext.request.contextPath}/views/Admin/suanhanvien.jsp">
											Sửa Thông Tin User </a></li>
									<li class="nav-item"><a class="nav-link" href="#">Thay
											đổi mật khẩu</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a class="nav-link" href="#"> Quản
								lý user </a></li>
											<li class="nav-item">
									    <a class="nav-link" href="${pageContext.request.contextPath}/sanpham">
									        Quản lý Sản Phẩm
									    </a>
									</li>

					</ul>
				</div>
			</nav>
<main class="col-md-9 ms-sm-auto col-lg-10 main-content">
    <h2>Danh sách sản phẩm</h2>
    <a href="${pageContext.request.contextPath}/sanpham/them" class="btn btn-primary mb-3">Thêm sản phẩm</a>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Mã</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Số ghế</th>
                <th>Hãng</th>
                <th>Ảnh</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="sp" items="${dsSanPham}">
                <tr>
                    <td>${sp.productID}</td>
                    <td>${sp.tenSanPham}</td>
                    <td>${sp.gia}</td>
                    <td>${sp.soGhe}</td>
                    <td>${sp.hangXe}</td>
                    <td><img src="${sp.anhDaiDien}" width="50"></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/sanpham/sua/${sp.productID}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/sanpham/xoa/${sp.productID}" class="btn btn-danger btn-sm">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </main>
</div>
</div>
</body>
</html>
