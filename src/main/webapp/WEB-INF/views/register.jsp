<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
        />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            rel="stylesheet"
        />
        <style>
            .card:hover {
                transform: translateY(-5px);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }
            .card-img-top,
            img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            button:hover {
                transition: background-color 0.3s ease;
            }
            .form-select.is-invalid,
            .was-validated .form-select:invalid {
                border-color: #dc3545;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath stroke-linejoin='round' d='M5.8 3.6h.4L6 6.5z'/%3e%3ccircle cx='6' cy='8.2' r='.6' fill='%23dc3545' stroke='none'/%3e%3c/svg%3e");
            }
            .select-loading {
                opacity: 0.6;
                pointer-events: none;
            }

            /* Add styles for autocomplete suggestions */
            .autocomplete-container {
                position: relative;
            }

            .autocomplete-suggestions {
                position: absolute;
                border: 1px solid #ddd;
                border-top: none;
                background-color: white;
                z-index: 99;
                top: 100%;
                left: 0;
                right: 0;
                max-height: 200px;
                overflow-y: auto;
                display: none;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .autocomplete-suggestion {
                padding: 8px 12px;
                cursor: pointer;
                border-bottom: 1px solid #f9f9f9;
            }

            .autocomplete-suggestion:hover {
                background-color: #f1f5f9;
            }

            .highlight {
                font-weight: bold;
                background-color: #f0f9ff;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/common/header.jsp" />

        <main class="container py-5">
            <c:if test="${not empty message}">
                <div
                    class="alert alert-danger alert-dismissible fade show"
                    role="alert"
                >
                    ${message}
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                    ></button>
                </div>
            </c:if>
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow-sm">
                        <div class="card-body p-4">
                            <h2 class="card-title text-center mb-4">
                                Đăng Ký Tài Khoản
                            </h2>
                            <form
                                id="registerForm"
                                action="/register"
                                method="post"
                                class="needs-validation"
                                novalidate
                            >
                                <div class="mb-3">
                                    <label for="username" class="form-label"
                                        >Tên đăng nhập</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="username"
                                        name="username"
                                        required
                                    />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập tên đăng nhập
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label"
                                        >Mật khẩu</label
                                    >
                                    <input
                                        type="password"
                                        class="form-control"
                                        name="password"
                                        id="password"
                                        required
                                        pattern="(?=.*[a-z])(?=.*[A-Z]).{6,}"
                                    />
                                    <div class="form-text">
                                        <ul>
                                            <li>Ít nhất 6 ký tự</li>
                                            <li>
                                                Chứa ít nhất một chữ hoa (A-Z)
                                            </li>
                                            <li>
                                                Chứa ít nhất một chữ thường
                                                (a-z)
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mật khẩu hợp lệ (ít nhất 6
                                        ký tự và chứa ít nhất một chữ hoa và một
                                        chữ thường).
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Họ và tên</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        name="hovaten"
                                        required
                                    />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập họ và tên
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label"
                                        >Email</label
                                    >
                                    <input
                                        type="email"
                                        class="form-control"
                                        id="email"
                                        name="email"
                                        required
                                        pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
                                    />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập email hợp lệ (vd:
                                        example@domain.com)
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label"
                                        >Số điện thoại</label
                                    >
                                    <input
                                        type="tel"
                                        class="form-control"
                                        id="phone"
                                        name="sodienthoai"
                                        pattern="[0-9]{10}"
                                        required
                                    />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số điện thoại hợp lệ (10
                                        số)
                                    </div>
                                </div>

                                <!-- Thay đổi phần địa chỉ chỉ dành cho TPHCM -->
                                <div class="mb-3">
                                    <label class="form-label fw-bold"
                                        >Địa chỉ giao hàng (Chỉ giao trong
                                        TP.HCM)</label
                                    >
                                </div>

                                <!-- Quận/Huyện -->
                                <div class="mb-3">
                                    <label for="quanHuyen" class="form-label"
                                        >Quận/Huyện</label
                                    >
                                    <select
                                        class="form-select"
                                        id="quanHuyen"
                                        name="quanHuyen"
                                        required
                                    >
                                        <option value="">
                                            -- Chọn Quận/Huyện --
                                        </option>
                                        <!-- Sẽ được điền bằng JavaScript -->
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn quận/huyện
                                    </div>
                                </div>

                                <!-- Phường/Xã -->
                                <div class="mb-3">
                                    <label for="phuongXa" class="form-label"
                                        >Phường/Xã</label
                                    >
                                    <select
                                        class="form-select"
                                        id="phuongXa"
                                        name="phuongXa"
                                        required
                                        disabled
                                    >
                                        <option value="">
                                            -- Chọn Phường/Xã --
                                        </option>
                                        <!-- Sẽ được điền bằng JavaScript -->
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn phường/xã
                                    </div>
                                </div>

                                <!-- Thay đổi trường số nhà/đường thành 2 trường riêng biệt -->

                                <!-- Thêm trường tên đường -->
                                <div class="mb-3">
                                    <label for="tenDuong" class="form-label"
                                        >Tên đường</label
                                    >
                                    <select
                                        class="form-select"
                                        id="tenDuong"
                                        name="tenDuong"
                                        required
                                        disabled
                                    >
                                        <option value="">
                                            -- Chọn tên đường --
                                        </option>
                                        <!-- Sẽ được điền bằng JavaScript dựa trên phường/xã đã chọn -->
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn tên đường
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="soNha" class="form-label"
                                        >Số nhà</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="soNha"
                                        name="soNha"
                                        placeholder="Ví dụ: 123, 45B, ..."
                                        required
                                    />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số nhà
                                    </div>
                                </div>

                                <!-- Hidden field for city -->
                                <input
                                    type="hidden"
                                    name="tinhThanh"
                                    value="Thành phố Hồ Chí Minh"
                                />

                                <button
                                    type="submit"
                                    class="btn btn-primary w-100"
                                >
                                    <i class="fas fa-user-plus me-2"></i> Đăng
                                    ký
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="/common/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Form validation
            (() => {
                "use strict";

                // Lấy tất cả các form cần xác thực
                const forms = document.querySelectorAll(".needs-validation");

                // Lặp qua chúng và ngăn chặn việc gửi
                Array.from(forms).forEach((form) => {
                    form.addEventListener(
                        "submit",
                        (event) => {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }

                            // Kiểm tra thêm điều kiện cho mật khẩu
                            const passwordInput =
                                form.querySelector("#password");
                            if (passwordInput) {
                                const passwordValue = passwordInput.value;
                                const hasUpperCase = /[A-Z]/.test(
                                    passwordValue
                                );
                                const hasLowerCase = /[a-z]/.test(
                                    passwordValue
                                );
                                const isLongEnough = passwordValue.length >= 6;

                                if (
                                    !isLongEnough ||
                                    !hasUpperCase ||
                                    !hasLowerCase
                                ) {
                                    passwordInput.classList.add("is-invalid");
                                    event.preventDefault();
                                    event.stopPropagation();
                                } else {
                                    passwordInput.classList.remove(
                                        "is-invalid"
                                    );
                                }
                            }

                            form.classList.add("was-validated");
                        },
                        false
                    );
                });
            })();

            // Ho Chi Minh City Districts, Wards and Streets
            document.addEventListener("DOMContentLoaded", function () {
                // Danh sách quận/huyện, phường/xã và đường phố ở TP.HCM
                const hcmcDistrictsWardsStreets = {
                    "Quận 1": {
                        "Phường Bến Nghé": [
                            "Đường Lê Lợi",
                            "Đường Nguyễn Huệ",
                            "Đường Đồng Khởi",
                            "Đường Pasteur",
                            "Đường Nam Kỳ Khởi Nghĩa",
                            "Đường Hàm Nghi",
                            "Đường Tôn Thất Đạm",
                        ],
                        "Phường Bến Thành": [
                            "Đường Lê Lai",
                            "Đường Phạm Ngũ Lão",
                            "Đường Nguyễn Thái Học",
                            "Đường Calmette",
                            "Đường Lý Tự Trọng",
                            "Đường Thủ Khoa Huân",
                        ],
                        "Phường Cầu Kho": [
                            "Đường Trần Hưng Đạo",
                            "Đường Nguyễn Cư Trinh",
                            "Đường Nguyễn Thị Nghĩa",
                            "Đường Cống Quỳnh",
                        ],
                        // Các phường còn lại trong Quận 1...
                        "Phường Cầu Ông Lãnh": [
                            "Đường Nguyễn Thái Bình",
                            "Đường Cô Bắc",
                            "Đường Cô Giang",
                            "Đường Ký Con",
                        ],
                        "Phường Cô Giang": [
                            "Đường Cô Giang",
                            "Đường Nguyễn Thái Bình",
                            "Đường Phạm Viết Chánh",
                        ],
                        "Phường Đa Kao": [
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Võ Văn Tần",
                            "Đường Nguyễn Thị Minh Khai",
                        ],
                        "Phường Nguyễn Cư Trinh": [
                            "Đường Trần Hưng Đạo",
                            "Đường Nguyễn Cư Trinh",
                            "Đường Cống Quỳnh",
                            "Đường Bùi Viện",
                        ],
                        "Phường Nguyễn Thái Bình": [
                            "Đường Nguyễn Thái Bình",
                            "Đường Phó Đức Chính",
                            "Đường Hồ Tùng Mậu",
                        ],
                        "Phường Phạm Ngũ Lão": [
                            "Đường Phạm Ngũ Lão",
                            "Đường Đề Thám",
                            "Đường Bùi Viện",
                            "Đường Nguyễn Thái Học",
                        ],
                        "Phường Tân Định": [
                            "Đường Hai Bà Trưng",
                            "Đường Nguyễn Hữu Cầu",
                            "Đường Trần Quang Khải",
                        ],
                    },
                    "Quận 3": {
                        "Phường 1": [
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Võ Văn Tần",
                            "Đường Cao Thắng",
                        ],
                        "Phường 2": [
                            "Đường Nam Kỳ Khởi Nghĩa",
                            "Đường Lý Chính Thắng",
                            "Đường Trần Cao Vân",
                        ],
                        // Thêm các phường còn lại của Quận 3...
                        "Phường 14": [
                            "Đường Lý Chính Thắng",
                            "Đường Trần Quang Diệu",
                            "Đường Nguyễn Thiện Thuật",
                        ],
                    },
                    // Mẫu cho Quận 7 - một trong những quận phổ biến
                    "Quận 7": {
                        "Phường Tân Thuận Đông": [
                            "Đường Huỳnh Tấn Phát",
                            "Đường Nguyễn Văn Linh",
                            "Đường Lưu Trọng Lư",
                        ],
                        "Phường Tân Thuận Tây": [
                            "Đường Nguyễn Văn Linh",
                            "Đường Huỳnh Tấn Phát",
                            "Đường Bùi Văn Ba",
                        ],
                        "Phường Tân Kiểng": [
                            "Đường Lâm Văn Bền",
                            "Đường Nguyễn Thị Thập",
                            "Đường Trần Xuân Soạn",
                        ],
                        "Phường Tân Hưng": [
                            "Đường Nguyễn Thị Thập",
                            "Đường Tân Mỹ",
                            "Đường Phạm Thái Bường",
                        ],
                        "Phường Phú Mỹ": [
                            "Đường Hoàng Quốc Việt",
                            "Đường Đào Trí",
                            "Đường Phạm Hữu Lầu",
                        ],
                        // Các phường còn lại của Quận 7...
                        "Phường Bình Thuận": [
                            "Đường Huỳnh Tấn Phát",
                            "Đường Phạm Hữu Lầu",
                            "Đường Đào Tông Nguyên",
                        ],
                        "Phường Phú Thuận": [
                            "Đường Huỳnh Tấn Phát",
                            "Đường Tôn Thất Thuyết",
                            "Đường Tân Phú",
                        ],
                        "Phường Tân Phong": [
                            "Đường Nguyễn Đức Cảnh",
                            "Đường Nguyễn Văn Linh",
                            "Đường Tân Trào",
                        ],
                        "Phường Tân Phú": [
                            "Đường Đào Trí",
                            "Đường Lê Văn Thịnh",
                            "Đường Tân Phú",
                        ],
                        "Phường Tân Quy": [
                            "Đường Nguyễn Thị Thập",
                            "Đường Lâm Văn Bền",
                            "Đường Chuyên Dùng 9",
                        ],
                    },
                    // Thêm mẫu cho các quận khác...
                    "Quận Bình Thạnh": {
                        "Phường 1": [
                            "Đường Điện Biên Phủ",
                            "Đường Vũ Tùng",
                            "Đường Phan Văn Trị",
                        ],
                        "Phường 11": [
                            "Đường Nguyễn Xí",
                            "Đường Bạch Đằng",
                            "Đường D2",
                        ],
                        "Phường 12": [
                            "Đường Phan Văn Trị",
                            "Đường D1",
                            "Đường D3",
                        ],
                        "Phường 13": [
                            "Đường Lê Quang Định",
                            "Đường Cầu Kiệu",
                            "Đường Phạm Văn Đồng",
                        ],
                        // Các phường còn lại...
                        "Phường 28": [
                            "Đường Xô Viết Nghệ Tĩnh",
                            "Đường D5",
                            "Đường Bình Quới",
                        ],
                    },
                    // Có thể thêm dữ liệu cho các quận khác ở đây
                };

                // Lấy references đến các dropdown
                const districtSelect = document.getElementById("quanHuyen");
                const wardSelect = document.getElementById("phuongXa");
                const streetSelect = document.getElementById("tenDuong");

                // Đổ dữ liệu quận/huyện vào dropdown
                districtSelect.innerHTML =
                    '<option value="">-- Chọn Quận/Huyện --</option>';
                Object.keys(hcmcDistrictsWardsStreets).forEach((district) => {
                    const option = document.createElement("option");
                    option.value = district;
                    option.textContent = district;
                    districtSelect.appendChild(option);
                });

                // Sự kiện khi chọn quận/huyện
                districtSelect.addEventListener("change", function () {
                    const selectedDistrict = this.value;
                    wardSelect.innerHTML =
                        '<option value="">-- Chọn Phường/Xã --</option>';
                    streetSelect.innerHTML =
                        '<option value="">-- Chọn tên đường --</option>';

                    if (selectedDistrict) {
                        // Lấy danh sách phường/xã của quận/huyện đã chọn
                        const wards = Object.keys(
                            hcmcDistrictsWardsStreets[selectedDistrict] || {}
                        );

                        // Đổ dữ liệu phường/xã vào dropdown
                        wards.forEach((ward) => {
                            const option = document.createElement("option");
                            option.value = ward;
                            option.textContent = ward;
                            wardSelect.appendChild(option);
                        });

                        // Enable dropdown phường/xã
                        wardSelect.disabled = false;

                        // Disable dropdown tên đường cho đến khi chọn phường/xã
                        streetSelect.disabled = true;
                    } else {
                        // Disable cả hai dropdown nếu chưa chọn quận/huyện
                        wardSelect.disabled = true;
                        streetSelect.disabled = true;
                    }
                });

                // Sự kiện khi chọn phường/xã
                wardSelect.addEventListener("change", function () {
                    const selectedDistrict = districtSelect.value;
                    const selectedWard = this.value;
                    streetSelect.innerHTML =
                        '<option value="">-- Chọn tên đường --</option>';

                    if (selectedDistrict && selectedWard) {
                        // Lấy danh sách đường của phường/xã đã chọn
                        const streets =
                            hcmcDistrictsWardsStreets[selectedDistrict][
                                selectedWard
                            ] || [];

                        // Đổ dữ liệu tên đường vào dropdown
                        streets.forEach((street) => {
                            const option = document.createElement("option");
                            option.value = street;
                            option.textContent = street;
                            streetSelect.appendChild(option);
                        });

                        // Enable dropdown tên đường
                        streetSelect.disabled = false;
                    } else {
                        // Disable dropdown tên đường nếu chưa chọn phường/xã
                        streetSelect.disabled = true;
                    }
                });

                // Form validation
                document
                    .getElementById("registerForm")
                    .addEventListener("submit", function (e) {
                        const quanHuyen =
                            document.getElementById("quanHuyen").value;
                        const phuongXa =
                            document.getElementById("phuongXa").value;
                        const soNha = document.getElementById("soNha").value;
                        const tenDuong =
                            document.getElementById("tenDuong").value;

                        if (!quanHuyen || !phuongXa || !soNha || !tenDuong) {
                            e.preventDefault();

                            if (!quanHuyen) {
                                document
                                    .getElementById("quanHuyen")
                                    .classList.add("is-invalid");
                            }
                            if (!phuongXa) {
                                document
                                    .getElementById("phuongXa")
                                    .classList.add("is-invalid");
                            }
                            if (!soNha) {
                                document
                                    .getElementById("soNha")
                                    .classList.add("is-invalid");
                            }
                            if (!tenDuong) {
                                document
                                    .getElementById("tenDuong")
                                    .classList.add("is-invalid");
                            }

                            alert(
                                "Vui lòng nhập đầy đủ địa chỉ: Số nhà, Tên đường, Phường/Xã, Quận/Huyện"
                            );
                        }
                    });
            });
        </script>
    </body>
</html>
