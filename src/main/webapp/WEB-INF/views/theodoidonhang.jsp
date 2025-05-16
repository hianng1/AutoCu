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
            .order-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }
            .order-table th,
            .order-table td {
                padding: 0.75rem;
                vertical-align: middle;
            }
            .order-table thead th {
                background-color: #f9fafb;
                font-weight: 600;
                text-align: left;
                border-bottom: 2px solid #e5e7eb;
            }
            .order-table tbody tr {
                transition: background-color 0.2s;
            }
            .order-table tbody tr:hover {
                background-color: #f9fafb;
            }
            .order-table tbody td {
                border-bottom: 1px solid #e5e7eb;
            }
            .order-table .status-badge {
                display: inline-block;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 500;
            }
            .badge-waiting {
                background-color: #fef3c7;
                color: #b45309;
            }
            .badge-processing {
                background-color: #dbeafe;
                color: #1e40af;
            }
            .badge-shipping {
                background-color: #e0e7ff;
                color: #3730a3;
            }
            .badge-delivered {
                background-color: #d1fae5;
                color: #065f46;
            }
            .badge-cancelled {
                background-color: #fee2e2;
                color: #b91c1c;
            }
            .view-order-btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-weight: 500;
                font-size: 0.875rem;
                transition: all 0.2s;
                background-color: #f59e0b;
                color: white;
            }
            .view-order-btn:hover {
                background-color: #d97706;
            }
            .cancel-order-btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-weight: 500;
                font-size: 0.875rem;
                transition: all 0.2s;
                background-color: #ef4444;
                color: white;
                border: none;
                cursor: pointer;
            }
            .cancel-order-btn:hover {
                background-color: #dc2626;
            }
            .flex.gap-2 {
                display: flex;
                gap: 0.5rem;
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

            <!-- Đơn hàng của bạn - Bảng danh sách đơn hàng của khách hàng -->
            <div class="bg-white shadow-lg rounded-lg p-6 mb-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800">
                    <i class="fas fa-shopping-bag mr-2 text-orange-500"></i>Đơn
                    hàng của bạn
                </h2>

                <c:choose>
                    <c:when test="${empty userOrders}">
                        <div class="bg-gray-50 p-8 text-center rounded-lg">
                            <i
                                class="fas fa-box-open text-gray-400 text-5xl mb-4"
                            ></i>
                            <h3 class="text-lg font-medium text-gray-600 mb-2">
                                Bạn chưa có đơn hàng nào
                            </h3>
                            <p class="text-gray-500 mb-4">
                                Khi bạn đặt hàng, các đơn hàng sẽ hiển thị ở đây
                            </p>
                            <a
                                href="${pageContext.request.contextPath}/trangchu"
                                class="inline-flex items-center px-4 py-2 bg-orange-500 hover:bg-orange-600 text-white rounded-lg transition-colors"
                            >
                                <i class="fas fa-shopping-cart mr-2"></i>Mua sắm
                                ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="order-table">
                                <thead>
                                    <tr>
                                        <th>Mã đơn hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach
                                        var="order"
                                        items="${userOrders}"
                                    >
                                        <tr>
                                            <td class="font-medium">
                                                #${order.orderID}
                                            </td>
                                            <td>
                                                <fmt:formatDate
                                                    value="${order.ngayDatHang}"
                                                    pattern="dd/MM/yyyy HH:mm"
                                                />
                                            </td>
                                            <td
                                                class="font-medium text-orange-600"
                                            >
                                                <fmt:formatNumber
                                                    value="${order.tongThanhToan}"
                                                    pattern="#,##0 đ"
                                                />
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when
                                                        test="${order.trangThai eq 'CHO_XAC_NHAN'}"
                                                    >
                                                        <span
                                                            class="status-badge badge-waiting"
                                                            >Chờ xác nhận</span
                                                        >
                                                    </c:when>
                                                    <c:when
                                                        test="${order.trangThai eq 'DANG_XU_LY'}"
                                                    >
                                                        <span
                                                            class="status-badge badge-processing"
                                                            >Đang xử lý</span
                                                        >
                                                    </c:when>
                                                    <c:when
                                                        test="${order.trangThai eq 'DANG_GIAO'}"
                                                    >
                                                        <span
                                                            class="status-badge badge-shipping"
                                                            >Đang giao</span
                                                        >
                                                    </c:when>
                                                    <c:when
                                                        test="${order.trangThai eq 'DA_GIAO'}"
                                                    >
                                                        <span
                                                            class="status-badge badge-delivered"
                                                            >Đã giao</span
                                                        >
                                                    </c:when>
                                                    <c:when
                                                        test="${order.trangThai eq 'DA_HUY'}"
                                                    >
                                                        <span
                                                            class="status-badge badge-cancelled"
                                                            >Đã hủy</span
                                                        >
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="status-badge badge-processing"
                                                            >Đang xử lý</span
                                                        >
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="flex gap-2">
                                                <a
                                                    href="${pageContext.request.contextPath}/theodoidonhang/trangthai?orderid=${order.orderID}"
                                                    class="view-order-btn"
                                                >
                                                    <i
                                                        class="fas fa-eye mr-2"
                                                    ></i
                                                    >Xem chi tiết
                                                </a>

                                                <!-- Chỉ hiển thị nút hủy đơn hàng nếu đơn hàng đang ở trạng thái chờ xác nhận hoặc đang xử lý -->
                                                <c:if
                                                    test="${order.trangThai eq 'CHO_XAC_NHAN' || order.trangThai eq 'DANG_XU_LY'}"
                                                >
                                                    <button
                                                        onclick="confirmCancelOrder(${order.orderID})"
                                                        class="cancel-order-btn ml-2"
                                                    >
                                                        <i
                                                            class="fas fa-times-circle mr-2"
                                                        ></i
                                                        >Hủy đơn
                                                    </button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
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

        <script>
            function confirmCancelOrder(orderId) {
                if (confirm("Bạn có chắc chắn muốn hủy đơn hàng này không?")) {
                    window.location.href =
                        "${pageContext.request.contextPath}/theodoidonhang/cancel?orderid=" +
                        orderId;
                }
            }
        </script>
    </body>
</html>
