<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-style.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp">
            <jsp:param name="activeMenu" value="sanpham" />
            <jsp:param name="activeSubmenu" value="qlsanpham" />
        </jsp:include>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <div class="container mt-4">
                <h2 class="text-center text-primary">Quản Lý Sản Phẩm</h2>
                
                <!-- Form thêm/sửa sản phẩm -->
                <form action="SanPhamServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="${sanPham != null ? 'update' : 'create'}">
                    <div class="row">
                        <div class="col-md-6">
                            <label>Mã sản phẩm:</label>
                            <input type="text" name="productID" class="form-control" value="${sanPham.productID}" required>
                        </div>
                        <div class="col-md-6">
                            <label>Tên sản phẩm:</label>
                            <input type="text" name="tenSanPham" class="form-control" value="${sanPham.tenSanPham}" required>
                        </div>
                        <div class="col-md-6">
                            <label>Hãng xe:</label>
                            <input type="text" name="hangXe" class="form-control" value="${sanPham.hangXe}">
                        </div>
                        <div class="col-md-6">
                            <label>Số ghế:</label>
                            <input type="number" name="soGhe" class="form-control" value="${sanPham.soGhe}">
                        </div>
                        <div class="col-md-6">
                            <label>Truyền động:</label>
                            <input type="text" name="truyenDong" class="form-control" value="${sanPham.truyenDong}">
                        </div>
                        <div class="col-md-6">
                            <label>Nhiên liệu:</label>
                            <input type="text" name="nhienLieu" class="form-control" value="${sanPham.nhienLieu}">
                        </div>
                        <div class="col-md-6">
                            <label>Giá:</label>
                            <input type="number" name="gia" class="form-control" value="${sanPham.gia}" required>
                        </div>
                        <div class="col-md-6">
                            <label>Số lượng:</label>
                            <input type="number" name="soLuongTrongKho" class="form-control" value="${sanPham.soLuongTrongKho}">
                        </div>
                        <div class="col-md-6">
                            <label>Ngày sản xuất:</label>
                            <input type="date" name="ngaySanXuat" class="form-control" value="${sanPham.ngaySanXuat}">
                        </div>
                        <div class="col-md-6">
                            <label>Bảo hành:</label>
                            <input type="text" name="baoHanh" class="form-control" value="${sanPham.baoHanh}">
                        </div>
                        <div class="col-md-6">
                            <label>Ảnh đại diện:</label>
                            <input type="file" name="anhDaiDien" class="form-control">
                            <c:if test="${not empty sanPham.anhDaiDien}">
                                <img src="${pageContext.request.contextPath}/uploads/${sanPham.anhDaiDien}" alt="Ảnh sản phẩm" class="img-thumbnail mt-2" width="100">
                            </c:if>
                        </div>
                        <div class="col-md-6">
                            <label>Danh mục:</label>
                            <select name="categoryID" class="form-control">
                                <c:forEach var="dm" items="${dsDanhMuc}">
                                    <option value="${dm.categoryID}" ${sanPham.danhMuc.categoryID == dm.categoryID ? 'selected' : ''}>${dm.tenDanhMuc}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success mt-3">Lưu</button>
                </form>

                <!-- Danh sách sản phẩm -->
                <h3 class="mt-4">Danh sách sản phẩm</h3>
                <table class="table table-bordered table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>Mã SP</th>
                            <th>Tên SP</th>
                            <th>Hãng</th>
                            <th>Giá</th>
                            <th>Ảnh</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sp" items="${dsSanPham}">
                            <tr>
                                <td>${sp.productID}</td>
                                <td>${sp.tenSanPham}</td>
                                <td>${sp.hangXe}</td>
                                <td><fmt:formatNumber value="${sp.gia}" type="currency" currencyCode="VND" /></td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/uploads/${sp.anhDaiDien}" width="50" alt="Ảnh">
                                </td>
                                <td>
                                    <a href="SanPhamServlet?action=edit&productID=${sp.productID}" class="btn btn-warning btn-sm">Sửa</a>
                                    <a href="SanPhamServlet?action=delete&productID=${sp.productID}" class="btn btn-danger btn-sm" onclick="return confirm('Xóa sản phẩm này?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
