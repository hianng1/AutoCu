<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Xe Ô Tô Cũ Chất Lượng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.8)), url('${pageContext.request.contextPath}/imgs/905a7c51285be48ad16a41b2b4a7aaf8c4b076a6.jpg');
            background-size: cover;
            background-position: center;
            padding: 80px 0;
            color: white;
            margin-bottom: 30px;
        }
        .card-car {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
            border: none;
        }
        .card-car:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.1);
        }
        .car-img-wrapper {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        .car-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        .car-img-wrapper:hover img {
            transform: scale(1.05);
        }
        .price-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #fd7e14;
            color: white;
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 30px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        .status-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #dc3545;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
        }
        .filter-chip {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 30px;
            padding: 8px 20px;
            margin: 5px;
            font-weight: 500;
            color: #495057;
            transition: all 0.2s;
            text-decoration: none;
            font-size: 0.85rem;
        }
        .filter-chip:hover, .filter-chip.active {
            background-color: #fd7e14;
            border-color: #fd7e14;
            color: white;
        }
        .car-feature {
            display: inline-flex;
            align-items: center;
            font-size: 0.85rem;
            color: #6c757d;
            margin-right: 15px;
            margin-bottom: 8px;
        }
        .car-feature i {
            margin-right: 5px;
            color: #fd7e14;
        }
        .section-title {
            position: relative;
            margin-bottom: 30px;
        }
        .section-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 3px;
            background-color: #fd7e14;
        }
        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .btn-orange {
            background-color: #fd7e14;
            color: white;
            border: none;
        }
        .btn-orange:hover {
            background-color: #e96b02;
            color: white;
        }
        .car-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #e63946;
        }
        /* Card balancing enhancements */
        .card {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .card-title {
            height: 48px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            line-clamp: 2;
        }
        .btn.mt-auto {
            margin-top: auto !important;
        }        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        
        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .hero-section {
                padding: 40px 0;
            }
            
            .hero-section h1 {
                font-size: 1.8rem;
            }
            
            .hero-section p {
                font-size: 0.95rem;
            }
            
            .filter-chip {
                padding: 6px 12px;
                margin: 3px;
                font-size: 0.85rem;
            }
            
            .card-car {
                margin-bottom: 20px;
            }
            
            .car-img-wrapper {
                height: 160px;
            }
            
            .card-title {
                font-size: 1rem;
                line-height: 1.3;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
            
            .position-absolute.top-0.end-0 .btn {
                width: 35px !important;
                height: 35px !important;
            }
            
            .filter-section {
                margin-bottom: 20px;
            }
            
            .container {
                padding-left: 15px;
                padding-right: 15px;
            }
            
            .row.g-4 {
                margin: 0 -10px;
            }
            
            .row.g-4 > * {
                padding: 0 10px;
                margin-bottom: 20px;
            }
        }

        @media (max-width: 480px) {
            .hero-section h1 {
                font-size: 1.5rem;
            }
            
            .filter-chip {
                display: block;
                width: 100%;
                text-align: center;
                margin: 5px 0;
            }
            
            .car-img-wrapper {
                height: 140px;
            }
            
            .card-title {
                font-size: 0.95rem;
            }
            
            .btn {
                padding: 6px 12px;
                font-size: 0.85rem;
            }
            
            .position-absolute.top-0.end-0 .btn {
                width: 30px !important;
                height: 30px !important;
            }
            
            .position-absolute.top-0.end-0 .btn i {
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 mx-auto text-center">
                <h1 class="display-4 fw-bold mb-4">Xe Ô Tô Cũ Chất Lượng</h1>
                <p class="lead mb-4">Khám phá bộ sưu tập xe cũ đa dạng, đã qua kiểm định và bảo dưỡng kỹ lưỡng</p>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mt-3 mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a></li>
            <li class="breadcrumb-item active">Xe cũ</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Sidebar Filters -->
        <div class="col-lg-3 mb-4">
            <form action="${pageContext.request.contextPath}/cars" method="get" id="filterForm">
                <!-- Keep existing category if selected -->
                <c:if test="${not empty param.category}">
                    <input type="hidden" name="category" value="${param.category}">
                </c:if>
                
                <div class="filter-section">
                    <h5 class="section-title fw-bold">Danh Mục Xe</h5>
                    <div class="d-flex flex-wrap mt-4">
                        <a href="${pageContext.request.contextPath}/cars" class="filter-chip ${empty param.category ? 'active' : ''}">
                            Tất cả
                        </a>
                        <c:forEach var="category" items="${categoriesList}">
                            <c:if test="${category.loai == 'xe'}">
                                <a href="${pageContext.request.contextPath}/cars?category=${category.tenDanhMuc}" 
                                class="filter-chip ${param.category eq category.tenDanhMuc ? 'active' : ''}">
                                    ${category.tenDanhMuc}
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>     
                <div class="filter-section">
                    <h5 class="fw-bold mb-3">Năm Sản Xuất</h5>
                    <div class="row g-2">
                        <div class="col-6">
                            <select class="form-select form-select-sm" name="yearFrom" onchange="document.getElementById('filterForm').submit()">
                                <option value="">Từ năm</option>
                                <c:forEach var="year" begin="2010" end="2024">
                                    <option value="${year}" ${param.yearFrom eq year ? 'selected' : ''}>${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-6">
                            <select class="form-select form-select-sm" name="yearTo" onchange="document.getElementById('filterForm').submit()">
                                <option value="">Đến năm</option>
                                <c:forEach var="year" begin="2010" end="2024">
                                    <option value="${year}" ${param.yearTo eq year ? 'selected' : ''}>${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="filter-section">
                    <h5 class="fw-bold mb-3">Nhiên Liệu</h5>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" value="Xăng" id="fuel1" name="fuelType" 
                               ${param.fuelType eq 'Xăng' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label" for="fuel1">
                            Xăng
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" value="Dầu diesel" id="fuel2" name="fuelType" 
                               ${param.fuelType eq 'Dầu diesel' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label" for="fuel2">
                            Dầu diesel
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" value="Điện" id="fuel3" name="fuelType" 
                               ${param.fuelType eq 'Điện' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label" for="fuel3">
                            Điện
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="Hybrid" id="fuel4" name="fuelType" 
                               ${param.fuelType eq 'Hybrid' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label" for="fuel4">
                            Hybrid
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-orange w-100 mt-3">
                    <i class="fas fa-filter me-2"></i>Áp Dụng Bộ Lọc
                </button>
            </form>
        </div>
        
        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="text-muted">
                    <c:choose>
                        <c:when test="${not empty allCarsList}">
                            <span>Hiển thị ${allCarsList.size()} kết quả</span>
                        </c:when>
                        <c:otherwise>
                            <span>0 kết quả</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty allCarsList}">
                        <c:forEach var="xe" items="${allCarsList}">                            <div class="col-12 col-sm-6 col-md-4 col-lg-4">
                                <!-- Using the same card design as index2.jsp -->
                                <div class="card h-100 card-hover-effect border-0 shadow-sm">
                                    <div class="position-relative">
                                        <img src="${pageContext.request.contextPath}/imgs/${xe.anhDaiDien}" class="card-img-top object-cover" alt="${xe.tenSanPham}" style="height: 200px;">
                                        
                                        <!-- Wishlist Button -->
                                        <div class="position-absolute top-0 end-0 p-2">
                                            <sec:authorize access="isAuthenticated()">
                                                <button 
                                                    class="btn btn-sm btn-light rounded-circle wishlist-btn-car shadow-sm" 
                                                    data-car-id="${xe.productID}"
                                                    title="Thêm vào danh sách yêu thích"
                                                    style="width: 40px; height: 40px;"
                                                >
                                                    <i class="far fa-heart text-danger"></i>
                                                </button>
                                            </sec:authorize>
                                            <sec:authorize access="!isAuthenticated()">
                                                <a href="${pageContext.request.contextPath}/login" 
                                                   class="btn btn-sm btn-light rounded-circle shadow-sm" 
                                                   title="Đăng nhập để thêm vào yêu thích"
                                                   style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                                    <i class="far fa-heart text-danger"></i>
                                                </a>
                                            </sec:authorize>
                                        </div>
                                    </div><div class="card-body d-flex flex-column">
                                        <h5 class="card-title fw-bold mb-3">${xe.tenSanPham}</h5>

                                        <div class="d-flex justify-content-between text-muted small mb-2">
                                            <span><i class="fas fa-calendar text-success me-1"></i> <fmt:formatDate value="${xe.ngaySanXuat}" pattern="yyyy" /></span>
                                            <span><i class="fas fa-map-marker-alt text-danger me-1"></i> ${xe.diaDiemLayXe}</span>
                                        </div>

                                        <div class="d-flex justify-content-between text-muted small mb-3">
                                            <span><i class="fas fa-gas-pump text-primary me-1"></i> ${xe.nhienLieu}</span>
                                            <span><i class="fas fa-cog text-warning me-1"></i> ${xe.truyenDong}</span>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/details/${xe.productID}" class="btn btn-outline-primary w-100 mt-auto">
                                            <i class="fas fa-info-circle me-2"></i>Chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="empty-state">
                                <i class="fas fa-car-side text-muted mb-4" style="font-size: 4rem;"></i>
                                <h4 class="mb-3">Không tìm thấy xe phù hợp</h4>
                                <p class="text-muted mb-4">Vui lòng thay đổi tiêu chí tìm kiếm hoặc quay lại sau.</p>
                                <a href="${pageContext.request.contextPath}/cars" class="btn btn-orange">
                                    <i class="fas fa-search me-2"></i>Xem tất cả xe
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Pagination (if needed) -->
            <c:if test="${not empty allCarsList && allCarsList.size() > 12}">
                <nav class="mt-5">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Trước</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>

      // Debounce function to prevent too many form submissions
    function debounce(func, wait) {
        let timeout;
        return function() {
            const context = this;
            const args = arguments;
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                func.apply(context, args);
            }, wait);
        };
    }

    // Wishlist functionality for cars
    document.addEventListener('DOMContentLoaded', function() {
        // Car wishlist functionality
        document.querySelectorAll('.wishlist-btn-car').forEach(button => {
            button.addEventListener('click', function() {
                const carId = this.getAttribute('data-car-id');
                const heartIcon = this.querySelector('i');
                
                fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        carId: carId,
                        productType: 'CAR'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Toggle heart icon
                        if (data.added) {
                            heartIcon.className = 'fas fa-heart text-danger';
                            showToast('Đã thêm xe vào danh sách yêu thích!', 'success');
                        } else {
                            heartIcon.className = 'far fa-heart text-danger';
                            showToast('Đã xóa xe khỏi danh sách yêu thích!', 'info');
                        }
                        
                        // Update wishlist count in header
                        updateWishlistCount();
                    } else {
                        showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                });
            });
        });        // Toast notification function
        function showToast(message, type) {
            // Create toast element
            const toast = document.createElement('div');
            let alertClass = 'alert alert-info';
            let iconClass = 'fas fa-info-circle';
            
            if (type === 'success') {
                alertClass = 'alert alert-success';
                iconClass = 'fas fa-check-circle';
            } else if (type === 'error') {
                alertClass = 'alert alert-danger';
                iconClass = 'fas fa-exclamation-circle';
            }
            
            toast.className = alertClass + ' position-fixed';
            toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
            toast.innerHTML = 
                '<div class="d-flex align-items-center">' +
                    '<i class="' + iconClass + ' me-2"></i>' +
                    message +
                    '<button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>' +
                '</div>';
            
            document.body.appendChild(toast);
            
            // Auto remove after 3 seconds
            setTimeout(function() {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 3000);
        }

        // Update wishlist count in header
        function updateWishlistCount() {
            const wishlistCountElement = document.getElementById('wishlist-count');
            if (wishlistCountElement) {
                fetch('${pageContext.request.contextPath}/api/wishlist/count')
                    .then(response => response.json())
                    .then(data => {
                        if (data.count > 0) {
                            wishlistCountElement.textContent = data.count;
                            wishlistCountElement.style.display = 'flex';
                        } else {
                            wishlistCountElement.style.display = 'none';
                        }
                    })
                    .catch(error => console.log('Could not update wishlist count'));
            }
        }

        // Load existing wishlist items to show filled hearts
        function loadWishlistStatus() {
            fetch('${pageContext.request.contextPath}/api/wishlist/items')
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.items) {
                        data.items.forEach(item => {
                            if (item.carId) {
                                const button = document.querySelector(`[data-car-id="${item.carId}"]`);
                                if (button) {
                                    button.querySelector('i').className = 'fas fa-heart text-danger';
                                }
                            }
                        });
                    }
                })
                .catch(error => console.log('Could not load wishlist status'));
        }

        // Load wishlist status on page load
        loadWishlistStatus();
    });
</script>
</body>
</html>