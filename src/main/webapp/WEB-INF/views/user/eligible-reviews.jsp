<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm chờ đánh giá - AutoCu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .product-image {
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp" />
    
    <div class="container py-5">
        <div class="row mb-4">
            <div class="col-md-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">Tài khoản</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Viết đánh giá</li>
                    </ol>
                </nav>
                
                <h2 class="mb-4"><i class="fas fa-edit me-2"></i>Sản phẩm chờ đánh giá</h2>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-3">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <i class="fas fa-user-circle me-2"></i> Tài khoản của tôi
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action">
                            <i class="fas fa-user me-2"></i> Thông tin tài khoản
                        </a>
                        <a href="${pageContext.request.contextPath}/user/orders" class="list-group-item list-group-item-action">
                            <i class="fas fa-shopping-bag me-2"></i> Đơn hàng của tôi
                        </a>
                        <a href="${pageContext.request.contextPath}/reviews/user-reviews" class="list-group-item list-group-item-action">
                            <i class="fas fa-star me-2"></i> Đánh giá của tôi
                        </a>
                        <a href="${pageContext.request.contextPath}/user/review-eligible" class="list-group-item list-group-item-action active">
                            <i class="fas fa-edit me-2"></i> Viết đánh giá
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <c:choose>
                    <c:when test="${empty eligibleProducts}">
                        <div class="text-center py-5">
                            <i class="fas fa-clipboard-list text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3">Không có sản phẩm nào cần đánh giá</h3>
                            <p class="text-muted">Bạn đã đánh giá tất cả sản phẩm đã mua hoặc chưa có sản phẩm nào được giao.</p>
                            <a href="${pageContext.request.contextPath}/user/orders?status=DA_GIAO" class="btn btn-primary mt-3">
                                <i class="fas fa-shopping-bag me-2"></i>Xem đơn hàng đã giao
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach var="product" items="${eligibleProducts}">
                                <div class="col">
                                    <div class="card h-100 product-card">
                                        <img src="${pageContext.request.contextPath}/imgs/${product.anhDaiDien}" 
                                             class="card-img-top product-image" alt="${product.tenPhuKien}">
                                        <div class="card-body">
                                            <h5 class="card-title">${product.tenPhuKien}</h5>
                                            <p class="card-text text-truncate">${product.moTa}</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${product.gia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                                <c:forEach var="order" items="${ordersByProduct[product.accessoryID]}">
                                                    <a href="${pageContext.request.contextPath}/reviews/write?productId=${product.accessoryID}&orderId=${order.orderID}" 
                                                       class="btn btn-primary btn-sm">
                                                        <i class="fas fa-star me-1"></i>Đánh giá
                                                    </a>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <small class="text-muted">Đã mua trong đơn hàng 
                                                <c:forEach var="order" items="${ordersByProduct[product.accessoryID]}" varStatus="status">
                                                    #${order.orderID}<c:if test="${!status.last}">, </c:if>
                                                </c:forEach>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <jsp:include page="/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
