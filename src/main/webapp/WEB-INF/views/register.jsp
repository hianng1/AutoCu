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
                                    <div class="input-group">
                                        <input
                                            type="password"
                                            class="form-control"
                                            name="password"
                                            id="password"
                                            required
                                            pattern="(?=.*[a-z])(?=.*[A-Z]).{6,}"
                                        />
                                        <button
                                            class="btn btn-outline-secondary"
                                            type="button"
                                            id="togglePassword"
                                        >
                                            <i class="fas fa-eye-slash"></i>
                                        </button>
                                    </div>
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

                                <!-- Add confirmation password field -->
                                <div class="mb-3">
                                    <label
                                        for="confirmPassword"
                                        class="form-label"
                                        >Xác nhận mật khẩu</label
                                    >
                                    <div class="input-group">
                                        <input
                                            type="password"
                                            class="form-control"
                                            name="confirmPassword"
                                            id="confirmPassword"
                                            required
                                        />
                                        <button
                                            class="btn btn-outline-secondary"
                                            type="button"
                                            id="toggleConfirmPassword"
                                        >
                                            <i class="fas fa-eye-slash"></i>
                                        </button>
                                    </div>
                                    <div
                                        id="passwordMatchMessage"
                                        class="form-text"
                                    ></div>
                                    <div class="invalid-feedback">
                                        Mật khẩu xác nhận không khớp với mật
                                        khẩu.
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
            // Add show/hide password functionality
            document.addEventListener("DOMContentLoaded", function () {
                // Password fields and show/hide functionality
                const passwordInput = document.getElementById("password");
                const confirmPasswordInput =
                    document.getElementById("confirmPassword");
                const passwordMatchMessage = document.getElementById(
                    "passwordMatchMessage"
                );

                // Show/hide password for password field
                document
                    .getElementById("togglePassword")
                    .addEventListener("click", function () {
                        const icon = this.querySelector("i");

                        if (passwordInput.type === "password") {
                            passwordInput.type = "text";
                            icon.classList.remove("fa-eye-slash");
                            icon.classList.add("fa-eye");
                        } else {
                            passwordInput.type = "password";
                            icon.classList.remove("fa-eye");
                            icon.classList.add("fa-eye-slash");
                        }
                    });

                // Show/hide password for confirm password field
                document
                    .getElementById("toggleConfirmPassword")
                    .addEventListener("click", function () {
                        const icon = this.querySelector("i");

                        if (confirmPasswordInput.type === "password") {
                            confirmPasswordInput.type = "text";
                            icon.classList.remove("fa-eye-slash");
                            icon.classList.add("fa-eye");
                        } else {
                            confirmPasswordInput.type = "password";
                            icon.classList.remove("fa-eye");
                            icon.classList.add("fa-eye-slash");
                        }
                    });

                // Real-time password match checking
                function checkPasswordMatch() {
                    if (confirmPasswordInput.value === "") {
                        passwordMatchMessage.innerHTML = "";
                        passwordMatchMessage.className = "form-text";
                        return;
                    }

                    if (passwordInput.value === confirmPasswordInput.value) {
                        passwordMatchMessage.innerHTML = "Mật khẩu khớp";
                        passwordMatchMessage.className =
                            "form-text text-success";
                        confirmPasswordInput.classList.remove("is-invalid");
                        confirmPasswordInput.classList.add("is-valid");
                    } else {
                        passwordMatchMessage.innerHTML = "Mật khẩu không khớp";
                        passwordMatchMessage.className =
                            "form-text text-danger";
                        confirmPasswordInput.classList.remove("is-valid");
                        confirmPasswordInput.classList.add("is-invalid");
                    }
                }

                // Add event listeners for password matching
                passwordInput.addEventListener("keyup", checkPasswordMatch);
                confirmPasswordInput.addEventListener(
                    "keyup",
                    checkPasswordMatch
                );
            });

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
                            const confirmPasswordInput =
                                form.querySelector("#confirmPassword");

                            if (passwordInput && confirmPasswordInput) {
                                const passwordValue = passwordInput.value;
                                const confirmPasswordValue =
                                    confirmPasswordInput.value;
                                const hasUpperCase = /[A-Z]/.test(
                                    passwordValue
                                );
                                const hasLowerCase = /[a-z]/.test(
                                    passwordValue
                                );
                                const isLongEnough = passwordValue.length >= 6;
                                const passwordsMatch =
                                    passwordValue === confirmPasswordValue;

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

                                if (!passwordsMatch) {
                                    confirmPasswordInput.classList.add(
                                        "is-invalid"
                                    );
                                    event.preventDefault();
                                    event.stopPropagation();
                                } else {
                                    confirmPasswordInput.classList.remove(
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
                            "Đường Tôn Đức Thắng",
                            "Đường Mạc Thị Bưởi",
                            "Đường Lê Thánh Tôn",
                            "Đường Hồ Tùng Mậu",
                            "Đường Thái Văn Lung",
                            "Đường Huỳnh Thúc Kháng",
                        ],
                        "Phường Bến Thành": [
                            "Đường Lê Lai",
                            "Đường Phạm Ngũ Lão",
                            "Đường Nguyễn Thái Học",
                            "Đường Calmette",
                            "Đường Lý Tự Trọng",
                            "Đường Thủ Khoa Huân",
                            "Đường Nguyễn An Ninh",
                            "Đường Phó Đức Chính",
                            "Đường Yersin",
                        ],
                        "Phường Cầu Kho": [
                            "Đường Trần Hưng Đạo",
                            "Đường Nguyễn Cư Trinh",
                            "Đường Nguyễn Thị Nghĩa",
                            "Đường Cống Quỳnh",
                            "Đường Nguyễn Văn Cừ",
                            "Đường Trần Đình Xu",
                            "Đường Huỳnh Mẫn Đạt",
                            "Đường Châu Văn Liêm",
                        ],
                        "Phường Cầu Ông Lãnh": [
                            "Đường Nguyễn Thái Bình",
                            "Đường Cô Bắc",
                            "Đường Cô Giang",
                            "Đường Ký Con",
                            "Đường Hải Triều",
                            "Đường Nguyễn Công Trứ",
                            "Đường Nguyễn Văn Nguyễn",
                        ],
                        "Phường Cô Giang": [
                            "Đường Cô Giang",
                            "Đường Nguyễn Thái Bình",
                            "Đường Phạm Viết Chánh",
                            "Đường Nguyễn Trãi",
                            "Đường Trần Đình Xu",
                            "Đường Võ Văn Kiệt",
                        ],
                        "Phường Đa Kao": [
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Võ Văn Tần",
                            "Đường Nguyễn Thị Minh Khai",
                            "Đường Nguyễn Bỉnh Khiêm",
                            "Đường Huỳnh Khương Ninh",
                            "Đường Điện Biên Phủ",
                            "Đường Trương Định",
                            "Đường Cao Bá Quát",
                            "Đường Huyền Trân Công Chúa",
                        ],
                        "Phường Nguyễn Cư Trinh": [
                            "Đường Trần Hưng Đạo",
                            "Đường Nguyễn Cư Trinh",
                            "Đường Cống Quỳnh",
                            "Đường Bùi Viện",
                            "Đường Đề Thám",
                            "Đường Đỗ Quang Đẩu",
                            "Đường Nguyễn Trãi",
                            "Đường Nguyễn Cảnh Chân",
                        ],
                        "Phường Nguyễn Thái Bình": [
                            "Đường Nguyễn Thái Bình",
                            "Đường Phó Đức Chính",
                            "Đường Hồ Tùng Mậu",
                            "Đường Mạc Thị Bưởi",
                            "Đường Hàm Nghi",
                            "Đường Tôn Thất Đạm",
                            "Đường Thi Sách",
                        ],
                        "Phường Phạm Ngũ Lão": [
                            "Đường Phạm Ngũ Lão",
                            "Đường Đề Thám",
                            "Đường Bùi Viện",
                            "Đường Nguyễn Thái Học",
                            "Đường Trần Hưng Đạo",
                            "Đường Lê Lai",
                            "Đường Lý Tự Trọng",
                            "Đường Nguyễn An Ninh",
                            "Đường Cống Quỳnh",
                            "Đường Lương Hữu Khánh",
                        ],
                        "Phường Tân Định": [
                            "Đường Hai Bà Trưng",
                            "Đường Nguyễn Hữu Cầu",
                            "Đường Trần Quang Khải",
                            "Đường Nguyễn Phi Khanh",
                            "Đường Ngô Thời Nhiệm",
                            "Đường Phạm Ngọc Thạch",
                            "Đường Phan Kế Bính",
                            "Đường Phan Văn Đạt",
                        ],
                    },
                    "Quận 2": {
                        "Phường An Khánh": [
                            "Đường Mai Chí Thọ",
                            "Đường Trần Não",
                            "Đường Lương Định Của",
                            "Đường Xuân Thuỷ",
                            "Đường Đồng Văn Cống",
                            "Đường Nguyễn Bá Huân",
                        ],
                        "Phường An Lợi Đông": [
                            "Đường Nguyễn Duy Trinh",
                            "Đường Trường Lưu",
                            "Đường Lê Văn Thịnh",
                            "Đường Liên Phường",
                            "Đường Lê Quang Định",
                            "Đường Đặng Văn Bi",
                        ],
                        "Phường An Phú": [
                            "Đường Nguyễn Hoàng",
                            "Đường Quốc Hương",
                            "Đường Trần Lựu",
                            "Đường Cao Đức Lân",
                            "Đường Vũ Tông Phan",
                            "Đường Nguyễn Thị Định",
                        ],
                        "Phường Bình An": [
                            "Đường Mai Chí Thọ",
                            "Đường Lương Định Của",
                            "Đường Trần Não",
                            "Đường Nguyễn Văn Hưởng",
                            "Đường Quốc Hương",
                            "Đường Ngô Quang Huy",
                        ],
                        "Phường Bình Khánh": [
                            "Đường Đồng Văn Cống",
                            "Đường Nguyễn Thị Định",
                            "Đường Mai Chí Thọ",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Thịnh",
                            "Đường Liên Phường",
                        ],
                        "Phường Thủ Thiêm": [
                            "Đường Mai Chí Thọ",
                            "Đường Trần Bạch Đằng",
                            "Đường Nguyễn Cơ Thạch",
                            "Đường Nguyễn Duy Hiệu",
                            "Đường Lê Duẩn",
                            "Đường Tôn Đức Thắng",
                        ],
                        "Phường Thảo Điền": [
                            "Đường Xuân Thủy",
                            "Đường Nguyễn Văn Hưởng",
                            "Đường Quốc Hương",
                            "Đường Thảo Điền",
                            "Đường Nguyễn Duy Hiệu",
                            "Đường Ngô Quang Huy",
                        ],
                        "Phường Cát Lái": [
                            "Đường Nguyễn Thị Định",
                            "Đường Đồng Văn Cống",
                            "Đường Bùi Văn Ba",
                            "Đường Lê Văn Thịnh",
                            "Đường Trương Văn Bang",
                            "Đường Bình Trưng",
                        ],
                        "Phường Bình Trưng Đông": [
                            "Đường Đỗ Xuân Hợp",
                            "Đường Liên Phường",
                            "Đường Nguyễn Duy Trinh",
                            "Đường Trương Văn Bang",
                            "Đường Bình Trưng",
                            "Đường Bùi Tá Hán",
                        ],
                        "Phường Bình Trưng Tây": [
                            "Đường Đỗ Xuân Hợp",
                            "Đường Liên Phường",
                            "Đường Nguyễn Duy Trinh",
                            "Đường Trần Não",
                            "Đường Mai Chí Thọ",
                            "Đường Nguyễn Hoàng",
                        ],
                    },
                    "Quận 3": {
                        "Phường 1": [
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Võ Văn Tần",
                            "Đường Cao Thắng",
                            "Đường Lý Chính Thắng",
                            "Đường Trần Quốc Thảo",
                            "Đường Phạm Ngọc Thạch",
                        ],
                        "Phường 2": [
                            "Đường Nam Kỳ Khởi Nghĩa",
                            "Đường Lý Chính Thắng",
                            "Đường Trần Cao Vân",
                            "Đường Nguyễn Thị Diệu",
                            "Đường Lê Quý Đôn",
                            "Đường Phạm Ngọc Thạch",
                        ],
                        "Phường 3": [
                            "Đường Võ Thị Sáu",
                            "Đường Lê Thị Riêng",
                            "Đường Nguyễn Thiện Thuật",
                            "Đường Lê Văn Sỹ",
                            "Đường Huỳnh Tịnh Của",
                            "Đường Trần Quốc Thảo",
                        ],
                        "Phường 4": [
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Nguyễn Thông",
                            "Đường Võ Thị Sáu",
                            "Đường Phạm Đình Toái",
                            "Đường Lê Thị Riêng",
                            "Đường Nguyễn Thiện Thuật",
                        ],
                        "Phường 5": [
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Võ Văn Tần",
                            "Đường Trần Văn Đang",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Huỳnh Tịnh Của",
                            "Đường Lê Văn Sỹ",
                        ],
                        "Phường 6": [
                            "Đường Lý Chính Thắng",
                            "Đường Nam Kỳ Khởi Nghĩa",
                            "Đường Võ Văn Tần",
                            "Đường Cao Thắng",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Ngô Thời Nhiệm",
                        ],
                        "Phường 7": [
                            "Đường Nguyễn Thị Minh Khai",
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Võ Thị Sáu",
                            "Đường Ngô Gia Tự",
                            "Đường Trần Quốc Thảo",
                            "Đường Bà Huyện Thanh Quan",
                        ],
                        "Phường 8": [
                            "Đường Võ Văn Tần",
                            "Đường Bà Huyện Thanh Quan",
                            "Đường Trần Quốc Thảo",
                            "Đường Ngô Gia Tự",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Điện Biên Phủ",
                        ],
                        "Phường 9": [
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Võ Thị Sáu",
                            "Đường Bà Huyện Thanh Quan",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Trần Quang Diệu",
                            "Đường Cao Thắng",
                        ],
                        "Phường 10": [
                            "Đường Nguyễn Thị Minh Khai",
                            "Đường Điện Biên Phủ",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Cao Thắng",
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Võ Thị Sáu",
                        ],
                        "Phường 11": [
                            "Đường Nguyễn Thị Minh Khai",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Võ Thị Sáu",
                            "Đường Cao Thắng",
                            "Đường Nguyễn Thượng Hiền",
                        ],
                        "Phường 12": [
                            "Đường Nguyễn Thị Minh Khai",
                            "Đường Điện Biên Phủ",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Trương Định",
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Nguyễn Thiện Thuật",
                        ],
                        "Phường 13": [
                            "Đường Nguyễn Thị Minh Khai",
                            "Đường Nguyễn Đình Chiểu",
                            "Đường Võ Thị Sáu",
                            "Đường Trương Định",
                            "Đường Cao Thắng",
                            "Đường Rạch Bùng Binh",
                        ],
                    },
                    "Quận 4": {
                        "Phường 1": [
                            "Đường Khánh Hội",
                            "Đường Tôn Đản",
                            "Đường Đoàn Văn Bơ",
                            "Đường Vĩnh Khánh",
                            "Đường Nguyễn Tất Thành",
                            "Đường Hoàng Diệu",
                        ],
                        "Phường 2": [
                            "Đường Tôn Thất Thuyết",
                            "Đường Bến Vân Đồn",
                            "Đường Nguyễn Tất Thành",
                            "Đường Nguyễn Hữu Hào",
                            "Đường Vĩnh Khánh",
                            "Đường Xóm Chiếu",
                        ],
                        "Phường 3": [
                            "Đường Tôn Thất Thuyết",
                            "Đường Nguyễn Khoái",
                            "Đường Nguyễn Tất Thành",
                            "Đường Tôn Đản",
                            "Đường Vĩnh Khánh",
                            "Đường Xóm Chiếu",
                        ],
                        "Phường 4": [
                            "Đường Đoàn Văn Bơ",
                            "Đường Bến Vân Đồn",
                            "Đường Nguyễn Tất Thành",
                            "Đường Hoàng Diệu",
                            "Đường Khánh Hội",
                            "Đường Tôn Thất Thuyết",
                        ],
                        "Phường 5": [
                            "Đường Đoàn Văn Bơ",
                            "Đường Tôn Đản",
                            "Đường Nguyễn Tất Thành",
                            "Đường Hoàng Diệu",
                            "Đường Khánh Hội",
                            "Đường Xóm Chiếu",
                        ],
                        "Phường 6": [
                            "Đường Hoàng Diệu",
                            "Đường Tôn Đản",
                            "Đường Nguyễn Tất Thành",
                            "Đường Đoàn Văn Bơ",
                            "Đường Vĩnh Khánh",
                            "Đường Khánh Hội",
                        ],
                        "Phường 8": [
                            "Đường Hoàng Diệu",
                            "Đường Tôn Đản",
                            "Đường Nguyễn Tất Thành",
                            "Đường Đoàn Văn Bơ",
                            "Đường Vĩnh Khánh",
                            "Đường Nguyễn Khoái",
                        ],
                        "Phường 9": [
                            "Đường Nguyễn Tất Thành",
                            "Đường Bến Vân Đồn",
                            "Đường Vĩnh Khánh",
                            "Đường Tôn Thất Thuyết",
                            "Đường Nguyễn Khoái",
                            "Đường Xóm Chiếu",
                        ],
                        "Phường 10": [
                            "Đường Nguyễn Tất Thành",
                            "Đường Khánh Hội",
                            "Đường Tôn Đản",
                            "Đường Đoàn Văn Bơ",
                            "Đường Hoàng Diệu",
                            "Đường Nguyễn Khoái",
                        ],
                        "Phường 12": [
                            "Đường Bến Vân Đồn",
                            "Đường Nguyễn Tất Thành",
                            "Đường Hoàng Diệu",
                            "Đường Xóm Chiếu",
                            "Đường Tôn Thất Thuyết",
                            "Đường Vĩnh Khánh",
                        ],
                        "Phường 13": [
                            "Đường Bến Vân Đồn",
                            "Đường Nguyễn Tất Thành",
                            "Đường Tôn Thất Thuyết",
                            "Đường Vĩnh Khánh",
                            "Đường Nguyễn Khoái",
                            "Đường Xóm Chiếu",
                        ],
                        "Phường 14": [
                            "Đường Khánh Hội",
                            "Đường Tôn Đản",
                            "Đường Nguyễn Tất Thành",
                            "Đường Đoàn Văn Bơ",
                            "Đường Hoàng Diệu",
                            "Đường Vĩnh Khánh",
                        ],
                        "Phường 15": [
                            "Đường Nguyễn Tất Thành",
                            "Đường Đoàn Văn Bơ",
                            "Đường Tôn Đản",
                            "Đường Hoàng Diệu",
                            "Đường Khánh Hội",
                            "Đường Vĩnh Khánh",
                        ],
                        "Phường 16": [
                            "Đường Bến Vân Đồn",
                            "Đường Nguyễn Tất Thành",
                            "Đường Tôn Thất Thuyết",
                            "Đường Vĩnh Khánh",
                            "Đường Nguyễn Khoái",
                            "Đường Xóm Chiếu",
                        ],
                        "Phường 18": [
                            "Đường Nguyễn Tất Thành",
                            "Đường Hoàng Diệu",
                            "Đường Tôn Đản",
                            "Đường Đoàn Văn Bơ",
                            "Đường Vĩnh Khánh",
                            "Đường Khánh Hội",
                        ],
                    },
                    "Quận 5": {
                        "Phường 1": [
                            "Đường Trần Hưng Đạo",
                            "Đường Châu Văn Liêm",
                            "Đường Nguyễn Văn Cừ",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Lương Nhữ Học",
                            "Đường Nguyễn Trãi",
                        ],
                        "Phường 2": [
                            "Đường Trần Hưng Đạo",
                            "Đường Nguyễn Văn Cừ",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Châu Văn Liêm",
                            "Đường Lương Nhữ Học",
                            "Đường Châu Thị Vĩnh Tế",
                        ],
                        "Phường 3": [
                            "Đường Trần Hưng Đạo",
                            "Đường Châu Văn Liêm",
                            "Đường Nguyễn Văn Cừ",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Lương Nhữ Học",
                            "Đường Tăng Bạt Hổ",
                        ],
                        "Phường 4": [
                            "Đường Trần Hưng Đạo",
                            "Đường Nguyễn Văn Cừ",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Châu Văn Liêm",
                            "Đường Lương Nhữ Học",
                            "Đường Phù Đổng Thiên Vương",
                        ],
                        "Phường 5": [
                            "Đường Nguyễn Trãi",
                            "Đường An Dương Vương",
                            "Đường Trần Bình Trọng",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Lương Nhữ Học",
                            "Đường Ngô Quyền",
                        ],
                        "Phường 6": [
                            "Đường Nguyễn Trãi",
                            "Đường Trần Bình Trọng",
                            "Đường An Dương Vương",
                            "Đường Tản Đà",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Lương Nhữ Học",
                        ],
                        "Phường 7": [
                            "Đường Nguyễn Trãi",
                            "Đường Hùng Vương",
                            "Đường Trần Bình Trọng",
                            "Đường Ngô Quyền",
                            "Đường Hải Thượng Lãn Ông",
                            "Đường Lương Nhữ Học",
                        ],
                        "Phường 8": [
                            "Đường Nguyễn Trãi",
                            "Đường An Dương Vương",
                            "Đường Trần Bình Trọng",
                            "Đường Hùng Vương",
                            "Đường Ngô Quyền",
                            "Đường Tản Đà",
                        ],
                        "Phường 9": [
                            "Đường Nguyễn Trãi",
                            "Đường Hùng Vương",
                            "Đường An Dương Vương",
                            "Đường Trần Bình Trọng",
                            "Đường Tản Đà",
                            "Đường Ngô Quyền",
                        ],
                        "Phường 10": [
                            "Đường Nguyễn Trãi",
                            "Đường An Dương Vương",
                            "Đường Trần Phú",
                            "Đường Trần Bình Trọng",
                            "Đường Ngô Quyền",
                            "Đường Tản Đà",
                        ],
                        "Phường 11": [
                            "Đường Nguyễn Trãi",
                            "Đường Hùng Vương",
                            "Đường Trần Phú",
                            "Đường Trần Bình Trọng",
                            "Đường Tản Đà",
                            "Đường Ngô Quyền",
                        ],
                        "Phường 12": [
                            "Đường Nguyễn Trãi",
                            "Đường Trần Phú",
                            "Đường An Dương Vương",
                            "Đường Trần Bình Trọng",
                            "Đường Ngô Quyền",
                            "Đường Tản Đà",
                        ],
                        "Phường 13": [
                            "Đường Nguyễn Trãi",
                            "Đường Hùng Vương",
                            "Đường Trần Phú",
                            "Đường Trần Bình Trọng",
                            "Đường Ngô Quyền",
                            "Đường Tản Đà",
                        ],
                        "Phường 14": [
                            "Đường Nguyễn Chí Thanh",
                            "Đường An Dương Vương",
                            "Đường Trần Phú",
                            "Đường Lê Hồng Phong",
                            "Đường Ngô Quyền",
                            "Đường Trần Bình Trọng",
                        ],
                        "Phường 15": [
                            "Đường Nguyễn Chí Thanh",
                            "Đường Hùng Vương",
                            "Đường Lê Hồng Phong",
                            "Đường Trần Phú",
                            "Đường Ngô Quyền",
                            "Đường An Dương Vương",
                        ],
                    },
                    "Quận 6": {
                        "Phường 1": [
                            "Đường Hậu Giang",
                            "Đường Minh Phụng",
                            "Đường An Dương Vương",
                            "Đường Hùng Vương",
                            "Đường Nguyễn Văn Luông",
                            "Đường Bà Hom",
                        ],
                        "Phường 2": [
                            "Đường Hậu Giang",
                            "Đường Minh Phụng",
                            "Đường An Dương Vương",
                            "Đường Hùng Vương",
                            "Đường Nguyễn Văn Luông",
                            "Đường Tân Hóa",
                        ],
                        "Phường 3": [
                            "Đường Minh Phụng",
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường Nguyễn Văn Luông",
                            "Đường Bà Hom",
                            "Đường An Dương Vương",
                        ],
                        "Phường 4": [
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường An Dương Vương",
                            "Đường Hùng Vương",
                            "Đường Minh Phụng",
                            "Đường Nguyễn Văn Luông",
                        ],
                        "Phường 5": [
                            "Đường Minh Phụng",
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường An Dương Vương",
                            "Đường Nguyễn Văn Luông",
                            "Đường Bà Hom",
                        ],
                        "Phường 6": [
                            "Đường Hậu Giang",
                            "Đường Minh Phụng",
                            "Đường Tân Hóa",
                            "Đường An Dương Vương",
                            "Đường Nguyễn Văn Luông",
                            "Đường Bà Hom",
                        ],
                        "Phường 7": [
                            "Đường Hậu Giang",
                            "Đường Minh Phụng",
                            "Đường Tân Hóa",
                            "Đường An Dương Vương",
                            "Đường Nguyễn Văn Luông",
                            "Đường Bình Tiên",
                        ],
                        "Phường 8": [
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường Bà Hom",
                            "Đường An Dương Vương",
                            "Đường Minh Phụng",
                            "Đường Nguyễn Văn Luông",
                        ],
                        "Phường 9": [
                            "Đường Minh Phụng",
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường Bình Tiên",
                            "Đường Bà Hom",
                            "Đường Nguyễn Văn Luông",
                        ],
                        "Phường 10": [
                            "Đường Minh Phụng",
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường Bà Hom",
                            "Đường Nguyễn Văn Luông",
                            "Đường Bình Tiên",
                        ],
                        "Phường 11": [
                            "Đường Hậu Giang",
                            "Đường Minh Phụng",
                            "Đường Tân Hóa",
                            "Đường Bà Hom",
                            "Đường Bình Tiên",
                            "Đường Nguyễn Văn Luông",
                        ],
                        "Phường 12": [
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường Bà Hom",
                            "Đường Bình Tiên",
                            "Đường Minh Phụng",
                            "Đường Nguyễn Văn Luông",
                        ],
                        "Phường 13": [
                            "Đường Minh Phụng",
                            "Đường Hậu Giang",
                            "Đường Tân Hóa",
                            "Đường Bình Tiên",
                            "Đường Bà Hom",
                            "Đường Nguyễn Văn Luông",
                        ],
                        "Phường 14": [
                            "Đường Minh Phụng",
                            "Đường Hậu Giang",
                            "Đường Bình Tiên",
                            "Đường Bà Hom",
                            "Đường Tân Hóa",
                            "Đường Nguyễn Văn Luông",
                        ],
                    },
                    "Quận 7": {
                        "Phường Tân Thuận Đông": [
                            "Đường Huỳnh Tấn Phát",
                            "Đường Nguyễn Văn Linh",
                            "Đường Lưu Trọng Lư",
                            "Đường Phạm Hữu Lầu",
                            "Đường Trần Trọng Cung",
                            "Đường Bùi Văn Ba",
                        ],
                        "Phường Tân Thuận Tây": [
                            "Đường Nguyễn Văn Linh",
                            "Đường Huỳnh Tấn Phát",
                            "Đường Bùi Văn Ba",
                            "Đường Phạm Văn Nghị",
                            "Đường Trần Xuân Soạn",
                            "Đường Tân Trào",
                        ],
                        "Phường Tân Kiểng": [
                            "Đường Lâm Văn Bền",
                            "Đường Nguyễn Thị Thập",
                            "Đường Trần Xuân Soạn",
                            "Đường Huỳnh Tấn Phát",
                            "Đường Tân Mỹ",
                            "Đường Chuyên Dùng 9",
                        ],
                        "Phường Tân Hưng": [
                            "Đường Nguyễn Thị Thập",
                            "Đường Tân Mỹ",
                            "Đường Phạm Thái Bường",
                            "Đường Tân Quy",
                            "Đường Lâm Văn Bền",
                            "Đường Nguyễn Hữu Thọ",
                        ],
                        "Phường Phú Mỹ": [
                            "Đường Hoàng Quốc Việt",
                            "Đường Đào Trí",
                            "Đường Phạm Hữu Lầu",
                            "Đường Huỳnh Tấn Phát",
                            "Đường Võ Chí Công",
                            "Đường Nguyễn Lương Bằng",
                        ],
                        "Phường Bình Thuận": [
                            "Đường Huỳnh Tấn Phát",
                            "Đường Phạm Hữu Lầu",
                            "Đường Đào Tông Nguyên",
                            "Đường Lê Văn Lương",
                            "Đường Nguyễn Bình",
                            "Đường Trần Xuân Soạn",
                        ],
                        "Phường Phú Thuận": [
                            "Đường Huỳnh Tấn Phát",
                            "Đường Tôn Thất Thuyết",
                            "Đường Tân Phú",
                            "Đường Phạm Thái Bường",
                            "Đường Tôn Thất Thuyết",
                            "Đường Nguyễn Văn Linh",
                        ],
                        "Phường Tân Phong": [
                            "Đường Nguyễn Đức Cảnh",
                            "Đường Nguyễn Văn Linh",
                            "Đường Tân Trào",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Nguyễn Hữu Thọ",
                            "Đường Nguyễn Khắc Viện",
                        ],
                        "Phường Tân Phú": [
                            "Đường Đào Trí",
                            "Đường Lê Văn Thịnh",
                            "Đường Tân Phú",
                            "Đường Nguyễn Khắc Viện",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                        ],
                        "Phường Tân Quy": [
                            "Đường Nguyễn Thị Thập",
                            "Đường Lâm Văn Bền",
                            "Đường Chuyên Dùng 9",
                            "Đường Phạm Văn Nghị",
                            "Đường Tân Quy",
                            "Đường Huỳnh Tấn Phát",
                        ],
                    },
                    "Quận 8": {
                        "Phường 1": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 2": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 3": [
                            "Đường Phạm Thế Hiển",
                            "Đường Bến Bình Đông",
                            "Đường Cao Lỗ",
                            "Đường Dương Bá Trạc",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 4": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 5": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 6": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 7": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 8": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 9": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 10": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 11": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 12": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 13": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 14": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 15": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                        "Phường 16": [
                            "Đường Phạm Thế Hiển",
                            "Đường Dương Bá Trạc",
                            "Đường Cao Lỗ",
                            "Đường Bến Bình Đông",
                            "Đường Hưng Phú",
                            "Đường Nguyễn Chế Nghĩa",
                        ],
                    },
                    "Quận 9": {
                        "Phường Long Bình": [
                            "Đường Nguyễn Xiển",
                            "Đường Long Thuận",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Tam Đa",
                            "Đường Long Phước",
                        ],
                        "Phường Long Thạnh Mỹ": [
                            "Đường Nguyễn Xiển",
                            "Đường Long Thuận",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Tam Đa",
                            "Đường Long Phước",
                        ],
                        "Phường Tân Phú": [
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Nguyễn Duy Trinh",
                            "Đường Tam Đa",
                            "Đường Long Phước",
                            "Đường Long Thuận",
                        ],
                        "Phường Hiệp Phú": [
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Trương Văn Thành",
                            "Đường Man Thiện",
                            "Đường Quang Trung",
                            "Đường Võ Văn Ngân",
                        ],
                        "Phường Tăng Nhơn Phú A": [
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Man Thiện",
                            "Đường Trương Văn Thành",
                            "Đường Nguyễn Duy Trinh",
                            "Đường Lê Văn Thịnh",
                        ],
                        "Phường Tăng Nhơn Phú B": [
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Man Thiện",
                            "Đường Trương Văn Thành",
                            "Đường Nguyễn Duy Trinh",
                            "Đường Lê Văn Thịnh",
                        ],
                        "Phường Phước Long A": [
                            "Đường Nguyễn Duy Trinh",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Man Thiện",
                            "Đường Trương Văn Thành",
                            "Đường Lê Văn Thịnh",
                        ],
                        "Phường Phước Long B": [
                            "Đường Nguyễn Duy Trinh",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Man Thiện",
                            "Đường Trương Văn Thành",
                            "Đường Lê Văn Thịnh",
                        ],
                        "Phường Trường Thạnh": [
                            "Đường Nguyễn Xiển",
                            "Đường Long Thuận",
                            "Đường Long Phước",
                            "Đường Tam Đa",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                        ],
                        "Phường Long Phước": [
                            "Đường Nguyễn Xiển",
                            "Đường Long Thuận",
                            "Đường Long Phước",
                            "Đường Tam Đa",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                        ],
                        "Phường Long Trường": [
                            "Đường Nguyễn Xiển",
                            "Đường Long Thuận",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Tam Đa",
                            "Đường Long Phước",
                        ],
                        "Phường Phú Hữu": [
                            "Đường Nguyễn Xiển",
                            "Đường Long Thuận",
                            "Đường Đỗ Xuân Hợp",
                            "Đường Lê Văn Việt",
                            "Đường Tam Đa",
                            "Đường Long Phước",
                        ],
                    },
                    "Quận 10": {
                        "Phường 1": [
                            "Đường 3 Tháng 2",
                            "Đường Sư Vạn Hạnh",
                            "Đường Thành Thái",
                            "Đường Ngô Gia Tự",
                            "Đường Nguyễn Chí Thanh",
                            "Đường Nguyễn Kim",
                        ],
                        "Phường 2": [
                            "Đường Lý Thường Kiệt",
                            "Đường Sư Vạn Hạnh",
                            "Đường Ngô Quyền",
                            "Đường Nguyễn Chí Thanh",
                            "Đường Thành Thái",
                            "Đường Ngô Gia Tư",
                        ],
                        "Phường 9": [
                            "Đường Lý Thường Kiệt",
                            "Đường 3 Tháng 2",
                            "Đường Cao Thắng",
                            "Đường Điện Biên Phủ",
                            "Đường Nguyễn Tri Phương",
                            "Đường Bà Hạt",
                        ],
                        "Phường 10": [
                            "Đường Điện Biên Phủ",
                            "Đường Lê Hồng Phong",
                            "Đường Lý Thường Kiệt",
                            "Đường Nguyễn Tri Phương",
                            "Đường Cao Thắng",
                            "Đường Bà Hạt",
                        ],
                        "Phường 13": [
                            "Đường Cách Mạng Tháng 8",
                            "Đường Cao Thắng",
                            "Đường Nguyễn Chí Thanh",
                            "Đường Điện Biên Phủ",
                            "Đường Huỳnh Mẫn Đạt",
                            "Đường Tô Hiến Thành",
                        ],
                    },
                    "Quận 11": {
                        "Phường 1": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 2": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 3": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 4": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 5": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 6": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 7": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 8": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 9": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 10": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 11": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 12": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 13": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 14": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 15": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                        "Phường 16": [
                            "Đường 3 Tháng 2",
                            "Đường Lãnh Binh Thăng",
                            "Đường Lý Thường Kiệt",
                            "Đường Lê Đại Hành",
                            "Đường Hòa Bình",
                            "Đường Tôn Thất Hiệp",
                        ],
                    },
                    "Quận 12": {
                        "Phường An Phú Đông": [
                            "Đường Vườn Lài",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                            "Đường Trường Chinh",
                        ],
                        "Phường Đông Hưng Thuận": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Hiệp Thành": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Tân Chánh Hiệp": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Tân Hưng Thuận": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Tân Thới Hiệp": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Tân Thới Nhất": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Thạnh Lộc": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Thạnh Xuân": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Thới An": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                        "Phường Trung Mỹ Tây": [
                            "Đường Quốc Lộ 1A",
                            "Đường Tô Ký",
                            "Đường Nguyễn Văn Quá",
                            "Đường Lê Văn Khương",
                            "Đường Phan Văn Hớn",
                            "Đường Nguyễn Ảnh Thủ",
                        ],
                    },
                    "Quận Phú Nhuận": {
                        "Phường 1": [
                            "Đường Phan Đăng Lưu",
                            "Đường Đặng Văn Ngữ",
                            "Đường Hoa Phượng",
                            "Đường Hoa Lan",
                            "Đường Hoa Cau",
                            "Đường Nguyễn Đình Chính",
                        ],
                        "Phường 2": [
                            "Đường Phan Đăng Lưu",
                            "Đường Đặng Văn Ngữ",
                            "Đường Thích Quảng Đức",
                            "Đường Nguyễn Thượng Hiền",
                            "Đường Huỳnh Văn Bánh",
                            "Đường Nguyễn Trọng Tuyển",
                        ],
                        "Phường 3": [
                            "Đường Cao Thắng",
                            "Đường Nguyễn Kiệm",
                            "Đường Nguyễn Thượng Hiền",
                            "Đường Huỳnh Văn Bánh",
                            "Đường Thích Quảng Đức",
                            "Đường Phan Đình Phùng",
                        ],
                        "Phường 4": [
                            "Đường Hoàng Văn Thụ",
                            "Đường Hoa Sứ",
                            "Đường Nguyễn Văn Trỗi",
                            "Đường Phan Đình Phùng",
                            "Đường Nguyễn Trọng Tuyển",
                            "Đường Nguyễn Thượng Hiền",
                        ],
                        "Phường 5": [
                            "Đường Nguyễn Văn Trỗi",
                            "Đường Phan Đình Phùng",
                            "Đường Hoàng Văn Thụ",
                            "Đường Nguyễn Thượng Hiền",
                            "Đường Huỳnh Văn Bánh",
                            "Đường Trần Huy Liệu",
                        ],
                    },
                    "Quận Bình Thạnh": {
                        "Phường 1": [
                            "Đường Điện Biên Phủ",
                            "Đường Vũ Tùng",
                            "Đường Phan Văn Trị",
                            "Đường Lê Quang Định",
                            "Đường Trương Công Định",
                            "Đường Phan Đăng Lưu",
                        ],
                        "Phường 11": [
                            "Đường Nguyễn Xí",
                            "Đường Bạch Đằng",
                            "Đường D2",
                            "Đường Chu Văn An",
                            "Đường Nơ Trang Long",
                            "Đường Phan Văn Trị",
                        ],
                        "Phường 12": [
                            "Đường Phan Văn Trị",
                            "Đường D1",
                            "Đường D3",
                            "Đường Lê Quang Định",
                            "Đường Phạm Văn Đồng",
                            "Đường Võ Văn Ngân",
                        ],
                        "Phường 13": [
                            "Đường Lê Quang Định",
                            "Đường Cầu Kiệu",
                            "Đường Phạm Văn Đồng",
                            "Đường Xô Viết Nghệ Tĩnh",
                            "Đường Nơ Trang Long",
                            "Đường Bình Lợi",
                        ],
                        "Phường 28": [
                            "Đường Xô Viết Nghệ Tĩnh",
                            "Đường D5",
                            "Đường Bình Quới",
                            "Đường Thanh Đa",
                            "Đường Bình Lợi",
                            "Đường Nguyễn Cửu Vân",
                        ],
                    },
                    "Quận Tân Bình": {
                        "Phường 1": [
                            "Đường Cách Mạng Tháng Tám",
                            "Đường Nguyễn Trãi",
                            "Đường Lý Thường Kiệt",
                            "Đường Phạm Văn Hai",
                            "Đường Nguyễn Thái Bình",
                            "Đường Võ Thành Trang",
                        ],
                        "Phường 2": [
                            "Đường Lý Thường Kiệt",
                            "Đường Phổ Quang",
                            "Đường Nguyễn Thái Bình",
                            "Đường Phạm Văn Hai",
                            "Đường Võ Thành Trang",
                            "Đường Bùi Thị Xuân",
                        ],
                        "Phường 3": [
                            "Đường Trường Chinh",
                            "Đường Phạm Văn Hai",
                            "Đường Ngô Gia Tự",
                            "Đường Nguyễn Thái Bình",
                            "Đường Lê Văn Sỹ",
                            "Đường Nguyễn Minh Hoàng",
                        ],
                        "Phường 4": [
                            "Đường Trường Chinh",
                            "Đường Lý Thường Kiệt",
                            "Đường Bùi Thị Xuân",
                            "Đường Ba Vân",
                            "Đường Tân Tiến",
                            "Đường Nguyễn Hiền",
                        ],
                        "Phường 5": [
                            "Đường Bà Hạt",
                            "Đường Âu Cơ",
                            "Đường Lũy Bán Bích",
                            "Đường Thoại Ngọc Hầu",
                            "Đường Trần Văn Quang",
                            "Đường Nguyễn Cửu Đàm",
                        ],
                    },
                    "Quận Tân Phú": {
                        "Phường Hiệp Tân": [
                            "Đường Tân Hương",
                            "Đường Tân Quý",
                            "Đường Nguyễn Sơn",
                            "Đường Lũy Bán Bích",
                            "Đường Tân Hòa Đông",
                            "Đường Tây Thạnh",
                        ],
                        "Phường Hòa Thạnh": [
                            "Đường Lý Thường Kiệt",
                            "Đường Nguyễn Sơn",
                            "Đường Tân Kỳ Tân Quý",
                            "Đường Thoại Ngọc Hầu",
                            "Đường Lũy Bán Bích",
                            "Đường Trường Chinh",
                        ],
                        "Phường Phú Thạnh": [
                            "Đường Lũy Bán Bích",
                            "Đường Gò Dầu",
                            "Đường Tân Sơn Nhì",
                            "Đường Tân Hương",
                            "Đường Bình Long",
                            "Đường Nguyễn Sơn",
                        ],
                        "Phường Phú Thọ Hòa": [
                            "Đường Âu Cơ",
                            "Đường Tân Kỳ Tân Quý",
                            "Đường Lũy Bán Bích",
                            "Đường Nguyễn Sơn",
                            "Đường Thạch Lam",
                            "Đường Trần Thánh Tông",
                        ],
                        "Phường Phú Trung": [
                            "Đường Tân Hương",
                            "Đường Tân Quý",
                            "Đường Tân Hòa Đông",
                            "Đường Tân Sơn Nhì",
                            "Đường Nguyễn Sơn",
                            "Đường Lũy Bán Bích",
                        ],
                    },
                    "Quận Gò Vấp": {
                        "Phường 1": [
                            "Đường Phạm Văn Đồng",
                            "Đường Lê Đức Thọ",
                            "Đường Nguyễn Văn Lượng",
                            "Đường Thống Nhất",
                            "Đường Nguyễn Oanh",
                            "Đường Lê Văn Thọ",
                        ],
                        "Phường 3": [
                            "Đường Quang Trung",
                            "Đường Lê Văn Thọ",
                            "Đường Thống Nhất",
                            "Đường Nguyễn Oanh",
                            "Đường Phạm Văn Chiêu",
                            "Đường Dương Quảng Hàm",
                        ],
                        "Phường 4": [
                            "Đường Quang Trung",
                            "Đường Lê Văn Thọ",
                            "Đường Phạm Văn Đồng",
                            "Đường Lê Đức Thọ",
                            "Đường Nguyễn Văn Lượng",
                            "Đường Lê Quang Định",
                        ],
                        "Phường 5": [
                            "Đường Nguyễn Thái Sơn",
                            "Đường Nguyễn Văn Nghi",
                            "Đường Nguyễn Oanh",
                            "Đường Lê Văn Thọ",
                            "Đường Phạm Văn Đồng",
                            "Đường Lê Đức Thọ",
                        ],
                        "Phường 15": [
                            "Đường Lê Đức Thọ",
                            "Đường Phạm Văn Đồng",
                            "Đường Phan Văn Trị",
                            "Đường Nguyễn Văn Lượng",
                            "Đường Quang Trung",
                            "Đường Lê Quang Định",
                        ],
                    },
                    "Huyện Bình Chánh": {
                        "Thị trấn Tân Túc": [
                            "Đường Trần Văn Giàu",
                            "Đường Quốc Lộ 50",
                            "Đường Vĩnh Lộc",
                            "Đường Bùi Thanh Khiết",
                            "Đường Đinh Đức Thiện",
                            "Đường Nguyễn Hữu Trí",
                        ],
                        "Xã Bình Chánh": [
                            "Đường Quốc Lộ 50",
                            "Đường Nguyễn Văn Linh",
                            "Đường Trần Văn Giàu",
                            "Đường Vĩnh Lộc",
                            "Đường Đoàn Nguyễn Tuấn",
                            "Đường Nguyễn Cửu Phú",
                        ],
                        "Xã Tân Kiên": [
                            "Đường Quốc Lộ 1A",
                            "Đường Nguyễn Văn Linh",
                            "Đường Trần Văn Giàu",
                            "Đường Bùi Thanh Khiết",
                            "Đường Đinh Đức Thiện",
                            "Đường Đoàn Nguyễn Tuấn",
                        ],
                        "Xã Vĩnh Lộc A": [
                            "Đường Quốc Lộ 1A",
                            "Đường Trần Văn Giàu",
                            "Đường Vĩnh Lộc",
                            "Đường Tỉnh Lộ 10",
                            "Đường Lê Thị Hà",
                            "Đường Nguyễn Cửu Phú",
                        ],
                        "Xã Vĩnh Lộc B": [
                            "Đường Quốc Lộ 1A",
                            "Đường Trần Văn Giàu",
                            "Đường Vĩnh Lộc",
                            "Đường Tỉnh Lộ 10",
                            "Đường Lê Thị Hà",
                            "Đường Nguyễn Cửu Phú",
                        ],
                    },
                    "Huyện Củ Chi": {
                        "Thị trấn Củ Chi": [
                            "Đường Tỉnh Lộ 8",
                            "Đường Quốc Lộ 22",
                            "Đường Tỉnh Lộ 15",
                            "Đường Nguyễn Thị Sóc",
                            "Đường Võ Văn Bích",
                            "Đường Nguyễn Thị Rành",
                        ],
                        "Xã An Nhơn Tây": [
                            "Đường Tỉnh Lộ 8",
                            "Đường Quốc Lộ 22",
                            "Đường An Nhơn Tây",
                            "Đường Võ Văn Bích",
                            "Đường Nguyễn Thị Rành",
                            "Đường Phạm Văn Cội",
                        ],
                        "Xã Tân Phú Trung": [
                            "Đường Tỉnh Lộ 8",
                            "Đường Quốc Lộ 22",
                            "Đường Tân Phú Trung",
                            "Đường Võ Văn Bích",
                            "Đường Nguyễn Thị Sóc",
                            "Đường Nguyễn Thị Rành",
                        ],
                        "Xã Tân Thạnh Đông": [
                            "Đường Tỉnh Lộ 8",
                            "Đường Quốc Lộ 22",
                            "Đường Tân Thạnh Đông",
                            "Đường Võ Văn Bích",
                            "Đường Nguyễn Thị Rành",
                            "Đường Phạm Văn Cội",
                        ],
                        "Xã Trung An": [
                            "Đường Tỉnh Lộ 8",
                            "Đường Quốc Lộ 22",
                            "Đường Trung An",
                            "Đường Võ Văn Bích",
                            "Đường Nguyễn Thị Sóc",
                            "Đường Nguyễn Thị Rành",
                        ],
                    },
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
