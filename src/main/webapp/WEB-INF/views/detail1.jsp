<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${phukien.tenPhuKien} - AutoCu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
     <!-- CSS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        .price-text {
            color: #dc3545;
            font-weight: 600;
            font-size: 2.2rem; /* Increased font size */
        }

        .product-details-container {
            background-color: #f8f9fa; /* Light gray background */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Optional shadow */
        }

        .product-image {
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .quantity-button {
            background-color: #e9ecef;
            border: none;
            color: #495057;
            padding: 8px 12px; /* Lớn hơn một chút */
            cursor: pointer;
            border-radius: 5px;
            font-size: 1.1rem; /* Tăng kích thước chữ */
        }

        .quantity-input {
            width: 60px; /* Rộng hơn một chút */
            text-align: center;
            border: 1px solid #ced4da;
            border-radius: 5px;
            margin: 0 5px;
            font-size: 1.1rem; /* Tăng kích thước chữ */
        }

        .add-to-cart-button {
            background-color: #ffc107; /* Yellow color */
            border: none;
            color: #212529;
            padding: 12px 24px; /* Lớn hơn một chút */
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
            font-size: 1.3rem; /* Tăng kích thước chữ */
        }

        .add-to-cart-button:hover {
            background-color: #ffca2c;
        }

        .product-tags {
            margin-top: 15px;
        }

        .product-tags span {
            display: inline-block;
            background-color: #6c757d;
            color: white;
            padding: 6px 12px; /* Lớn hơn một chút */
            border-radius: 5px;
            margin-right: 5px;
            margin-bottom: 5px;
            font-size: 1.1rem; /* Tăng kích thước chữ */
        }

        /* CSS Grid cho thumbnails */
        .thumbnail-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* Chia thành 3 cột bằng nhau */
            gap: 5px; /* Giảm khoảng cách giữa các ảnh */
            margin-top: 10px; /* Khoảng cách với ảnh lớn */
        }

        .thumbnail-image {
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            width: 100%; /* Đảm bảo ảnh lấp đầy ô grid */
            height: auto; /* Duy trì tỷ lệ khung hình */
            object-fit: cover; /* Đảm bảo ảnh không bị méo */
        }
        h2 {
            font-size: 2.5rem; /* Increased font size */
            margin-bottom: 0.75rem;
        }

        p {
            font-size: 1.2rem; /* Increased font size */
        }

        .text-muted {
            font-size: 1.1rem; /* Increased font size */
        }
    </style>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="container mt-5">
    <div class="product-details-container">
        <div class="row">
            <div class="col-md-6">
                <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid product-image">
                
                <!-- Thumbnail Images -->
                <div class="thumbnail-grid">
                    <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid thumbnail-image">
                    <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid thumbnail-image">
                    <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid thumbnail-image">
                </div>

                <!-- Thumbnail Images (Flexbox - uncomment để sử dụng) -->
                <!--<div class="thumbnail-flexbox">
                    <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid thumbnail-image">
                    <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid thumbnail-image">
                    <img src="/imgs/${phukien.anhDaiDien}" alt="${phukien.tenPhuKien}" class="img-fluid thumbnail-image">
                </div>-->
            </div>
            <div class="col-md-6">
                <h2>${phukien.tenPhuKien}</h2>
                <p class="text-muted">Hãng sản xuất: ${phukien.hangSanXuat}</p>
                <div class="mb-3">
                    <span class="price-text"><fmt:formatNumber value="${phukien.gia}" pattern="#,##0" /> VND</span>
                </div>
                <p>${phukien.moTa}</p>

                <!-- Quantity Selector -->
                <div class="quantity-selector">
                    <span>Số lượng:</span>
                    <button class="quantity-button">-</button>
                    <input type="text" class="quantity-input" value="1">
                    <button class="quantity-button">+</button>
                </div>

                <!-- Add to Cart Button -->
                <form action="/addToCart" method="post">
                    <input type="hidden" name="productId" value="${phukien.accessoryID}" />
                    <input type="hidden" name="quantity" value="1" />
                    <button type="submit" class="add-to-cart-button"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                </form>
                
                 <!-- Product Tags -->
                <div class="product-tags">
                    <span>auto</span>
                    <span>wheel</span>
                    <span>stainless</span>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>