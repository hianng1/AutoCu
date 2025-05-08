<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Roboto', sans-serif; }
        .card-hover-effect {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-hover-effect:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .price-text {
            color: #dc3545;
            font-weight: 600;
            font-size: 1.1rem;
        }
         .section-divider {
            width: 15%;
            height: 1px;
            background-color: #e5e7eb;
        }
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="/common/header.jsp" />

<div class="container mx-auto px-4 py-12">
    <div class="text-center mb-8">
        <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-4">TẤT CẢ XE Ô TÔ CŨ</h1>
         <div class="flex items-center justify-center space-x-4">
            <div class="section-divider"></div>
            <i class="fas fa-car text-orange-500 text-2xl"></i>
            <div class="section-divider"></div>
        </div>
    </div>

    <%-- Category/Filter Section (Optional but Recommended) --%>
    <div class="mb-8">
        <h3 class="text-xl font-semibold mb-4">Lọc theo Danh mục</h3>
        <div class="d-flex flex-wrap gap-2">
            <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline-secondary btn-sm">Tất cả</a>
            <%-- Loop through car categories from backend --%>
            <c:forEach var="category" items="${categoriesList}">
                 <c:if test="${category.loai == 'xe'}">
                    <a href="${pageContext.request.contextPath}/cars?category=${category.tenDanhMuc}" class="btn btn-outline-secondary btn-sm">${category.tenDanhMuc}</a>
                 </c:if>
            </c:forEach>
             <%-- Example static categories based on your data --%>
             <%--
             <a href="#" class="btn btn-outline-secondary btn-sm">Sedan</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">SUV</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Bán tải</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Xe điện</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Hatchback</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Coupe</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">MPV</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Xe sang</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Xe thể thao</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Xe cổ điển</a>
             --%>
        </div>
    </div>

    <%-- Car Listings Grid --%>
    <div class="row g-4">
        <c:choose>
             <c:when test="${not empty allCarsList}">
                 <c:forEach var="xe" items="${allCarsList}">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card h-100 card-hover-effect border-0 shadow-sm">
                            <%-- Ensure the image path is correct --%>
                            <img src="${pageContext.request.contextPath}/imgs/${xe.anhDaiDien}" class="card-img-top object-cover" alt="${xe.tenSanPham}" style="height: 200px;">

                            <div class="card-body">
                                <h5 class="card-title fw-bold mb-3">${xe.tenSanPham}</h5>

                                <div class="d-flex justify-content-between text-muted small mb-2">
                                    <%-- Format Date --%>
                                    <span><i class="fas fa-calendar text-success me-1"></i> <fmt:formatDate value="${xe.ngaySanXuat}" pattern="yyyy" /></span>
                                    <span><i class="fas fa-map-marker-alt text-danger me-1"></i> ${xe.diaDiemLayXe}</span>
                                </div>

                                <div class="d-flex justify-content-between text-muted small mb-3">
                                    <span><i class="fas fa-gas-pump text-primary me-1"></i> ${xe.nhienLieu}</span>
                                    <span><i class="fas fa-cog text-warning me-1"></i> ${xe.truyenDong}</span>
                                </div>

                                <p class="price-text mb-4">
                                    <%-- Format Price --%>
                                    <fmt:formatNumber value="${xe.gia}" pattern="#,##0" /> VND
                                </p>

                                <%-- Link to Car Details Page --%>
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
                     <p class="text-center text-gray-600">Không tìm thấy xe ô tô cũ nào.</p>
                 </div>
             </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>