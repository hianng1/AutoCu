<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  <!-- Thêm thư viện JSTL -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- forgot-password.jsp -->
<form action="/forgot-password" method="post">
    <label>Email:</label>
    <input type="email" name="email" required />
    <button type="submit">Gửi mật khẩu mới</button>
</form>
<p style="color:red">${message}</p>


</body>
</html>