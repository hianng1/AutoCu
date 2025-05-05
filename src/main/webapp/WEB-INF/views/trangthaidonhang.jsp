<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trạng Thái Đơn Hàng - AutoCu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse; /* Loại bỏ khoảng cách giữa các ô */
        }
        th, td {
            border-bottom: 1px solid #ddd;
            padding: 8px;
        }
        th:nth-child(1), td:nth-child(1) { /* Cột Mã Chi Tiết */
            text-align: left;
            width: 10%;
        }
        th:nth-child(2), td:nth-child(2) { /* Cột Tên Sản Phẩm */
            text-align: left;
        }
        th:nth-child(3), td:nth-child(3) { /* Cột Số Lượng */
            text-align: center;
            width: 15%;
        }
        th:nth-child(4), td:nth-child(4) { /* Cột Đơn Giá */
            text-align: right;
            width: 20%;
        }
        th:nth-child(5), td:nth-child(5) { /* Cột Thành Tiền */
            text-align: right;
            width: 20%;
        }
    </style>
</head>
<body class="bg-gray-100">

    <div class="bg-gray-100 py-2 text-sm">
        <div class="container mx-auto flex justify-between items-center">
            <div class="flex items-center space-x-4">
                <select name="" id="">
                    <option>
                        VN
                        <i class="fas fa-chevron-down"> </i>
                    </option>
                    <option>EN</option>
                </select>
                <div>
                    Gọi ngay cho chúng tôi:
                    <a class="text-gray-600" href="tel:+84382948198"> +84 382 948 198 </a>
                </div>
                <div>
                    Gửi mail cho chúng tôi:
                    <a class="text-gray-600" href="mailto:autocu@gmail.com">
                        autocu@gmail.com
                    </a>
                </div>
            </div>
            <div class="flex items-center space-x-4">
                <div>
                    <i class="fas fa-truck text-green-600"> </i>
                    <a href="#">Order Tracking</a>
                </div>
                <div>
                    <i class="fas fa-heart text-red-600"> </i>
                    <a href="#">Wishlist</a>
                </div>
            </div>
        </div>
    </div>

    <header class="bg-white py-4 shadow-sm">
        <div class="container mx-auto flex justify-between items-center">
            <div class="flex items-center space-x-3">
                <a href="${pageContext.request.contextPath}/trangchu">
                    <img src="${pageContext.request.contextPath}/imgs/logo2.png" alt="logo" class="h-16 max-w-[300px] object-contain"/>
                </a>
            </div>
            <div class="relative flex items-center w-full max-w-2xl mx-auto">
                <form action="${pageContext.request.contextPath}/search" method="get" class="flex w-full">
                    <input
                        name="keyword"
                        class="border border-gray-300 rounded-l px-4 py-2 w-full"
                        placeholder="Tìm kiếm sản phẩm..."
                        type="text"
                        value="${param.keyword}"
                    />
                    <button
                        type="submit"
                        class="bg-orange-500 text-white px-6 py-2 rounded-r hover:bg-orange-600 transition-colors"
                    >
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
            <div class="flex items-center space-x-4">
                <div class="text-center">
                    <div class="flex items-center justify-center space-x-2">
                        <a href="${pageContext.request.contextPath}/cart/views" class="relative flex items-center">
                            <h2 class="text-lg font-semibold hover:text-orange-500 mr-2">
                                Giỏ Hàng
                            </h2>
                            <div class="relative">
                                <i class="fas fa-shopping-basket text-orange-400 text-lg"></i>
                                <c:if test="${not empty CART_ITEMS}">
                                    <span
                                        class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
                                    >
                                        ${CART_ITEMS.size()}
                                    </span>
                                </c:if>
                            </div>
                        </a>
                    </div>
                    </div>
            </div>
        </div>
    </header>

    <nav class="bg-orange-500 text-white">
        <div class="container mx-auto flex justify-between items-center whitespace-nowrap">

            <div class="flex items-center flex-nowrap">
                <a href="${pageContext.request.contextPath}/trangchu" class="px-4 py-3 hover:bg-orange-600 inline-block"><i class="fas fa-home"></i> Trang Chủ</a>
                <a href="/usedcars" class="px-4 py-3 hover:bg-orange-600 inline-block">Xe oto cũ</a>
                <a href="/accessories" class="px-4 py-3 hover:bg-orange-600 inline-block">Phụ kiện xe</a>
                <a href="/rente-cars" class="px-4 py-3 hover:bg-orange-600 inline-block">Thuê xe</a>
                <a href="cars-news" class="px-4 py-3 hover:bg-orange-600 inline-block">Tin xe hơi</a>
                <a href="/support" class="px-4 py-3 hover:bg-orange-600 inline-block">Hỗ trợ</a>
                <a href="/contact" class="px-4 py-3 hover:bg-orange-600 inline-block">Liên hệ</a>
            </div>

            <div class="flex items-center flex-shrink-0 ml-4">
                <%-- Kiểm tra nếu người dùng ĐÃ xác thực --%>
                <sec:authorize access="isAuthenticated()">
                    <%-- Lấy username từ Principal của Spring Security --%>
                    <a href="${pageContext.request.contextPath}/profile" class="px-4 py-3 font-medium hover:bg-orange-700">
                        <i class="fas fa-user"></i> <sec:authentication property="principal.username"/>
                    </a>
                    <%-- Link đăng xuất (Spring Security sẽ xử lý) --%>
                    <a href="${pageContext.request.contextPath}/logout" class="px-4 py-3 hover:bg-orange-700 ml-2">
                        <i class="fas fa-sign-out-alt"></i> Đăng Xuất
                    </a>
                </sec:authorize>

                <%-- Kiểm tra nếu người dùng CHƯA xác thực --%>
                <sec:authorize access="!isAuthenticated()">
                    <%-- Link đăng nhập --%>
                    <a href="${pageContext.request.contextPath}/login" class="px-4 py-3 hover:bg-orange-700">Đăng Nhập</a>
                </sec:authorize>
            </div>

        </div>
    </nav>

    <div class="container mx-auto mt-8">
        <h1 class="text-2xl font-semibold mb-4">Thông Tin Chi Tiết Đơn Hàng</h1>

        <div class="bg-white shadow-md rounded-md p-6">
            <c:if test="${not empty danhSachChiTiet}">
                <h2 class="text-xl font-semibold mt-6 mb-2">Đơn Hàng Mã: ${param.orderid}</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full bg-white border border-gray-300 shadow-md rounded-md">
                        <thead class="bg-gray-100">
                            <tr>
                                <th class="py-2 px-4 border-b text-left" style="width: 10%;">Mã Chi Tiết</th>
                                <th class="py-2 px-4 border-b text-left">Tên Sản Phẩm</th>
                                <th class="py-2 px-4 border-b text-center" style="width: 15%;">Số Lượng</th>
                                <th class="py-2 px-4 border-b text-right" style="width: 20%;">Đơn Giá</th>
                                <th class="py-2 px-4 border-b text-right" style="width: 20%;">Thành Tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${danhSachChiTiet}">
                                <tr>
                                    <td class="py-2 px-4 border-b text-left">${item.orderItemID}</td>
                                    <td class="py-2 px-4 border-b text-left">${item.tenSanPham}</td>
                                    <td class="py-2 px-4 border-b text-center">${item.soLuong}</td>
                                    <td class="py-2 px-4 border-b text-right"><fmt:formatNumber value="${item.donGia}" pattern="#,##0.00"/></td>
                                    <td class="py-2 px-4 border-b text-right"><fmt:formatNumber value="${item.thanhTien}" pattern="#,##0.00"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <p class="text-red-500 mt-4">${errorMessage}</p>
            </c:if>

            <c:if test="${empty danhSachChiTiet and empty errorMessage}">
                <p class="text-gray-500 mt-4">Không có thông tin đơn hàng cho mã: ${param.orderid}.</p>
            </c:if>
        </div>
    </div>

    <footer class="bg-gray-200 py-6 mt-8">
        <div class="container mx-auto text-center text-gray-600">
            <p>&copy; 2025 AutoCu. All rights reserved.</p>
            <p class="mt-2">Địa chỉ: 123 Đường ABC, Quận XYZ, Thành phố Hồ Chí Minh</p>
            <p>Liên hệ: <a href="mailto:info@autocu.com">info@autocu.com</a> | Điện thoại: 0123.456.789</p>
            <div class="mt-4">
                <a href="#" class="text-gray-600 hover:text-orange-500 mr-4"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="text-gray-600 hover:text-orange-500 mr-4"><i class="fab fa-twitter"></i></a>
                <a href="#" class="text-gray-600 hover:text-orange-500 mr-4"><i class="fab fa-instagram"></i></a>
                <a href="#" class="text-gray-600 hover:text-orange-500"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
    </footer>

</body>
</html>