<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Quản lý phụ kiện</title>
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
        <jsp:include page="../Admin/sidebar.jsp">
            <jsp:param name="activeMenu" value="sanpham" />
            <jsp:param name="activeSubmenu" value="phukien" />
        </jsp:include>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
        
        <div class="container py-4">
            <h2 class="mb-4 text-primary">Danh sách phụ kiện ô tô</h2>
            
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">
                    ${errorMessage}  
                    <a class="nav-link" href="${pageContext.request.contextPath}/phukien/list" style="font-size: 18px; font-weight: bold;">Quay lại</a>
                </p>
            </c:if>
            
            <div class="mb-3">
                <a href="/phukien/form" class="btn btn-success">+ Thêm phụ kiện</a>
            </div>

            <table class="table table-bordered table-hover text-center">
                <thead class="table-success text-white">
                    <tr>
                        <th>Mã</th>
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
                            <td>
                                <img src="/imgs/${item.anhDaiDien}" class="card-img-top object-cover" alt="${item.anhDaiDien}" style="height: 40px; width: 70px;">
                            </td>
                            <td>${item.danhMuc.tenDanhMuc}</td>
                            <%-- <td>
                                <a href="/phukien/edit/${item.accessoryID}" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="/phukien/delete/${item.accessoryID}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                            </td> --%>
                            <td>
                                    <div class="btn-group">
                                        <a href="/phukien/edit/${item.accessoryID}" class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="/phukien/delete/${item.accessoryID}" 
                                           class="btn btn-danger btn-sm" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
