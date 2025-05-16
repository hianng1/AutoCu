<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- Cập nhật URI taglib JSTL sang chuẩn mới --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- Đã sửa core_rt thành core --%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%-- Nếu bạn cần sử dụng các thẻ sec:... trong trang cart.jsp này, bỏ comment dòng dưới --%>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <%-- Assuming you are using Spring Security and need CSRF token for POST requests --%>
    <%-- Nếu bạn có cấu hình Spring Security CSRF (chưa disable), hãy bỏ comment dòng dưới --%>
    <%-- Các meta tag này thường được đặt ở head của trang chính (layout hoặc index) --%>
    <%-- <meta name="_csrf" content="${_csrf.token}"/> --%>
    <%-- <meta name="_csrf_header" content="${_csrf.headerName}"/> --%>

    <%-- Import Bootstrap CSS (Cần thiết cho Modal và các class form) --%>
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

         /* Custom style for Bootstrap form controls within Tailwind layout */
         .form-label {
            display: block; /* Make label block */
            margin-bottom: 0.25rem; /* Add small margin below label */
            font-size: 0.875rem; /* text-sm */
            font-weight: 500; /* font-semibold */
            color: #4b5563; /* text-gray-700 */
         }
         .form-control-sm {
             padding: 0.25rem 0.5rem; /* Smaller padding */
             font-size: 0.875rem; /* text-sm */
             border-radius: 0.25rem; /* smaller border-radius */
         }
          .form-check-input {
              margin-top: 0.25em; /* Adjust alignment */
          }
          .form-check-label {
              margin-bottom: 0; /* Remove bottom margin */
          }
          
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
         /* Custom style for Bootstrap form controls within Tailwind layout */
         .form-label {
            display: block; /* Make label block */
            margin-bottom: 0.25rem; /* Add small margin below label */
            font-size: 0.875rem; /* text-sm */
            font-weight: 500; /* font-semibold */
            color: #4b5563; /* text-gray-700 */
         }
         .form-control-sm {
             padding: 0.25rem 0.5rem; /* Smaller padding */
             font-size: 0.875rem; /* text-sm */
             border-radius: 0.25rem; /* smaller border-radius */
         }
          .form-check-input {
              margin-top: 0.25em; /* Adjust alignment */
          }
          .form-check-label {
              margin-bottom: 0; /* Remove bottom margin */
          }
           /* Style for Toast messages positioning */
          .toast-container.top-0.end-0 {
              top: 1rem !important;
              right: 1rem !important;
          }

    </style>
