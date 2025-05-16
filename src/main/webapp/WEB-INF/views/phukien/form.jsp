<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty phuKienOto.accessoryID ? 'Thêm Phụ Kiện Mới' : 'Cập Nhật Phụ Kiện'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            <jsp:param name="activeSubmenu" value="phukien" />
        </jsp:include>
        
        <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
            <h2 class="mb-4">
                <i class="fas ${empty phuKienOto.accessoryID ? 'fa-plus-circle' : 'fa-edit'}"></i>
                ${empty phuKienOto.accessoryID ? 'Thêm Phụ Kiện Mới' : 'Cập Nhật Phụ Kiện'}
            </h2>
            
            <form action="${pageContext.request.contextPath}/phukien/save" 
                  method="post" 
                  enctype="multipart/form-data" 
                  class="mb-5 needs-validation" 
                  novalidate 
                  id="accessoryForm">
                
                <!-- Hidden fields -->
                <input type="hidden" name="accessoryID" value="${phuKienOto.accessoryID}"/>

                <!-- Thông tin cơ bản -->
                <div class="form-section">
                    <h4><i class="fas fa-info-circle"></i> Thông tin cơ bản</h4>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="tenPhuKien" class="form-label required-field">Tên phụ kiện</label>
                                <input type="text" name="tenPhuKien" id="tenPhuKien" 
                                       value="${phuKienOto.tenPhuKien}" class="form-control" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập tên phụ kiện
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="hangSanXuat" class="form-label required-field">Hãng sản xuất</label>
                                <input type="text" name="hangSanXuat" id="hangSanXuat" 
                                       value="${phuKienOto.hangSanXuat}" class="form-control" 
                                       list="hangSanXuatList" required>
                                <datalist id="hangSanXuatList">
                                    <option value="Bosch"/>
                                    <option value="Denso"/>
                                    <option value="Valeo"/>
                                    <option value="ZF Friedrichshafen"/>
                                    <option value="Continental"/>
                                    <option value="Hella"/>
                                    <option value="Brembo"/>
                                    <option value="Magneti Marelli"/>
                                    <option value="KYB"/>
                                    <option value="NGK"/>
                                </datalist>
                                <div class="invalid-feedback">
                                    Vui lòng chọn hoặc nhập hãng sản xuất
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="gia" class="form-label required-field">Giá</label>
                                <div class="input-group">
                                    <input type="number" name="gia" id="gia" 
                                           value="${phuKienOto.gia}" class="form-control" 
                                           min="0" step="1000" required>
                                    <span class="input-group-text">VNĐ</span>
                                    <div class="invalid-feedback">
                                        Giá không được để trống và phải lớn hơn 0
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="soLuong" class="form-label required-field">Số lượng tồn kho</label>
                                <input type="number" name="soLuong" id="soLuong" 
                                       value="${phuKienOto.soLuong}" class="form-control" 
                                       min="0" required>
                                <div class="invalid-feedback">
                                    Số lượng không được để trống và phải là số không âm
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="categoryId" class="form-label required-field">Danh mục</label>
                        <select name="categoryId" id="categoryId" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${danhMucList}" var="dm">
                                <option value="${dm.categoryID}" 
                                    ${phuKienOto.danhMuc != null && phuKienOto.danhMuc.categoryID == dm.categoryID ? 'selected' : ''}>
                                    ${dm.tenDanhMuc} (${dm.loai})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">
                            Vui lòng chọn danh mục
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="moTa" class="form-label">Mô tả chi tiết</label>
                        <textarea name="moTa" id="moTa" class="form-control" rows="4">${phuKienOto.moTa}</textarea>
                        <div class="form-text">Nhập mô tả chi tiết về phụ kiện, tính năng và các thông số kỹ thuật</div>
                    </div>
                </div>

                <!-- Thông tin hình ảnh -->
                <div class="form-section">
                    <h4><i class="fas fa-image"></i> Hình ảnh sản phẩm</h4>
                    <div class="mb-3">
                        <label for="file" class="form-label required-field">Ảnh đại diện sản phẩm</label>
                        <input type="file" name="file" id="imageInput" class="form-control" accept="image/*" ${empty phuKienOto.anhDaiDien ? 'required' : ''}>
                        <div class="form-text">Chọn ảnh chính cho sản phẩm (JPG, PNG)</div>
                        
                        <div class="mt-2">
                            <c:choose>
                                <c:when test="${not empty phuKienOto.anhDaiDien}">
                                    <div>
                                        <p class="fw-bold">Ảnh hiện tại:</p>
                                        <img src="${pageContext.request.contextPath}/imgs/${phuKienOto.anhDaiDien}" 
                                             alt="Ảnh hiện tại" class="image-preview">
                                        <input type="hidden" name="currentImage" value="${phuKienOto.anhDaiDien}">
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
                    <a href="${pageContext.request.contextPath}/phukien/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách
                    </a>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> ${empty phuKienOto.accessoryID ? 'Thêm phụ kiện' : 'Cập nhật phụ kiện'}
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
            const form = document.getElementById('accessoryForm');
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
