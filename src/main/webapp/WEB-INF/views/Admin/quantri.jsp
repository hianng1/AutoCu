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
    <!-- Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-style.css">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp">
            <jsp:param name="activeMenu" value="quantri" />
        </jsp:include>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Danh sách tài khoản</h2>
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