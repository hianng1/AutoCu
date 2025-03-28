<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    
    <!-- External Resources -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    
    <style>
        .card-hover-effect {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-hover-effect:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .price-text {
            color: #dc3545;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .section-divider {
            width: 15%;
            height: 1px;
            background-color: #e5e7eb;
        }
    </style>
</head>
<body class="font-roboto bg-gray-50">
    <jsp:include page="/common/header.jsp" />

    <!-- Hero Section -->
    <section class="relative h-[80vh] flex items-center justify-center">
        <div class="absolute inset-0">
            <img src="/imgs/car1.avif" alt="Hero Background" class="w-full h-full object-cover">
            <div class="absolute inset-0 bg-black/50"></div>
        </div>
        
        <div class="relative z-10 text-center text-white px-4 max-w-4xl">
            <h1 class="text-4xl md:text-5xl font-bold mb-6 drop-shadow-lg">
                Tìm kiếm chiếc xe yêu thích của bạn<br>
                & trải nghiệm ngay hôm nay
            </h1>
            <p class="text-lg md:text-xl text-orange-200 mb-8 drop-shadow-lg">
                Khám phá bộ sưu tập đa dạng từ xe bình dân đến hạng sang cùng các phụ kiện chính hãng
            </p>
            <a href="#cars-section" class="btn btn-outline-light px-8 py-3 rounded-lg hover:bg-white/10 transition">
                Khám phá ngay
            </a>
        </div>
    </section>

    <!-- Used Cars Section -->
    <section id="cars-section" class="container py-12">
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800 mb-4">XE ĐÃ QUA SỬ DỤNG</h2>
            <div class="flex items-center justify-center space-x-4">
                <div class="section-divider"></div>
                <i class="fas fa-car text-orange-500 text-2xl"></i>
                <div class="section-divider"></div>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="xe" items="${sanPhamList}">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card h-100 card-hover-effect border-0 shadow-sm">
                        <img src="/imgs/${xe.anhDaiDien}" class="card-img-top object-cover" alt="${xe.tenSanPham}" style="height: 200px;">
                        
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-3">${xe.tenSanPham}</h5>
                            
                            <div class="d-flex justify-content-between text-muted small mb-2">
                                <span><i class="fas fa-calendar text-success me-1"></i> <fmt:formatDate value="${xe.ngaySanXuat}" pattern="yyyy" /></span>
                                <span><i class="fas fa-map-marker-alt text-danger me-1"></i> ${xe.diaDiemLayXe}</span>
                            </div>
                            
                            <div class="d-flex justify-content-between text-muted small mb-3">
                                <span><i class="fas fa-gas-pump text-primary me-1"></i> ${xe.nhienLieu}</span>
                                <span><i class="fas fa-cog text-warning me-1"></i> ${xe.truyenDong}</span>
                            </div>
                            
                            <p class="price-text mb-4">
                                <fmt:formatNumber value="${xe.gia}" pattern="#,##0" /> VND
                            </p>
                            
                            <a href="/car?xeID=${xe.productID}" class="btn btn-outline-primary w-100">
                                <i class="fas fa-info-circle me-2"></i>Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Accessories Section -->
    <section class="container py-12">
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800 mb-4">PHỤ KIỆN BÁN CHẠY</h2>
            <div class="flex items-center justify-center space-x-4">
                <div class="section-divider"></div>
                <i class="fas fa-tools text-orange-500 text-2xl"></i>
                <div class="section-divider"></div>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="phukien" items="${phuKienOtoList}">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card h-100 card-hover-effect border-0 shadow-sm">
                        <div class="position-relative">
                            <img src="/imgs/${phukien.anhDaiDien}" class="card-img-top object-cover" alt="${phukien.tenPhuKien}" style="height: 200px;">
                            
                            <div class="position-absolute top-0 end-0 m-2 d-flex flex-column gap-2">
                                <button class="btn btn-light btn-sm rounded-circle shadow-sm">
                                    <i class="fas fa-search text-primary"></i>
                                </button>
                                <button class="btn btn-light btn-sm rounded-circle shadow-sm">
                                    <i class="far fa-heart text-danger"></i>
                                </button>
                            </div>
                        </div>
                        
                        <div class="card-body">
                            <h5 class="card-title fw-bold mb-2">${phukien.tenPhuKien}</h5>
                            
                            <div class="d-flex align-items-center mb-2">
                                <div class="text-warning small">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="far fa-star"></i>
                                </div>
                                <span class="text-muted small ms-2">(15 đánh giá)</span>
                            </div>
                            
                            <p class="price-text mb-2">
                                <fmt:formatNumber value="${phukien.gia}" pattern="#,##0" /> VND
                            </p>
                            
                            <form action="/addToCart" method="post">
					            <input type="hidden" name="productId" value="${phukien.accessoryID}" />
					            <input type="hidden" name="quantity" value="1" />
					            <a class="btn btn-primary w-full bg-black text-yellow-400 py-2 rounded-full font-semibold mt-3 hover:bg-gray-800" href="/cart/add/${phukien.accessoryID}">Thêm vào giỏ</a>
					        </form>
                            
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Notification Section -->
    <c:if test="${not empty successMessage}">
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div class="toast show" role="alert">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto">Thành công</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">${successMessage}</div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div class="toast show" role="alert">
                <div class="toast-header bg-danger text-white">
                    <strong class="me-auto">Lỗi</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">${errorMessage}</div>
            </div>
        </div>
    </c:if>

    <jsp:include page="/common/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Toast Initialization -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var toastElList = [].slice.call(document.querySelectorAll('.toast'))
            var toastList = toastElList.map(function(toastEl) {
                return new bootstrap.Toast(toastEl, {
                    autohide: true,
                    delay: 5000
                })
            })
        })
    </script>
</body>
</html>