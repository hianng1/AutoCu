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
    <title>Gửi mail</title>
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
        min-height: 70vh;
      }
      .card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      }
    </style>
</head>
<body>
  <jsp:include page="/common/header.jsp" />

  <div class="container d-flex justify-content-center align-items-center form-container">
    <div class="col-md-6">
      <div class="card p-4">
        <h3 class="text-center mb-4">Quên mật khẩu</h3>
        <form action="/forgot-password" method="post">
          <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required />
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-primary">Gửi mật khẩu mới</button>
          </div>
        </form>
        <c:if test="${not empty message}">
          <p class="text-danger mt-3 text-center">${message}</p>
        </c:if>
      </div>
    </div>
  </div>

  <jsp:include page="/common/footer.jsp" />
</body>
</html>
