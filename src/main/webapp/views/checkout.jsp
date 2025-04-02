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
</html>