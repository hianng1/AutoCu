<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý User</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
                               
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/khachhang">Danh sách khách hàng</a></li>
                                <li class="nav-item"><a class="nav-link"
                                                        href="${pageContext.request.contextPath}/themnhanvien">
                                    Thêm Nhân Viên </a></li>

                            
                            </ul>
                        </div></li>
                    <li class="nav-item"><a class="nav-link" href="/quantri"> Quản
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
 <h2 class="mb-4 text-primary">Danh sách phụ kiện ô tô</h2>

    <div class="mb-3">
        <a href="/phukien/form" class="btn btn-success">+ Thêm phụ kiện</a>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Tên phụ kiện</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Hãng sản xuất</th>
                <th>Ảnh</th>
                <th>Danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td>${item.accessoryID}</td>
                    <td>${item.tenPhuKien}</td>
                    <td>${item.gia} ₫</td>
                    <td>${item.soLuong}</td>
                    <td>${item.hangSanXuat}</td>
                   
                     <td>   <img src="/imgs/${item.anhDaiDien}" 
				     class="card-img-top object-cover" 
				     alt="${item.anhDaiDien}" 
				     style="height: 40px; width: 70px;" >
						</td>
                    <td>${item.danhMuc.tenDanhMuc}</td>
                    <td>
                        <a href="/phukien/edit/${item.accessoryID}" class="btn btn-sm btn-warning">Sửa</a>
                        <a href="/phukien/delete/${item.accessoryID}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
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
