<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty sanPham.productID ? 'Thêm Sản Phẩm Mới' : 'Cập Nhật Sản Phẩm'}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Admin CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin-style.css">
    <style>
        .required-field::after {
            content: " *";
            color: red;
            font-weight: bold;
        }
        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            margin-top: 10px;
        }
        .form-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #0d6efd;
        }
        .form-section h4 {
            margin-bottom: 15px;
            color: #0d6efd;
        }
    </style>
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
            <h2 class="mb-4">
                <i class="fas ${empty sanPham.productID ? 'fa-plus-circle' : 'fa-edit'}"></i>
                ${empty sanPham.productID ? 'Thêm Sản Phẩm Mới' : 'Cập Nhật Sản Phẩm'}
            </h2>
            
            <form action="${pageContext.request.contextPath}/sanpham/saveSanPham" 
                method="post" enctype="multipart/form-data" class="mb-5 needs-validation" novalidate id="productForm">
                
                <!-- Thêm dòng này để giữ lại ID sản phẩm khi chỉnh sửa -->
                <input type="hidden" name="productID" value="${sanPham.productID}" />

                <!-- Thông tin cơ bản -->
                <div class="form-section">
                    <h4><i class="fas fa-info-circle"></i> Thông tin cơ bản</h4>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="mb-3">
                                <label class="form-label required-field">Tên sản phẩm</label>
                                <input type="text" name="tenSanPham" value="${sanPham.tenSanPham}" 
                                       class="form-control" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập tên sản phẩm
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12">
                            <div class="mb-3">
                                <label class="form-label required-field">Danh mục</label>
                                <select name="categoryID" class="form-select" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="dm" items="${danhMucs}">
                                        <option value="${dm.categoryID}" 
                                            ${sanPham.danhMuc != null && sanPham.danhMuc.categoryID == dm.categoryID ? 'selected' : ''}>
                                            ${dm.tenDanhMuc} (${dm.loai})
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">
                                    Vui lòng chọn danh mục
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="mota" class="form-label">Mô tả sản phẩm</label>
                        <textarea name="mota" id="mota" class="form-control" rows="4">${sanPham.mota}</textarea>
                    </div>
                </div>

                <!-- Thông tin kỹ thuật xe -->
                <div class="form-section">
                    <h4><i class="fas fa-car"></i> Thông số kỹ thuật</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Số ghế</label>
                                <input type="number" name="soGhe" value="${sanPham.soGhe}" 
                                       class="form-control" min="0" max="50">
                                <div class="form-text">Nhập số ghế của xe</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Truyền động</label>
                                <select name="truyenDong" class="form-select">
                                    <option value="">-- Chọn kiểu truyền động --</option>
                                    <option value="Số sàn" ${sanPham.truyenDong == "Số sàn" ? "selected" : ""}>Số sàn</option>
                                    <option value="Số tự động" ${sanPham.truyenDong == "Số tự động" ? "selected" : ""}>Số tự động</option>
                                    <option value="Số hỗn hợp" ${sanPham.truyenDong == "Số hỗn hợp" ? "selected" : ""}>Số hỗn hợp</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="nhienLieu" class="form-label">Nhiên liệu</label>
                                <select name="nhienLieu" id="nhienLieu" class="form-select">
                                    <option value="">-- Chọn nhiên liệu --</option>
                                    <option value="Xăng" ${sanPham.nhienLieu == "Xăng" ? "selected" : ""}>Xăng</option>
                                    <option value="Dầu" ${sanPham.nhienLieu == "Dầu" ? "selected" : ""}>Dầu</option>
                                    <option value="Điện" ${sanPham.nhienLieu == "Điện" ? "selected" : ""}>Điện</option>
                                    <option value="Hybrid" ${sanPham.nhienLieu == "Hybrid" ? "selected" : ""}>Hybrid</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="hangXe" class="form-label">Hãng xe</label>
                                <select name="hangXe" id="hangXe" class="form-select">
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
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Ngày lăn bánh</label>
                                <fmt:formatDate value="${sanPham.ngaySanXuat}" pattern="yyyy-MM-dd" var="ngaySX" />
                                <input type="date" name="ngaySanXuat" value="${ngaySX}" class="form-control">
                                <div class="form-text">Ngày xe đăng ký lăn bánh đầu tiên</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="baoHanh" class="form-label">Bảo hành</label>
                                <select name="baoHanh" id="baoHanh" class="form-select">
                                    <option value="">-- Số năm bảo hành --</option>
                                    <option value="1 năm" ${sanPham.baoHanh == "1 năm" ? "selected" : ""}>1 Năm</option>
                                    <option value="2 năm" ${sanPham.baoHanh == "2 năm" ? "selected" : ""}>2 Năm</option>
                                    <option value="3 năm" ${sanPham.baoHanh == "3 năm" ? "selected" : ""}>3 Năm</option>
                                    <option value="5 năm" ${sanPham.baoHanh == "5 năm" ? "selected" : ""}>5 Năm</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Thông tin địa điểm -->
                <div class="form-section">
                    <h4><i class="fas fa-map-marker-alt"></i> Thông tin địa điểm</h4>
                    <div class="mb-3">
                        <label class="form-label">Địa điểm lấy xe</label>
                        <input type="text" name="diaDiemLayXe" value="${sanPham.diaDiemLayXe}" 
                               class="form-control" list="diaDiemLayXeList">
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
                </div>
                
                <!-- Thông tin hình ảnh -->
                <div class="form-section">
                    <h4><i class="fas fa-image"></i> Hình ảnh sản phẩm</h4>
                    <div class="mb-3">
                        <label class="form-label">Ảnh đại diện sản phẩm</label>
                        <input type="file" name="file" id="imageInput" class="form-control" accept="image/*">
                        <div class="form-text">Chọn ảnh chính cho sản phẩm (JPG, PNG)</div>
                        
                        <div class="mt-2">
                            <c:choose>
                                <c:when test="${not empty sanPham.anhDaiDien}">
                                    <div>
                                        <p class="fw-bold">Ảnh hiện tại:</p>
                                        <img src="${pageContext.request.contextPath}/imgs/${sanPham.anhDaiDien}" 
                                             alt="Ảnh hiện tại" class="image-preview">
                                        <input type="hidden" name="currentImage" value="${sanPham.anhDaiDien}">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="noImageText" class="text-muted">
                                        Chưa có ảnh đại diện
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div id="imagePreviewContainer" class="mt-2" style="display: none;">
                                <p class="fw-bold">Ảnh đã chọn:</p>
                                <img id="imagePreview" class="image-preview" alt="Ảnh xem trước">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/sanpham" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách
                    </a>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> ${empty sanPham.productID ? 'Thêm sản phẩm' : 'Cập nhật sản phẩm'}
                    </button>
                </div>
            </form>
        </main>
    </div>
</div>

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            const form = document.getElementById('productForm');
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
    
    // Image preview functionality
    document.getElementById('imageInput').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('imagePreview').src = e.target.result;
                document.getElementById('imagePreviewContainer').style.display = 'block';
                document.getElementById('noImageText') && (document.getElementById('noImageText').style.display = 'none');
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>
