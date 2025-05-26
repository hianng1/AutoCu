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
        .star-rating {
            color: #ffc107;
            font-size: 18px;
        }
        .star-rating .far {
            color: #e0e0e0;
        }
        .review-date {
            color: #6c757d;
            font-size: 0.85rem;
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
                        <a href="${pageContext.request.contextPath}/user/delivered-orders" class="list-group-item list-group-item-action">
                            <i class="fas fa-check-circle me-2"></i> Đơn hàng đã giao
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
                <h2 class="mb-4"><i class="fas fa-star me-2 text-warning"></i>Đánh giá của tôi</h2>
                
                <c:choose>
                    <c:when test="${empty reviews}">
                        <div class="text-center py-5">
                            <i class="fas fa-comment-slash text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3">Bạn chưa có đánh giá nào</h3>
                            <p class="text-muted">Hãy đánh giá sản phẩm để chia sẻ trải nghiệm của bạn với người khác.</p>
                            <a href="${pageContext.request.contextPath}/user/review-eligible" class="btn btn-primary mt-3">
                                <i class="fas fa-edit me-2"></i>Viết đánh giá ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row row-cols-1 g-4">
                            <c:forEach var="review" items="${reviews}">
                                <div class="col">
                                    <div class="card review-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3">
                                                <img src="${pageContext.request.contextPath}/imgs/${review.phuKienOto.anhDaiDien}" 
                                                    class="img-thumbnail me-3" style="width: 80px; height: 80px; object-fit: cover;" 
                                                    alt="${review.phuKienOto.tenPhuKien}">
                                                <div>
                                                    <h5 class="card-title mb-1">${review.phuKienOto.tenPhuKien}</h5>
                                                    <div class="star-rating">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when test="${i <= review.saoDanhGia}">
                                                                    <i class="fas fa-star"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="far fa-star"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                    <p class="review-date">
                                                        Đánh giá ngày: <fmt:formatDate value="${review.ngayDanhGia}" pattern="dd/MM/yyyy"/>
                                                    </p>
                                                </div>
                                            </div>
                                            
                                            <div class="border-top pt-3">
                                                <p class="card-text">${review.noiDung}</p>
                                            </div>
                                        </div>
                                        <div class="card-footer bg-white">
                                            <div class="d-flex justify-content-between">
                                                <small class="text-muted">Mã đơn hàng: #${review.donHang.orderID}</small>
                                                <div>
                                                    <a href="${pageContext.request.contextPath}/reviews/edit/${review.danhGiaID}" 
                                                       class="btn btn-sm btn-outline-primary me-2">
                                                        <i class="fas fa-edit me-1"></i>Chỉnh sửa
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/product/details/${review.phuKienOto.accessoryID}" 
                                                       class="btn btn-sm btn-outline-secondary">
                                                        <i class="fas fa-eye me-1"></i>Xem sản phẩm
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination if needed -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/reviews/user-reviews?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/reviews/user-reviews?page=${i}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/reviews/user-reviews?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <jsp:include page="/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
