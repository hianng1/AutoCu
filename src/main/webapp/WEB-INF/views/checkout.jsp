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
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            color: #333;
        }
        h1 {
            color: #ee4d2d;
            font-size: 24px;
            margin-bottom: 20px;
        }
        h2 {
            font-size: 18px;
            margin: 15px 0 10px 0;
        }
        .section {
            background: #fff;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="tel"], textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #ee4d2d;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        .btn:hover {
            background-color: #e3381c;
        }
        .product-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .price-summary {
            text-align: right;
            margin-top: 15px;
            font-weight: bold;
        }
        .checkbox-group {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />
	<h1>Thanh Toán</h1>
    
    <div class="section">
        <h2>Thông Tin Nhận Hàng</h2>
        <div class="form-group">
            <label for="name">Họ và Tên</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="phone">Số Điện Thoại</label>
            <input type="tel" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="address">Địa Chỉ</label>
            <textarea id="address" name="address" rows="3" required></textarea>
        </div>
    </div>
    
    <div class="section">
        <h2>Sản Phẩm</h2>
        <div class="product-item">
            <div>
                <p>Bộ sofa chất lượng cao</p>
                <p>Loại: Xám tro</p>
            </div>
            <div>
                <p>¥132,998</p>
                <p>Số lượng: 1</p>
            </div>
        </div>
        
        <div class="price-summary">
            <p>Tổng tiền: <span style="color: #ee4d2d; font-size: 18px;">¥132,998</span></p>
        </div>
    </div>
    
    <div class="section">
        <h2>Phương Thức Vận Chuyển</h2>
        <select name="shipping" id="shipping">
            <option value="fast">Giao hàng nhanh (4-7 ngày)</option>
            <option value="standard">Giao hàng tiêu chuẩn (7-10 ngày)</option>
        </select>
    </div>
    
    <div class="section">
        <h2>Phương Thức Thanh Toán</h2>
        <div class="checkbox-group">
            <input type="radio" id="cod" name="payment" value="cod" checked>
            <label for="cod">Thanh toán khi nhận hàng (COD)</label>
        </div>
        <div class="checkbox-group">
            <input type="radio" id="bank" name="payment" value="bank">
            <label for="bank">Chuyển khoản ngân hàng</label>
        </div>
        <div class="checkbox-group">
            <input type="radio" id="card" name="payment" value="card">
            <label for="card">Thẻ tín dụng/ghi nợ</label>
        </div>
    </div>
    
    <button type="submit" class="btn">Đặt Hàng</button>
    

    <jsp:include page="/common/footer.jsp" />

</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu - Thanh toán</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
        }
        .checkout-container {
            max-width: 1200px;
            margin: 20px auto;
        }
        .checkout-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 20px;
        }
        .checkout-title {
            color: #d70018;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
        .total-price {
            color: #d70018;
            font-size: 18px;
            font-weight: 700;
        }
        .btn-checkout {
            background-color: #d70018;
            color: white;
            font-weight: 600;
            padding: 12px 0;
            width: 100%;
            border: none;
            border-radius: 4px;
        }
        .btn-checkout:hover {
            background-color: #b30012;
        }
        .form-control:focus {
            border-color: #d70018;
            box-shadow: 0 0 0 0.25rem rgba(215, 0, 24, 0.25);
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />
    
    <div class="container checkout-container">
        <div class="row">
            <div class="col-md-8">
                <div class="checkout-card">
                    <h2 class="checkout-title">Thông tin thanh toán</h2>
                    
                    <form id="checkoutForm" action="/checkout" method="post">
                        <div class="mb-4">
                            <h3 class="section-title">Thông tin khách hàng</h3>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fullName" class="form-label">Họ và tên</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${sessionScope.user.fullName}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${sessionScope.user.phoneNumber}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ nhận hàng</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required>${sessionScope.user.diaChi}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="note" class="form-label">Ghi chú (tùy chọn)</label>
                                <textarea class="form-control" id="note" name="note" rows="2"></textarea>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3 class="section-title">Phương thức vận chuyển</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="shippingMethod" 
                                       id="standardShipping" value="standard" checked>
                                <label class="form-check-label" for="standardShipping">
                                    Giao hàng tiêu chuẩn (3-5 ngày) - Miễn phí
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="shippingMethod" 
                                       id="fastShipping" value="fast">
                                <label class="form-check-label" for="fastShipping">
                                    Giao hàng nhanh (1-2 ngày) - 30.000đ
                                </label>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3 class="section-title">Phương thức thanh toán</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="cod" value="cod" checked>
                                <label class="form-check-label" for="cod">
                                    Thanh toán khi nhận hàng (COD)
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="bankTransfer" value="bank">
                                <label class="form-check-label" for="bankTransfer">
                                    Chuyển khoản ngân hàng
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="vnpay" value="vnpay">
                                <label class="form-check-label" for="vnpay">
                                    Ví điện tử VNPay
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="checkout-card">
                    <h2 class="checkout-title">Đơn hàng của bạn</h2>
                    
                    <div class="mb-3">
                        <c:forEach items="${cartItems}" var="item">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="d-flex align-items-center">
                                    <img src="${item.phuKienOto.hinhAnh}" alt="${item.phuKienOto.tenPhuKien}" 
                                         class="product-img me-3">
                                    <div>
                                        <h6 class="mb-0">${item.phuKienOto.tenPhuKien}</h6>
                                        <small class="text-muted">Số lượng: ${item.soLuong}</small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <fmt:formatNumber value="${item.phuKienOto.gia * item.soLuong}" 
                                                      type="currency" currencySymbol="₫" 
                                                      maxFractionDigits="0"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="border-top pt-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <span>
                                <fmt:formatNumber value="${subtotal}" type="currency" 
                                                  currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Phí vận chuyển:</span>
                            <span id="shippingFee">0₫</span>
                        </div>
                        <div class="d-flex justify-content-between fw-bold fs-5">
                            <span>Tổng cộng:</span>
                            <span class="total-price" id="totalPrice">
                                <fmt:formatNumber value="${subtotal}" type="currency" 
                                                  currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>
                    </div>
                    
                    <button type="submit" form="checkoutForm" class="btn btn-checkout mt-4">
                        ĐẶT HÀNG
                    </button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script>
        // Tính phí vận chuyển và cập nhật tổng tiền
        document.querySelectorAll('input[name="shippingMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const shippingFee = this.value === 'fast' ? 30000 : 0;
                const subtotal = ${subtotal};
                const total = subtotal + shippingFee;
                
                document.getElementById('shippingFee').textContent = 
                    shippingFee.toLocaleString('vi-VN', {style:'currency', currency:'VND'});
                
                document.getElementById('totalPrice').textContent = 
                    total.toLocaleString('vi-VN', {style:'currency', currency:'VND'});
            });
        });
        
        // Xử lý submit form
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            // Có thể thêm validation ở đây nếu cần
            if(!validateForm()) {
                e.preventDefault();
            }
        });
        
        function validateForm() {
            const fullName = document.getElementById('fullName').value;
            const phone = document.getElementById('phone').value;
            const address = document.getElementById('address').value;
            
            if(!fullName || !phone || !address) {
                alert('Vui lòng điền đầy đủ thông tin khách hàng');
                return false;
            }
            
            // Validate số điện thoại
            const phoneRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;
            if(!phone.match(phoneRegex)) {
                alert('Số điện thoại không hợp lệ');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>