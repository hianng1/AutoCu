<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${details[0].tenSanPham} - AutoCu</title>

    <!-- CSS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #fd7e14;
            --secondary-color: #343a40;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-bg: #212529;
            --text-color: #343a40;
            --light-text: #6c757d;
            --border-color: #dee2e6;
        }
        
        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--light-bg);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .breadcrumb-section {
            background-color: white;
            padding: 12px 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        
        .breadcrumb-item a {
            color: var(--light-text);
            text-decoration: none;
            transition: color 0.2s;
        }
        
        .breadcrumb-item a:hover {
            color: var(--primary-color);
        }
        
        .breadcrumb-item.active {
            color: var(--primary-color);
        }
        
        .product-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--secondary-color);
        }
        
        .product-price {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 1.5rem;
        }
        
        .gallery-container {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .main-image-container {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: 400px;
            margin-bottom: 15px;
        }
        
        .main-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        
        .main-image:hover {
            transform: scale(1.05);
        }
        
        .thumbnails-container {
            display: flex;
            gap: 10px;
            overflow-x: auto;
            padding-bottom: 10px;
        }
        
        .thumbnail {
            width: 80px;
            height: 60px;
            border-radius: 5px;
            object-fit: cover;
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.3s, transform 0.3s;
            border: 2px solid transparent;
        }
        
        .thumbnail:hover, .thumbnail.active {
            opacity: 1;
            transform: translateY(-3px);
            border-color: var(--primary-color);
        }
        
        .spec-table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .spec-table th {
            background-color: #f8f9fa;
            color: var(--secondary-color);
            font-weight: 600;
        }
        
        .spec-row {
            transition: background-color 0.2s;
        }
        
        .spec-row:hover {
            background-color: #f8f9fa;
        }
        
        .spec-label {
            font-weight: 500;
            color: var(--secondary-color);
        }
        
        .spec-value {
            color: var(--text-color);
        }
        
        .contact-box {
            background-color: #fff8f0;
            border: 1px solid rgba(253, 126, 20, 0.2);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.04);
        }
        
        .contact-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: rgba(253, 126, 20, 0.1);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-right: 15px;
        }
        
        .description-box {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-top: 30px;
        }
        
        .description-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .description-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .description-content {
            color: var(--text-color);
            line-height: 1.8;
        }
        
        .similar-products-section {
            margin-top: 40px;
            padding: 30px 0;
            background-color: white;
        }
        
        .similar-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        
        .similar-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .card-similar {
            border: none;
            border-radius: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
            overflow: hidden;
            height: 100%;
        }
        
        .card-similar:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .card-similar .card-img-top {
            height: 160px;
            object-fit: cover;
        }
        
        .card-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: var(--accent-color);
            color: white;
            font-size: 0.8rem;
            font-weight: 500;
            padding: 3px 8px;
            border-radius: 20px;
        }
        
        .btn-primary-custom {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
            transition: background-color 0.2s, transform 0.2s;
            border-radius: 50px;
            padding: 10px 20px;
        }
        
        .btn-primary-custom:hover {
            background-color: #e96b02;
            border-color: #e96b02;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(253, 126, 20, 0.2);
        }
        
        .btn-outline-custom {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            background-color: transparent;
            transition: all 0.2s;
            border-radius: 50px;
            padding: 8px 15px;
        }
        
        .btn-outline-custom:hover {
            background-color: var(--primary-color);
            color: white;
        }
    </style>
</head>

<body>
<jsp:include page="/common/header.jsp" />

<!-- Breadcrumb Navigation -->
<div class="breadcrumb-section">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cars">Xe cũ</a></li>
                <li class="breadcrumb-item active" aria-current="page">${details[0].tenSanPham}</li>
            </ol>
        </nav>
    </div>
</div>

