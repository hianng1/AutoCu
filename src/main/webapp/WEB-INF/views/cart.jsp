<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- Cập nhật URI taglib JSTL sang chuẩn mới --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- Đã sửa core_rt thành core --%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Nếu bạn cần sử dụng các thẻ sec:... trong trang cart.jsp này, bỏ comment dòng dưới --%>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu - Giỏ hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <%-- Assuming you are using Spring Security and need CSRF token for POST requests --%>
    <%-- Nếu bạn có cấu hình Spring Security CSRF (chưa disable), hãy bỏ comment dòng dưới --%>
    <%-- Các meta tag này thường được đặt ở head của trang chính (layout hoặc index) --%>
    <%-- <meta name="_csrf" content="${_csrf.token}"/> --%>
    <%-- <meta name="_csrf_header" content="${_csrf.headerName}"/> --%>

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
        .customer-info {
            background-color: #f3f4f6;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        .customer-info p {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        .customer-info i {
            margin-right: 0.5rem;
            color: #4b5563;
            width: 20px;
            text-align: center;
        }
         #notification {
            z-index: 1000; /* Ensure it's on top of other elements */
            position: fixed; /* Or 'absolute' depending on desired behavior */
            top: 1rem;
            right: 1rem;
         }
    </style>
</head>
<body>
    <%-- Include your header (Đảm bảo header.jsp đã được sửa để dùng Spring Security Taglib và contextPath) --%>
    <jsp:include page="/common/header.jsp" />

    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">Giỏ Hàng</h1>

        <%-- Display Flash Messages (success and error attributes from controller) --%>
        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                <span class="block sm:inline">${success}</span>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                <span class="block sm:inline">${error}</span>
            </div>
        </c:if>

        <%-- Check if the cart is empty (based on CART_ITEMS attribute from service/controller) --%>
        <c:if test="${empty CART_ITEMS}">
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <h2 class="text-2xl font-semibold text-gray-600 mb-4">Giỏ hàng trống</h2>
                <p class="text-gray-500 mb-6">Bạn chưa có sản phẩm nào trong giỏ hàng</p>
                <%-- THÊM contextPath vào link --%>
                <a href="${pageContext.request.contextPath}/trangchu" class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors">
                    <i class="fas fa-shopping-bag mr-2"></i>
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:if>

        <%-- Display cart items if the cart is not empty --%>
        <c:if test="${not empty CART_ITEMS}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div class="lg:col-span-2 space-y-4">
                    <%-- Iterate over the list of GioHang items (from CART_ITEMS) --%>
                    <c:forEach var="item" items="${CART_ITEMS}">
                        <%-- Each 'item' here is a GioHang object --%>
                        <div class="cart-item bg-white rounded-lg p-4 flex items-center gap-4">
                            <%-- Access PhuKienOto properties via the GioHang item --%>
                            <%-- THÊM contextPath vào src ảnh --%>
                            <img src="${pageContext.request.contextPath}/imgs/${item.phuKienOto.anhDaiDien}" alt="${item.phuKienOto.tenPhuKien}" class="product-image">

                            <div class="flex-1">
                                <h3 class="font-semibold text-lg text-gray-800">${item.phuKienOto.tenPhuKien}</h3>
                                <p class="text-gray-600 text-sm mb-2">${item.phuKienOto.moTa}</p>
                                <div class="price text-lg">
                                    <%-- Display the price from the GioHang item --%>
                                    <fmt:formatNumber value="${item.gia}" pattern="#,##0" /> đ
                                </div>
                            </div>

                            <div class="flex items-center gap-6">
                                <div class="quantity-control">
                                    <%-- Form for updating quantity --%>
                                    <%-- THÊM contextPath vào action form --%>
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="flex items-center" id="updateForm_${item.cartID}"> <%-- Dùng cartID --%>
                                        <%-- Use the cart item ID (GioHang ID) for updating --%>
                                        <%-- Input ẩn chứa ID mục giỏ hàng --%>
                                        <input type="hidden" name="id" value="${item.cartID}"/> <%-- Dùng cartID --%>
                                        <%-- Nếu bạn có cấu hình Spring Security CSRF, hãy bỏ comment dòng dưới --%>
                                        <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>

                                        <%-- Button giảm số lượng. Gọi JS function với cart item ID --%>
                                        <button type="button" class="quantity-btn" onclick="updateQuantity(${item.cartID}, -1)"> <%-- Dùng cartID --%>
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        <%-- Input số lượng. name="soLuong" khớp với tham số controller. data-cart-item-id dùng cho JS. onchange gọi JS function --%>
                                        <input type="number" name="soLuong" value="${item.soLuong}"
                                               class="quantity-input" min="1"
                                               data-cart-item-id="${item.cartID}" <%-- Dùng cartID --%>
                                               onchange="submitUpdateForm(${item.cartID})"> <%-- Dùng cartID --%>
                                        <%-- Button tăng số lượng. Gọi JS function với cart item ID --%>
                                        <button type="button" class="quantity-btn" onclick="updateQuantity(${item.cartID}, 1)"> <%-- Dùng cartID --%>
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </form>
                                </div>

                                <div class="text-right">
                                    <div class="font-semibold text-lg">
                                        <%-- Tính tổng tiền cho mục này (giá * số lượng) --%>
                                        <fmt:formatNumber value="${item.gia * item.soLuong}" pattern="#,##0" /> đ
                                    </div>
                                    <%-- Link xóa mục giỏ hàng --%>
                                    <%-- THÊM contextPath vào link --%>
                                    <%-- Link gửi yêu cầu GET đến /cart/remove/{cartId} --%>
                                    <a href="${pageContext.request.contextPath}/cart/remove/${item.cartID}" <%-- Dùng cartID --%>
                                       class="remove-btn text-sm inline-flex items-center mt-1"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?');">
                                        <i class="fas fa-trash-alt mr-1"></i>
                                        Xóa
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="total-section">
                    <div class="customer-info">
                        <h3 class="font-semibold text-gray-800 mb-3 flex items-center">
                            <i class="fas fa-user-circle"></i>
                            Thông tin giao hàng
                        </h3>

                        <%-- Hiển thị thông tin người dùng từ biến 'userInfo' được truyền từ controller --%>
                        <c:choose>
                            <c:when test="${not empty userInfo}">
                                <p>
                                    <i class="fas fa-user"></i>
                                    <span class="font-medium">${userInfo.hovaten}</span>
                                </p>
                                <p>
                                    <i class="fas fa-phone"></i>
                                    <span>${userInfo.sodienthoai}</span>
                                </p>
                                <p>
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${userInfo.diaChi}</span>
                                </p>
                                <%-- THÊM contextPath vào link cập nhật thông tin profile --%>
                                <a href="${pageContext.request.contextPath}/profile" class="text-blue-600 text-sm hover:text-blue-800 inline-flex items-center mt-2">
                                    <i class="fas fa-edit mr-1"></i>
                                    Cập nhật thông tin
                                </a>
                            </c:when>
                            <c:otherwise>
                                <p class="text-red-500">Vui lòng đăng nhập để hiển thị thông tin giao hàng</p>
                                <%-- THÊM contextPath vào link đăng nhập --%>
                                <%-- Dùng URL /login đã cấu hình trong SecurityConfig --%>
                                <a href="${pageContext.request.contextPath}/login" class="text-blue-600 text-sm hover:text-blue-800 inline-flex items-center mt-2">
                                    <i class="fas fa-sign-in-alt mr-1"></i>
                                    Đăng nhập ngay
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Tổng Đơn Hàng</h2>
                    <div class="space-y-2 mb-4">
                        <div class="flex justify-between text-gray-600">
                            <span>Tổng tiền hàng</span>
                             <%-- Hiển thị tổng tiền từ biến 'TOTAL' được truyền từ controller --%>
                            <span><fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ</span>
                        </div>
                         <div class="flex justify-between text-gray-600">
                            <span>Phí vận chuyển</span>
                             <%-- Phí vận chuyển thường tính ở trang thanh toán. Có thể hiển thị placeholder hoặc 0 --%>
                            <span>--</span> <%-- Hoặc <span>0 đ</span> hoặc tương tự --%>
                        </div>
                        <%-- Tính thuế VAT (thường tính ở tổng cuối cùng) --%>
                        <%-- <div class="flex justify-between text-gray-600">
                            <span>Thuế VAT (10%)</span>
                            <span><fmt:formatNumber value="${TOTAL * 0.1}" pattern="#,##0" /> đ</span>
                        </div> --%>
                        <div class="border-t pt-2 mt-2">
                            <div class="flex justify-between font-semibold text-lg">
                                <span>Tổng cộng</span>
                                <span class="price">
                                    <%-- Hiển thị tổng tiền từ biến 'TOTAL' --%>
                                    <fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ
                                    <%-- Lưu ý: Tổng cuối cùng bao gồm ship/VAT sẽ hiển thị/tính ở trang thanh toán --%>
                                </span>
                            </div>
                        </div>
                    </div>

					<%-- Link tiến hành thanh toán --%>
                    <%-- THÊM contextPath vào link --%>
					<%-- Form này sẽ gửi yêu cầu POST trực tiếp đến /checkout --%>
					<form action="${pageContext.request.contextPath}/cart/checkout" method="post">
					    <%-- Nếu bạn có cấu hình Spring Security CSRF, bỏ comment dòng dưới --%>
					    <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					
					    <%--
					       Quan trọng: Nếu phương thức POST /checkout cần các tham số
					       @RequestParam("paymentMethod"), @RequestParam("shippingAddress"), v.v.,
					       bạn cần cung cấp chúng ở đây dưới dạng input ẩn hoặc thay đổi logic trong controller
					       để lấy chúng từ nguồn khác (ví dụ: user profile defaults).
					       Nếu không có input ẩn, các @RequestParam trong controller sẽ là null hoặc lỗi nếu required.
					    --%>
					    <%-- Ví dụ (nếu muốn gửi giá trị mặc định hoặc từ user profile): --%>
					    <input type="hidden" name="paymentMethod" value="CashOnDelivery"/>
					    <input type="hidden" name="shippingAddress" value="${userInfo.diaChi}"/>
					    <input type="hidden" name="shippingMethod" value="standard"/>
					    <input type="hidden" name="note" value=""/>
					
					
					    <button type="submit" class="w-full text-center inline-block px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors">
					        Tiến hành thanh toán
					    </button>
					</form>

					<%-- Link tiếp tục mua sắm --%>
                    <%-- THÊM contextPath vào link --%>
					<a href="${pageContext.request.contextPath}/trangchu" class="block w-full text-center px-6 py-3 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors mt-3">
					    Tiếp tục mua sắm
					</a>

                    <%-- Link xóa toàn bộ giỏ hàng --%>
                    <%-- THÊM contextPath vào link --%>
					<a href="${pageContext.request.contextPath}/cart/clear" class="block w-full text-center px-6 py-3 text-red-600 font-semibold hover:text-red-700 transition-colors mt-3"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng không?');">
					    Xóa giỏ hàng
					</a>

					<%-- Add notification area --%>
					<div id="notification" class="hidden fixed top-4 right-4 p-4 rounded-lg shadow-lg text-white"></div>
                </div>
            </div>
        </c:if>
    </div>

    <%-- Include your footer --%>
    <jsp:include page="/common/footer.jsp" />

    <script>
    // Function to update quantity input and potentially submit form
    function updateQuantity(cartID, delta) { // Dùng cartID
        const quantityInput = document.querySelector(`input[data-cart-item-id='${cartID}']`); // Dùng cartID
        if (quantityInput) {
            let currentValue = parseInt(quantityInput.value);
            let newValue = currentValue + delta;
            if (newValue >= 1) { // Ensure quantity is at least 1
                quantityInput.value = newValue;
                // Automatically submit the form after quantity change
                submitUpdateForm(cartID); // Dùng cartID
            } else if (newValue === 0) {
                 // If reducing to 0, confirm and redirect to remove
                 if (confirm('Bạn có muốn xóa sản phẩm này khỏi giỏ hàng không?')) {
                     // THÊM contextPath vào link xóa trong JS
                     window.location.href = "${pageContext.request.contextPath}/cart/remove/" + cartID; // Dùng cartID
                 } else {
                     // Revert the input value if the user cancels
                     quantityInput.value = currentValue;
                 }
            }
        }
    }

    // Function to submit the update form for a specific cart item
    function submitUpdateForm(cartID) { // Dùng cartID
        const form = document.getElementById(`updateForm_${cartID}`); // Dùng cartID
        if (form) {
             // Optional: Add a small delay to prevent rapid submissions if the user clicks buttons fast
            setTimeout(() => {
                 form.submit();
            }, 100); // Adjust delay as needed
        }
    }

	// Function to show notification messages (if needed for AJAX or other client-side events)
    // Your controller is currently using RedirectAttributes for flash messages,
    // which are displayed by the JSTL 'success' and 'error' checks above.
    // This showNotification function might be useful for future AJAX interactions.
	/*
    function showNotification(message, type) {
	    const notification = document.getElementById('notification');
	    notification.textContent = message;

	    // Remove all previous color classes
	    notification.classList.remove('bg-green-500', 'bg-red-500');

	    // Add the appropriate color class based on type
	    if (type === 'success') {
	        notification.classList.add('bg-green-500');
	    } else { // Assuming 'error' type
	        notification.classList.add('bg-red-500');
	    }

	    notification.classList.remove('hidden');

	    // Hide the notification after 5 seconds
	    setTimeout(() => {
	        notification.classList.add('hidden');
	    }, 5000);
	}
    */

    <%-- The AJAX checkout script was commented out as your controller uses a form submission. --%>
    <%-- If you decide to implement AJAX checkout later, you can use and adapt this. --%>
    </script>
    <%-- Cần có script Bootstrap nếu bạn dùng các thành phần Bootstrap cần JS (ví dụ: alert dismissible) --%>
    <%-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="..." crossorigin="anonymous"></script> --%>
</body>
</html>