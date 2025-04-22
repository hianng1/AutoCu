<%@ taglib uri="http://www.springframework.org/tags" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán</title>
</head>
<body>

<h1>Thanh toán đơn hàng</h1>

<form action="/don-hang/xu-ly-thanh-toan" method="post">
    <fieldset>
        <legend>Thông tin khách hàng</legend>
        <label for="hoTen">Họ tên:</label>
        <input type="text" id="hoTen" name="hoTen" value="${user.hovaten}" required><br>
        
        <label for="soDienThoai">Số điện thoại:</label>
        <input type="text" id="soDienThoai" name="soDienThoai" value="${user.sodienthoai}" required><br>
        
        <label for="diaChi">Địa chỉ:</label>
        <input type="text" id="diaChi" name="diaChi" value="${user.diaChi}" required><br>
        
        <label for="ghiChu">Ghi chú:</label>
        <textarea id="ghiChu" name="ghiChu"></textarea><br>
    </fieldset>

    <fieldset>
        <legend>Phương thức vận chuyển</legend>
        <label for="phuongThucVanChuyen">Chọn phương thức vận chuyển:</label>
        <select id="phuongThucVanChuyen" name="phuongThucVanChuyen">
            <option value="tiêu chuẩn">Tiêu chuẩn</option>
            <option value="nhanh">Nhanh</option>
        </select><br>
    </fieldset>

    <fieldset>
        <legend>Phương thức thanh toán</legend>
        <label for="phuongThucThanhToan">Chọn phương thức thanh toán:</label>
        <select id="phuongThucThanhToan" name="phuongThucThanhToan">
            <option value="COD">Thanh toán khi nhận hàng (COD)</option>
            <option value="thẻ">Thanh toán qua thẻ</option>
        </select><br>
    </fieldset>

    <h2>Chi tiết giỏ hàng</h2>
    <table>
        <thead>
            <tr>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${cartItems}">
                <tr>
                    <td>${item.phuKienOto.tenPhuKien}</td>
                    <td>${item.soLuong}</td>
                    <td>${item.donGia}</td>
                    <td>${item.soLuong * item.donGia}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <h3>Tổng tiền: ${totalAmount}</h3>

    <button type="submit">Xác nhận và thanh toán</button>
</form>

</body>
</html>
