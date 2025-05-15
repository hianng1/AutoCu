<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Phụ Kiện Ô Tô Chính Hãng</title>
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
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('/imgs/accessories-bg.jpg');
            background-size: cover;
            background-position: center;
            padding: 80px 0;
            color: white;
            margin-bottom: 30px;
        }
        .card-product {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
            border: none;
        }
        .card-product:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.1);
        }
        .product-img-wrapper {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        .product-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        .product-img-wrapper:hover img {
            transform: scale(1.05);
        }
        .discount-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #e63946;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
        }
        .product-actions {
            position: absolute;
            top: 15px;
            right: 15px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .product-action-btn {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            opacity: 0;
            transform: translateX(20px);
            transition: all 0.3s ease;
        }
        .card-product:hover .product-action-btn {
            opacity: 1;
            transform: translateX(0);
        }
        .filter-category {
            padding: 10px 20px;
            margin: 5px;
            border-radius: 8px;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            border: 1px solid #dee2e6;
            display: inline-block;
            text-decoration: none;
            color: #495057;
            transition: all 0.2s;
            font-size: 0.9rem;
        }
        .filter-category:hover, .filter-category.active {
            background: #fd7e14;
            color: white;
            border-color: #fd7e14;
        }
        .product-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #e63946;
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
        .filter-sidebar {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .btn-add-cart {
            background: #fd7e14;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 15px;
            transition: all 0.2s;
        }
        .btn-add-cart:hover {
            background: #e96b02;
        }
        .empty-state {
            padding: 50px 20px;
            text-align: center;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .breadcrumb {
            background: transparent;
            padding: 0;
        }
        .breadcrumb-item a {
            color: #6c757d;
            text-decoration: none;
        }
        .breadcrumb-item.active {
            color: #fd7e14;
        }
        .product-brand {
            font-size: 0.85rem;
            color: #6c757d;
            display: block;
            margin-bottom: 8px;
        }
        .stock-indicator {
            font-size: 0.85rem;
            margin-top: 8px;
        }
        .in-stock {
            color: #198754;
        }
        .out-of-stock {
            color: #dc3545;
        }
        .star-rating {
            color: #ffc107;
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
                <h1 class="display-4 fw-bold mb-4">Phụ Kiện Ô Tô Chính Hãng</h1>
                <p class="lead mb-4">Nâng cấp và cá nhân hóa chiếc xe của bạn với các phụ kiện chất lượng cao</p>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mt-3 mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a></li>
            <li class="breadcrumb-item active">Phụ kiện ô tô</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Sidebar Filters -->
        <div class="col-lg-3 mb-4">
            <form action="${pageContext.request.contextPath}/accessories" method="get" id="filterForm">
                <!-- Keep existing category if selected -->
                <c:if test="${not empty param.category}">
                    <input type="hidden" name="category" value="${param.category}">
                </c:if>
                
                <div class="filter-sidebar">
                    <h5 class="section-title fw-bold">Danh Mục Phụ Kiện</h5>
                    <div class="d-flex flex-column mt-4">
                        <a href="${pageContext.request.contextPath}/accessories" class="filter-category mb-2 ${empty param.category ? 'active' : ''}">
                            <i class="fas fa-list me-2"></i>Tất cả
                        </a>
                        <c:forEach var="category" items="${categoriesList}">
                            <c:if test="${category.loai == 'phu_kien'}">
                                <a href="${pageContext.request.contextPath}/accessories?category=${category.tenDanhMuc}" 
                                class="filter-category mb-2 ${param.category eq category.tenDanhMuc ? 'active' : ''}">
                                    <i class="fas fa-tag me-2"></i>${category.tenDanhMuc}
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="filter-sidebar">
                    <h5 class="fw-bold mb-3">Giá</h5>
                    <div class="range-slider">
                        <input type="range" class="form-range" min="0" max="5000000" step="100000" id="price-range" name="priceMax" 
                               value="${empty param.priceMax ? '2500000' : param.priceMax}">
                        <div class="d-flex justify-content-between mt-2">
                            <span>0đ</span>
                            <span id="price-value">
                                <c:choose>
                                    <c:when test="${not empty param.priceMax}">
                                        <fmt:formatNumber value="${param.priceMax}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                    </c:when>
                                    <c:otherwise>2,500,000đ</c:otherwise>
                                </c:choose>
                            </span>
                            <span>5,000,000đ</span>
                        </div>
                    </div>
                </div>
                
                <div class="filter-sidebar">
                    <h5 class="fw-bold mb-3">Đánh Giá</h5>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" value="5" id="rating5" name="rating"
                               ${param.rating eq '5' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label star-rating" for="rating5">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <span class="text-muted ms-2">(5)</span>
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" value="4" id="rating4" name="rating"
                               ${param.rating eq '4' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label star-rating" for="rating4">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                            <span class="text-muted ms-2">(4+)</span>
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" value="3" id="rating3" name="rating"
                               ${param.rating eq '3' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label star-rating" for="rating3">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <span class="text-muted ms-2">(3+)</span>
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-add-cart w-100 mt-3">
                    <i class="fas fa-filter me-2"></i>Lọc Kết Quả
                </button>
            </form>
        </div>
        
        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="text-muted">
                    <c:choose>
                        <c:when test="${not empty allAccessoriesList}">
                            <span>Hiển thị ${allAccessoriesList.size()} kết quả</span>
                        </c:when>
                        <c:otherwise>
                            <span>0 kết quả</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="dropdown">
                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-sort me-1"></i>Sắp xếp theo
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.brand ? 'brand='.concat(param.brand).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=price-desc"><i class="fas fa-sort-amount-up me-2"></i>Giá cao đến thấp</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.brand ? 'brand='.concat(param.brand).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=price-asc"><i class="fas fa-sort-amount-down me-2"></i>Giá thấp đến cao</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.brand ? 'brand='.concat(param.brand).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=rating-desc"><i class="fas fa-star me-2"></i>Đánh giá cao nhất</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.brand ? 'brand='.concat(param.brand).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=popular"><i class="fas fa-fire-alt me-2"></i>Bán chạy nhất</a></li>
                    </ul>
                </div>
            </div>

            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty allAccessoriesList}">
                        <c:forEach var="phukien" items="${allAccessoriesList}">
                            <div class="col-md-6 col-lg-4">
                                <div class="card card-product shadow-sm">
                                    <div class="product-img-wrapper">
                                        <img src="${pageContext.request.contextPath}/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}">
                                        <!-- <div class="discount-badge">-15%</div> -->
                                        <div class="product-actions">
                                            <button class="product-action-btn">
                                                <i class="far fa-heart text-danger"></i>
                                            </button>
                                            <button class="product-action-btn">
                                                <i class="fas fa-search text-primary"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="card-body p-4">
                                        <span class="product-brand">${phukien.hangSanXuat}</span>
                                        <h5 class="card-title fw-bold mb-2">${phukien.tenPhuKien}</h5>
                                        
                                        <div class="star-rating mb-2">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                            <span class="text-muted ms-1">(4.0)</span>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="product-price">
                                                <fmt:formatNumber value="${phukien.gia}" pattern="#,##0" /> đ
                                            </span>
                                            <c:choose>
                                                <c:when test="${phukien.soLuong > 0}">
                                                    <span class="stock-indicator in-stock">
                                                        <i class="fas fa-check-circle me-1"></i>Còn hàng
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="stock-indicator out-of-stock">
                                                        <i class="fas fa-times-circle me-1"></i>Hết hàng
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <form action="${pageContext.request.contextPath}/cart/add/${phukien.accessoryID}" method="post" class="mt-3">
                                            <input type="hidden" name="quantity" value="1" />
                                            <button type="submit" class="btn btn-add-cart w-100">
                                                <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="empty-state">
                                <i class="fas fa-tools text-muted mb-4" style="font-size: 4rem;"></i>
                                <h4 class="mb-3">Không tìm thấy phụ kiện phù hợp</h4>
                                <p class="text-muted mb-4">Vui lòng thay đổi tiêu chí tìm kiếm hoặc quay lại sau.</p>
                                <a href="${pageContext.request.contextPath}/accessories" class="btn btn-add-cart">
                                    <i class="fas fa-search me-2"></i>Xem tất cả phụ kiện
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Pagination (if needed) -->
            <c:if test="${not empty allAccessoriesList && allAccessoriesList.size() > 12}">
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
    // Price range slider
    const priceRange = document.getElementById('price-range');
    const priceValue = document.getElementById('price-value');
    
    priceRange.addEventListener('input', function() {
        priceValue.textContent = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
            minimumFractionDigits: 0
        }).format(this.value);
    });
    
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
    
    // Submit form when the range input changes, but debounced
    priceRange.addEventListener('change', debounce(function() {
        document.getElementById('filterForm').submit();
    }, 500));
</script>
</body>
</html>