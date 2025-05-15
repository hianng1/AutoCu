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
            <jsp:param name="activeMenu" value="taikhoan" />
            <jsp:param name="activeSubmenu" value="khachhang" />
        </jsp:include>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
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
                            <td>${khachHang.id}</td>
                            <td>${khachHang.hovaten}</td>  <!-- Corrected -->
                            <td>${khachHang.email}</td>
                            <td>${khachHang.sodienthoai}</td>  <!-- Corrected -->
                            <td>${khachHang.diaChi}</td>  <!-- Corrected -->
                            <td class="hidden-role">${khachHang.role}</td>  <!-- Corrected -->
                    <td>
    <div class="dropdown">
        <button class="btn btn-sm btn-light dropdown-toggle"
                type="button" id="dropdownMenuButton${khachHang.id}"
                data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-ellipsis-v"></i>
        </button>
        <ul class="dropdown-menu"
            aria-labelledby="dropdownMenuButton${khachHang.id}">
            <li>
                <form action="${pageContext.request.contextPath}/xoakhachhang" method="post">
                    <input type="hidden" name="userID" value="${khachHang.id}">
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
        </main>
    </div>
</div>

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>