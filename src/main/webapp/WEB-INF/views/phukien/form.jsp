<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Thêm/Sửa phụ tùng</title>
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
        
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <h2 class="mb-4">Thêm/Sửa Phụ kiện Ô tô</h2>
            <form:form method="post" modelAttribute="phuKienOto" action="/phukien/save" enctype="multipart/form-data" class="mb-5">
                <form:hidden path="accessoryID"/>

                <div class="mb-3">
                    <label for="tenPhuKien" class="form-label">Tên phụ kiện:</label>
                    <form:input path="tenPhuKien" cssClass="form-control" id="tenPhuKien"/>
                </div>

                <div class="mb-3">
                    <label for="moTa" class="form-label">Mô tả:</label>
                    <form:textarea path="moTa" cssClass="form-control" id="moTa"/>
                </div>

                <div class="mb-3">
                    <label for="gia" class="form-label">Giá:</label>
                    <form:input path="gia" type="number" cssClass="form-control" id="gia"/>
                </div>

                <div class="mb-3">
                    <label for="soLuong" class="form-label">Số lượng:</label>
                    <form:input path="soLuong" type="number" cssClass="form-control" id="soLuong"/>
                </div>

                <div class="mb-3">
                    <label for="hangSanXuat" class="form-label">Hãng sản xuất:</label>
                    <form:input path="hangSanXuat" cssClass="form-control" id="hangSanXuat" list="hangSanXuatList"/>
                    <datalist id="hangSanXuatList">
                        <option value="Bosch" />
                        <option value="Denso" />
                        <option value="Valeo" />
                        <option value="ZF Friedrichshafen" />
                        <option value="Continental" />
                        <option value="Hella" />
                        <option value="Brembo" />
                        <option value="Magneti Marelli" />
                        <option value="KYB" />
                        <option value="NGK" />
                    </datalist>
                </div>

                <div class="mb-3">
                    <label for="file" class="form-label">Ảnh đại diện:</label>
                    <input type="file" name="file" class="form-control" id="file"/>
                </div>

                <div class="mb-3">
                    <label for="categoryId" class="form-label">Danh mục:</label>
                    <select name="categoryId" id="categoryId" class="form-control">
                        <c:forEach items="${danhMucList}" var="dm">
                            <option value="${dm.categoryID}"
                                <c:if test="${phuKienOto.danhMuc.categoryID == dm.categoryID}">selected</c:if>>
                                ${dm.categoryID} - ${dm.tenDanhMuc}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Lưu</button>
                <a href="/phukien/list" class="btn btn-secondary">Hủy</a>
            </form:form>
        </main>
    </div>
</div>

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
