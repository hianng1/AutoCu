<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.Wishlist" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AutoCu - Danh sách yêu thích</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: "Roboto", sans-serif;
            background-color: #f8f9fa;
        }

        .wishlist-item {
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            overflow: hidden;
            background: white;
        }

        .wishlist-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .wishlist-item:hover .product-image {
            transform: scale(1.05);
        }

        .wishlist-tabs .nav-link {
            border: none;
            border-radius: 25px;
            margin: 0 5px;
            padding: 10px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .wishlist-tabs .nav-link.active {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }

        .wishlist-tabs .nav-link:not(.active) {
            background-color: #f8f9fa;
            color: #6c757d;
        }

        .wishlist-tabs .nav-link:hover:not(.active) {
            background-color: #e9ecef;
            color: #495057;
        }

        .remove-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .wishlist-item:hover .remove-btn {
            opacity: 1;
        }

        .remove-btn:hover {
            background: #dc3545;
            transform: scale(1.1);
        }

        .empty-wishlist {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .empty-wishlist i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .price-tag {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            display: inline-block;
        }

        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(0, 123, 255, 0.9);
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
        }

        /* Mobile Responsive Improvements */
        @media (max-width: 768px) {
            .wishlist-tabs {
                flex-direction: column;
                gap: 10px;
            }

            .wishlist-tabs .nav-link {
                margin: 0;
                text-align: center;
            }

            .product-image {
                height: 180px;
            }

            .wishlist-item {
                margin-bottom: 20px;
            }

            .remove-btn {
                opacity: 1;
                background: rgba(220, 53, 69, 0.8);
            }

            .container {
                padding: 0 15px;
            }

            h1 {
                font-size: 1.5rem;
            }

            .btn {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .product-image {
                height: 150px;
            }

            .card-body {
                padding: 15px;
            }

            .price-tag {
                font-size: 0.85rem;
                padding: 3px 12px;
            }

            .wishlist-tabs .nav-link {
                padding: 8px 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="/common/header.jsp" />

    <!-- Toast Container -->
    <div class="toast-container">
        <div id="wishlistToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-heart text-danger me-2"></i>
                <strong class="me-auto">Danh sách yêu thích</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage">
                <!-- Message will be inserted here -->
            </div>
        </div>
    </div>

    <div class="container mt-4 mb-5">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                    <div class="mb-3 mb-md-0">
                        <h1 class="text-primary mb-2">
                            <i class="fas fa-heart me-2"></i>Danh sách yêu thích
                        </h1>
                        <p class="text-muted mb-0">Quản lý các sản phẩm bạn quan tâm</p>
                    </div>
                    <div class="d-flex gap-2">
                        <% if (request.getAttribute("totalCount") != null && ((Long) request.getAttribute("totalCount")) > 0) { %>
                        <button class="btn btn-outline-danger" onclick="clearWishlist()">
                            <i class="fas fa-trash me-2"></i>Xóa tất cả
                        </button>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                            <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Wishlist Tabs -->
        <div class="row mb-4">
            <div class="col-12">
                <ul class="nav nav-pills wishlist-tabs d-flex justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link ${activeType == 'all' ? 'active' : ''}" 
                           href="${pageContext.request.contextPath}/wishlist?type=all">
                            <i class="fas fa-heart me-2"></i>Tất cả 
                            <span class="badge bg-light text-dark ms-1">${totalCount}</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activeType == 'XE' ? 'active' : ''}" 
                           href="${pageContext.request.contextPath}/wishlist?type=XE">
                            <i class="fas fa-car me-2"></i>Xe cũ 
                            <span class="badge bg-light text-dark ms-1">${carCount}</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activeType == 'PHUKIEN' ? 'active' : ''}" 
                           href="${pageContext.request.contextPath}/wishlist?type=PHUKIEN">
                            <i class="fas fa-cog me-2"></i>Phụ kiện 
                            <span class="badge bg-light text-dark ms-1">${accessoryCount}</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Wishlist Content -->
        <div class="row">
            <% 
            List<Wishlist> wishlistItems = (List<Wishlist>) request.getAttribute("wishlistItems");
            if (wishlistItems != null && !wishlistItems.isEmpty()) {
                NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
                for (Wishlist item : wishlistItems) {
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 col-12 mb-4">
                <div class="wishlist-item position-relative">
                    <!-- Remove button -->
                    <button class="remove-btn" onclick="removeFromWishlist(<%= item.getWishlistID() %>)" 
                            title="Xóa khỏi danh sách yêu thích">
                        <i class="fas fa-times"></i>
                    </button>

                    <!-- Product Image -->
                    <div class="position-relative overflow-hidden">
                        <% if ("XE".equals(item.getLoaiSanPham()) && item.getSanPham() != null) { %>
                            <span class="product-badge">Xe cũ</span>
                            <img src="${pageContext.request.contextPath}/imgs/<%= item.getSanPham().getAnhDaiDien() %>" 
                                 alt="<%= item.getSanPham().getTenSanPham() %>" 
                                 class="product-image">
                        <% } else if ("PHUKIEN".equals(item.getLoaiSanPham()) && item.getPhuKienOto() != null) { %>
                            <span class="product-badge">Phụ kiện</span>
                            <img src="${pageContext.request.contextPath}/imgs/<%= item.getPhuKienOto().getAnhDaiDien() %>" 
                                 alt="<%= item.getPhuKienOto().getTenPhuKien() %>" 
                                 class="product-image">
                        <% } %>
                    </div>

                    <!-- Product Info -->
                    <div class="card-body p-3">
                        <% if ("XE".equals(item.getLoaiSanPham()) && item.getSanPham() != null) { %>
                            <h5 class="card-title text-truncate mb-2">
                                <%= item.getSanPham().getTenSanPham() %>
                            </h5>
                            <p class="text-muted small mb-2">
                                <i class="fas fa-car me-1"></i><%= item.getSanPham().getHangXe() %> • 
                                <i class="fas fa-calendar me-1"></i><%= item.getSanPham().getNgaySanXuat() != null ? 
                                    new java.text.SimpleDateFormat("yyyy").format(item.getSanPham().getNgaySanXuat()) : "N/A" %>
                            </p>

                        <% } else if ("PHUKIEN".equals(item.getLoaiSanPham()) && item.getPhuKienOto() != null) { %>
                            <h5 class="card-title text-truncate mb-2">
                                <%= item.getPhuKienOto().getTenPhuKien() %>
                            </h5>
                            <p class="text-muted small mb-2">
                                <i class="fas fa-industry me-1"></i><%= item.getPhuKienOto().getHangSanXuat() %>
                                <% if (item.getPhuKienOto().getSoLuong() > 0) { %>
                                    • <span class="text-success"><i class="fas fa-check me-1"></i>Còn hàng</span>
                                <% } else { %>
                                    • <span class="text-danger"><i class="fas fa-times me-1"></i>Hết hàng</span>
                                <% } %>
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="price-tag">
                                    <%= currencyFormat.format(item.getPhuKienOto().getGia()) %> VNĐ
                                </span>
                                <div class="btn-group btn-group-sm">
                                    <a href="${pageContext.request.contextPath}/accessories/<%= item.getPhuKienOto().getAccessoryID() %>" 
                                       class="btn btn-outline-primary">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <% if (item.getPhuKienOto().getSoLuong() > 0) { %>
                                    <button class="btn btn-primary" 
                                            onclick="addToCart(<%= item.getPhuKienOto().getAccessoryID() %>)">
                                        <i class="fas fa-cart-plus"></i>
                                    </button>
                                    <% } %>
                                </div>
                            </div>
                        <% } %>
                        
                        <div class="mt-2">
                            <small class="text-muted">
                                <i class="fas fa-clock me-1"></i>
                                Thêm ngày <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(item.getNgayThem()) %>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                }
            } else {
            %>
            <!-- Empty Wishlist -->
            <div class="col-12">
                <div class="empty-wishlist">
                    <i class="fas fa-heart-broken"></i>
                    <h3>Danh sách yêu thích trống</h3>
                    <p class="mb-4">Bạn chưa có sản phẩm nào trong danh sách yêu thích.</p>
                    <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                            <i class="fas fa-car me-2"></i>Xem xe cũ
                        </a>
                        <a href="${pageContext.request.contextPath}/accessories" class="btn btn-outline-primary">
                            <i class="fas fa-cog me-2"></i>Xem phụ kiện
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toast functionality
        function showToast(message, type = 'info') {
            const toast = document.getElementById('wishlistToast');
            const toastBody = document.getElementById('toastMessage');
            const toastInstance = new bootstrap.Toast(toast);
            
            toastBody.textContent = message;
            
            // Update toast style based on type
            toast.className = 'toast';
            if (type === 'success') {
                toast.classList.add('text-bg-success');
            } else if (type === 'error') {
                toast.classList.add('text-bg-danger');
            } else {
                toast.classList.add('text-bg-info');
            }
            
            toastInstance.show();
        }

        // Remove item from wishlist
        function removeFromWishlist(wishlistId) {
            if (!confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích?')) {
                return;
            }

            fetch(`${window.location.origin}/wishlist/remove/${wishlistId}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast(data.message, 'success');
                    // Reload page to update the list
                    setTimeout(() => {
                        window.location.reload();
                    }, 1000);
                } else {
                    showToast(data.message, 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('Có lỗi xảy ra khi xóa sản phẩm', 'error');
            });
        }

        // Clear all wishlist items
        function clearWishlist() {
            if (!confirm('Bạn có chắc chắn muốn xóa tất cả sản phẩm khỏi danh sách yêu thích?')) {
                return;
            }

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/wishlist/clear';
            document.body.appendChild(form);
            form.submit();
        }

        // Add to cart function (for accessories)
        function addToCart(accessoryId) {
            fetch(`${window.location.origin}/cart/add`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: `accessoryId=${accessoryId}&quantity=1`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast('Đã thêm vào giỏ hàng', 'success');
                    // Update cart count if available
                    updateCartCount();
                } else {
                    showToast(data.message || 'Có lỗi xảy ra', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('Có lỗi xảy ra khi thêm vào giỏ hàng', 'error');
            });
        }

        // Update cart count
        function updateCartCount() {
            fetch(`${window.location.origin}/cart/count`)
            .then(response => response.json())
            .then(data => {
                const cartCountElement = document.querySelector('.cart-count');
                if (cartCountElement && data.count !== undefined) {
                    cartCountElement.textContent = data.count;
                }
            })
            .catch(error => console.error('Error updating cart count:', error));
        }

        // Show success/error messages from server
        <% if (request.getAttribute("success") != null) { %>
            showToast('<%= request.getAttribute("success") %>', 'success');
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            showToast('<%= request.getAttribute("error") %>', 'error');
        <% } %>
    </script>
</body>
</html>
