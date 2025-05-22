<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng đã giao - AutoCu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/orders">Đơn hàng</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Đơn hàng đã giao</li>
                    </ol>
                </nav>
                
                <h2 class="mb-4"><i class="fas fa-check-circle me-2 text-success"></i>Đơn hàng đã giao</h2>
                
                <p class="text-muted">Dưới đây là danh sách những đơn hàng đã giao thành công. Bạn có thể đánh giá sản phẩm hoặc xem chi tiết.</p>
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
                        <a href="${pageContext.request.contextPath}/user/delivered-orders" class="list-group-item list-group-item-action active">
                            <i class="fas fa-check-circle me-2"></i> Đơn hàng đã giao
                        </a>
                        <a href="${pageContext.request.contextPath}/reviews/user-reviews" class="list-group-item list-group-item-action">
                            <i class="fas fa-star me-2"></i> Đánh giá của tôi
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <c:choose>
                    <c:when test="${empty deliveredOrders}">
                        <div class="text-center py-5">
                            <i class="fas fa-shipping-fast text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3">Không có đơn hàng nào đã giao</h3>
                            <p class="text-muted">Khi đơn hàng của bạn được giao thành công, chúng sẽ xuất hiện ở đây.</p>
                            <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-primary mt-3">
                                <i class="fas fa-shopping-bag me-2"></i>Xem tất cả đơn hàng
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="order-list">
                            <c:forEach var="order" items="${deliveredOrders}">
                                <div class="card mb-4 order-card border-success">
                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <span>
                                            <strong>Mã đơn hàng:</strong> #${order.orderID}
                                        </span>
                                        <span class="badge bg-success">
                                            Đã giao thành công
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <p><strong><i class="far fa-calendar-alt me-2"></i>Ngày đặt:</strong> 
                                                    <fmt:formatDate value="${order.ngayDatHang}" pattern="dd/MM/yyyy HH:mm"/>
                                                </p>
                                                <p><strong><i class="fas fa-calendar-check me-2"></i>Ngày giao:</strong> 
                                                    <fmt:formatDate value="${order.ngayCapNhat}" pattern="dd/MM/yyyy HH:mm"/>
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-md-end">
                                                <p><strong><i class="fas fa-money-bill-wave me-2"></i>Tổng tiền:</strong> 
                                                    <span class="text-success fw-bold">
                                                        <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </span>
                                                </p>
                                                <p><strong><i class="fas fa-map-marker-alt me-2"></i>Địa chỉ:</strong> 
                                                    <span class="text-truncate d-inline-block" style="max-width: 250px;">
                                                        ${order.diaChiGiaoHang}
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                        
                                        <div class="order-products mb-3">
                                            <h6><i class="fas fa-box-open me-2"></i>Sản phẩm</h6>
                                            <div class="row">
                                                <c:forEach var="item" items="${order.chiTietDonHangs}">
                                                    <div class="col-md-6 mb-2">
                                                        <div class="d-flex align-items-center">
                                                            <img src="${pageContext.request.contextPath}/imgs/${item.phuKienOto.anhDaiDien}" 
                                                                class="img-thumbnail me-3" style="width: 60px; height: 60px; object-fit: cover;" 
                                                                alt="${item.tenSanPham}">
                                                            <div>
                                                                <p class="mb-0 fw-bold">${item.tenSanPham}</p>
                                                                <p class="text-muted small mb-0">
                                                                    <fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/> 
                                                                    x ${item.soLuong}
                                                                </p>
                                                                <a href="${pageContext.request.contextPath}/reviews/write?productId=${item.phuKienOto.accessoryID}&orderId=${order.orderID}" 
                                                                    class="btn btn-sm btn-outline-warning mt-1">
                                                                    <i class="fas fa-star me-1"></i>Đánh giá
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex flex-wrap gap-2">
                                            <a href="${pageContext.request.contextPath}/theodoidonhang/trangthai?orderid=${order.orderID}" 
                                                class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-info-circle me-1"></i>Chi tiết
                                            </a>
                                            
                                            <a href="${pageContext.request.contextPath}/user/buy-again?orderid=${order.orderID}" 
                                                class="btn btn-outline-success btn-sm">
                                                <i class="fas fa-redo me-1"></i>Mua lại
                                            </a>
                                            
                                            <a href="${pageContext.request.contextPath}/user/review-eligible" 
                                                class="btn btn-outline-warning btn-sm">
                                                <i class="fas fa-star me-1"></i>Đánh giá sản phẩm
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination if needed -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/user/delivered-orders?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/user/delivered-orders?page=${i}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/user/delivered-orders?page=${currentPage + 1}" aria-label="Next">
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
