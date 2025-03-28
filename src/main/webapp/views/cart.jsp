<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.PhuKienOto" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>AutoCu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Bootstrap CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		crossorigin="anonymous">
	
	<!-- Font Awesome CSS -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
	    
    <style>
      .card:hover {
        transform: translateY(-5px);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      }
      .card-img-top {
	    width: 100%;
	    height: 180px; 
	    object-fit: cover;
	  }
	  img {
		  width: 100%;
		  height: 200px;
		  object-fit: cover; /* Giữ tỷ lệ ảnh */
		}
		button:hover {
		  transition: background-color 0.3s ease;
		}
    </style>
</head>
<body>
	<jsp:include page="/common/header.jsp" />
    <div class="container">
		<h2>List Products</h2>
		<div class="rows">
			<div class="col-sm-9">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Amount</th>
							<th></th>
						</tr>
					</thead>
					<tbody>

						<c:forEach var="item" items="${CART_ITEMS}">
    <tr>
        <td>${item.phuKienOto.accessoryID }</td>
        <td>${item.phuKienOto.tenPhuKien }</td>
        <td>${item.phuKienOto.gia}</td>
        <td>
            <form action="/cart/update" method="post">
                <input type="hidden" name="id" value="${item.phuKienOto.accessoryID }"/>
                <input name="soLuong" value="${item.soLuong}" 
                       onblur="this.form.submit()" style="width: 50px;">
            </form>
        </td>
        <td>${item.gia * item.soLuong}</td>
        <td>
            <a class="btn btn-primary btn-sm" 
               href="/cart/del/${item.phuKienOto.accessoryID }">Remove</a>
        </td>
    </tr>
</c:forEach>


					</tbody>
				</table>
				<p>Tổng Tiền:${TOTAL} đ</p>
				<hr />
				<a class="btn btn-primary btn-sm" href="/cart/clear">Clear
					Cart</a> <a class="btn btn-primary btn-sm" href="/trangchu">Add
					more</a>
			</div>
		</div>

	</div>
    <jsp:include page="/common/footer.jsp" />
</body>
</html>
