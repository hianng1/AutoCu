<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - AutoCu</title>
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
                        <li class="breadcrumb-item active" aria-current="page">Đơn hàng của tôi</li>
                    </ol>
                </nav>
                
                <h2 class="mb-4"><i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi</h2>
                
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <ul class="nav nav-pills mb-4">
                    <li class="nav-item">
                        <a class="nav-link ${empty statusFilter ? 'active' : ''}" href="${pageContext.request.contextPath}/user/orders">
                            Tất cả <span class="badge bg-secondary ms-1">${fn:length(orders)}</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${statusFilter == 'CHO_XAC_NHAN' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/orders?status=CHO_XAC_NHAN">
                            Chờ xác nhận
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${statusFilter == 'DANG_XU_LY' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/orders?status=DANG_XU_LY">
                            Đang xử lý
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${statusFilter == 'DANG_GIAO' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/orders?status=DANG_GIAO">
                            Đang giao
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${statusFilter == 'DA_GIAO' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/orders?status=DA_GIAO">
                            Đã giao
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${statusFilter == 'DA_HUY' ? 'active' : ''}" href="${pageContext.request.contextPath}/user/orders?status=DA_HUY">
                            Đã hủy
                        </a>
                    </li>
                </ul>
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
                        <a href="${pageContext.request.contextPath}/user/orders" class="list-group-item list-group-item-action active">
                            <i class="fas fa-shopping-bag me-2"></i> Đơn hàng của tôi
                        </a>
                        <a href="${pageContext.request.contextPath}/reviews/user-reviews" class="list-group-item list-group-item-action">
                            <i class="fas fa-star me-2"></i> Đánh giá của tôi
                        </a>
                        <a href="${pageContext.request.contextPath}/user/review-eligible" class="list-group-item list-group-item-action">
                            <i class="fas fa-edit me-2"></i> Viết đánh giá
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-bag text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3">Bạn chưa có đơn hàng nào</h3>
                            <p class="text-muted">Hãy mua sắm để mang trải nghiệm tốt nhất về nhà bạn!</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">
                                <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="order-list">
                            <c:forEach var="order" items="${orders}">
                                <div class="card mb-4 order-card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <span>
                                            <strong>Mã đơn hàng:</strong> #${order.orderID}
                                        </span>
                                        <span class="badge ${order.trangThai == 'DA_GIAO' ? 'bg-success' : order.trangThai == 'DA_HUY' ? 'bg-danger' : 'bg-warning'}">
                                            ${order.trangThai.moTa}
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <p><strong><i class="far fa-calendar-alt me-2"></i>Ngày đặt:</strong> 
                                                    <fmt:formatDate value="${order.ngayDatHang}" pattern="dd/MM/yyyy HH:mm"/>
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-md-end">
                                                <p><strong><i class="fas fa-money-bill-wave me-2"></i>Tổng tiền:</strong> 
                                                    <span class="text-danger fw-bold">
                                                        <fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                        
                                        <div class="order-products mb-3">
                                            <c:forEach var="item" items="${order.chiTietDonHangs}" varStatus="status">
                                                <c:if test="${status.index < 3}">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <img src="${pageContext.request.contextPath}/imgs/${item.phuKienOto.anhDaiDien}" 
                                                             class="img-thumbnail me-3" style="width: 60px; height: 60px; object-fit: cover;" 
                                                             alt="${item.tenSanPham}">
                                                        <div>
                                                            <p class="mb-0">${item.tenSanPham}</p>
                                                            <p class="text-muted small mb-0">
                                                                <fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/> 
                                                                x ${item.soLuong}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            
                                            <c:if test="${fn:length(order.chiTietDonHangs) > 3}">
                                                <p class="text-muted small">+${fn:length(order.chiTietDonHangs) - 3} sản phẩm khác</p>
                                            </c:if>
                                        </div>
                                        
                                        <div class="d-flex flex-wrap gap-2">
                                            <a href="${pageContext.request.contextPath}/theodoidonhang/trangthai?orderid=${order.orderID}" 
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-info-circle me-1"></i>Chi tiết
                                            </a>
                                            
                                            <c:if test="${order.trangThai == 'CHO_XAC_NHAN' || order.trangThai == 'DANG_XU_LY'}">
                                                <a href="${pageContext.request.contextPath}/theodoidonhang/cancel?orderid=${order.orderID}" 
                                                   class="btn btn-outline-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')">
                                                    <i class="fas fa-times-circle me-1"></i>Hủy đơn hàng
                                                </a>
                                            </c:if>
                                            
                                            <c:if test="${order.trangThai == 'DA_GIAO'}">
                                                <a href="${pageContext.request.contextPath}/user/review-eligible" 
                                                   class="btn btn-outline-success btn-sm">
                                                    <i class="fas fa-star me-1"></i>Đánh giá
                                                </a>
                                                
                                                <a href="${pageContext.request.contextPath}/user/buy-again?orderid=${order.orderID}" 
                                                   class="btn btn-outline-info btn-sm">
                                                    <i class="fas fa-redo me-1"></i>Mua lại
                                                </a>
                                            </c:if>
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
