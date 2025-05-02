<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.PhuKienOto" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Đổi mật khẩu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
      body {
        font-family: 'Roboto', sans-serif;
        background-color: #f8f9fa;
      }
      .form-container {
        min-height: 80vh;
      }
      .card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      }
      .form-group {
        position: relative;
      }
      .toggle-password {
        position: absolute;
        top: 50%;
        right: 15px;
        transform: translateY(-50%);
        cursor: pointer;
        color: #666;
      }
      .message {
        color: red;
        text-align: center;
        margin-top: 15px;
      }
    </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="container d-flex justify-content-center align-items-center form-container">
  <div class="col-md-6">
    <div class="card p-4">
      <h3 class="text-center mb-4">Đổi mật khẩu</h3>
      <form action="/change-password" method="post">
        <div class="mb-3 form-group">
          <label for="currentPassword">Mật khẩu hiện tại:</label>
          <input type="password" class="form-control" id="currentPassword" name="currentPassword" required />
          <i class="fas fa-eye toggle-password" onclick="togglePassword('currentPassword', this)"></i>
        </div>

        <div class="mb-3 form-group">
          <label for="newPassword">Mật khẩu mới:</label>
          <input type="password" class="form-control" id="newPassword" name="newPassword" required />
          <i class="fas fa-eye toggle-password" onclick="togglePassword('newPassword', this)"></i>
        </div>

        <input type="hidden" name="userId" value="${userId}" />

        <div class="d-grid">
          <button type="submit" class="btn btn-primary">Cập nhật mật khẩu</button>
        </div>
      </form>

      <c:if test="${not empty message}">
        <div class="message">${message}</div>
      </c:if>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script>
  function togglePassword(fieldId, icon) {
    const input = document.getElementById(fieldId);
    if (input.type === "password") {
      input.type = "text";
      icon.classList.remove("fa-eye");
      icon.classList.add("fa-eye-slash");
    } else {
      input.type = "password";
      icon.classList.remove("fa-eye-slash");
      icon.classList.add("fa-eye");
    }
  }
</script>

</body>
</html>
