<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.PhuKienOto" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Giỏ Hàng - AutoCu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8fafc;
        }
        .cart-item {
            transition: all 0.3s ease;
        }
        .cart-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .quantity-btn {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e5e7eb;
            background-color: white;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .quantity-btn:hover {
            background-color: #f3f4f6;
        }
        .quantity-input {
            width: 50px;
            text-align: center;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            padding: 0.25rem;
        }
        .remove-btn {
            color: #ef4444;
            transition: all 0.2s ease;
        }
        .remove-btn:hover {
            color: #dc2626;
        }
        .empty-cart {
            text-align: center;
            padding: 4rem 0;
        }
        .empty-cart i {
            font-size: 4rem;
            color: #9ca3af;
            margin-bottom: 1rem;
        }
        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 0.5rem;
        }
        .price {
            color: #ef4444;
            font-weight: 600;
        }
        .total-section {
            background-color: white;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />
    
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">Giỏ Hàng</h1>
        
        <c:if test="${empty CART_ITEMS}">
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <h2 class="text-2xl font-semibold text-gray-600 mb-4">Giỏ hàng trống</h2>
                <p class="text-gray-500 mb-6">Bạn chưa có sản phẩm nào trong giỏ hàng</p>
                <a href="/trangchu" class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors">
                    <i class="fas fa-shopping-bag mr-2"></i>
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:if>

        <c:if test="${not empty CART_ITEMS}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Danh sách sản phẩm -->
                <div class="lg:col-span-2 space-y-4">
                    <c:forEach var="item" items="${CART_ITEMS}">
                        <div class="cart-item bg-white rounded-lg p-4 flex items-center gap-4">
                            <img src="/imgs/${item.phuKienOto.anhDaiDien}" alt="${item.phuKienOto.tenPhuKien}" class="product-image">
                            
                            <div class="flex-1">
                                <h3 class="font-semibold text-lg text-gray-800">${item.phuKienOto.tenPhuKien}</h3>
                                <p class="text-gray-600 text-sm mb-2">${item.phuKienOto.moTa}</p>
                                <div class="price text-lg">
                                    <fmt:formatNumber value="${item.phuKienOto.gia}" pattern="#,##0" /> đ
                                </div>
                            </div>

                            <div class="flex items-center gap-6">
                                <div class="quantity-control">
                                    <form action="/cart/update" method="post" class="flex items-center">
                                        <input type="hidden" name="id" value="${item.phuKienOto.accessoryID}"/>
                                        <button type="button" class="quantity-btn" onclick="updateQuantity(this, -1)">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <input type="number" name="soLuong" value="${item.soLuong}" 
                                               class="quantity-input" min="1" onchange="this.form.submit()">
                                        <button type="button" class="quantity-btn" onclick="updateQuantity(this, 1)">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </form>
                                </div>

                                <div class="text-right">
                                    <div class="font-semibold text-lg">
                                        <fmt:formatNumber value="${item.gia * item.soLuong}" pattern="#,##0" /> đ
                                    </div>
                                    <a href="/cart/del/${item.phuKienOto.accessoryID}" 
                                       class="remove-btn text-sm inline-flex items-center mt-1">
                                        <i class="fas fa-trash-alt mr-1"></i>
                                        Xóa
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Tổng tiền và nút thanh toán -->
                <div class="total-section">
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Tổng Đơn Hàng</h2>
                    <div class="space-y-2 mb-4">
                        <div class="flex justify-between text-gray-600">
                            <span>Tạm tính</span>
                            <span><fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ</span>
                        </div>
                        <div class="flex justify-between text-gray-600">
                            <span>Phí vận chuyển</span>
                            <span>Miễn phí</span>
                        </div>
                        <div class="border-t pt-2 mt-2">
                            <div class="flex justify-between font-semibold text-lg">
                                <span>Tổng cộng</span>
                                <span class="price"><fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="space-y-3">
                        <a href="/checkout" class="block w-full text-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors">
                            Tiến hành thanh toán
                        </a>
                        <a href="/trangchu" class="block w-full text-center px-6 py-3 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors">
                            Tiếp tục mua sắm
                        </a>
                        <a href="/cart/clear" class="block w-full text-center px-6 py-3 text-red-600 font-semibold hover:text-red-700 transition-colors">
                            Xóa giỏ hàng
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script>
        function updateQuantity(button, change) {
            const form = button.closest('form');
            const input = form.querySelector('input[name="soLuong"]');
            const newValue = parseInt(input.value) + change;
            if (newValue >= 1) {
                input.value = newValue;
                form.submit();
            }
        }
    </script>
</body>
</html>
