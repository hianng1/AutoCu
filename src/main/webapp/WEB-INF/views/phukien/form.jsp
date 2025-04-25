<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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

        /* Sidebar */
        /* Sidebar */
#sidebar {
    background-color: #343a40;
    color: white;
    padding: 20px;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    width: 300px; /* Độ rộng sidebar */
    z-index: 1000;
    box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.1);
}

/* Tăng kích thước font chữ cho header sidebar */
.sidebar-heading span {
    font-size: 1.5rem;
    color: #007bff;
    font-weight: bold;
}

/* Hiệu ứng cho link sidebar */
.sidebar .nav-link {
    padding: 0.75rem 1rem;
    color: #adb5bd;
    transition: background-color 0.3s, padding-left 0.3s;
}

.sidebar .nav-link:hover {
    background-color: #007bff;
    color: white;
    padding-left: 1.5rem; /* Tăng khoảng cách khi hover */
}

.sidebar .nav-link i {
    margin-right: 10px;
}

/* Hiệu ứng collapse item */
.sidebar .nav-item .collapse {
    background-color: #495057;
}

.sidebar .nav-item .collapse .nav-link {
    color: #ccc;
    padding-left: 2rem;
}

.sidebar .nav-item .collapse .nav-link:hover {
    background-color: #6c757d;
}

.sidebar .nav-link.active {
    background-color: #28a745;
    color: white;
}

/* Thêm hiệu ứng cho các item có icon */
.sidebar .nav-link i {
    font-size: 1.2rem;
}

    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
       <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar">
    <div class="position-sticky">
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Quản lý user</span>
        </h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/quantri">
                    <i class="fas fa-tachometer-alt"></i> Quản trị
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-user-circle"></i> Tài khoản
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#thongTinTaiKhoan">
                    <i class="fas fa-cogs"></i> Thông tin tài khoản <i class="fas fa-caret-down"></i>
                </a>
                <div class="collapse show" id="thongTinTaiKhoan">
                    <ul class="nav flex-column ps-3">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/khachhang">Danh sách khách hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/themnhanvien">Thêm Nhân Viên</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/quantri">
                    <i class="fas fa-users"></i> Quản lý user
                </a>
            </li>
          <li class="nav-item">
    <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#quanLySanPham">
        <i class="fas fa-box"></i> Quản lý Sản Phẩm <i class="fas fa-caret-down"></i>
    </a>
    <div class="collapse" id="quanLySanPham">
        <ul class="nav flex-column ps-3">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/sanpham">Quản lý sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/phukien/list">Quản lý phụ kiện</a></li>
        </ul>
    </div>
</li>
<li class="nav-item">
    <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#thongKe">
        <i class="fas fa-chart-bar"></i> Thống kê <i class="fas fa-caret-down"></i>
    </a>
    <div class="collapse" id="thongKe">
        <ul class="nav flex-column ps-3">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/thongke/banhang">Thống kê bán hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/donhang">Thống kê đơn hàng</a></li>
           
        </ul>
    </div>
</li>


        </ul>
    </div>
</nav>
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <h2>Form Phụ kiện Ô tô</h2>
            <form:form method="post" modelAttribute="phuKienOto" action="/phukien/save" enctype="multipart/form-data">
                <form:hidden path="accessoryID"/>

                <div class="mb-3">
                    <label for="tenPhuKien" class="form-label">Tên phụ kiện:</label>
                    <form:input path="tenPhuKien" cssClass="form-control" id="tenPhuKien"/>
                </div>

                <div class="mb-3">
                    <label for="moTa" class="form-label">Mô tả:</label>
                    <form:textarea path="moTa" cssClass="form-control" id="moTa"/>
                </div>

                <div class="mb-3">
                    <label for="gia" class="form-label">Giá:</label>
                    <form:input path="gia" type="number" cssClass="form-control" id="gia"/>
                </div>

                <div class="mb-3">
                    <label for="soLuong" class="form-label">Số lượng:</label>
                    <form:input path="soLuong" type="number" cssClass="form-control" id="soLuong"/>
                </div>

                <div class="mb-3">
                    <label for="hangSanXuat" class="form-label">Hãng sản xuất:</label>
                    <form:input path="hangSanXuat" cssClass="form-control" id="hangSanXuat" list="hangSanXuatList"/>
                    <datalist id="hangSanXuatList">
                        <option value="Bosch" />
                        <option value="Denso" />
                        <option value="Valeo" />
                        <option value="ZF Friedrichshafen" />
                        <option value="Continental" />
                        <option value="Hella" />
                        <option value="Brembo" />
                        <option value="Magneti Marelli" />
                        <option value="KYB" />
                        <option value="NGK" />
                    </datalist>
                </div>

                <div class="mb-3">
                    <label for="file" class="form-label">Ảnh đại diện:</label>
                    <input type="file" name="file" class="form-control" id="file"/>
                </div>

                <div class="mb-3">
                    <label for="categoryId" class="form-label">Danh mục:</label>
                    <select name="categoryId" id="categoryId" class="form-control">
                        <c:forEach items="${danhMucList}" var="dm">
                            <option value="${dm.categoryID}"
                                <c:if test="${phuKienOto.danhMuc.categoryID == dm.categoryID}">selected</c:if>>
                                ${dm.categoryID} - ${dm.tenDanhMuc}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Lưu</button>
            </form:form>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
