<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Danh sách tài khoản   </h2>
                <form class="d-flex">
                    <input class="form-control me-2" type="search"
                           placeholder="Tìm Kiếm" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-bordered" id="userTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                         <th>Mật khẩu</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Số điện thoại</th>
                        <th>Họ và tên</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                             <td>${user.password}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>${user.sodienthoai}</td>
                            <td>${user.hovaten}</td>
                            <td>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-light dropdown-toggle"
                                            type="button" id="dropdownMenuButton1"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v"></i>
                                    </button>
                                    <ul class="dropdown-menu"
                                        aria-labelledby="dropdownMenuButton1">

                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/suanhanvien?id=${user.id}">Sửa</a></li>
     <li>
    <form action="${pageContext.request.contextPath}/xoanhanvien" method="post">
        <input type="hidden" name="id" value="${user.id}">
        <button type="submit" class="dropdown-item" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">Xóa</button>
    </form>
</li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
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

<script>
    function sortTable() {
        const table = document.getElementById("userTable");
        const tbody = table.querySelector("tbody");
        const rows = Array.from(tbody.querySelectorAll("tr"));

        // Sắp xếp các hàng dựa trên giá trị của cột ID (cột đầu tiên)
        rows.sort((rowA, rowB) => {
            const idA = parseInt(rowA.cells[0].textContent);
            const idB = parseInt(rowB.cells[0].textContent);
            return idA - idB;
        });

        // Xóa các hàng hiện tại khỏi tbody
        while (tbody.firstChild) {
            tbody.removeChild(tbody.firstChild);
        }

        // Thêm lại các hàng đã sắp xếp vào tbody
        rows.forEach(row => {
            tbody.appendChild(row);
        });
    }

    // Gọi hàm sortTable() khi trang được tải
    window.onload = sortTable;
</script>
</body>
</html>