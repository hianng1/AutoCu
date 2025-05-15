<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn Hàng</title>
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
            <jsp:param name="activeMenu" value="thongke" />
            <jsp:param name="activeSubmenu" value="donhang" />
        </jsp:include>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
           <div class="container py-4">
                <h2 class="mb-4 text-primary">Quản lý Đơn Hàng</h2>

                <!-- Form lọc -->
    <form class="row g-3 mb-4" method="get" action="/donhang">
        <div class="col-auto">
            <label for="trangThai" class="col-form-label">Lọc theo trạng thái:</label>
        </div>
        <div class="col-auto">
            <select class="form-select" name="trangThai" id="trangThai" onchange="this.form.submit()">
                <option value="">-- Tất cả --</option>
                <c:forEach items="${trangThais}" var="tt">
                    <option value="${tt}" ${tt == trangThaiSelected ? 'selected' : ''}>${tt.moTa}</option>
                </c:forEach>
            </select>
        </div>
    </form>

    <!-- Bảng đơn hàng -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-primary">
            <tr>
            <th>Mã đơn hàng</th>
        <th>Ngày đặt</th>
        <th>Trạng thái</th>
        <th>Phương thức thanh toán</th>
        
        <th>User ID</th>
        <th>Địa chỉ giao hàng</th>
        <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${donHangs}" var="don">
                <tr>
                    <td>${don.orderID}</td>
               
                    <td>${don.ngayDatHang}</td>
                 
                    <td>
                        <form method="post" action="/donhang/update/${don.orderID}">
                            <select class="form-select form-select-sm" name="trangThai" onchange="this.form.submit()">
                                <c:forEach items="${trangThais}" var="tt">
                                    <option value="${tt}" ${tt == don.trangThai ? 'selected' : ''}>${tt.moTa}</option>
                                </c:forEach>
                            </select>

                            <!-- CSRF token nếu dùng Spring Security -->
                            <sec:csrfInput/>
                        </form>
                        
                    </td>
                    <td>${don.phuongThucThanhToan}</td>
                     <td>${don.user.id}</td>
                   <td>${don.diaChiGiaoHang}</td>
                    <td>
                     <a href="${pageContext.request.contextPath}/donhang/chitiet/${don.orderID}" class="btn btn-sm btn-info ms-2">
        <i class="fa fa-eye"></i> Xem chi tiết
    </a>
                    </td>
                    
                </tr>
            </c:forEach>
            </tbody>
          
        </table>
    </div>
</div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
