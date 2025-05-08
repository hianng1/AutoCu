<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng</title>
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


        <!-- Main Content -->
        <main class="col-md-3 ms-sm-auto col-lg-9 main-content">
           
    <h3>Chi tiết đơn hàng #${donHang.orderID}</h3>
    
    <!-- Thông tin khách hàng -->
    <div class="card mb-3">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0"><i class="fas fa-user-circle me-2"></i>Thông tin khách hàng</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong><i class="fas fa-user me-2"></i>Tên khách hàng:</strong> ${donHang.user.hovaten}</p>
                    <p><strong><i class="fas fa-envelope me-2"></i>Email:</strong> ${donHang.user.email}</p>
                </div>
                <div class="col-md-6">
                    <p><strong><i class="fas fa-phone me-2"></i>Số điện thoại:</strong> ${donHang.user.sodienthoai}</p>
                    <p><strong><i class="fas fa-map-marker-alt me-2"></i>Địa chỉ giao hàng:</strong> ${donHang.diaChiGiaoHang}</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Thông tin đơn hàng -->
    <div class="card mb-3">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong><i class="far fa-calendar-alt me-2"></i>Ngày đặt:</strong> <fmt:formatDate value="${donHang.ngayDatHang}" pattern="dd/MM/yyyy HH:mm" /></p>
                    <p><strong><i class="fas fa-shipping-fast me-2"></i>Phương thức vận chuyển:</strong> ${donHang.phuongThucVanChuyen}</p>
                </div>
                <div class="col-md-6">
                    <p><strong><i class="fas fa-tasks me-2"></i>Trạng thái:</strong> <span class="badge bg-${donHang.trangThai == 'DA_GIAO' ? 'success' : donHang.trangThai == 'DA_HUY' ? 'danger' : 'warning'}">${donHang.trangThai.moTa}</span></p>
                    <p><strong><i class="fas fa-credit-card me-2"></i>Phương thức thanh toán:</strong> ${donHang.phuongThucThanhToan}</p>
                    <p><strong><i class="fas fa-check-circle me-2"></i>Đã thanh toán:</strong> ${donHang.daThanhToan ? 'Có' : 'Chưa'}</p>
                </div>
            </div>
            <c:if test="${not empty donHang.ghiChu}">
                <p class="mt-2"><strong><i class="fas fa-comment me-2"></i>Ghi chú:</strong> ${donHang.ghiChu}</p>
            </c:if>
        </div>
    </div>

    <!-- Chi tiết sản phẩm -->
    <div class="card mb-3">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Chi tiết sản phẩm</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${chiTietDonHangs}" var="ct">
                    <tr>
                        <td>${ct.orderItemID}</td>
                        <td>${ct.tenSanPham}</td>
                        <td class="text-center">${ct.soLuong}</td>
                        <td class="text-end"><fmt:formatNumber value="${ct.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                        <td class="text-end"><fmt:formatNumber value="${ct.thanhTien}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot class="table-secondary">
                    <tr>
                        <td colspan="4" class="text-end fw-bold">Tổng tiền hàng:</td>
                        <td class="text-end fw-bold"><fmt:formatNumber value="${donHang.tongTienHang}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="text-end fw-bold">Phí vận chuyển:</td>
                        <td class="text-end fw-bold"><fmt:formatNumber value="${donHang.phiVanChuyen}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="text-end fw-bold fs-5">Tổng thanh toán:</td>
                        <td class="text-end fw-bold fs-5 text-danger"><fmt:formatNumber value="${donHang.tongThanhToan}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>

    <div class="d-flex gap-2 mb-4">
        <a href="${pageContext.request.contextPath}/donhang" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-2"></i>Quay lại
        </a>
        <form action="${pageContext.request.contextPath}/donhang/xuatpdf/${donHang.orderID}" method="post" class="d-inline">
            <button type="submit" class="btn btn-success">
                <i class="fas fa-file-pdf me-2"></i>Xuất hóa đơn PDF
            </button>
        </form>
    </div>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
