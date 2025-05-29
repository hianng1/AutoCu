<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
        /* Card balancing styles */
        .card {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }        .card-title {
            height: 48px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            line-clamp: 2;
        }        .btn.mt-auto {
            margin-top: auto !important;
        }
        
        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .hero-section {
                padding: 40px 0;
            }
            
            .hero-section h1 {
                font-size: 1.8rem;
            }
            
            .hero-section p {
                font-size: 0.95rem;
            }
            
            .card-title {
                font-size: 1rem;
                line-height: 1.3;
                height: auto;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
            
            .btn-sm {
                padding: 4px 8px;
                font-size: 0.8rem;
            }
            
            .position-absolute.top-0.end-0 .btn {
                width: 32px;
                height: 32px;
            }
            
            .container {
                padding-left: 15px;
                padding-right: 15px;
            }
            
            .row.g-4 {
                margin: 0 -10px;
            }
            
            .row.g-4 > * {
                padding: 0 10px;
                margin-bottom: 20px;
            }
            
            .price-text {
                font-size: 1rem;
            }
        }

        @media (max-width: 480px) {
            .hero-section h1 {
                font-size: 1.5rem;
            }
            
            .card-title {
                font-size: 0.95rem;
            }
            
            .btn {
                padding: 6px 12px;
                font-size: 0.85rem;
            }
            
            .btn-sm {
                padding: 3px 6px;
                font-size: 0.75rem;
            }
            
            .position-absolute.top-0.end-0 .btn {
                width: 28px;
                height: 28px;
            }
            
            .position-absolute.top-0.end-0 .btn i {
                font-size: 0.7rem;
            }
            
            .price-text {
                font-size: 0.95rem;
            }
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

<!-- Featured Categories -->
<section class="py-12 bg-gray-50">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Danh Mục Nổi Bật</h2>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
            <a href="#" class="category-card bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow text-center">
                <i class="fas fa-lightbulb text-3xl text-orange-500 mb-3"></i>
                <h3 class="font-semibold text-gray-800">Đèn LED</h3>
                <p class="text-sm text-gray-600">Đèn pha, đèn hậu</p>
            </a>
            <a href="#" class="category-card bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow text-center">
                <i class="fas fa-tools text-3xl text-orange-500 mb-3"></i>
                <h3 class="font-semibold text-gray-800">Dụng Cụ</h3>
                <p class="text-sm text-gray-600">Bộ dụng cụ sửa chữa</p>
            </a>
            <a href="#" class="category-card bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow text-center">
                <i class="fas fa-shield-alt text-3xl text-orange-500 mb-3"></i>
                <h3 class="font-semibold text-gray-800">Bảo Vệ</h3>
                <p class="text-sm text-gray-600">Camera, cảnh báo</p>
            </a>
            <a href="#" class="category-card bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow text-center">
                <i class="fas fa-car-battery text-3xl text-orange-500 mb-3"></i>
                <h3 class="font-semibold text-gray-800">Điện Tử</h3>
                <p class="text-sm text-gray-600">Phụ tùng điện</p>
            </a>
        </div>
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
        <c:forEach var="xe" items="${sanPhamList}" begin="0" end="7">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">                <div class="card h-100 card-hover-effect border-0 shadow-sm">
                    <div class="position-relative">
                        <img src="/imgs/${xe.anhDaiDien}" class="card-img-top object-cover" alt="${xe.tenSanPham}" style="height: 200px;">
                        <div class="position-absolute top-0 end-0 m-2 d-flex flex-column gap-2">
                            <span class="badge bg-danger">Hot</span>
                            <sec:authorize access="isAuthenticated()">
                                <button 
                                    class="btn btn-light btn-sm rounded-circle shadow-sm wishlist-btn-car" 
                                    data-car-id="${xe.productID}"
                                    title="Thêm vào danh sách yêu thích"
                                >
                                    <i class="far fa-heart text-danger"></i>
                                </button>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated()">
                                <a href="${pageContext.request.contextPath}/login" 
                                   class="btn btn-light btn-sm rounded-circle shadow-sm" 
                                   title="Đăng nhập để thêm vào yêu thích">
                                    <i class="far fa-heart text-danger"></i>
                                </a>
                            </sec:authorize>
                        </div>
                    </div>

                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title fw-bold mb-3">${xe.tenSanPham}</h5>

                        <div class="d-flex justify-content-between text-muted small mb-2">
                            <span><i class="fas fa-calendar text-success me-1"></i> <fmt:formatDate value="${xe.ngaySanXuat}" pattern="yyyy" /></span>
                            <span><i class="fas fa-map-marker-alt text-danger me-1"></i> ${xe.diaDiemLayXe}</span>
                        </div>

                        <div class="d-flex justify-content-between text-muted small mb-3">
                            <span><i class="fas fa-gas-pump text-primary me-1"></i> ${xe.nhienLieu}</span>
                            <span><i class="fas fa-cog text-warning me-1"></i> ${xe.truyenDong}</span>
                        </div>
                   
                        <a href="${pageContext.request.contextPath}/details/${xe.productID}" class="btn btn-outline-primary w-100 mt-auto">
                            <i class="fas fa-info-circle me-2"></i>Chi tiết
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
<!-- Why Choose Us -->
<section class="py-12 bg-white">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Tại Sao Chọn Chúng Tôi</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="text-center">
                <div class="bg-orange-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-shield-alt text-2xl text-orange-500"></i>
                </div>
                <h3 class="font-semibold text-xl mb-2">Bảo Mật Tuyệt Đối</h3>
                <p class="text-gray-600">Cam kết bảo vệ thông tin và tài sản của khách hàng</p>
            </div>
            <div class="text-center">
                <div class="bg-orange-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-clock text-2xl text-orange-500"></i>
                </div>
                <h3 class="font-semibold text-xl mb-2">Hỗ Trợ 24/7</h3>
                <p class="text-gray-600">Đội ngũ hỗ trợ luôn sẵn sàng giúp đỡ bạn</p>
            </div>
            <div class="text-center">
                <div class="bg-orange-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-hand-holding-usd text-2xl text-orange-500"></i>
                </div>
                <h3 class="font-semibold text-xl mb-2">Giá Cả Hợp Lý</h3>
                <p class="text-gray-600">Cam kết mang đến giá trị tốt nhất cho khách hàng</p>
            </div>
        </div>
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
        <c:forEach var="phukien" items="${phuKienOtoList}" >
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card h-100 card-hover-effect border-0 shadow-sm">
                    <div class="position-relative">                        <img src="/imgs/${phukien.anhDaiDien}" class="card-img-top object-cover" alt="${phukien.tenPhuKien}" style="height: 200px;">                        <div class="position-absolute top-0 end-0 m-2 d-flex flex-column gap-2">
                            <a href="${pageContext.request.contextPath}/accessories/${phukien.accessoryID}" 
                               class="btn btn-light btn-sm rounded-circle shadow-sm"
                               title="Xem chi tiết">
                                <i class="fas fa-search text-primary"></i>
                            </a>
                            <sec:authorize access="isAuthenticated()">
                                <button 
                                    class="btn btn-light btn-sm rounded-circle shadow-sm wishlist-btn-accessory" 
                                    data-accessory-id="${phukien.accessoryID}"
                                    title="Thêm vào danh sách yêu thích"
                                >
                                    <i class="far fa-heart text-danger"></i>
                                </button>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated()">
                                <a href="${pageContext.request.contextPath}/login" 
                                   class="btn btn-light btn-sm rounded-circle shadow-sm" 
                                   title="Đăng nhập để thêm vào yêu thích">
                                    <i class="far fa-heart text-danger"></i>
                                </a>
                            </sec:authorize>
                        </div>
                    </div>

                    <div class="card-body">
                        <h5 class="card-title fw-bold mb-2">${phukien.tenPhuKien}</h5>

                        <div class="d-flex align-items-center mb-2">
                            <div class="text-warning small">
                                <!-- Replace static stars with dynamic rating display -->
                                <c:choose>
                                    <c:when test="${phukien.soLuongDanhGia > 0}">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= phukien.trungBinhSao ? 'text-warning' : 'text-muted'}"></i>
                                        </c:forEach>
                                        <span class="text-muted ms-2">(${phukien.soLuongDanhGia})</span>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-star text-muted"></i>
                                        <i class="fas fa-star text-muted"></i>
                                        <i class="fas fa-star text-muted"></i>
                                        <i class="fas fa-star text-muted"></i>
                                        <i class="fas fa-star text-muted"></i>
                                        <span class="text-muted ms-2">(0)</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>                        <p class="price-text mb-2">
                            <fmt:formatNumber value="${phukien.gia}" pattern="#,##0" /> VND
                        </p>
                        
                        <c:choose>
                            <c:when test="${phukien.soLuong > 0}">
                                <form action="/cart/add/${phukien.accessoryID}" method="post">
                                    <input type="hidden" name="quantity" value="1" />
                                    <button type="submit" class="btn btn-primary w-full bg-black text-yellow-400 py-2 rounded-full font-semibold mt-3 hover:bg-gray-800">
                                        <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-secondary w-full py-2 rounded-full font-semibold mt-3" disabled>
                                    <i class="fas fa-ban me-2"></i>Hết hàng
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>



