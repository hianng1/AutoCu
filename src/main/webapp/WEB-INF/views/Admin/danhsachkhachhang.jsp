<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Khách Hàng</title>
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
            font-weight: bold;
        }

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
            background-color: #f0f0f0;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

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

        .main-content {
            padding: 20px;
        }

        .table {
            background-color: #fff;
        }

        .table-responsive {
            overflow-x: auto;
        }

        /* Thêm CSS để ẩn cột "Vai trò" */
        .hidden-role {
            display: none;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar (Giữ nguyên hoặc điều chỉnh nếu cần) -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="position-sticky">
                <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
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
                                                        href="${pageContext.request.contextPath}/quantri">
                                    Quản Trị </a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Danh sách khách hàng</a></li>
                                <li class="nav-item"><a class="nav-link"
                                                        href="${pageContext.request.contextPath}/themnhanvien">
                                    Thêm Nhân Viên </a></li>

                            
                        </div></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/quantri"> Quản
                            lý user </a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/sanpham">
                            Quản lý Sản Phẩm
                        </a>
                    </li>

                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Danh sách Khách Hàng đã đặt hàng</h2>
                <form class="d-flex">
                    <input class="form-control me-2" type="search"
                           placeholder="Tìm Kiếm" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Địa chỉ</th>
                        <th>Mật khẩu</th>
                        <th class="hidden-role">Vai trò</th>
                        <th></th> <!-- Cột cho các action -->
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="khachHang" items="${khachHangs}">
                        <tr>
                            <td>${khachHang.userID}</td>
                            <td>${khachHang.tenKhachHang}</td>  <!-- Corrected -->
                            <td>${khachHang.email}</td>
                            <td>${khachHang.soDienThoai}</td>  <!-- Corrected -->
                            <td>${khachHang.diaChi}</td>  <!-- Corrected -->
                            <td>${khachHang.matKhau}</td>  <!-- Corrected -->
                            <td class="hidden-role">${khachHang.vaiTro}</td>  <!-- Corrected -->
                    <td>
    <div class="dropdown">
        <button class="btn btn-sm btn-light dropdown-toggle"
                type="button" id="dropdownMenuButton${khachHang.userID}"
                data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-ellipsis-v"></i>
        </button>
        <ul class="dropdown-menu"
            aria-labelledby="dropdownMenuButton${khachHang.userID}">
            <li>
                <form action="${pageContext.request.contextPath}/xoakhachhang" method="post">
                    <input type="hidden" name="userID" value="${khachHang.userID}">
                    <button type="submit" class="dropdown-item" onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này?')">Xóa</button>
                </form>
            </li>
        </ul>
    </div>
</td>
            
        </ul>
    </div>
</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang (nếu cần) -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="#">Trang
                        đầu</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item active"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">Trang
                        cuối</a></li>
                </ul>
            </nav>
        </main>
    </div>
</div>

<!-- Bootstrap JavaScript -->
<script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>