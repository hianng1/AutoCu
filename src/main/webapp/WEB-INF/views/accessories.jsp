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
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('${pageContext.request.contextPath}/imgs/mau-sieu-xe-cai-lam-hinh-nen.jpg');
            background-size: cover;
            background-position: center 30%; /* Adjusted position to show more of the car */
            padding: 80px 0;
            color: white;
            margin-bottom: 30px;
        }        .card-product {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
            border: none;
            display: flex;
            flex-direction: column;
        }
        .card-product:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.1);
        }
        .card-product .card-body {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .card-product form.mt-3 {
            margin-top: auto !important;
        }        .product-img-wrapper {
            height: 220px;
            overflow: hidden;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }
        .product-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 10px;
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
        }        .product-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #e63946;
        }
        .card-title {
            height: 48px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            line-clamp: 2;
        }
        .product-brand {
            display: block;
            margin-bottom: 5px;
            color: #6c757d;
            font-size: 0.9rem;
        }
        .section-title {
            position: relative;
            margin-bottom: 30px;
        }        .section-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 3px;
            background-color: #fd7e14;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .hero-section {
                padding: 40px 0;
                background-position: center;
            }
            
            .hero-section h1 {
                font-size: 1.8rem;
            }
            
            .hero-section p {
                font-size: 0.95rem;
            }
            
            .filter-category {
                padding: 8px 12px;
                margin: 3px;
                font-size: 0.85rem;
            }
            
            .card-product {
                margin-bottom: 20px;
            }
            
            .product-img-wrapper {
                height: 180px;
            }
            
            .card-title {
                font-size: 1rem;
                height: auto;
                line-height: 1.3;
            }
            
            .product-price {
                font-size: 1.1rem;
            }
            
            .btn-add-cart {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
            
            .product-actions {
                gap: 5px;
            }
            
            .product-action-btn {
                width: 35px;
                height: 35px;
            }
            
            .star-rating {
                font-size: 0.9rem;
            }
            
            .stock-indicator {
                font-size: 0.8rem;
            }
            
            .filter-sidebar .card {
                margin-bottom: 15px;
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
            
            .filter-category {
                display: block;
                width: 100%;
                text-align: center;
                margin: 5px 0;
            }
            
            .product-img-wrapper {
                height: 160px;
            }
            
            .card-title {
                font-size: 0.95rem;
            }
            
            .product-price {
                font-size: 1rem;
            }
            
            .btn-add-cart {
                padding: 6px 12px;
                font-size: 0.85rem;
            }
            
            .product-action-btn {
                width: 30px;
                height: 30px;
            }
            
            .product-action-btn i {
                font-size: 0.8rem;
            }
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
        .star-rating .far.fa-star, .star-rating i.fas.fa-star.text-muted {
            color: #e2e2e2;
        }
        .star-rating .fas.fa-star.filled {
            color: #ffc107;
        }
        .dropdown-item.active {
            background-color: #fd7e14;
            color: white;
        }
        .dropdown-item:hover {
            background-color: #f8f9fa;
            color: #fd7e14;
        }
        .dropdown-item.active:hover {
            background-color: #e96b02;
            color: white;
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
                        <input class="form-check-input" type="radio" value="5" id="rating5" name="rating"
                               ${param.rating eq '5' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label d-flex align-items-center" for="rating5">
                            <div class="star-rating">
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                            </div>
                            <span class="text-muted ms-2">(5 sao)</span>
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" value="4" id="rating4" name="rating"
                               ${param.rating eq '4' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label d-flex align-items-center" for="rating4">
                            <div class="star-rating">
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <span class="text-muted ms-2">(4 sao trở lên)</span>
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" value="3" id="rating3" name="rating"
                               ${param.rating eq '3' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label d-flex align-items-center" for="rating3">
                            <div class="star-rating">
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="fas fa-star filled"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <span class="text-muted ms-2">(3 sao trở lên)</span>
                        </label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" value="0" id="ratingAll" name="rating"
                               ${empty param.rating ? 'checked' : param.rating eq '0' ? 'checked' : ''} onchange="document.getElementById('filterForm').submit()">
                        <label class="form-check-label" for="ratingAll">
                            <span>Tất cả đánh giá</span>
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
                </div>                <div class="dropdown">
                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-sort me-1"></i>
                        <c:choose>
                            <c:when test="${param.sort eq 'price-desc'}">Giá cao đến thấp</c:when>
                            <c:when test="${param.sort eq 'price-asc'}">Giá thấp đến cao</c:when>
                            <c:when test="${param.sort eq 'rating-desc'}">Đánh giá cao nhất</c:when>
                            <c:when test="${param.sort eq 'popular'}">Bán chạy nhất</c:when>
                            <c:otherwise>Sắp xếp theo</c:otherwise>
                        </c:choose>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton1">
                        <li>
                            <a class="dropdown-item ${param.sort eq 'price-desc' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=price-desc">
                                <i class="fas fa-sort-amount-up me-2"></i>Giá cao đến thấp
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item ${param.sort eq 'price-asc' ? 'active' : ''}"
                               href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=price-asc">
                                <i class="fas fa-sort-amount-down me-2"></i>Giá thấp đến cao
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item ${param.sort eq 'rating-desc' ? 'active' : ''}"
                               href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=rating-desc">
                                <i class="fas fa-star me-2"></i>Đánh giá cao nhất
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item ${param.sort eq 'popular' ? 'active' : ''}"
                               href="${pageContext.request.contextPath}/accessories?${not empty param.category ? 'category='.concat(param.category).concat('&') : ''}${not empty param.priceMax ? 'priceMax='.concat(param.priceMax).concat('&') : ''}${not empty param.rating ? 'rating='.concat(param.rating).concat('&') : ''}sort=popular">
                                <i class="fas fa-fire-alt me-2"></i>Bán chạy nhất
                            </a>
                        </li>
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
                                        <!-- <div class="discount-badge">-15%</div> -->                                        <div class="product-actions">
                                            <sec:authorize access="isAuthenticated()">
                                                <button 
                                                    class="product-action-btn wishlist-btn" 
                                                    data-accessory-id="${phukien.accessoryID}"
                                                    title="Thêm vào danh sách yêu thích"
                                                >                                                    <i class="far fa-heart text-danger"></i>
                                                </button>
                                            </sec:authorize>
                                            <a href="${pageContext.request.contextPath}/accessories/${phukien.accessoryID}" 
                                               class="product-action-btn"
                                               title="Xem chi tiết">
                                                <i class="fas fa-search text-primary"></i>
                                            </a>
                                        </div>
                                    </div>                                    <div class="card-body p-4">                                        <span class="product-brand">${phukien.hangSanXuat}</span>
                                        <h5 class="card-title fw-bold mb-2">${phukien.tenPhuKien}</h5>
                                          <div class="star-rating mb-2">
                                            <c:choose>
                                                <c:when test="${phukien.soLuongDanhGia > 0}">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= phukien.trungBinhSao}">
                                                                <i class="fas fa-star filled"></i>
                                                            </c:when>
                                                            <c:when test="${i - phukien.trungBinhSao <= 0.5 && i - phukien.trungBinhSao > 0}">
                                                                <i class="fas fa-star-half-alt filled"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="far fa-star"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <span class="text-muted ms-1">(${phukien.soLuongDanhGia})</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <span class="text-muted ms-1">(0)</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3">
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
    document.addEventListener('DOMContentLoaded', function() {
        // Price range slider
        const priceRange = document.getElementById('price-range');
        const priceValue = document.getElementById('price-value');
        
        if (priceRange && priceValue) {
            priceRange.addEventListener('input', function() {
                // Format the price with commas as thousands separators
                const formattedPrice = new Intl.NumberFormat('vi-VN').format(this.value);
                priceValue.textContent = formattedPrice + ' đ';
            });
            
            // Delay form submission on range input to improve UX
            priceRange.addEventListener('change', function() {
                document.getElementById('filterForm').submit();
            });
        }        
        // Initialize tooltips if needed
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });

        // Wishlist functionality
        document.querySelectorAll('.wishlist-btn').forEach(button => {
            button.addEventListener('click', function() {
                const accessoryId = this.getAttribute('data-accessory-id');
                const heartIcon = this.querySelector('i');
                
                fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        accessoryId: accessoryId,
                        productType: 'ACCESSORY'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Toggle heart icon
                        if (data.added) {
                            heartIcon.className = 'fas fa-heart text-danger';
                            showToast('Đã thêm vào danh sách yêu thích!', 'success');
                        } else {
                            heartIcon.className = 'far fa-heart text-danger';
                            showToast('Đã xóa khỏi danh sách yêu thích!', 'info');
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
                            if (item.accessoryId) {
                                const button = document.querySelector(`[data-accessory-id="${item.accessoryId}"]`);
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