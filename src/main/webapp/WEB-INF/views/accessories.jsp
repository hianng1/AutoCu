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
         .product-item .price { color: green; font-weight: bold; margin-top: 10px; } /* Added from previous example, adjust if needed */
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="/common/header.jsp" />

<div class="container mx-auto px-4 py-12">
    <div class="text-center mb-8">
        <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-4">TẤT CẢ PHỤ KIỆN Ô TÔ</h1>
        <div class="flex items-center justify-center space-x-4">
            <div class="section-divider"></div>
            <i class="fas fa-tools text-orange-500 text-2xl"></i>
            <div class="section-divider"></div>
        </div>
    </div>

    <%-- Category/Filter Section (Optional but Recommended) --%>
     <div class="mb-8">
        <h3 class="text-xl font-semibold mb-4">Lọc theo Danh mục</h3>
        <div class="d-flex flex-wrap gap-2">
            <a href="${pageContext.request.contextPath}/accessories" class="btn btn-outline-secondary btn-sm">Tất cả</a>
            <%-- Loop through accessory categories from backend --%>
            <c:forEach var="category" items="${categoriesList}">
                 <c:if test="${category.loai == 'phu_kien'}">
                     <%-- Assuming category object has an 'id' or identifier for filtering --%>
                    <a href="${pageContext.request.contextPath}/accessories?category=${category.tenDanhMuc}" class="btn btn-outline-secondary btn-sm">${category.tenDanhMuc}</a>
                 </c:if>
            </c:forEach>
            <%-- Example static categories based on your data --%>
             <%--
             <a href="#" class="btn btn-outline-secondary btn-sm">Camera hành trình</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Cảm biến áp suất lốp</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Bọc ghế da</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Thanh giá nóc</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Bơm lốp ô tô</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Gạt mưa</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Nước hoa ô tô</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Màn hình giải trí</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Tấm che nắng</a>
             <a href="#" class="btn btn-outline-secondary btn-sm">Bạt phủ xe</a>
             --%>
        </div>
    </div>

    <%-- Accessory Listings Grid --%>
    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty allAccessoriesList}">
                 <c:forEach var="phukien" items="${allAccessoriesList}">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card h-100 card-hover-effect border-0 shadow-sm">
                            <div class="position-relative">
                                 <%-- Ensure the image path is correct --%>
                                <img src="${pageContext.request.contextPath}/imgs/${phukien.anhDaiDien}" class="card-img-top object-cover" alt="${phukien.tenPhuKien}" style="height: 200px;">

                                <%-- Icon buttons (Optional, remove if not needed) --%>
                                <div class="position-absolute top-0 end-0 m-2 d-flex flex-column gap-2">
                                    <button class="btn btn-light btn-sm rounded-circle shadow-sm">
                                        <i class="fas fa-search text-primary"></i>
                                    </button>
                                    <button class="btn btn-light btn-sm rounded-circle shadow-sm">
                                        <i class="far fa-heart text-danger"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title fw-bold mb-2">${phukien.tenPhuKien}</h5>

                                <%-- Rating (Optional, remove if not needed) --%>
                                <div class="d-flex align-items-center mb-2">
                                    <div class="text-warning small">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                    <span class="text-muted small ms-2">(15 đánh giá)</span>
                                </div>

                                <p class="price-text mb-2">
                                    <%-- Format Price --%>
                                    <fmt:formatNumber value="${phukien.gia}" pattern="#,##0" /> VND
                                </p>

                                <%-- Add to Cart Form (Use the form structure you have) --%>
                                <form action="${pageContext.request.contextPath}/cart/add/${phukien.accessoryID}" method="post">
                                     <%-- Input for quantity (default 1) --%>
                                    <input type="hidden" name="quantity" value="1" />
                                     <%-- If you use Spring Security and CSRF, uncomment the line below --%>
                                    <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>

                                     <%-- Submit button --%>
                                    <button type="submit" class="btn btn-primary w-full bg-black text-yellow-400 py-2 rounded-full font-semibold mt-3 hover:bg-gray-800">
                                        Thêm vào giỏ
                                    </button>
                                </form>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                 <div class="col-12">
                     <p class="text-center text-gray-600">Không tìm thấy phụ kiện ô tô nào.</p>
                 </div>
            </c:otherwise>
        </c:choose>
    </div>

     <%-- Pagination (Add if needed) --%>
   

</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>