<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${phuKien.tenPhuKien} - AutoCu Phụ Kiện</title>

    <!-- CSS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #fd7e14;
            --secondary-color: #343a40;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-bg: #212529;
            --text-color: #343a40;
            --light-text: #6c757d;
            --border-color: #dee2e6;
        }
        
        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--light-bg);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .breadcrumb-section {
            background-color: white;
            padding: 12px 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        
        .breadcrumb-item a {
            color: var(--light-text);
            text-decoration: none;
            transition: color 0.2s;
        }
        
        .breadcrumb-item a:hover {
            color: var(--primary-color);
        }
        
        .breadcrumb-item.active {
            color: var(--primary-color);
        }
        
        .product-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--secondary-color);
        }
        
        .product-price {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 1.5rem;
        }
        
        .gallery-container {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .main-image-container {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: 400px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: white;
        }
        
        .main-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            transition: transform 0.5s;
        }
        
        .main-image:hover {
            transform: scale(1.05);
        }
        
        .spec-table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .spec-table th {
            background-color: #f8f9fa;
            color: var(--secondary-color);
            font-weight: 600;
        }
        
        .spec-row {
            transition: background-color 0.2s;
        }
        
        .spec-row:hover {
            background-color: #f8f9fa;
        }
        
        .spec-label {
            font-weight: 500;
            color: var(--secondary-color);
        }
        
        .spec-value {
            color: var(--text-color);
        }
        
        .contact-box {
            background-color: #fff8f0;
            border: 1px solid rgba(253, 126, 20, 0.2);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.04);
        }
        
        .contact-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: rgba(253, 126, 20, 0.1);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-right: 15px;
        }
        
        .description-box {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-top: 30px;
        }
        
        .description-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .description-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .description-content {
            color: var(--text-color);
            line-height: 1.8;
        }
        
        .similar-products-section {
            margin-top: 40px;
            padding: 30px 0;
            background-color: white;
        }
        
        .similar-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        
        .similar-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .card-similar {
            border: none;
            border-radius: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
            overflow: hidden;
            height: 100%;
        }
        
        .card-similar:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .card-similar .card-img-top {
            height: 160px;
            object-fit: cover;
        }
        
        .card-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: var(--accent-color);
            color: white;
            font-size: 0.8rem;
            font-weight: 500;
            padding: 3px 8px;
            border-radius: 20px;
        }
        
        .btn-primary-custom {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
            transition: background-color 0.2s, transform 0.2s;
            border-radius: 50px;
            padding: 10px 20px;
        }
        
        .btn-primary-custom:hover {
            background-color: #e96b02;
            border-color: #e96b02;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(253, 126, 20, 0.2);
        }
        
        .btn-outline-custom {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            background-color: transparent;
            transition: all 0.2s;
            border-radius: 50px;
            padding: 8px 15px;
        }
        
        .btn-outline-custom:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            border-radius: 25px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            width: fit-content;
        }
        
        .quantity-btn {
            border: none;
            background-color: #f8f9fa;
            width: 40px;
            height: 40px;
            font-size: 1.25rem;
        }
        
        .quantity-input {
            width: 60px;
            text-align: center;
            border: none;
            background-color: white;
            font-weight: 500;
            height: 40px;
        }
        
        .rating-stars {
            color: #ffc107;
            font-size: 1.1rem;
        }
        
        .stock-status {
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.875rem;
            display: inline-block;
            margin-bottom: 1rem;
        }
        
        .in-stock {
            background-color: #d4edda;
            color: #155724;
        }
        
        .low-stock {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .out-of-stock {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .accent-box {
            border-left: 4px solid var(--primary-color);
            background-color: #fff8f0;
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }
    </style>
</head>

<body>
<jsp:include page="/common/header.jsp" />

<!-- Breadcrumb Navigation -->
<div class="breadcrumb-section">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/accessories">Phụ kiện ô tô</a></li>
                <li class="breadcrumb-item active" aria-current="page">${phuKien.tenPhuKien}</li>
            </ol>
        </nav>
    </div>
</div>

<div class="container py-4">
    <!-- Tiêu đề và giá -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h1 class="product-title">${phuKien.tenPhuKien}</h1>
            <div class="d-flex align-items-center mb-3">                <div class="rating-stars me-2">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= phuKien.trungBinhSao}">
                                <i class="fas fa-star"></i>
                            </c:when>
                            <c:when test="${i <= phuKien.trungBinhSao + 0.5}">
                                <i class="fas fa-star-half-alt"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="far fa-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <span class="text-muted">(${phuKien.soLuongDanhGia} đánh giá)</span>
            </div>
        </div>
        <div class="col-md-4 text-md-end">
            <h2 class="product-price">
                <fmt:formatNumber value="${phuKien.gia}" pattern="#,##0" /> ₫
            </h2>
        </div>
    </div>

    <div class="row">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-md-6 mb-4">
            <div class="gallery-container">
                <div class="main-image-container">
                    <img src="<c:url value='/imgs/${phuKien.anhDaiDien}' />" class="main-image" id="mainImage" alt="${phuKien.tenPhuKien}">
                </div>
            </div>
            
            <!-- Thêm vào giỏ hàng -->
            <div class="mt-4">
                <c:choose>
                    <c:when test="${phuKien.soLuong > 10}">
                        <div class="stock-status in-stock mb-3">
                            <i class="fas fa-check-circle me-1"></i> Còn hàng
                        </div>
                    </c:when>
                    <c:when test="${phuKien.soLuong > 0}">
                        <div class="stock-status low-stock mb-3">
                            <i class="fas fa-exclamation-circle me-1"></i> Còn ${phuKien.soLuong} sản phẩm
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="stock-status out-of-stock mb-3">
                            <i class="fas fa-times-circle me-1"></i> Hết hàng
                        </div>
                    </c:otherwise>
                </c:choose>
                  <c:choose>
                    <c:when test="${phuKien.soLuong > 0}">
                        <form action="${pageContext.request.contextPath}/cart/add/${phuKien.accessoryID}" method="post" class="mb-3">
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <label for="quantity" class="form-label mb-0 fw-bold">Số lượng:</label>
                                <div class="quantity-control">
                                    <button type="button" class="quantity-btn" onclick="decrementQuantity()">-</button>
                                    <input type="number" id="quantity" name="quantity" class="quantity-input" value="1" min="1" max="${phuKien.soLuong}">
                                    <button type="button" class="quantity-btn" onclick="incrementQuantity()">+</button>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary-custom">
                                    <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ hàng
                                </button>
                                <button type="button" class="btn btn-outline-custom add-to-wishlist" data-id="${phuKien.accessoryID}" data-type="accessory">
                                    <i class="far fa-heart"></i>
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-3">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-secondary" disabled>
                                    <i class="fas fa-ban me-2"></i> Hết hàng
                                </button>
                                <button type="button" class="btn btn-outline-custom add-to-wishlist" data-id="${phuKien.accessoryID}" data-type="accessory">
                                    <i class="far fa-heart"></i>
                                </button>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Contact Box -->
            <div class="contact-box mt-4">
                <div class="row">
                    <div class="col-md-6 mb-3 mb-md-0">
                        <div class="d-flex align-items-center">
                            <div class="contact-icon">
                                <i class="fas fa-phone-alt"></i>
                            </div>
                            <div>
                                <h6 class="mb-1 fw-bold">Gọi ngay</h6>
                                <p class="mb-0">0988.888.888</p>
                                <small class="text-muted">Zalo cùng số</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-center">
                            <div class="contact-icon">
                                <i class="fab fa-facebook-messenger"></i>
                            </div>
                            <div>
                                <h6 class="mb-1 fw-bold">Chat ngay</h6>
                                <p class="mb-0">AUTOCU</p>
                                <small class="text-muted">Hỗ trợ 24/7</small>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <a href="${pageContext.request.contextPath}/support" class="btn btn-primary-custom w-100">
                            <i class="fas fa-headset me-2"></i> Yêu cầu tư vấn
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Thông số kỹ thuật -->
        <div class="col-md-6">
            <div class="card spec-table border-0 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0 fw-bold"><i class="fas fa-clipboard-list me-2 text-primary"></i>Thông tin sản phẩm</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <tbody>
                            <tr class="spec-row">
                                <td width="40%" class="spec-label">Hãng sản xuất</td>
                                <td class="spec-value">${phuKien.hangSanXuat}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Danh mục</td>
                                <td class="spec-value">${phuKien.danhMuc.tenDanhMuc}</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Còn hàng</td>
                                <td class="spec-value">${phuKien.soLuong} sản phẩm</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Bảo hành</td>
                                <td class="spec-value">12 tháng</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Đổi trả</td>
                                <td class="spec-value">30 ngày đổi trả miễn phí</td>
                            </tr>
                            <tr class="spec-row">
                                <td class="spec-label">Vận chuyển</td>
                                <td class="spec-value">Miễn phí vận chuyển nội thành</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Thông tin thêm -->
            <div class="accent-box mt-4">
                <h6 class="fw-bold mb-2"><i class="fas fa-shield-alt me-2"></i>Cam kết chất lượng</h6>
                <p class="mb-0">Sản phẩm chính hãng 100%, được kiểm tra kỹ lưỡng trước khi giao hàng. Hoàn tiền 100% nếu phát hiện hàng giả, hàng nhái.</p>
            </div>
            
            <!-- Chính sách -->
            <div class="accent-box">
                <h6 class="fw-bold mb-2"><i class="fas fa-truck me-2"></i>Giao hàng & Lắp đặt</h6>
                <p class="mb-0">Giao hàng toàn quốc. Miễn phí lắp đặt tại các trung tâm AutoCu hoặc đối tác được ủy quyền.</p>
            </div>
            
            <!-- Chia sẻ -->
            <div class="mt-4">
                <p class="fw-bold mb-2">Chia sẻ sản phẩm:</p>
                <div class="d-flex gap-2">
                    <a href="#" class="btn btn-outline-primary btn-sm"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="btn btn-outline-info btn-sm"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="btn btn-outline-danger btn-sm"><i class="fab fa-pinterest"></i></a>
                    <a href="#" class="btn btn-outline-success btn-sm"><i class="fab fa-whatsapp"></i></a>
                </div>
            </div>
        </div>
    </div>

    <!-- Mô tả sản phẩm -->
    <div class="description-box">
        <h2 class="description-title">Thông tin chi tiết</h2>
        <div class="description-content">
            ${phuKien.moTa}
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Quantity control
    function incrementQuantity() {
        const input = document.getElementById('quantity');
        const max = parseInt(input.getAttribute('max'));
        const currentValue = parseInt(input.value);
        
        if (currentValue < max) {
            input.value = currentValue + 1;
        }
    }
    
    function decrementQuantity() {
        const input = document.getElementById('quantity');
        const currentValue = parseInt(input.value);
        
        if (currentValue > 1) {
            input.value = currentValue - 1;
        }
    }
    
    // Wishlist functionality
    document.addEventListener('DOMContentLoaded', function() {
        const wishlistBtns = document.querySelectorAll('.add-to-wishlist');
        
        wishlistBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                const type = this.getAttribute('data-type');
                
                // AJAX call to add to wishlist
                fetch(`${pageContext.request.contextPath}/api/wishlist/toggle`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        accessoryId: id,
                        productType: 'ACCESSORY'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Toggle heart icon
                        const icon = this.querySelector('i');
                        if (data.added) {
                            icon.classList.remove('far');
                            icon.classList.add('fas');
                            icon.classList.add('text-danger');
                        } else {
                            icon.classList.remove('fas');
                            icon.classList.remove('text-danger');
                            icon.classList.add('far');
                        }
                        
                        // Show toast or notification
                        alert(data.message);
                    } else {
                        // Handle error
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            });
        });
    });
</script>
</body>
</html>
