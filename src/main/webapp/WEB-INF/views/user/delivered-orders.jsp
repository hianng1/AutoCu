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
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/orders">Đơn hàng của tôi</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Đơn hàng đã giao</li>
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
                        <a href="${pageContext.request.contextPath}/user/orders" class="list-group-item list-group-item-action active">
                            <i class="fas fa-shopping-bag me-2"></i> Đơn hàng của tôi
                        </a>
                        <a href="${pageContext.request.contextPath}/user/review-eligible" class="list-group-item list-group-item-action">
                            <i class="fas fa-star me-2"></i> Đánh giá sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">
                            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0 fw-bold">Đơn hàng đã giao</h2>
                    <a href="${pageContext.request.contextPath}/user/review-eligible" class="btn btn-outline-primary">
                        <i class="fas fa-star me-2"></i>Viết đánh giá sản phẩm
                    </a>
                </div>
                
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="card shadow-sm mb-4">
                                <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                    <span>
                                        <strong>Mã đơn hàng:</strong> #${order.orderID}
                                    </span>
                                    <span class="badge bg-success">Đã giao</span>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <p class="mb-1"><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.ngayDatHang}" pattern="dd/MM/yyyy HH:mm" /></p>
                                            <p class="mb-1"><strong>Phương thức thanh toán:</strong> ${order.phuongThucThanhToan}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <p class="mb-1"><strong>Địa chỉ giao hàng:</strong> ${order.diaChiGiaoHang}</p>
                                            <p class="mb-1"><strong>Trạng thái thanh toán:</strong> ${order.daThanhToan ? 'Đã thanh toán' : 'Chưa thanh toán'}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead class="table-light">
                                                <tr>
                                                    <th scope="col">Sản phẩm</th>
                                                    <th scope="col" class="text-center">Số lượng</th>
                                                    <th scope="col" class="text-end">Đơn giá</th>
                                                    <th scope="col" class="text-end">Thành tiền</th>
                                                    <th scope="col" class="text-center">Đánh giá</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${order.chiTietDonHangs}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <c:if test="${item.phuKienOto != null}">
                                                                    <img src="${pageContext.request.contextPath}/imgs/${item.phuKienOto.anhDaiDien}" 
                                                                        alt="${item.tenSanPham}" class="me-2" style="width: 50px; height: 50px; object-fit: cover;">
                                                                </c:if>
                                                                <div>
                                                                    <p class="mb-0 fw-medium">${item.tenSanPham}</p>
                                                                    <small class="text-muted">SKU: ${item.phuKienOto != null ? item.phuKienOto.accessoryID : 'N/A'}</small>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="text-center">${item.soLuong}</td>
                                                        <td class="text-end"><fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="" />đ</td>
                                                        <td class="text-end"><fmt:formatNumber value="${item.thanhTien}" type="currency" currencySymbol="" />đ</td>
                                                        <td class="text-center">
                                                            <c:choose>
                                                                <c:when test="${item.phuKienOto != null && reviewedProductMap[item.phuKienOto.accessoryID]}">
                                                                    <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Đã đánh giá</span>
                                                                </c:when>
                                                                <c:when test="${item.phuKienOto != null}">
                                                                    <a href="${pageContext.request.contextPath}/user/write-review/${item.phuKienOto.accessoryID}/${order.orderID}" 
                                                                       class="btn btn-sm btn-outline-primary">
                                                                        <i class="fas fa-star me-1"></i>Đánh giá
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">Không khả dụng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot class="table-light">
                                                <tr>
                                                    <td colspan="3" class="text-end"><strong>Phí vận chuyển:</strong></td>
                                                    <td class="text-end"><fmt:formatNumber value="${order.phiVanChuyen}" type="currency" currencySymbol="" />đ</td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" class="text-end"><strong>Tổng tiền:</strong></td>
                                                    <td class="text-end fw-bold"><fmt:formatNumber value="${order.tongThanhToan}" type="currency" currencySymbol="" />đ</td>
                                                    <td></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-shopping-bag text-muted mb-3" style="font-size: 3rem;"></i>
                                <h4>Bạn chưa có đơn hàng nào đã giao</h4>
                                <p class="text-muted">Khi đơn hàng của bạn được giao thành công, chúng sẽ xuất hiện ở đây.</p>
                                <a href="${pageContext.request.contextPath}/accessories" class="btn btn-primary mt-3">
                                    <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
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