<div class="container py-4">
    <!-- Tiêu đề và giá -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h1 class="product-title">${details[0].tenSanPham}</h1>
            <div class="d-flex align-items-center mb-3">
                <div class="text-warning me-2">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
                <span class="text-muted">(12 đánh giá)</span>
            </div>
        </div>
        <div class="col-md-4 text-md-end">
            <div class="text-muted">
                <i class="fas fa-map-marker-alt me-1"></i> ${details[0].diaDiemLayXe}
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-md-6 mb-4">
            <div class="gallery-container">
                <div class="main-image-container">
                    <img src="<c:url value='/imgs/${details[0].anhDaiDien}' />" class="main-image" id="mainImage" alt="${details[0].tenSanPham}">
                </div>
                <div class="thumbnails-container">
                    <img src="<c:url value='/imgs/${details[0].anhDaiDien}' />" class="thumbnail active" onclick="changeImage(this)" alt="${details[0].tenSanPham}">
                    
                    <c:forEach var="image" items="${hinhAnhList}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <img src="<c:url value='/imgs/${image.fileName}' />" class="thumbnail" onclick="changeImage(this)" alt="Ảnh ${status.index + 1}">
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            
            <!-- Contact Box -->
            <div class="contact-box mt-4">
                <div class="row">
                    <div class="col-md-6 mb-3 mb-md-0">
                        <div class="d-flex align-items-center">
                            <div class="contact-icon">
                                <i class="fas fa-phone-alt"></i>
                            </div>
                            <div>
                                <h6 class="mb-1 fw-bold">Gọi ngay</h6>
                                <p class="mb-0">0988.888.888</p>
                                <small class="text-muted">Zalo cùng số</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-center">
                            <div class="contact-icon">
                                <i class="fab fa-facebook-messenger"></i>
                            </div>
                            <div>
                                <h6 class="mb-1 fw-bold">Chat ngay</h6>
                                <p class="mb-0">AUTOCU</p>
                                <small class="text-muted">Hỗ trợ 24/7</small>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <a href="${pageContext.request.contextPath}/support" class="btn btn-primary-custom w-100">
                            <i class="fas fa-file-alt me-2"></i> Đăng ký tư vấn xe
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Thông số kỹ thuật -->
        <div class="col-md-6">
            <div class="card spec-table border-0 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0 fw-bold"><i class="fas fa-clipboard-list me-2 text-primary"></i>Thông số kỹ thuật</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <tbody>
                            <tr class="spec-row">
                                <td width="40%" class="spec-label">Động cơ</td>
                                <td class="spec-value">${details[0].nhienLieu}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Số ghế</td>
                                <td class="spec-value">${details[0].soGhe} Ghế</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Truyền động</td>
                                <td class="spec-value">${details[0].truyenDong}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Số cửa</td>
                                <td class="spec-value">5 Cửa</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Kiểu dáng</td>
                                <td class="spec-value">${details[0].danhMuc.tenDanhMuc}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Hãng xe</td>
                                <td class="spec-value">${details[0].hangXe}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Bảo hành</td>
                                <td class="spec-value">${details[0].baoHanh}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Địa điểm lấy xe</td>
                                <td class="spec-value">${details[0].diaDiemLayXe}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Năm sản xuất</td>
                                <td class="spec-value"><fmt:formatDate value="${details[0].ngaySanXuat}" pattern="yyyy"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="card-footer bg-white d-flex justify-content-between">
                    <button class="btn btn-outline-custom">
                        <i class="far fa-heart me-1"></i> Lưu xe
                    </button>
                    <button class="btn btn-outline-custom">
                        <i class="fas fa-share-alt me-1"></i> Chia sẻ
                    </button>
                </div>
            </div>
            
            <!-- Badges/Tags -->
            <div class="mt-4">
                <span class="badge bg-light text-dark me-2 mb-2 p-2"><i class="fas fa-check-circle text-success me-1"></i> Đã kiểm định</span>
                <span class="badge bg-light text-dark me-2 mb-2 p-2"><i class="fas fa-history text-info me-1"></i> Lịch sử rõ ràng</span>
                <span class="badge bg-light text-dark me-2 mb-2 p-2"><i class="fas fa-certificate text-warning me-1"></i> Bảo hành</span>
                <span class="badge bg-light text-dark me-2 mb-2 p-2"><i class="fas fa-exchange-alt text-primary me-1"></i> Hỗ trợ đổi xe</span>
            </div>
        </div>
    </div>

    <!-- Mô tả sản phẩm -->
    <div class="description-box">
        <h2 class="description-title">Thông tin chi tiết</h2>
        <div class="description-content">
            ${details[0].mota}
        </div>
    </div>
</div>

<!-- Similar Products Section -->
<section class="similar-products-section">
    <div class="container">
        <h2 class="similar-title">Xe tương tự</h2>
        
        <div class="row g-4">
            <c:forEach var="sp" items="${sanPhamTuongTu}" begin="0" end="3">
                <div class="col-12 col-sm-6 col-md-6 col-lg-3">
                    <!-- Card design from index2.jsp -->
                    <div class="card h-100 card-hover-effect border-0 shadow-sm">
                        <img src="<c:url value='/imgs/${sp.anhDaiDien}' />" class="card-img-top object-cover" alt="${sp.tenSanPham}" style="height: 200px;">

                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-3">${sp.tenSanPham}</h5>

                            <div class="d-flex justify-content-between text-muted small mb-2">
                                <span><i class="fas fa-calendar text-success me-1"></i> <fmt:formatDate value="${sp.ngaySanXuat}" pattern="yyyy" /></span>
                                <span><i class="fas fa-map-marker-alt text-danger me-1"></i> ${sp.diaDiemLayXe}</span>
                            </div>

                            <div class="d-flex justify-content-between text-muted small mb-3">
                                <span><i class="fas fa-gas-pump text-primary me-1"></i> ${sp.nhienLieu}</span>
                                <span><i class="fas fa-cog text-warning me-1"></i> ${sp.truyenDong}</span>
                            </div>

                            <a href="${pageContext.request.contextPath}/details/${sp.productID}" class="btn btn-outline-primary w-100">
                                <i class="fas fa-info-circle me-2"></i>Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Image Gallery Functionality
    function changeImage(thumbnail) {
        // Change the main image source
        document.getElementById('mainImage').src = thumbnail.src;
        
        // Update active class
        document.querySelectorAll('.thumbnail').forEach(thumb => {
            thumb.classList.remove('active');
        });
        thumbnail.classList.add('active');
    }
    
    // Auto-rotate images
    const thumbnails = document.querySelectorAll('.thumbnail');
    let currentIndex = 0;
    
    function rotateImages() {
        if (thumbnails.length > 1) {
            currentIndex = (currentIndex + 1) % thumbnails.length;
            changeImage(thumbnails[currentIndex]);
        }
    }
    
    // Rotate images every 5 seconds
    const imageInterval = setInterval(rotateImages, 5000);
    
    // Stop auto-rotation when user interacts with thumbnails
    document.querySelectorAll('.thumbnail').forEach(thumb => {
        thumb.addEventListener('click', () => {
            clearInterval(imageInterval);
        });
    });
</script>
</body>
</html>