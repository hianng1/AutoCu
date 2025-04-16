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

        .sidebar {
            background-color: #fff;
            border-right: 1px solid #1677FF;
            padding: 20px;
        }

        .sidebar .nav-link {
            padding: 0.5rem 1rem;
            color: #333;
        }

        .sidebar .nav-link:hover {
            background-color: #1677FF;
            color: #fff;
        }

        .sidebar-heading span,
        .main-content h2 {
            color: #1677FF;
            font-weight: bold;
        }

        .main-content {
            padding: 20px;
        }

        .form-label {
            font-weight: 500;
        }

        .form-control {
            border-radius: 0.5rem;
        }

        button[type="submit"] {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="position-sticky">
                <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
                    <span>Quản lý user</span>
                </h6>
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="#">Quản trị</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Tài khoản</a></li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="collapse" data-bs-target="#thongTinTaiKhoan">
                            Thông tin tài khoản
                        </a>
                        <div class="collapse show" id="thongTinTaiKhoan">
                            <ul class="nav flex-column ps-3">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/views/Admin/quantri.jsp">Quản Trị</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Thông tin người dùng</a></li>
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/views/Admin/themnhanvien.jsp">Thêm Nhân Viên</a></li>
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/views/Admin/suanhanvien.jsp">Sửa Thông Tin User</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Thay đổi mật khẩu</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="#">Quản lý user</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/sanpham">Quản lý Sản Phẩm</a></li>
                </ul>
            </div>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
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
