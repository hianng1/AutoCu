<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${not empty sessionScope.loggedInUser}">
    <span>Xin chào: ${sessionScope.loggedInUser.username}</span>
    <a href="/change-password">Đổi mật khẩu</a>
</c:if>

</body>
</html>