<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                        <c:forEach var="xe" items="${allCarsList}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-4">
                                <!-- Using the same card design as index2.jsp -->
                                <div class="card h-100 card-hover-effect border-0 shadow-sm">
                                    <img src="${pageContext.request.contextPath}/imgs/${xe.anhDaiDien}" class="card-img-top object-cover" alt="${xe.tenSanPham}" style="height: 200px;">

                                    <div class="card-body">
                                        <h5 class="card-title fw-bold mb-3">${xe.tenSanPham}</h5>

                                        <div class="d-flex justify-content-between text-muted small mb-2">
                                            <span><i class="fas fa-calendar text-success me-1"></i> <fmt:formatDate value="${xe.ngaySanXuat}" pattern="yyyy" /></span>
                                            <span><i class="fas fa-map-marker-alt text-danger me-1"></i> ${xe.diaDiemLayXe}</span>
                                        </div>

                                        <div class="d-flex justify-content-between text-muted small mb-3">
                                            <span><i class="fas fa-gas-pump text-primary me-1"></i> ${xe.nhienLieu}</span>
                                            <span><i class="fas fa-cog text-warning me-1"></i> ${xe.truyenDong}</span>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/details/${xe.productID}" class="btn btn-outline-primary w-100">
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
</script>
</body>
</html>