<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá của tôi - AutoCu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .review-card {
            border-left: 4px solid #fd7e14;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .review-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
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
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">Tài khoản của tôi</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Đánh giá của tôi</li>
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
                        <a href="${pageContext.request.contextPath}/reviews/user-reviews" class="list-group-item list-group-item-action active">
                            <i class="fas fa-star me-2"></i> Đánh giá của tôi
                        </a>
                        <a href="${pageContext.request.contextPath}/user/review-eligible" class="list-group-item list-group-item-action">
                            <i class="fas fa-edit me-2"></i> Viết đánh giá
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">
                            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <h2 class="mb-4 fw-bold">Đánh giá của tôi</h2>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${success}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                    </div>
                </c:if>
                
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <p class="mb-0 text-muted">Tổng số đánh giá: <span class="fw-bold">${userReviews.size()}</span></p>
                    <a href="${pageContext.request.contextPath}/user/review-eligible" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-2"></i>Viết đánh giá mới
                    </a>
                </div>
                
                <c:choose>
                    <c:when test="${not empty userReviews}">
                        <div class="row">
                            <c:forEach var="review" items="${userReviews}">
                                <div class="col-md-12 mb-4">
                                    <div class="card review-card shadow-sm">
                                        <div class="card-body">
                                            <div class="d-flex mb-3">
                                                <div class="flex-shrink-0">
                                                    <img src="${pageContext.request.contextPath}/imgs/${review.phuKienOto.anhDaiDien}" 
                                                         alt="${review.phuKienOto.tenPhuKien}" class="img-fluid rounded" 
                                                         style="width: 80px; height: 80px; object-fit: cover;">
                                                </div>
                                                <div class="ms-3">
                                                    <h5 class="card-title mb-1">${review.phuKienOto.tenPhuKien}</h5>
                                                    <p class="text-muted small mb-2">${review.phuKienOto.hangSanXuat}</p>
                                                    <div class="mb-1">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star ${i <= review.saoDanhGia ? 'text-warning' : 'text-muted'}"></i>
                                                        </c:forEach>
                                                        <span class="text-muted ms-2 small">
                                                            <fmt:formatDate value="${review.ngayDanhGia}" pattern="dd/MM/yyyy" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <p class="card-text mb-0">${review.noiDung}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center p-5 bg-light rounded">
                            <i class="fas fa-star text-muted mb-3" style="font-size: 3rem;"></i>
                            <h3 class="mb-3">Bạn chưa có đánh giá nào!</h3>
                            <p class="text-muted mb-4">Hãy mua sắm và đánh giá các sản phẩm để chia sẻ trải nghiệm của bạn.</p>
                            <div>
                                <a href="${pageContext.request.contextPath}/accessories" class="btn btn-primary me-2">
                                    <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                                </a>
                                <a href="${pageContext.request.contextPath}/user/review-eligible" class="btn btn-outline-primary">
                                    <i class="fas fa-edit me-2"></i>Kiểm tra sản phẩm có thể đánh giá
                                </a>
                            </div>
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
