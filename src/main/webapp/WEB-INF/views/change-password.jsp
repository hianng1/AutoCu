<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  <!-- Thêm thư viện JSTL -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
</head>
<body>
   <h2>Đổi mật khẩu</h2>

<!-- form đổi mật khẩu -->
<form action="/change-password" method="post">
    <label for="currentPassword">Mật khẩu hiện tại:</label>
    <input type="password" id="currentPassword" name="currentPassword" required />

    <label for="newPassword">Mật khẩu mới:</label>
    <input type="password" id="newPassword" name="newPassword" required />

    <!-- Id người dùng được truyền từ Controller -->
    <input type="hidden" name="userId" value="${userId}" />

    <button type="submit">Cập nhật mật khẩu</button>
</form>

<!-- Hiển thị thông báo nếu có -->
<c:if test="${not empty message}">
    <div class="message">${message}</div>
</c:if>


</body>
</html>
