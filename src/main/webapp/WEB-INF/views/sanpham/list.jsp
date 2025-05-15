<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Quản lý sản phẩm</title>
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
            <jsp:param name="activeSubmenu" value="qlsanpham" />
        </jsp:include>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Danh sách sản phẩm</h2>
                <a href="${pageContext.request.contextPath}/sanpham/them" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm sản phẩm
                </a>
            </div>
            
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Mã</th>
                            <th>Tên</th>
                            <th>Giá</th>
                            <th>Số ghế</th>
                            <th>Hãng</th>
                            <th>Ảnh</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sp" items="${dsSanPham}">
                            <tr>
                                <td>${sp.productID}</td>
                                <td>${sp.tenSanPham}</td>
                                <td>
                                    <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                                </td>
                                <td>${sp.soGhe}</td>
                                <td>${sp.hangXe}</td>
                                <td>
                                    <img src="/imgs/${sp.anhDaiDien}" 
                                    class="card-img-top object-cover" 
                                    alt="${sp.anhDaiDien}" 
                                    style="height: 40px; width: 70px;">
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/sanpham/sua/${sp.productID}" class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/sanpham/xoa/${sp.productID}" 
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
            
            <!-- Pagination if needed -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/sanpham?page=0">Trang đầu</a>
                        </li>
                        <c:forEach begin="0" end="${totalPages-1}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/sanpham?page=${i}">${i+1}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages-1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/sanpham?page=${totalPages-1}">Trang cuối</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </main>
    </div>
</div>

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>