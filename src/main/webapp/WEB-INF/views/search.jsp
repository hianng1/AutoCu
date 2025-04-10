<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8fafc;
        }
        .product-card {
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 0.5rem 0.5rem 0 0;
        }
        .product-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 1rem;
        }
        .product-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.5rem;
            line-height: 1.4;
            height: 3rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product-description {
            color: #6b7280;
            font-size: 0.875rem;
            margin-bottom: 1rem;
            line-height: 1.5;
            height: 3rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product-footer {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }
        .price {
            color: #ef4444;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .add-to-cart {
            background-color: #f97316;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .add-to-cart:hover {
            background-color: #ea580c;
        }
        .search-header {
            background-color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        }
        .search-count {
            color: #6b7280;
            font-size: 1.1rem;
        }
        .search-keyword {
            color: #f97316;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />
    
    <div class="search-header">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-gray-800 mb-2">Kết quả tìm kiếm</h1>
            <c:if test="${not empty keyword}">
                <p class="search-count">
                    Tìm thấy <span class="font-semibold">${searchResults != null ? searchResults.size() : 0}</span> sản phẩm cho từ khóa 
                    <span class="search-keyword">"${keyword}"</span>
                </p>
            </c:if>
        </div>
    </div>

    <div class="container mx-auto px-4 pb-8">
        <c:if test="${empty searchResults}">
            <div class="text-center py-12 bg-white rounded-lg shadow-sm">
                <i class="fas fa-search text-gray-400 text-5xl mb-4"></i>
                <h2 class="text-2xl font-semibold text-gray-600 mb-2">Không tìm thấy sản phẩm</h2>
                <p class="text-gray-500 mb-6">Vui lòng thử lại với từ khóa khác</p>
                <a href="/trangchu" class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors">
                    <i class="fas fa-home mr-2"></i>
                    Về trang chủ
                </a>
            </div>
        </c:if>

        <c:if test="${not empty searchResults}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                <c:forEach var="product" items="${searchResults}">
                    <div class="product-card bg-white rounded-lg overflow-hidden">
                        <img src="/imgs/${product.anhDaiDien}" alt="${product.tenPhuKien}" class="product-image">
                        <div class="product-content">
                            <h3 class="product-title">${product.tenPhuKien}</h3>
                            <p class="product-description">${product.moTa}</p>
                            <div class="product-footer">
                                <div class="price">
                                    <fmt:formatNumber value="${product.gia}" pattern="#,##0" /> đ
                                </div>
                                <a href="/cart/add/${product.accessoryID}" class="add-to-cart">
                                    <i class="fas fa-shopping-cart"></i>
                                    Thêm vào giỏ
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <jsp:include page="/common/footer.jsp" />
</body>
</html> 