</head>
<body>
    <%-- Include your header (Đảm bảo header.jsp đã được sửa để dùng Spring Security Taglib và contextPath) --%>
    <jsp:include page="/common/header.jsp" />

    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">Giỏ Hàng</h1>
        
        
        <%-- START: DISPLAY TOAST MESSAGES (for general success/error) --%>
        <%-- Toast Container cho Toast messages --%>
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100">
            <%-- Toast cho thông báo thành công (từ RedirectAttributes) --%>
            <c:if test="${not empty successMessage}">
                <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-success text-white">
                        <strong class="me-auto">Thành công</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">${successMessage}</div>
                </div>
            </c:if>

            <%-- Toast cho thông báo lỗi (từ RedirectAttributes) --%>
            <c:if test="${not empty errorMessage}">
                <div id="errorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-danger text-white">
                        <strong class="me-auto">Lỗi</strong>
                         <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">${errorMessage}</div>
                </div>
            </c:if>
        </div>
        <%-- END: DISPLAY TOAST MESSAGES --%>

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
                            <span>0 đ</span> <%-- Hoặc <span>0 đ</span> hoặc tương tự --%>
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

					<%-- START: BUTTON KÍCH HOẠT MODAL --%>
					<button type="button"
					        class="w-full text-center inline-block px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors"
					        data-bs-toggle="modal" data-bs-target="#checkoutModal"
                            ${empty userInfo ? 'disabled' : ''}> <%-- Disable nút nếu chưa đăng nhập --%>
					    Tiến hành thanh toán
					</button>
                    <%-- END: BUTTON KÍCH HOẠT MODAL --%>

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
    
    <%-- START: BOOTSTRAP MODAL CHO CHECKOUT --%>
    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="checkoutModalLabel">Xác Nhận Đơn Hàng & Thanh Toán</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <%-- Form sẽ được gửi khi nhấn nút xác nhận trong footer --%>
	        <%-- THÊM contextPath vào action form trong modal --%>
	        <form action="${pageContext.request.contextPath}/cart/checkout" method="post" id="checkoutForm">
	            <%-- Nếu bạn có cấu hình Spring Security CSRF, bỏ comment dòng dưới --%>
	            <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>

                <%-- Hiển thị thông tin tổng tiền --%>
	            <div class="mb-3 text-center"> <%-- Thêm text-center để căn giữa --%>
	                <p class="font-semibold text-xl text-gray-800">Tổng cộng: <span class="text-red-600"><fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ</span></p>
	            </div>

	            <%-- Thông tin giao hàng (Điền sẵn từ userInfo) --%>
	            <div class="mb-4 p-3 bg-gray-100 rounded">
	                 <h6 class="font-semibold mb-2 text-gray-800">Thông tin giao hàng</h6>
	                 <%-- Kiểm tra userInfo trước khi hiển thị để tránh lỗi (Nút kích hoạt đã disabled nếu empty, nhưng kiểm tra lại vẫn tốt) --%>
	                 <c:if test="${not empty userInfo}">
	                    <div class="mb-2">
	                       <label for="shippingName" class="form-label text-sm">Người nhận:</label>
	                       <%-- Readonly input for name --%>
	                       <input type="text" class="form-control form-control-sm" id="shippingName" value="${userInfo.hovaten}" readonly>
	                    </div>
	                    <div class="mb-2">
	                       <label for="shippingPhone" class="form-label text-sm">Số điện thoại:</label>
                            <%-- Readonly input for phone --%>
	                       <input type="text" class="form-control form-control-sm" id="shippingPhone" value="${userInfo.sodienthoai}" readonly>
	                    </div>
	                    <div class="mb-2">
	                       <label for="shippingAddress" class="form-label text-sm">Địa chỉ nhận hàng:</label>
	                       <%-- Tên input "shippingAddress" phải khớp với @RequestParam hoặc property trong @ModelAttribute object --%>
	                       <input type="text" class="form-control form-control-sm" id="shippingAddress" name="shippingAddress" value="${userInfo.diaChi}" required> <%-- Cho phép sửa và bắt buộc --%>
	                    </div>
	                    <%-- Input ẩn cho user ID nếu controller cần (lấy lại từ session hoặc security context trong controller thường an toàn hơn) --%>
	                    <%-- <input type="hidden" name="userId" value="${userInfo.maNguoiDung}"> --%>
	                 </c:if>
	                 <%-- Trường hợp userInfo empty sẽ không xảy ra nếu nút kích hoạt modal bị disabled --%>
	            </div>

	            <%-- Lựa chọn phương thức thanh toán --%>
	            <div class="mb-4">
	                 <h6 class="font-semibold mb-2 text-gray-800">Phương thức thanh toán</h6>
	                 <%-- Tên input "paymentMethod" phải khớp với @RequestParam hoặc property trong @ModelAttribute object --%>
	                 <div class="form-check">
	                     <input class="form-check-input" type="radio" name="paymentMethod" id="paymentCash" value="CashOnDelivery" checked>
	                     <label class="form-check-label" for="paymentCash">
	                         Thanh toán khi nhận hàng (COD)
	                     </label>
	                 </div>
	                 <%-- Thêm các lựa chọn thanh toán khác nếu có --%>
	                 <%--
	                 <div class="form-check">
	                     <input class="form-check-input" type="radio" name="paymentMethod" id="paymentOnline" value="OnlinePayment">
	                     <label class="form-check-label" for="paymentOnline">
	                         Thanh toán Online (Ví điện tử, Ngân hàng...)
	                     </label>
	                 </div>
	                 --%>
	            </div>

	            <%-- Ghi chú đơn hàng --%>
	            <div class="mb-3">
	                <label for="orderNote" class="form-label text-sm">Ghi chú (Tùy chọn):</label>
	                <%-- Tên input "note" phải khớp với @RequestParam hoặc property trong @ModelAttribute object --%>
	                <textarea class="form-control form-control-sm" id="orderNote" name="note" rows="2"></textarea>
	            </div>

	            <%-- Input ẩn cho các thông tin khác nếu controller cần --%>
	            <%-- Ví dụ: tổng tiền, danh sách sản phẩm (nếu không lấy lại từ giỏ hàng session) --%>
                 <%-- <input type="hidden" name="totalAmount" value="${TOTAL}"> --%>

	             <%-- Lưu ý: Danh sách sản phẩm trong giỏ hàng thường được lấy lại từ session trong controller --%>
	             <%-- hoặc từ database dựa trên user ID, không cần gửi lại qua form ẩn --%>

	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
	        <%-- Nút này gửi form#checkoutForm --%>
	        <%-- KHÔNG cần disabled ở đây vì nút kích hoạt modal đã bị disabled nếu user empty --%>
	        <button type="submit" form="checkoutForm" class="btn btn-primary">Xác Nhận Thanh Toán</button>
	      </div>
	    </div>
	  </div>
	</div>
    <%-- END: BOOTSTRAP MODAL CHO CHECKOUT --%>
    
    <%-- START: MODAL THÔNG BÁO ĐẶT HÀNG THÀNH CÔNG (Popup theo yêu cầu) --%>
    <div class="modal fade" id="checkoutSuccessModal" tabindex="-1" aria-labelledby="checkoutSuccessModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false"> <%-- Thêm data-bs-backdrop/keyboard để không đóng modal trừ khi bấm OK --%>
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-success text-white">
            <h5 class="modal-title" id="checkoutSuccessModalLabel">Đặt Hàng Thành Công!</h5>
             <%-- Bỏ nút đóng mặc định để buộc người dùng bấm OK --%>
            <%-- <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button> --%>
          </div>
          <div class="modal-body">
            Đơn hàng của bạn đã được đặt thành công. Cảm ơn quý khách!
            <%-- Hiển thị mã đơn hàng nếu bạn đã truyền orderId vào Model --%>
             <c:if test="${not empty orderId}">
                 <p class="mt-2">Mã đơn hàng của bạn: <strong>${orderId}</strong></p>
             </c:if>
          </div>
          <div class="modal-footer">
            <%-- Nút OK để đóng modal và chuyển hướng --%>
            <button type="button" class="btn btn-primary" id="checkoutSuccessOkBtn">OK</button>
          </div>
        </div>
      </div>
    </div>
    <%-- END: MODAL THÔNG BÁO ĐẶT HÀNG THÀNH CÔNG --%>


    <%-- Include your footer --%>
    <jsp:include page="/common/footer.jsp" />

    <%-- jQuery (Cần cho Bootstrap JS và các script tùy chỉnh dễ dàng hơn) --%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%-- Bootstrap JS (Cần thiết cho Modal, Toast và các thành phần JS khác của Bootstrap) --%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    // Fixed updateQuantity function that correctly identifies and updates cart items
    function updateQuantity(cartID, delta) {
        // Find the form by its ID
        const form = document.getElementById(`updateForm_${cartID}`);
        if (!form) {
            console.error(`Form with ID updateForm_${cartID} not found`);
            return;
        }
        
        // Find the quantity input within the form
        const quantityInput = form.querySelector('input[name="soLuong"]');
        if (!quantityInput) {
            console.error(`Quantity input not found in form updateForm_${cartID}`);
            return;
        }
        
        // Get current quantity and calculate new value
        let currentValue = parseInt(quantityInput.value) || 1;
        let newValue = currentValue + delta;
        
        // Handle quantity changes
        if (newValue >= 1) {
            // Set the new value and submit the form
            quantityInput.value = newValue;
            form.submit();
        } else {
            // For zero or negative quantities, ask to remove the item
            if (confirm('Bạn có muốn xóa sản phẩm này khỏi giỏ hàng không?')) {
                window.location.href = "${pageContext.request.contextPath}/cart/remove/" + cartID;
            }
        }
    }

    // Function to submit update form for direct input changes
    function submitUpdateForm(cartID) {
        const form = document.getElementById(`updateForm_${cartID}`);
        if (form) {
            form.submit();
        }
    }

    // Set up event handlers when document is loaded
    $(document).ready(function() {
        // Handle direct input changes
        const quantityInputs = document.querySelectorAll('.quantity-input');
        quantityInputs.forEach(input => {
            input.addEventListener('change', function() {
                if (parseInt(this.value) < 1) {
                    this.value = 1; // Ensure minimum 1
                }
                const cartID = this.getAttribute('data-cart-item-id');
                submitUpdateForm(cartID);
            });
        });
        
        // Toast notifications handling
        var hasSuccessMessage = ${not empty successMessage}; 
        var hasErrorMessage = ${not empty errorMessage};
        var isCheckoutSuccess = ${checkoutSuccess eq true};
        
        if (hasSuccessMessage) {
            var successToast = new bootstrap.Toast($('#successToast'));
            successToast.show();
        }

        if (hasErrorMessage) {
            var errorToast = new bootstrap.Toast($('#errorToast'));
            errorToast.show();
        }

        // Checkout success modal handling
        if (isCheckoutSuccess) {
            var checkoutSuccessModal = new bootstrap.Modal($('#checkoutSuccessModal'));
            checkoutSuccessModal.show();
            
            $('#checkoutSuccessOkBtn').on('click', function() {
                window.location.href = "${pageContext.request.contextPath}/trangchu";
            });
            
            $('#checkoutSuccessModal').on('hidden.bs.modal', function() {
                window.location.href = "${pageContext.request.contextPath}/trangchu";
            });
        }
    });
    </script>
</body>
</html>