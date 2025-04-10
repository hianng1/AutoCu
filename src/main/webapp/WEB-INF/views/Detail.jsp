<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phụ kiện</title>

    <!-- CSS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            color: #1e293b;
        }

        .product-details-container {
            max-width: 1000px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .product-image-column {
            padding: 20px;
        }

        .main-image {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.03);
        }

        .thumbnail-list {
            display: flex;
            margin-top: 10px;
            overflow-x: auto;
            padding-bottom: 10px;
        }

        .thumbnail-item {
            width: 80px;
            height: 80px;
            margin-right: 10px;
            border-radius: 6px;
            overflow: hidden;
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.2s ease-in-out;
        }

        .thumbnail-item:hover,
        .thumbnail-item.active {
            opacity: 1;
        }

        .thumbnail-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-info-column {
            padding: 30px;
        }

        .product-title {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 2px;
            color: #334155;
        }

        .product-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: #0ea5e9;
            margin-bottom: 20px;
        }

        .product-description {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .product-options {
            margin-bottom: 25px;
        }

        .option-label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #475569;
        }

        .select-input,
        .quantity-input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            margin-bottom: 15px;
            font-size: 1rem;
            color: #334155;
            appearance: none;
            background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
        }

        .quantity-input {
            width: 60px;
            padding: 10px;
            text-align: center;
            margin-right: 10px;
        }

        .add-to-cart-button {
            background-color: #3b82f6;
            color: white;
            padding: 14px 22px;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .add-to-cart-button:hover {
            background-color: #2563eb;
        }

        .product-details-section {
            padding: 30px;
            background-color: #f9fafb;
            border-top: 1px solid #e5e7eb;
        }

        .details-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: #334155;
        }

        .details-content {
            color: #4b5563;
            line-height: 1.7;
        }

        /* Responsive layout */
        @media (min-width: 768px) {
            .product-details-container {
                display: flex;
            }

            .product-image-column {
                width: 40%;
                padding: 30px;
            }

            .product-info-column {
                width: 60%;
                padding: 30px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="product-details-container">
    <div class="product-image-column">
        <img src="<c:url value='/imgs/${details[0].anhDaiDien}' />" class="main-image" alt="${details[0].tenSanPham}">
        <div class="thumbnail-list">
            <c:forEach var="image" items="${details}" varStatus="status">
                <div class="thumbnail-item ${status.index == 0 ? 'active' : ''}">
                    <img src="<c:url value='/imgs/${image.anhDaiDien}' />" alt="Ảnh sản phẩm">
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="product-info-column">
        <h1 class="product-title">${details[0].tenSanPham}</h1>
        <p class="product-price"><fmt:formatNumber value="${details[0].gia}" type="currency" currencySymbol="VNĐ" /></p>
        <p class="product-description">
            Mô tả sản phẩm ở đây. Thêm thông tin chi tiết về sản phẩm để thu hút người mua.
        </p>

        <div class="product-options">
            <label class="option-label" for="color">Màu sắc</label>
            <select id="color" class="select-input">
                <option>Đỏ</option>
                <option>Xanh</option>
                <option>Đen</option>
            </select>

            <label class="option-label" for="size">Kích thước</label>
            <select id="size" class="select-input">
                <option>Nhỏ</option>
                <option>Vừa</option>
                <option>Lớn</option>
            </select>
        </div>

        <div style="display: flex; align-items: center;">
            <label for="quantity" style="margin-right: 10px; font-weight: 500; color: #475569;">Số lượng:</label>
            <input type="number" id="quantity" class="quantity-input" value="1" min="1">
            <button class="add-to-cart-button">Thêm vào giỏ hàng</button>
        </div>
    </div>
</div>

<section class="product-details-section">
    <div class="details-title">Chi tiết sản phẩm</div>
    <div class="details-content">
        <p>Thông tin chi tiết về sản phẩm, bao gồm chất liệu, xuất xứ, hướng dẫn sử dụng và các thông số kỹ thuật khác.</p>
        <ul>
            <li>Quốc gia: USA</li>
            <li>Số phụ tùng: A123-3416</li>
            <li>Color: Trắng / Bạc</li>
        </ul>
        <p><strong>Brands:</strong> Audi</p>
        <p><strong>Tags:</strong> auto, wheel, stainless</p>
    </div>
</section>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>