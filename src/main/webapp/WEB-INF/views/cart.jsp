<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- JSTL tags --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
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
            z-index: 1000;
            position: fixed;
            top: 1rem;
            right: 1rem;
        }
        .form-label {
            display: block;
            margin-bottom: 0.25rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: #4b5563;
        }
        .form-control-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 0.25rem;
        }
        .form-check-input {
            margin-top: 0.25em;
        }
        .form-check-label {
            margin-bottom: 0;
        }
        .toast-container.top-0.end-0 {
            top: 1rem !important;
            right: 1rem !important;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />

    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">Giỏ Hàng</h1>

        <%-- Toast Messages Container --%>
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100">
            <c:if test="${not empty successMessage}">
                <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header bg-success text-white">
                        <strong class="me-auto">Thành công</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">${successMessage}</div>
                </div>
            </c:if>

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

        <%-- Flash Messages --%>
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

        <%-- Empty Cart Display --%>
        <c:if test="${empty CART_ITEMS}">
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <h2 class="text-2xl font-semibold text-gray-600 mb-4">Giỏ hàng trống</h2>
                <p class="text-gray-500 mb-6">Bạn chưa có sản phẩm nào trong giỏ hàng</p>
                <a href="${pageContext.request.contextPath}/trangchu" class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors">
                    <i class="fas fa-shopping-bag mr-2"></i>
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:if>

        <%-- Cart Items Display --%>
        <c:if test="${not empty CART_ITEMS}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div class="lg:col-span-2 space-y-4">
                    <c:forEach var="item" items="${CART_ITEMS}">
                        <div class="cart-item bg-white rounded-lg p-4 flex items-center gap-4">
                            <img src="${pageContext.request.contextPath}/imgs/${item.phuKienOto.anhDaiDien}" alt="${item.phuKienOto.tenPhuKien}" class="product-image">

                            <div class="flex-1">
                                <h3 class="font-semibold text-lg text-gray-800">${item.phuKienOto.tenPhuKien}</h3>
                                <p class="text-gray-600 text-sm mb-2">${item.phuKienOto.moTa}</p>
                                <div class="price text-lg">
                                    <fmt:formatNumber value="${item.gia}" pattern="#,##0" /> đ
                                </div>
                            </div>

                            <div class="flex items-center gap-6">
                                <div class="quantity-control">
                                    <%-- Form for updating quantity --%>
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="flex items-center" id="updateForm_${item.cartID}">
                                        <input type="hidden" name="id" value="${item.cartID}"/>

                                        <%-- Quantity input: Removed onchange, handled by jQuery --%>
                                        <input type="number" name="soLuong" value="${item.soLuong}"
                                               class="quantity-input" min="1"
                                               data-cart-item-id="${item.cartID}">

                                    </form>
                                </div>

                                <div class="text-right">
                                    <div class="font-semibold text-lg">
                                        <fmt:formatNumber value="${item.gia * item.soLuong}" pattern="#,##0" /> đ
                                    </div>
                                    <a href="${pageContext.request.contextPath}/cart/remove/${item.cartID}"
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
                                <a href="${pageContext.request.contextPath}/profile" class="text-blue-600 text-sm hover:text-blue-800 inline-flex items-center mt-2">
                                    <i class="fas fa-edit mr-1"></i>
                                    Cập nhật thông tin
                                </a>
                            </c:when>
                            <c:otherwise>
                                <p class="text-red-500">Vui lòng đăng nhập để hiển thị thông tin giao hàng</p>
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
                            <span><fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ</span>
                        </div>
                        <div class="flex justify-between text-gray-600">
                            <span>Phí vận chuyển</span>
                            <span>0 đ</span>
                        </div>
                        <div class="border-t pt-2 mt-2">
                            <div class="flex justify-between font-semibold text-lg">
                                <span>Tổng cộng</span>
                                <span class="price">
                                    <fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ
                                </span>
                            </div>
                        </div>
                    </div>

                    <button type="button"
                            class="w-full text-center inline-block px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors"
                            data-bs-toggle="modal" data-bs-target="#checkoutModal"
                            ${empty userInfo ? 'disabled' : ''}>
                        Tiến hành thanh toán
                    </button>

                    <a href="${pageContext.request.contextPath}/trangchu" class="block w-full text-center px-6 py-3 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors mt-3">
                        Tiếp tục mua sắm
                    </a>

                    <a href="${pageContext.request.contextPath}/cart/clear" class="block w-full text-center px-6 py-3 text-red-600 font-semibold hover:text-red-700 transition-colors mt-3"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng không?');">
                        Xóa giỏ hàng
                    </a>

                    <div id="notification" class="hidden fixed top-4 right-4 p-4 rounded-lg shadow-lg text-white"></div>
                </div>
            </div>
        </c:if>
    </div>

    <%-- Checkout Modal --%>
    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="checkoutModalLabel">Xác Nhận Đơn Hàng & Thanh Toán</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form action="${pageContext.request.contextPath}/cart/checkout" method="post" id="checkoutForm">
                <div class="mb-3 text-center">
                    <p class="font-semibold text-xl text-gray-800">Tổng cộng: <span class="text-red-600"><fmt:formatNumber value="${TOTAL}" pattern="#,##0" /> đ</span></p>
                </div>

                <div class="mb-4 p-3 bg-gray-100 rounded">
                    <h6 class="font-semibold mb-2 text-gray-800">Thông tin giao hàng</h6>
                    <c:if test="${not empty userInfo}">
                        <div class="mb-2">
                           <label for="shippingName" class="form-label text-sm">Người nhận:</label>
                           <input type="text" class="form-control form-control-sm" id="shippingName" value="${userInfo.hovaten}" readonly>
                        </div>
                        <div class="mb-2">
                           <label for="shippingPhone" class="form-label text-sm">Số điện thoại:</label>
                           <input type="text" class="form-control form-control-sm" id="shippingPhone" value="${userInfo.sodienthoai}" readonly>
                        </div>
                        <div class="mb-2">
                           <label for="shippingAddress" class="form-label text-sm">Địa chỉ nhận hàng:</label>
                           <input type="text" class="form-control form-control-sm" id="shippingAddress" name="shippingAddress" value="${userInfo.diaChi}" required>
                        </div>
                    </c:if>
                </div>

                <div class="mb-4">
                    <h6 class="font-semibold mb-2 text-gray-800">Phương thức thanh toán</h6>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="paymentCash" value="CashOnDelivery" checked>
                        <label class="form-check-label" for="paymentCash">
                            Thanh toán khi nhận hàng (COD)
                        </label>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="orderNote" class="form-label text-sm">Ghi chú (Tùy chọn):</label>
                    <textarea class="form-control form-control-sm" id="orderNote" name="note" rows="2"></textarea>
                </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="submit" form="checkoutForm" class="btn btn-primary">Xác Nhận Thanh Toán</button>
          </div>
        </div>
      </div>
    </div>

    <%-- Checkout Success Modal --%>
    <div class="modal fade" id="checkoutSuccessModal" tabindex="-1" aria-labelledby="checkoutSuccessModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-success text-white">
            <h5 class="modal-title" id="checkoutSuccessModalLabel">Đặt Hàng Thành Công!</h5>
          </div>
          <div class="modal-body">
            Đơn hàng của bạn đã được đặt thành công. Cảm ơn quý khách!
            <c:if test="${not empty orderId}">
                <p class="mt-2">Mã đơn hàng của bạn: <strong>${orderId}</strong></p>
            </c:if>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" id="checkoutSuccessOkBtn">OK</button>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <%-- Scripts --%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    // Function to update the value of the quantity input and trigger change event
    function updateQuantityInput(cartID, delta) {
        const form = document.getElementById(`updateForm_${cartID}`);
        if (!form) {
            console.error("Form not found for cartID:", cartID);
            return;
        }

        const quantityInput = form.querySelector('input[name="soLuong"]');
        if (!quantityInput) {
             console.error("Quantity input not found in form for cartID:", cartID);
             return;
        }

        let currentValue = parseInt(quantityInput.value) || 1;
        let newValue = currentValue + delta;

        // Only proceed if new value is valid (1 or more)
        if (newValue >= 1) {
            quantityInput.value = newValue;
            // Submit the form immediately when button is clicked
            form.submit();
        } else if (newValue <= 0) {
            // If trying to reduce below 1, ask to remove item
            if (confirm('Bạn có muốn xóa sản phẩm này khỏi giỏ hàng không?')) {
                window.location.href = "${pageContext.request.contextPath}/cart/remove/" + cartID;
            }
        }
    }

    $(document).ready(function() {
        // Attach click handlers to the plus and minus buttons
        $('.minus-btn').on('click', function() {
             const cartID = $(this).closest('form').find('input[name="id"]').val();
             updateQuantityInput(cartID, -1);
         });

         $('.plus-btn').on('click', function() {
             const cartID = $(this).closest('form').find('input[name="id"]').val();
             updateQuantityInput(cartID, 1);
         });

        // Attach change handler to quantity inputs for manual changes
        $('.quantity-input').on('change', function() {
            // Get current value and ensure it's at least 1
            let currentValue = parseInt(this.value) || 1;
            if (currentValue < 1) {
                this.value = 1;
                currentValue = 1;
            }
            
            // Get the form and submit it
            const form = $(this).closest('form');
            form.submit();
        });

        // --- SCRIPT XỬ LÝ TOAST VÀ MODAL CHECKOUT SUCCESS ---
        // Toast notifications - JSTL checks are processed on server side
        // The output will be pure JS conditional blocks
        <c:if test="${not empty successMessage}">
             var successToast = new bootstrap.Toast($('#successToast'));
             successToast.show();
        </c:if>

        <c:if test="${not empty errorMessage}">
             var errorToast = new bootstrap.Toast($('#errorToast'));
             errorToast.show();
        </c:if>

        // Checkout success modal - JSTL check processed on server side
        <c:if test="${checkoutSuccess eq true}">
             var checkoutSuccessModal = new bootstrap.Modal($('#checkoutSuccessModal'));
             checkoutSuccessModal.show();

             // Use correct path derived from server
             const homepageUrl = "${pageContext.request.contextPath}/trangchu";

             $('#checkoutSuccessOkBtn').on('click', function() {
                 window.location.href = homepageUrl;
             });

             // Use correct path derived from server for hidden event
             $('#checkoutSuccessModal').on('hidden.bs.modal', function() {
                 window.location.href = homepageUrl;
             });
        </c:if>
        // --- END: SCRIPT XỬ LÝ TOAST VÀ MODAL CHECKOUT SUCCESS ---

    });
    </script>
</body>
</html>