<!-- Car Brands Section -->
<section class="py-12 bg-white">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Các Hãng Xe Nổi Tiếng</h2>
        <div id="brandCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4 items-center">
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMha4iBfMF-P54i0rxc5aSqqWuktU3_Ed0vA&s"
                                     alt="Toyota" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Toyota</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/7/7b/Honda_Logo.svg"
                                     alt="Honda" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Honda</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQKagMNuCiXObTWp4hCG89aKhcXXhZR9q28Q&s"
                                     alt="Ford" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Ford</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://rubee.com.vn/wp-content/uploads/2021/05/Logo-hyundai.jpg"
                                     alt="Hyundai" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Hyundai</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMqcX6JyCmPKjP6S7oSC1NqJ09PoiM4dGZRg&s"
                                     alt="Kia" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Kia</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlPpPHoc84uSFLbsdHm0jOyB6YaGa6n3D-SA&s"
                                     alt="Mazda" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Mazda</p>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4 items-center">
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEZT46rDalMzeLa41VT1QzdvfAjEe9posTXw&s"
                                     alt="BMW" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">BMW</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://inkythuatso.com/uploads/images/2021/11/logo-mercedes-inkythuatso-3-01-11-09-10-56.jpg"
                                     alt="Mercedes" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Mercedes</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://inkythuatso.com/uploads/images/2021/11/logo-audi-inkythuatso-01-11-13-32-37.jpg"
                                     alt="Audi" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Audi</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaIrxBzZaBA_EcUjW682b_uGyrtWSD7tpEWg&s"
                                     alt="Lexus" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Lexus</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT30J3mRPw32noOKF1ADLxDqkR0xUBKwE3M-w&s"
                                     alt="Volkswagen" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Volkswagen</p>
                        </div>
                        <div class="text-center p-3 hover:scale-105 transition-transform duration-300">
                            <div class="w-20 h-20 mx-auto bg-white rounded-lg shadow-sm p-2 flex items-center justify-center mb-2">
                                <img src="https://inkythuatso.com/uploads/images/2021/11/porsche-logo-inkythuatso-2-01-12-14-55-43.jpg"
                                     alt="Porsche" class="w-full h-full object-contain grayscale hover:grayscale-0 transition-all">
                            </div>
                            <p class="text-sm text-gray-600">Porsche</p>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#brandCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#brandCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#brandCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#brandCarousel" data-bs-slide-to="1"></button>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter Section -->
