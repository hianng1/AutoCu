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
       <nav id="sidebar" class="col-md-3 col-lg-3 d-md-block sidebar">
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
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/thongke">Thống kê bán hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/donhang">Thống kê đơn hàng</a></li>
        </ul>
    </div>
</li>
        </ul>
    </div>
</nav>


        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
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
                        <th>Địa chỉ</th>
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
                            <td>${user.diaChi}</td>
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