<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Theo Dõi Đơn Hàng - AutoCu</title>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        />
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet"
        />
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
            .tracking-container {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }
            .order-info {
                background-color: #f9fafb;
                border-radius: 0.5rem;
                padding: 1rem;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <jsp:include page="/common/header.jsp" />

        <div class="container mx-auto py-8 px-4">
            <div class="mb-8">
                <h1 class="text-3xl font-bold mb-2">Theo Dõi Đơn Hàng</h1>
                <p class="text-gray-600">
                    Xin chào <strong>${userInfo.hovaten}</strong>, vui lòng nhập
                    mã đơn hàng để theo dõi trạng thái.
                </p>
            </div>

            <div class="bg-white shadow-lg rounded-lg p-6 mb-8">
                <form
                    action="${pageContext.request.contextPath}/theodoidonhang/trangthai"
                    method="get"
                    class="mb-6"
                >
                    <div class="mb-4">
                        <label
                            for="orderid"
                            class="block text-gray-700 font-medium mb-2"
                        >
                            Mã Đơn Hàng:
                        </label>
                        <div class="flex">
                            <input
                                type="text"
                                id="orderid"
                                name="orderid"
                                class="flex-1 shadow-sm border border-gray-300 rounded-l-lg py-3 px-4 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500"
                                placeholder="Nhập mã đơn hàng để kiểm tra"
                                required
                            />
                            <button
                                type="submit"
                                class="bg-orange-500 hover:bg-orange-600 text-white font-bold py-3 px-6 rounded-r-lg transition duration-200"
                            >
                                <i class="fas fa-search mr-2"></i>Tra Cứu
                            </button>
                        </div>
                    </div>
                </form>

                <c:if test="${not empty errorMessage}">
                    <div
                        class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4"
                        role="alert"
                    >
                        <p class="font-bold">Lỗi</p>
                        <p>${errorMessage}</p>
                    </div>
                </c:if>

                <div
                    class="bg-blue-50 border-l-4 border-blue-500 text-blue-700 p-4"
                    role="alert"
                >
                    <h4 class="font-bold mb-2">Thông tin hữu ích</h4>
                    <p>
                        Mã đơn hàng được gửi trong email xác nhận đơn hàng của
                        bạn.
                    </p>
                    <p>
                        Nếu bạn gặp khó khăn trong việc tìm mã đơn hàng, vui
                        lòng liên hệ với bộ phận hỗ trợ khách hàng.
                    </p>
                </div>
            </div>

            <div class="bg-white shadow-lg rounded-lg p-6 mb-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800">
                    Thông tin trạng thái đơn hàng
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-5 gap-4 mb-8">
                    <div
                        class="p-4 border border-gray-200 rounded-lg text-center"
                    >
                        <div
                            class="w-16 h-16 bg-yellow-100 text-yellow-500 rounded-full flex items-center justify-center mx-auto mb-3"
                        >
                            <i class="fas fa-clipboard-list text-2xl"></i>
                        </div>
                        <h3 class="font-semibold mb-1">Chờ xác nhận</h3>
                        <p class="text-gray-500 text-sm">
                            Đơn hàng đã được đặt
                        </p>
                    </div>

                    <div
                        class="p-4 border border-gray-200 rounded-lg text-center"
                    >
                        <div
                            class="w-16 h-16 bg-blue-100 text-blue-500 rounded-full flex items-center justify-center mx-auto mb-3"
                        >
                            <i class="fas fa-cog text-2xl"></i>
                        </div>
                        <h3 class="font-semibold mb-1">Đang xử lý</h3>
                        <p class="text-gray-500 text-sm">
                            Đơn hàng đang được chuẩn bị
                        </p>
                    </div>

                    <div
                        class="p-4 border border-gray-200 rounded-lg text-center"
                    >
                        <div
                            class="w-16 h-16 bg-indigo-100 text-indigo-500 rounded-full flex items-center justify-center mx-auto mb-3"
                        >
                            <i class="fas fa-truck text-2xl"></i>
                        </div>
                        <h3 class="font-semibold mb-1">Đang giao</h3>
                        <p class="text-gray-500 text-sm">
                            Đơn hàng đang trên đường giao
                        </p>
                    </div>

                    <div
                        class="p-4 border border-gray-200 rounded-lg text-center"
                    >
                        <div
                            class="w-16 h-16 bg-green-100 text-green-500 rounded-full flex items-center justify-center mx-auto mb-3"
                        >
                            <i class="fas fa-check text-2xl"></i>
                        </div>
                        <h3 class="font-semibold mb-1">Đã giao</h3>
                        <p class="text-gray-500 text-sm">
                            Đơn hàng đã giao thành công
                        </p>
                    </div>

                    <div
                        class="p-4 border border-gray-200 rounded-lg text-center"
                    >
                        <div
                            class="w-16 h-16 bg-red-100 text-red-500 rounded-full flex items-center justify-center mx-auto mb-3"
                        >
                            <i class="fas fa-times text-2xl"></i>
                        </div>
                        <h3 class="font-semibold mb-1">Đã hủy</h3>
                        <p class="text-gray-500 text-sm">Đơn hàng đã bị hủy</p>
                    </div>
                </div>

                <div class="bg-gray-50 p-4 rounded-lg">
                    <h3 class="font-semibold mb-3">Liên hệ hỗ trợ</h3>
                    <p class="mb-2">
                        <i class="fas fa-phone-alt mr-2 text-orange-500"></i>
                        Hotline: 1900 1234
                    </p>
                    <p class="mb-2">
                        <i class="fas fa-envelope mr-2 text-orange-500"></i>
                        Email: hotro@autocu.com.vn
                    </p>
                    <p>
                        <i class="fas fa-clock mr-2 text-orange-500"></i> Thời
                        gian làm việc: 8:00 - 20:00 (T2 - CN)
                    </p>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp" />
    </body>
</html>