<section class="py-12 bg-gray-900 text-white">
    <div class="container mx-auto px-4">
        <div class="max-w-2xl mx-auto text-center">
            <h2 class="text-3xl font-bold mb-4">Đăng Ký Nhận Tin</h2>
            <p class="text-gray-300 mb-6">Đăng ký để nhận những thông tin mới nhất về xe và phụ kiện</p>
            <form class="flex gap-4">
                <input type="email" placeholder="Nhập email của bạn"
                       class="flex-1 px-4 py-2 rounded-lg text-gray-900">
                <button type="submit" class="bg-orange-500 px-6 py-2 rounded-lg hover:bg-orange-600 transition-colors">
                    Đăng Ký
                </button>
            </form>
        </div>
    </div>
</section>
<!-- Testimonials Section -->
<section class="py-12 bg-gray-50">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Khách Hàng Nói Gì</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white p-6 rounded-lg shadow-sm">
                <div class="flex items-center mb-4">
                    <img src="https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/anh-avatar-facebook-11-1.jpg" alt="Avatar" class="w-12 h-12 rounded-full mr-4">
                    <div>
                        <h4 class="font-semibold">Nguyễn Văn A</h4>
                        <p class="text-gray-600 text-sm">Khách hàng thân thiết</p>
                    </div>
                </div>
                <p class="text-gray-600">"Dịch vụ rất tốt, xe mới và sạch sẽ. Sẽ quay lại sử dụng!"</p>
                <div class="text-yellow-400 mt-4">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm">
                <div class="flex items-center mb-4">
                    <img src="https://live.staticflickr.com/65535/51348774357_379be59623.jpg" alt="Avatar" class="w-12 h-12 rounded-full mr-4">
                    <div>
                        <h4 class="font-semibold">Trần Thị B</h4>
                        <p class="text-gray-600 text-sm">Khách hàng VIP</p>
                    </div>
                </div>
                <p class="text-gray-600">"Đội ngũ hỗ trợ rất nhiệt tình, giá cả hợp lý."</p>
                <div class="text-yellow-400 mt-4">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm">
                <div class="flex items-center mb-4">
                    <img src="https://inkythuatso.com/uploads/thumbnails/800/2022/03/anh-dai-dien-facebook-dep-cho-nam-52-28-16-28-10.jpg" alt="Avatar" class="w-12 h-12 rounded-full mr-4">
                    <div>
                        <h4 class="font-semibold">Lê Văn C</h4>
                        <p class="text-gray-600 text-sm">Khách hàng mới</p>
                    </div>
                </div>
                <p class="text-gray-600">"Trải nghiệm thuê xe rất tốt, sẽ giới thiệu cho bạn bè."</p>
                <div class="text-yellow-400 mt-4">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
        </div>
    </div>
