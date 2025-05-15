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

    <jsp:include page="/common/header.jsp" />

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

    <jsp:include page="/common/footer.jsp" />

</body>
</html>