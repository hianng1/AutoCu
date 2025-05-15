<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/Sửa Sản Phẩm</title>
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

        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <h2 class="mb-4">Thêm/Sửa Sản Phẩm</h2>
            <form action="${pageContext.request.contextPath}/sanpham/saveSanPham" 
                method="post" enctype="multipart/form-data" class="mb-5">
                
                <!-- Thêm dòng này để giữ lại ID sản phẩm khi chỉnh sửa -->
                <input type="hidden" name="productID" value="${sanPham.productID}" />

                <div class="mb-3">
                    <label>Tên sản phẩm</label>
                    <input type="text" name="tenSanPham" value="${sanPham.tenSanPham}" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Số ghế</label>
                    <input type="number" name="soGhe" value="${sanPham.soGhe}" class="form-control">
                </div>
  <div class="mb-3">
    <label>Truyền động</label>
    <select name="truyenDong" class="form-control">
        <option value="" ${sanPham.truyenDong == "" ? "selected" : ""}>-- Chọn kiểu truyền động --</option>
        <option value="Số sàn" ${sanPham.truyenDong == "Số sàn" ? "selected" : ""}>Số sàn</option>
        <option value="Số tự động" ${sanPham.truyenDong == "Số tự động" ? "selected" : ""}>Số tự động</option>
    </select>
</div>

 <div class="mb-3">
    <label for="nhienLieu">Nhiên liệu</label>
    <select name="nhienLieu" class="form-control">
        <option value="">-- Chọn nhiên liệu --</option>
        <option value="Xăng" ${sanPham.nhienLieu == "Xăng" ? "selected" : ""}>Xăng</option>
        <option value="Điện" ${sanPham.nhienLieu == "Điện" ? "selected" : ""}>Điện</option>
        <option value="Hybrid" ${sanPham.nhienLieu == "Hybrid" ? "selected" : ""}>Hybrid</option>
    </select>
</div>

  <div class="mb-3">
    <label>Địa điểm lấy xe</label>
    <input type="text" name="diaDiemLayXe" value="${sanPham.diaDiemLayXe}" class="form-control" list="diaDiemLayXeList">
    <datalist id="diaDiemLayXeList">
        <option value="Hà Nội" />
        <option value="Hồ Chí Minh" />
        <option value="Đà Nẵng" />
        <option value="Hải Phòng" />
        <option value="Cần Thơ" />
        <option value="Nha Trang" />
        <option value="Huế" />
        <option value="Quảng Ninh" />
        <option value="Bình Dương" />
        <option value="Phan Thiết" />
    </datalist>
</div>

<div class="mb-3">
    <label for="hangXe">Hãng xe</label>
    <select name="hangXe" class="form-control">
        <option value="">-- Chọn hãng xe --</option>
        <option value="Toyota" ${sanPham.hangXe == "Toyota" ? "selected" : ""}>Toyota</option>
        <option value="Honda" ${sanPham.hangXe == "Honda" ? "selected" : ""}>Honda</option>
        <option value="Ford" ${sanPham.hangXe == "Ford" ? "selected" : ""}>Ford</option>
        <option value="BMW" ${sanPham.hangXe == "BMW" ? "selected" : ""}>BMW</option>
        <option value="Mercedes-Benz" ${sanPham.hangXe == "Mercedes-Benz" ? "selected" : ""}>Mercedes-Benz</option>
        <option value="Audi" ${sanPham.hangXe == "Audi" ? "selected" : ""}>Audi</option>
        <option value="Chevrolet" ${sanPham.hangXe == "Chevrolet" ? "selected" : ""}>Chevrolet</option>
        <option value="Nissan" ${sanPham.hangXe == "Nissan" ? "selected" : ""}>Nissan</option>
        <option value="Hyundai" ${sanPham.hangXe == "Hyundai" ? "selected" : ""}>Hyundai</option>
        <option value="Kia" ${sanPham.hangXe == "Kia" ? "selected" : ""}>Kia</option>
    </select>
</div>

    <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="gia" value="${sanPham.gia}" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Số lượng trong kho</label>
        <input type="number" name="soLuongTrongKho" value="${sanPham.soLuongTrongKho}" class="form-control">
    </div>
      <label>Ngày lăn bánh</label>
      <div>
<fmt:formatDate value="${sanPham.ngaySanXuat}" pattern="yyyy-MM-dd" var="ngaySX" />
<input type="date" name="ngaySanXuat"
       value="${ngaySX}" 
       class="form-control" required>
</div> <br>

  <div class="mb-3">
    <label for="baoHanh">Bảo hành</label>
    <select name="baoHanh" class="form-control">
        <option value="">-- Số năm bảo hành --</option>
        <option value="1 năm" ${sanPham.baoHanh == "1 năm" ? "selected" : ""}>1 Năm</option>
        <option value="2 năm" ${sanPham.baoHanh == "2 năm" ? "selected" : ""}>2 Năm</option>
        <option value="3 năm" ${sanPham.baoHanh == "3 năm" ? "selected" : ""}>3 Năm</option>
    </select>
</div>

 

  <div class="mb-3">
        <label>Chọn ảnh chính:</label>
        <input type="file" name="file" accept="image/*" />
        <c:if test="${not empty sanPham.anhDaiDien}">
            <img src="${pageContext.request.contextPath}/imgs/${sanPham.anhDaiDien}" width="100" />
        </c:if>
    </div>

   <div class="mb-3">
        <label for="mota">Mô tả sản phẩm</label>
        <textarea name="mota" class="form-control" rows="4">${sanPham.mota}</textarea>
    </div>
    
    <div class="mb-3">
        <label>Danh mục</label>
        <select name="categoryID" class="form-control">
            <c:forEach var="dm" items="${danhMucs}">
                <option value="${dm.categoryID}" 
                    ${sanPham.danhMuc != null && sanPham.danhMuc.categoryID == dm.categoryID ? 'selected' : ''}>
                    ${dm.categoryID}
                </option>
            </c:forEach>
        </select>
    </div>
    <button type="submit" class="btn btn-success">Lưu</button>
    <a href="${pageContext.request.contextPath}/sanpham" class="btn btn-secondary">Hủy</a>
</form>
        </main>
    </div>
</div>

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