</section>


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

        // Wishlist functionality
        // Car wishlist functionality
        document.querySelectorAll('.wishlist-btn-car').forEach(button => {
            button.addEventListener('click', function() {
                const carId = this.getAttribute('data-car-id');
                const heartIcon = this.querySelector('i');
                
                fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        carId: carId,
                        productType: 'CAR'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        if (data.added) {
                            heartIcon.className = 'fas fa-heart text-danger';
                            showToast('Đã thêm xe vào danh sách yêu thích!', 'success');
                        } else {
                            heartIcon.className = 'far fa-heart text-danger';
                            showToast('Đã xóa xe khỏi danh sách yêu thích!', 'info');
                        }
                        updateWishlistCount();
                    } else {
                        showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                });
            });
        });

        // Accessory wishlist functionality
        document.querySelectorAll('.wishlist-btn-accessory').forEach(button => {
            button.addEventListener('click', function() {
                const accessoryId = this.getAttribute('data-accessory-id');
                const heartIcon = this.querySelector('i');
                
                fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        accessoryId: accessoryId,
                        productType: 'ACCESSORY'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        if (data.added) {
                            heartIcon.className = 'fas fa-heart text-danger';
                            showToast('Đã thêm phụ kiện vào danh sách yêu thích!', 'success');
                        } else {
                            heartIcon.className = 'far fa-heart text-danger';
                            showToast('Đã xóa phụ kiện khỏi danh sách yêu thích!', 'info');
                        }
                        updateWishlistCount();
                    } else {
                        showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                });
            });
        });        // Toast notification function
        function showToast(message, type) {
            const toast = document.createElement('div');
            let alertClass = 'alert alert-info';
            let iconClass = 'fas fa-info-circle';
            
            if (type === 'success') {
                alertClass = 'alert alert-success';
                iconClass = 'fas fa-check-circle';
            } else if (type === 'error') {
                alertClass = 'alert alert-danger';
                iconClass = 'fas fa-exclamation-circle';
            }
            
            toast.className = alertClass + ' position-fixed';
            toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
            toast.innerHTML = 
                '<div class="d-flex align-items-center">' +
                    '<i class="' + iconClass + ' me-2"></i>' +
                    message +
                    '<button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>' +
                '</div>';
            
            document.body.appendChild(toast);
            
            setTimeout(function() {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 3000);
        }

        // Update wishlist count in header
        function updateWishlistCount() {
            const wishlistCountElement = document.getElementById('wishlist-count');
            if (wishlistCountElement) {
                fetch('${pageContext.request.contextPath}/api/wishlist/count')
                    .then(response => response.json())
                    .then(data => {
                        if (data.count > 0) {
                            wishlistCountElement.textContent = data.count;
                            wishlistCountElement.style.display = 'flex';
                        } else {
                            wishlistCountElement.style.display = 'none';
                        }
                    })
                    .catch(error => console.log('Could not update wishlist count'));
            }
        }

        // Load existing wishlist items to show filled hearts
        function loadWishlistStatus() {
            fetch('${pageContext.request.contextPath}/api/wishlist/items')
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.items) {
                        data.items.forEach(item => {
                            if (item.carId) {
                                const button = document.querySelector(`[data-car-id="${item.carId}"]`);
                                if (button) {
                                    button.querySelector('i').className = 'fas fa-heart text-danger';
                                }
                            }
                            if (item.accessoryId) {
                                const button = document.querySelector(`[data-accessory-id="${item.accessoryId}"]`);
                                if (button) {
                                    button.querySelector('i').className = 'fas fa-heart text-danger';
                                }
                            }
                        });
                    }
                })
                .catch(error => console.log('Could not load wishlist status'));
        }

        // Load wishlist status on page load
        loadWishlistStatus();
    })
</script>
</body>
</html>