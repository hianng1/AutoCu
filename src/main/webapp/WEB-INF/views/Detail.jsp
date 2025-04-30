<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>

    <!-- CSS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            color: #1e293b;
        }

        .product-details-container {
            max-width: 1000px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .product-image-column {
            padding: 20px;
        }

        .main-image {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.03);
        }

        .thumbnail-list {
            display: flex;
            margin-top: 10px;
            overflow-x: auto;
            padding-bottom: 10px;
        }

        .thumbnail-item {
            width: 80px;
            height: 80px;
            margin-right: 10px;
            border-radius: 6px;
            overflow: hidden;
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.2s ease-in-out;
        }

        .thumbnail-item:hover,
        .thumbnail-item.active {
            opacity: 1;
        }

        .thumbnail-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-info-column {
            padding: 30px;
        }

        .product-title {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 2px;
            color: #334155;
        }

        .product-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: #0ea5e9;
            margin-bottom: 20px;
        }

        .product-description {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .product-options {
            margin-bottom: 25px;
        }

        .option-label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #475569;
        }

        .select-input,
        .quantity-input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            margin-bottom: 15px;
            font-size: 1rem;
            color: #334155;
            appearance: none;
            background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23475569"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
        }

        .quantity-input {
            width: 60px;
            padding: 10px;
            text-align: center;
            margin-right: 10px;
        }

        .add-to-cart-button {
            background-color: #3b82f6;
            color: white;
            padding: 14px 22px;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .add-to-cart-button:hover {
            background-color: #2563eb;
        }

        .product-details-section {
            padding: 30px;
            background-color: #f9fafb;
            border-top: 1px solid #e5e7eb;
        }

        .details-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: #334155;
        }

        .details-content {
            color: #4b5563;
            line-height: 1.7;
        }

        /* Responsive layout */
        @media (min-width: 768px) {
            .product-details-container {
                display: flex;
            }

            .product-image-column {
                width: 40%;
                padding: 30px;
            }

            .product-info-column {
                width: 60%;
                padding: 30px;
            }
        }
                .small-thumb {
            width: 70px;
            height: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 5px;
            cursor: pointer;
        }
        .main-img {
            max-width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .table-specs td {
            padding: 6px 10px;
        }
        .desc-box {
            max-height: 250px;
            overflow-y: auto;
            padding-right: 10px;
        }
        .product-title {
            font-size: 22px;
            font-weight: bold;
            color: #333;
        }
        .product-price {
            font-size: 20px;
            color: #c0392b;
        }
        custom-prev, .custom-next {
        position: absolute;
        top: 45%;
        transform: translateY(-50%);
        z-index: 10;
    }

    .custom-prev {
        left: -160px;
    }

    .custom-next {
        right: -160px;
    }

    @media (max-width: 768px) {
        .custom-prev {
            left: -25px;
        }
        .custom-next {
            right: -25px;
        }
    }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/common/header.jsp" />
<div class="container bg-white shadow-sm mt-4 p-4 rounded">

    <!-- Tiêu đề và giá -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-9">
            <h4 class="fw-bold text-primary mb-0">
                Xe ${details[0].tenSanPham} - 
                <span class="text-danger">
                    <fmt:formatNumber value="${details[0].gia}" type="number"/> Triệu
                </span>
            </h4>
        </div>
        <div class="col-md-3 text-end text-muted">
            <small><i class="far fa-calendar-alt me-1"></i>Đăng ngày ${now}</small>
        </div>
    </div>

    <!-- Nội dung: Bảng thông số & Hình ảnh -->
    <div class="row">

        <!-- Thông số -->
        <div class="col-md-6 mb-4">
            <h5 class="fw-semibold mb-3">Thông số kỹ thuật</h5>
            <table class="table table-bordered table-striped">
                <tbody>
                    <tr><td><strong>Động cơ</strong></td><td>${details[0].nhienLieu} ${details[0].truyenDong}</td></tr>
                    <tr><td><strong>Số ghế</strong></td><td>${details[0].soGhe}</td></tr>
                    <tr><td><strong>Số cửa</strong></td><td>5 cửa</td></tr>
                    <tr><td><strong>Kiểu dáng</strong></td><td>${details[0].danhMuc.tenDanhMuc}</td></tr>
                    <tr><td><strong>Hãng xe</strong></td><td>${details[0].hangXe}</td></tr>
                    <tr><td><strong>Kho</strong></td><td>${details[0].soLuongTrongKho} chiếc</td></tr>
                    <tr><td><strong>Địa điểm lấy xe</strong></td><td>${details[0].diaDiemLayXe}</td></tr>
                </tbody>
            </table>

            <!-- Khung liên hệ -->
            <div class="border rounded p-3 d-flex justify-content-between align-items-center mt-4 bg-light">
               <div class="d-flex align-items-center gap-2">
    <i class="fas fa-phone fa-lg" style="color: #ffa64d;"></i>
    <div>
        <strong>Liên hệ chúng tôi</strong><br>
        <span>Zalo<br>0988.8888.88</span>
    </div>
</div>

<!-- Messenger -->
<div class="d-flex align-items-center gap-2">
    <i class="fab fa-facebook-messenger fa-lg" style="color: #ffa64d;"></i>
    <div>
        <strong>Messenger</strong><br>
        <span>AUTOCU</span>
    </div>
</div>

                <!-- Form button -->
             <div>
  <button class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#formModal">
    <i class="fas fa-file-alt me-1"></i> Tư vấn xe
  </button>
</div>
<div class="modal fade" id="formModal" tabindex="-1" aria-labelledby="formModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content p-4 shadow-sm rounded-4">
      <!-- Nút đóng -->
      <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>

      <!-- Tiêu đề -->
      <h5 class="modal-title fw-bold mb-3" id="formModalLabel">Nhận thông tin xe</h5>

      <!-- Form -->
      <form>
        <div class="mb-3">
          <label class="form-label fw-bold">Họ Tên*</label>
          <input type="text" class="form-control" required>
        </div>

        <div class="mb-3">
          <label class="form-label fw-bold">Email*</label>
          <input type="email" class="form-control">
        </div>

        <div class="mb-3">
          <label class="form-label fw-bold">Số điện thoại</label>
          <input type="text" class="form-control">
        </div>

        <!-- Nút gửi -->
        <div class="text-center">
          <button type="submit" class="btn btn-warning text-white fw-bold px-4 py-2 rounded-pill" style="background-color: #ffa64d; border: none;">
            GỬI THÔNG TIN
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
            </div>
        </div>

        <!-- Hình ảnh -->
        <div class="col-md-6 text-center">
            <!-- Ảnh chính -->
            <img src="<c:url value='/imgs/${details[0].anhDaiDien}' />" class="img-fluid rounded shadow-sm mb-3" alt="${details[0].tenSanPham}" style="max-height: 400px; object-fit: cover;">

            <!-- Ảnh phụ -->
            <div class="d-flex flex-wrap justify-content-center">
                <c:forEach var="image" items="${hinhAnhList}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <img src="<c:url value='/imgs/${image.fileName}' />" class="rounded border me-2 mb-2" alt="Ảnh phụ"
                             style="width: 80px; height: 60px; object-fit: cover; cursor: pointer;">
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>


    <!-- Mô tả -->
    <div class="row mt-4">
        <div class="col-12">
            <h5>Thông tin mô tả</h5>
            <div class="desc-box border rounded p-3 bg-light">
                <p>Toyota Avanza Premio 2022 – MPV 7 chỗ thực dụng, vận hành linh hoạt, tiết kiệm nhiên liệu

Toyota Avanza Premio 2022 là mẫu MPV 7 chỗ lý tưởng cho gia đình và dịch vụ, nổi bật với thiết kế hiện đại, không gian rộng rãi và khả năng vận hành ổn định. Ngoại thất xe được thiết kế mới mẻ với lưới tản nhiệt lớn, cụm đèn LED sắc nét và mâm hợp kim 16 inch mạnh mẽ.

Khoang nội thất rộng rãi với 3 hàng ghế linh hoạt, hàng ghế thứ 2 và 3 có thể gập phẳng để tối ưu không gian chứa đồ. Ghế nỉ bền đẹp, điều hòa 2 dàn lạnh làm mát nhanh và sâu, màn hình cảm ứng hỗ trợ kết nối USB/Bluetooth/AUX đáp ứng nhu cầu giải trí cơ bản.

Xe sử dụng động cơ xăng 1.5L 2NR-VE, công suất 105 mã lực tại 6.000 vòng/phút, mô-men xoắn 138 Nm tại 4.200 vòng/phút, kết hợp hộp số tự động vô cấp CVT, mang lại khả năng vận hành mượt mà và tiết kiệm nhiên liệu, với mức tiêu thụ trung bình khoảng 6,3L/100km .
Với ưu điểm về không gian, vận hành và chi phí sử dụng hợp lý, Toyota Avanza Premio 2022 là lựa chọn đáng cân nhắc cho những ai tìm kiếm một chiếc MPV 7 chỗ phục vụ gia đình hoặc kinh doanh dịch vụ.</p>
            </div>
        </div>
    </div>
</div>
<h3 class="mb-3">Sản phẩm tương tự</h3>
<div class="container" style="max-width: 1100px; position: relative;"> <!-- Phải có position: relative để định vị nút -->
    <div id="carouselSanPham" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <c:forEach var="sp" items="${sanPhamTuongTu}" varStatus="status">
                <c:if test="${status.index % 4 == 0}">
                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                        <div class="row gx-3 justify-content-center">
                </c:if>

                <div class="col-md-3">
                    <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                        <a href="/details/${sp.productID}">
                            <img src="<c:url value='/imgs/${sp.anhDaiDien}' />" class="card-img-top" style="height: 150px; object-fit: cover;" alt="${sp.tenSanPham}">
                        </a>
                        <div class="card-body p-2">
                            <a href="/details/${sp.productID}" class="text-decoration-none">
                                <h6 class="fw-bold text-primary mb-1" style="font-size: 0.9rem;">
                                    Xe ${sp.tenSanPham}
                                </h6>
                            </a>
                            <p class="text-muted mb-1" style="font-size: 0.8rem;">
                                Xe cũ nhập khẩu, máy ${sp.nhienLieu}, số tự động...
                            </p>
                            <p class="text-secondary mb-1" style="font-size: 0.75rem;">[TP HCM]</p>
                            <p class="fw-bold text-success mb-0" style="font-size: 0.9rem;">
                                <fmt:formatNumber value="${sp.gia}" type="currency" currencySymbol="Triệu" />
                            </p>
                        </div>
                    </div>
                </div>

                <c:if test="${status.index % 4 == 3 || status.last}">
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- Nút điều hướng ngoài viền -->
        <button class="carousel-control-prev custom-prev" type="button" data-bs-target="#carouselSanPham" data-bs-slide="prev">
            <span class="carousel-control-prev-icon bg-dark rounded-circle p-2" aria-hidden="true"></span>
            <span class="visually-hidden">Trước</span>
        </button>
        <button class="carousel-control-next custom-next" type="button" data-bs-target="#carouselSanPham" data-bs-slide="next">
            <span class="carousel-control-next-icon bg-dark rounded-circle p-2" aria-hidden="true"></span>
            <span class="visually-hidden">Tiếp</span>
        </button>
    </div>
</div>



<jsp:include page="/common/footer.jsp" />
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const mainImg = document.querySelector(".main-img");
        const thumbs = document.querySelectorAll(".small-thumb");

        let currentIndex = 0;

        // Đổi ảnh khi click vào thumbnail
        thumbs.forEach(function (thumb, index) {
            thumb.addEventListener("click", function () {
                mainImg.src = thumb.src;
                currentIndex = index; // cập nhật chỉ số ảnh hiện tại
            });
        });

        // Tự động chuyển ảnh mỗi 5 giây
        setInterval(function () {
            if (thumbs.length > 0) {
                currentIndex = (currentIndex + 1) % thumbs.length;
                mainImg.src = thumbs[currentIndex].src;
            }
        }, 5000);
    });
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>