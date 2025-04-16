<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
     <h2>Thêm/Sửa Sản Phẩm</h2>
<form action="${pageContext.request.contextPath}/sanpham/saveSanPham" 
      method="post" enctype="multipart/form-data">
    
    <!-- Thêm dòng này để giữ lại ID sản phẩm khi chỉnh sửa -->
    <input type="hidden" name="productID" value="${sanPham.productID}" />


    <div class="mb-3">
        <label>Tên sản phẩm</label>
        <input type="text" name="tenSanPham" value="${sanPham.tenSanPham}" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Số ghế</label>
        <input type="number" name="soGhe" value="${sanPham.soGhe}" class="form-control">
    </div>
  <div class="mb-3">
    <label>Truyền động</label>
    <select name="truyenDong" class="form-control">
        <option value="" ${sanPham.truyenDong == "" ? "selected" : ""}>-- Chọn kiểu truyền động --</option>
        <option value="Số sàn" ${sanPham.truyenDong == "Số sàn" ? "selected" : ""}>Số sàn</option>
        <option value="Số tự động" ${sanPham.truyenDong == "Số tự động" ? "selected" : ""}>Số tự động</option>
    </select>
</div>

 <div class="mb-3">
    <label for="nhienLieu">Nhiên liệu</label>
    <select name="nhienLieu" class="form-control">
        <option value="">-- Chọn nhiên liệu --</option>
        <option value="Xăng" ${sanPham.nhienLieu == "Xăng" ? "selected" : ""}>Xăng</option>
        <option value="Điện" ${sanPham.nhienLieu == "Điện" ? "selected" : ""}>Điện</option>
        <option value="Hybrid" ${sanPham.nhienLieu == "Hybrid" ? "selected" : ""}>Hybrid</option>
    </select>
</div>

  <div class="mb-3">
    <label>Địa điểm lấy xe</label>
    <input type="text" name="diaDiemLayXe1" value="${sanPham.diaDiemLayXe}" class="form-control" list="diaDiemLayXeList">
    <datalist id="diaDiemLayXeList">
        <option value="Hà Nội" />
        <option value="Hồ Chí Minh" />
        <option value="Đà Nẵng" />
        <option value="Hải Phòng" />
        <option value="Cần Thơ" />
        <option value="Nha Trang" />
        <option value="Huế" />
        <option value="Quảng Ninh" />
        <option value="Bình Dương" />
        <option value="Phan Thiết" />
    </datalist>
</div>

<div class="mb-3">
    <label for="hangXe">Hãng xe</label>
    <select name="hangXe" class="form-control">
        <option value="">-- Chọn hãng xe --</option>
        <option value="Toyota" ${sanPham.hangXe == "Toyota" ? "selected" : ""}>Toyota</option>
        <option value="Honda" ${sanPham.hangXe == "Honda" ? "selected" : ""}>Honda</option>
        <option value="Ford" ${sanPham.hangXe == "Ford" ? "selected" : ""}>Ford</option>
        <option value="BMW" ${sanPham.hangXe == "BMW" ? "selected" : ""}>BMW</option>
        <option value="Mercedes-Benz" ${sanPham.hangXe == "Mercedes-Benz" ? "selected" : ""}>Mercedes-Benz</option>
        <option value="Audi" ${sanPham.hangXe == "Audi" ? "selected" : ""}>Audi</option>
        <option value="Chevrolet" ${sanPham.hangXe == "Chevrolet" ? "selected" : ""}>Chevrolet</option>
        <option value="Nissan" ${sanPham.hangXe == "Nissan" ? "selected" : ""}>Nissan</option>
        <option value="Hyundai" ${sanPham.hangXe == "Hyundai" ? "selected" : ""}>Hyundai</option>
        <option value="Kia" ${sanPham.hangXe == "Kia" ? "selected" : ""}>Kia</option>
    </select>
</div>

    <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="gia" value="${sanPham.gia}" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Số lượng trong kho</label>
        <input type="number" name="soLuongTrongKho" value="${sanPham.soLuongTrongKho}" class="form-control">
    </div>
      <label>Ngày lăn bánh</label>
      <div>
<fmt:formatDate value="${sanPham.ngaySanXuat}" pattern="yyyy-MM-dd" var="ngaySX" />
<input type="date" name="ngaySanXuat"
       value="${ngaySX}" 
       class="form-control" required>
</div> <br>

  <div class="mb-3">
    <label for="baoHanh">Bảo hành</label>
    <select name="baoHanh" class="form-control">
        <option value="">-- Số năm bảo hành --</option>
        <option value="1 năm" ${sanPham.baoHanh == "1 năm" ? "selected" : ""}>1 Năm</option>
        <option value="2 năm" ${sanPham.baoHanh == "2 năm" ? "selected" : ""}>2 Năm</option>
        <option value="3 năm" ${sanPham.baoHanh == "3 năm" ? "selected" : ""}>3 Năm</option>
    </select>
</div>

    <div class="mb-3">
        <label>Chọn ảnh:</label>
        <input type="file" name="file" accept="image/*" />
        <c:if test="${not empty sanPham.anhDaiDien}">
            <img src="${pageContext.request.contextPath}/${sanPham.anhDaiDien}" width="100" />
        </c:if>
    </div>
    <div class="mb-3">
        <label>Danh mục</label>
        <select name="categoryID" class="form-control">
            <c:forEach var="dm" items="${danhMucs}">
                <option value="${dm.categoryID}" 
                    ${sanPham.danhMuc != null && sanPham.danhMuc.categoryID == dm.categoryID ? 'selected' : ''}>
                    ${dm.categoryID}
                </option>
            </c:forEach>
        </select>
    </div>
    <button type="submit" class="btn btn-success">Lưu</button>
    <a href="${pageContext.request.contextPath}/sanpham" class="btn btn-secondary">Hủy</a>
</form>
    </main>
</div>
</div>
</body>
</html>
