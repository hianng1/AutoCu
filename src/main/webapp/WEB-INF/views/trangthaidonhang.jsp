<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chi Tiết Đơn Hàng #${donHang.orderID} - AutoCu</title>
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
            .tracking-step {
                position: relative;
            }
            .tracking-step::after {
                content: "";
                position: absolute;
                width: 100%;
                height: 2px;
                background-color: #e5e7eb;
                top: 25px;
                left: 50%;
                z-index: 0;
            }
            .tracking-step:last-child::after {
                display: none;
            }
            .tracking-icon {
                position: relative;
                z-index: 1;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: #e5e7eb;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
            }
            .tracking-icon.completed {
                background-color: #10b981;
                color: white;
            }
            .tracking-icon.active {
                background-color: #3b82f6;
                color: white;
            }
            .product-table th {
                background-color: #f3f4f6;
                text-align: left;
                padding: 12px 16px;
            }
            .product-table td {
                padding: 12px 16px;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <jsp:include page="/common/header.jsp" />

        <div class="container mx-auto py-8 px-4">
            <div
                class="flex flex-col md:flex-row gap-4 items-center justify-between mb-6"
            >
                <div>
                    <h1 class="text-3xl font-bold">
                        Đơn hàng #${donHang.orderID}
                    </h1>
                    <p class="text-gray-600">
                        <span class="mr-4"
                            ><i class="far fa-calendar-alt mr-2"></i>Đặt ngày:
                            <fmt:formatDate
                                value="${donHang.ngayDatHang}"
                                pattern="dd/MM/yyyy HH:mm"
                        /></span>
                        <span>
                            <i class="fas fa-tag mr-2"></i>Trạng thái:
                            <c:choose>
                                <c:when
                                    test="${donHang.trangThai == 'CHO_XAC_NHAN'}"
                                >
                                    <span
                                        class="px-2 py-1 bg-yellow-100 text-yellow-800 rounded-full text-sm font-medium"
                                        >Chờ xác nhận</span
                                    >
                                </c:when>
                                <c:when
                                    test="${donHang.trangThai == 'DANG_XU_LY'}"
                                >
                                    <span
                                        class="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-sm font-medium"
                                        >Đang xử lý</span
                                    >
                                </c:when>
                                <c:when
                                    test="${donHang.trangThai == 'DANG_GIAO'}"
                                >
                                    <span
                                        class="px-2 py-1 bg-indigo-100 text-indigo-800 rounded-full text-sm font-medium"
                                        >Đang giao</span
                                    >
                                </c:when>
                                <c:when
                                    test="${donHang.trangThai == 'DA_GIAO'}"
                                >
                                    <span
                                        class="px-2 py-1 bg-green-100 text-green-800 rounded-full text-sm font-medium"
                                        >Đã giao</span
                                    >
                                </c:when>
                                <c:when test="${donHang.trangThai == 'DA_HUY'}">
                                    <span
                                        class="px-2 py-1 bg-red-100 text-red-800 rounded-full text-sm font-medium"
                                        >Đã hủy</span
                                    >
                                </c:when>
                            </c:choose>
                        </span>
                    </p>
                </div>
                <a
                    href="${pageContext.request.contextPath}/theodoidonhang"
                    class="bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-2 px-4 rounded inline-flex items-center transition duration-200"
                >
                    <i class="fas fa-arrow-left mr-2"></i> Quay lại
                </a>
            </div>

            <!-- Thanh tiến trình trạng thái đơn hàng -->
            <div class="bg-white shadow-lg rounded-lg p-6 mb-8">
                <h2 class="text-xl font-bold mb-6 text-gray-800">
                    Tiến trình đơn hàng
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-5 mb-4">
                    <div class="tracking-step flex flex-col items-center">
                        <div
                            class="tracking-icon ${donHang.trangThai == 'CHO_XAC_NHAN' || donHang.trangThai == 'DANG_XU_LY' || donHang.trangThai == 'DANG_GIAO' || donHang.trangThai == 'DA_GIAO' ? 'completed' : donHang.trangThai == 'DA_HUY' ? '' : 'active'}"
                        >
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <p class="mt-2 text-sm font-medium">Đã đặt hàng</p>
                    </div>
                    <div class="tracking-step flex flex-col items-center">
                        <div
                            class="tracking-icon ${donHang.trangThai == 'DANG_XU_LY' || donHang.trangThai == 'DANG_GIAO' || donHang.trangThai == 'DA_GIAO' ? 'completed' : donHang.trangThai == 'CHO_XAC_NHAN' ? 'active' : ''}"
                        >
                            <i class="fas fa-cog"></i>
                        </div>
                        <p class="mt-2 text-sm font-medium">Đang xử lý</p>
                    </div>
                    <div class="tracking-step flex flex-col items-center">
                        <div
                            class="tracking-icon ${donHang.trangThai == 'DANG_GIAO' || donHang.trangThai == 'DA_GIAO' ? 'completed' : donHang.trangThai == 'DANG_XU_LY' ? 'active' : ''}"
                        >
                            <i class="fas fa-box"></i>
                        </div>
                        <p class="mt-2 text-sm font-medium">Đóng gói</p>
                    </div>
                    <div class="tracking-step flex flex-col items-center">
                        <div
                            class="tracking-icon ${donHang.trangThai == 'DANG_GIAO' ? 'active' : donHang.trangThai == 'DA_GIAO' ? 'completed' : ''}"
                        >
                            <i class="fas fa-truck"></i>
                        </div>
                        <p class="mt-2 text-sm font-medium">Đang giao</p>
                    </div>
                    <div class="tracking-step flex flex-col items-center">
                        <div
                            class="tracking-icon ${donHang.trangThai == 'DA_GIAO' ? 'completed' : ''}"
                        >
                            <i class="fas fa-check"></i>
                        </div>
                        <p class="mt-2 text-sm font-medium">Đã giao</p>
                    </div>
                </div>

                <c:if test="${donHang.trangThai == 'DA_HUY'}">
                    <div
                        class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mt-4"
                        role="alert"
                    >
                        <p class="font-bold">Đơn hàng đã bị hủy</p>
                        <p>
                            Vui lòng liên hệ với chúng tôi nếu bạn có bất kỳ
                            thắc mắc nào.
                        </p>
                    </div>
                </c:if>
            </div>

            <!-- Thông tin giao hàng và thanh toán -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
                <!-- Thông tin giao hàng -->
                <div class="bg-white shadow-lg rounded-lg p-6">
                    <h2
                        class="text-xl font-bold mb-4 text-gray-800 border-b pb-2"
                    >
                        Thông tin giao hàng
                    </h2>
                    <div class="space-y-3">
                        <p>
                            <span class="font-medium">Người nhận:</span>
                            ${donHang.user.hovaten}
                        </p>
                        <p>
                            <span class="font-medium">Số điện thoại:</span>
                            ${donHang.user.sodienthoai}
                        </p>
                        <p>
                            <span class="font-medium">Địa chỉ:</span>
                            ${donHang.diaChiGiaoHang}
                        </p>
                        <p>
                            <span class="font-medium"
                                >Phương thức vận chuyển:</span
                            >
                            ${donHang.phuongThucVanChuyen}
                        </p>
                        <c:if test="${not empty donHang.ghiChu}">
                            <p>
                                <span class="font-medium">Ghi chú:</span>
                                ${donHang.ghiChu}
                            </p>
                        </c:if>
                    </div>
                </div>

                <!-- Thông tin thanh toán -->
                <div class="bg-white shadow-lg rounded-lg p-6">
                    <h2
                        class="text-xl font-bold mb-4 text-gray-800 border-b pb-2"
                    >
                        Thông tin thanh toán
                    </h2>
                    <div class="space-y-3">
                        <p>
                            <span class="font-medium"
                                >Phương thức thanh toán:</span
                            >
                            <span class="ml-2">
                                <c:choose>
                                    <c:when
                                        test="${donHang.phuongThucThanhToan eq 'cod'}"
                                    >
                                        <i
                                            class="fas fa-money-bill-wave text-green-500 mr-1"
                                        ></i>
                                        Thanh toán khi nhận hàng (COD)
                                    </c:when>
                                    <c:when
                                        test="${donHang.phuongThucThanhToan eq 'bank'}"
                                    >
                                        <i
                                            class="fas fa-university text-blue-500 mr-1"
                                        ></i>
                                        Chuyển khoản ngân hàng
                                    </c:when>
                                    <c:when
                                        test="${donHang.phuongThucThanhToan eq 'vnpay'}"
                                    >
                                        <i
                                            class="fas fa-credit-card text-indigo-500 mr-1"
                                        ></i>
                                        Thanh toán VNPay
                                    </c:when>
                                    <c:otherwise>
                                        ${donHang.phuongThucThanhToan}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </p>
                        <p>
                            <span class="font-medium"
                                >Trạng thái thanh toán:</span
                            >
                            <c:choose>
                                <c:when test="${donHang.daThanhToan}">
                                    <span class="text-green-600 font-medium"
                                        ><i
                                            class="fas fa-check-circle mr-1"
                                        ></i>
                                        Đã thanh toán</span
                                    >
                                </c:when>
                                <c:otherwise>
                                    <span class="text-amber-600 font-medium"
                                        ><i class="fas fa-clock mr-1"></i> Chưa
                                        thanh toán</span
                                    >
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div class="pt-4 mt-4 border-t">
                            <div class="flex justify-between mt-2">
                                <span>Phí vận chuyển:</span>
                                <span
                                    ><fmt:formatNumber
                                        value="${donHang.phiVanChuyen}"
                                        type="currency"
                                        currencySymbol="₫"
                                        maxFractionDigits="0"
                                /></span>
                            </div>
                            <div
                                class="flex justify-between mt-3 pt-3 border-t font-bold"
                            >
                                <span>Tổng thanh toán:</span>
                                <span class="text-orange-600 text-xl"
                                    ><fmt:formatNumber
                                        value="${donHang.tongThanhToan}"
                                        type="currency"
                                        currencySymbol="₫"
                                        maxFractionDigits="0"
                                /></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chi tiết sản phẩm -->
            <div class="bg-white shadow-lg rounded-lg p-6">
                <h2 class="text-xl font-bold mb-4 text-gray-800 border-b pb-2">
                    Chi tiết sản phẩm
                </h2>
                <div class="overflow-x-auto">
                    <table class="w-full product-table">
                        <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Sản phẩm</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-right">Đơn giá</th>
                                <th class="text-right">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <c:forEach var="item" items="${danhSachChiTiet}">
                                <tr>
                                    <td>${item.orderItemID}</td>
                                    <td>
                                        <div class="font-medium text-gray-900">
                                            ${item.tenSanPham}
                                        </div>
                                    </td>
                                    <td class="text-center">${item.soLuong}</td>
                                    <td class="text-right">
                                        <fmt:formatNumber
                                            value="${item.donGia}"
                                            type="currency"
                                            currencySymbol="₫"
                                            maxFractionDigits="0"
                                        />
                                    </td>
                                    <td class="text-right font-medium">
                                        <fmt:formatNumber
                                            value="${item.thanhTien}"
                                            type="currency"
                                            currencySymbol="₫"
                                            maxFractionDigits="0"
                                        />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Phần thông tin hỗ trợ -->
            <div class="bg-white shadow-lg rounded-lg p-6 mt-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800">
                    Cần hỗ trợ?
                </h2>
                <p class="mb-4">
                    Nếu bạn có bất kỳ câu hỏi nào về đơn hàng, vui lòng liên hệ
                    với chúng tôi:
                </p>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="flex items-center">
                        <div
                            class="w-10 h-10 bg-orange-100 text-orange-500 rounded-full flex items-center justify-center mr-3"
                        >
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Gọi hotline</p>
                            <p class="font-semibold">+84 382 948 198</p>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <div
                            class="w-10 h-10 bg-orange-100 text-orange-500 rounded-full flex items-center justify-center mr-3"
                        >
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Email</p>
                            <p class="font-semibold">hotro@autocu.com.vn</p>
                        </div>
                    </div>
<!--                     <div class="flex items-center">
                        <div
                            class="w-10 h-10 bg-orange-100 text-orange-500 rounded-full flex items-center justify-center mr-3"
                        >
                            <i class="fas fa-comment-dots"></i>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Chat trực tuyến</p>
                            <button
                                class="font-semibold text-orange-500 hover:underline"
                            >
                                Bắt đầu chat
                            </button>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp" />
    </body>
</html>
