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
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
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
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/orders">Đơn hàng của tôi</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Sản phẩm chờ đánh giá</li>
                    </ol>
                </nav>
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
                        <a href="${pageContext.request.contextPath}/user/review-eligible" class="list-group-item list-group-item-action active">
                            <i class="fas fa-star me-2"></i> Đánh giá sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">
                            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <h2 class="mb-4 fw-bold">Sản phẩm chờ đánh giá</h2>
                
                <div class="card shadow-sm">
                    <div class="card-body">
                        <p class="text-muted mb-4">
                            <i class="fas fa-info-circle me-2"></i> 
                            Đây là những sản phẩm bạn đã mua và đơn hàng đã được giao thành công. 
                            Đánh giá của bạn sẽ giúp những khách hàng khác có quyết định mua sắm tốt hơn.
                        </p>
                
                        <c:choose>
                            <c:when test="${not empty eligibleProducts}">
                                <div class="row g-4">
                                    <c:forEach var="product" items="${eligibleProducts}">
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card product-card h-100">
                                                <img src="${pageContext.request.contextPath}/imgs/${product.anhDaiDien}" 
                                                     class="card-img-top" alt="${product.tenPhuKien}"
                                                     style="height: 200px; object-fit: cover;">
                                                <div class="card-body">
                                                    <h5 class="card-title fw-bold">${product.tenPhuKien}</h5>
                                                    <p class="card-text text-secondary mb-2">${product.hangSanXuat}</p>
                                                    <p class="card-text text-danger fw-bold">
                                                        <fmt:formatNumber value="${product.gia}" type="currency" currencySymbol="" />đ
                                                    </p>
                                                </div>
                                                <div class="card-footer bg-white border-top-0">
                                                    <a href="${pageContext.request.contextPath}/user/write-review/${product.accessoryID}/${productToOrderMap[product.accessoryID]}" 
                                                       class="btn btn-primary w-100">
                                                        <i class="fas fa-star me-2"></i>Viết đánh giá
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-check-circle text-success mb-3" style="font-size: 3rem;"></i>
                                    <h4>Bạn đã đánh giá tất cả sản phẩm!</h4>
                                    <p class="text-muted">Hiện tại, bạn không có sản phẩm nào cần đánh giá.</p>
                                    <a href="${pageContext.request.contextPath}/accessories" class="btn btn-primary mt-3">
                                        <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
