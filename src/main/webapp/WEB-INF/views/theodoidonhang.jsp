<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theo Dõi Đơn Hàng - AutoCu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
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
<body class="bg-gray-100">

    <jsp:include page="/common/header.jsp" />

    <div class="container mx-auto m-8">
        <h1 class="text-2xl font-semibold mb-4">Theo Dõi Đơn Hàng</h1>

        <div class="bg-white shadow-md rounded-md p-6">
            <form action="${pageContext.request.contextPath}/theodoidonhang/trangthai" method="get" class="mb-4">
                <div class="mb-4">
                    <label for="orderid" class="block text-gray-700 text-sm font-bold mb-2">
                        Mã Đơn Hàng:
                    </label>
                    <input type="text" id="orderId" name="orderid" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" placeholder="Nhập mã đơn hàng của bạn">
                </div>
                <button type="submit" class="bg-orange-500 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                    Theo Dõi
                </button>
                <c:if test="${not empty errorMessage}">
                    <p class="text-red-500 mt-4">${errorMessage}</p>
                </c:if>
            </form>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

</body>
</html>