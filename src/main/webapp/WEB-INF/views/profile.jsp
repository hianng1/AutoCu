<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ page import="java.util.List" %> <%@ page
import="poly.edu.Model.User" %> <%@ page import="java.text.NumberFormat" %> <%@
page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>AutoCu - Thông tin tài khoản</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
        />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            rel="stylesheet"
        />
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap"
            rel="stylesheet"
        />

        <style>
            body {
                font-family: "Roboto", sans-serif;
                background-color: #f3f4f6;
                color: #1f2937;
            }

            .nav-pills .nav-link.active {
                background-color: #0d6efd;
                color: white;
            }

            .nav-pills .nav-link {
                color: #1f2937;
            }

            .input-group-text.password-toggle {
                cursor: pointer;
                background-color: #fff;
                border-left: none;
            }

            .form-control:focus {
                box-shadow: none;
                border-color: #80bdff;
            }

            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1050;
                display: none;
                opacity: 0;
                transition: opacity 0.5s ease-in-out;
            }

            .toast {
                padding: 15px;
                border-radius: 5px;
                color: white;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                margin-bottom: 10px;
                min-width: 250px;
                max-width: 350px;
            }

            .toast.success {
                background-color: #4caf50;
            }

            .toast.error {
                background-color: #f44336;
            }

            .btn-submit {
                background-color: #0d6efd;
                color: white;
            }

            .btn-submit:hover {
                background-color: #0b5ed7;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/common/header.jsp" />

        <div id="toastContainer" class="toast-container">
            <div id="toastMessage" class="toast"></div>
        </div>

        <div class="container py-5">
            <div class="row">
                <div class="col-lg-3">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <div
                                class="d-flex flex-column align-items-center text-center"
                            >
                                <img
                                    src="https://bootdey.com/img/Content/avatar/avatar7.png"
                                    alt="Admin"
                                    class="rounded-circle"
                                    width="150"
                                />
                                <div class="mt-3">
                                    <h4>${userInfo.hovaten}</h4>
                                    <p class="text-muted font-size-sm">
                                        ${userInfo.role}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card shadow-sm">
                        <div class="card-body">
                            <nav class="nav flex-column nav-pills">
                                <a
                                    class="nav-link active mb-2"
                                    id="profile-tab"
                                    data-bs-toggle="pill"
                                    href="#profile"
                                    >Thông tin tài khoản</a
                                >
                                <a
                                    class="nav-link mb-2"
                                    id="password-tab"
                                    data-bs-toggle="pill"
                                    href="#password"
                                    >Đổi mật khẩu</a
                                >
                                <a
                                    class="nav-link mb-2"
                                    id="orders-tab"
                                    data-bs-toggle="pill"
                                    href="#orders"
                                    >Lịch sử đơn hàng</a
                                >
                            </nav>
                        </div>
                    </div>

                    <div class="card mb-4 mt-4 shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <i class="fas fa-user-circle me-2"></i> Tài khoản
                            của tôi
                        </div>
                        <div class="list-group list-group-flush">
                            <a
                                href="${pageContext.request.contextPath}/profile"
                                class="list-group-item list-group-item-action active"
                            >
                                <i class="fas fa-user me-2"></i> Thông tin tài
                                khoản
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/user/orders"
                                class="list-group-item list-group-item-action"
                            >
                                <i class="fas fa-shopping-bag me-2"></i> Đơn
                                hàng của tôi
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/reviews/user-reviews"
                                class="list-group-item list-group-item-action"
                            >
                                <i class="fas fa-star me-2"></i> Đánh giá của
                                tôi
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/user/review-eligible"
                                class="list-group-item list-group-item-action"
                            >
                                <i class="fas fa-edit me-2"></i> Viết đánh giá
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="tab-content">
                        <!-- Profile Information Tab -->
                        <div class="tab-pane fade show active" id="profile">
                            <div class="card shadow-sm">
                                <div class="card-header bg-white">
                                    <h5 class="card-title mb-0">
                                        Thông tin cá nhân
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form
                                        id="profileUpdateForm"
                                        action="/profile/update"
                                        method="post"
                                        onsubmit="return confirmUpdate()"
                                    >
                                        <div class="mb-3">
                                            <label
                                                for="fullname"
                                                class="form-label"
                                                >Họ và tên</label
                                            >
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="fullname"
                                                name="fullname"
                                                value="${userInfo.hovaten}"
                                                required
                                            />
                                        </div>

                                        <div class="mb-3">
                                            <label
                                                for="email"
                                                class="form-label"
                                                >Email</label
                                            >
                                            <input
                                                type="email"
                                                class="form-control"
                                                id="email"
                                                name="email"
                                                value="${userInfo.email}"
                                                required
                                            />
                                        </div>

                                        <div class="mb-3">
                                            <label
                                                for="phone"
                                                class="form-label"
                                                >Số điện thoại</label
                                            >
                                            <input
                                                type="tel"
                                                class="form-control"
                                                id="phone"
                                                name="phone"
                                                value="${userInfo.sodienthoai}"
                                                pattern="[0-9]{10}"
                                                required
                                            />
                                            <div class="form-text">
                                                Vui lòng nhập đúng 10 số
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label
                                                for="address"
                                                class="form-label"
                                                >Địa chỉ</label
                                            >
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="address"
                                                name="address"
                                                value="${userInfo.diaChi}"
                                                required
                                            />
                                        </div>

                                        <button
                                            type="submit"
                                            class="btn btn-primary w-100"
                                        >
                                            Cập nhật thông tin
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Password Change Tab -->
                        <div class="tab-pane fade" id="password">
                            <div class="card shadow-sm">
                                <div class="card-header bg-white">
                                    <h5 class="card-title mb-0">
                                        Đổi mật khẩu
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form
                                        id="passwordChangeForm"
                                        action="/profile/change-password"
                                        method="post"
                                        onsubmit="return validatePasswordForm()"
                                    >
                                        <div class="mb-3">
                                            <label
                                                for="currentPassword"
                                                class="form-label"
                                                >Mật khẩu hiện tại</label
                                            >
                                            <div class="input-group">
                                                <input
                                                    type="password"
                                                    class="form-control"
                                                    id="currentPassword"
                                                    name="currentPassword"
                                                    required
                                                />
                                                <span
                                                    class="input-group-text password-toggle"
                                                    onclick="togglePassword('currentPassword', 'currentPasswordToggle')"
                                                >
                                                    <i
                                                        id="currentPasswordToggle"
                                                        class="fas fa-eye"
                                                    ></i>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label
                                                for="newPassword"
                                                class="form-label"
                                                >Mật khẩu mới</label
                                            >
                                            <div class="input-group">
                                                <input
                                                    type="password"
                                                    class="form-control"
                                                    id="newPassword"
                                                    name="newPassword"
                                                    pattern="(?=.*[a-z])(?=.*[A-Z]).{6,}"
                                                    required
                                                />
                                                <span
                                                    class="input-group-text password-toggle"
                                                    onclick="togglePassword('newPassword', 'newPasswordToggle')"
                                                >
                                                    <i
                                                        id="newPasswordToggle"
                                                        class="fas fa-eye"
                                                    ></i>
                                                </span>
                                            </div>
                                            <div class="form-text">
                                                Mật khẩu phải có ít nhất 6 ký
                                                tự, bao gồm chữ hoa và chữ
                                                thường
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label
                                                for="confirmPassword"
                                                class="form-label"
                                                >Xác nhận mật khẩu mới</label
                                            >
                                            <div class="input-group">
                                                <input
                                                    type="password"
                                                    class="form-control"
                                                    id="confirmPassword"
                                                    name="confirmPassword"
                                                    required
                                                />
                                                <span
                                                    class="input-group-text password-toggle"
                                                    onclick="togglePassword('confirmPassword', 'confirmPasswordToggle')"
                                                >
                                                    <i
                                                        id="confirmPasswordToggle"
                                                        class="fas fa-eye"
                                                    ></i>
                                                </span>
                                            </div>
                                            <div
                                                id="passwordMatchMessage"
                                                class="form-text"
                                            ></div>
                                        </div>

                                        <button
                                            type="submit"
                                            class="btn btn-primary w-100"
                                        >
                                            Đổi mật khẩu
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Orders History Tab -->
                        <div class="tab-pane fade" id="orders">
                            <div class="card shadow-sm">
                                <div class="card-header bg-white">
                                    <h5 class="card-title mb-0">
                                        Lịch sử đơn hàng
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="alert alert-info">
                                        Chức năng đang được phát triển. Vui lòng
                                        quay lại sau!
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Function to toggle password visibility
            function togglePassword(inputId, toggleId) {
                const passwordInput = document.getElementById(inputId);
                const toggleIcon = document.getElementById(toggleId);

                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    toggleIcon.classList.remove("fa-eye");
                    toggleIcon.classList.add("fa-eye-slash");
                } else {
                    passwordInput.type = "password";
                    toggleIcon.classList.remove("fa-eye-slash");
                    toggleIcon.classList.add("fa-eye");
                }
            }

            // Show toast notifications
            function showToast(message, type = 'success') {
                const toastContainer = document.getElementById('toastContainer');
                const toastMessage = document.getElementById('toastMessage');

                toastMessage.textContent = message;
                toastMessage.className = 'toast ' + type;

                toastContainer.style.display = 'block';
                setTimeout(() => {
                    toastContainer.style.opacity = 1;
                }, 10);

                setTimeout(() => {
                    toastContainer.style.opacity = 0;
                    setTimeout(() => {
                        toastContainer.style.display = 'none';
                    }, 500);
                }, 5000);
            }

            // Check for messages on page load
            window.onload = function() {
                <% String successMessage = (String) request.getAttribute("successMessage"); %>
                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>

                <% if (successMessage != null) { %>
                    showToast("<%= successMessage %>", 'success');
                <% } else if (errorMessage != null) { %>
                    showToast("<%= errorMessage %>", 'error');
                <% } %>

                // Add real-time password matching validation
                const newPasswordInput = document.getElementById('newPassword');
                const confirmPasswordInput = document.getElementById('confirmPassword');
                const passwordMatchMessage = document.getElementById('passwordMatchMessage');

                function checkPasswordMatch() {
                    if (confirmPasswordInput.value === "") {
                        passwordMatchMessage.innerHTML = "";
                        passwordMatchMessage.className = "form-text";
                        return;
                    }

                    if (newPasswordInput.value === confirmPasswordInput.value) {
                        passwordMatchMessage.innerHTML = "Mật khẩu khớp";
                        passwordMatchMessage.className = "form-text text-success";
                        confirmPasswordInput.classList.remove("is-invalid");
                        confirmPasswordInput.classList.add("is-valid");
                    } else {
                        passwordMatchMessage.innerHTML = "Mật khẩu không khớp";
                        passwordMatchMessage.className = "form-text text-danger";
                        confirmPasswordInput.classList.remove("is-valid");
                        confirmPasswordInput.classList.add("is-invalid");
                    }
                }

                if (newPasswordInput && confirmPasswordInput) {
                    newPasswordInput.addEventListener('keyup', checkPasswordMatch);
                    confirmPasswordInput.addEventListener('keyup', checkPasswordMatch);
                }
            };

            // Confirm profile update
            function confirmUpdate() {
                return confirm("Bạn có chắc chắn muốn cập nhật thông tin tài khoản?");
            }

            // Validate password form before submission
            function validatePasswordForm() {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                // Check if passwords match
                if (newPassword !== confirmPassword) {
                    showToast("Mật khẩu xác nhận không khớp với mật khẩu mới", 'error');
                    return false;
                }

                // Check password complexity
                const hasUpperCase = /[A-Z]/.test(newPassword);
                const hasLowerCase = /[a-z]/.test(newPassword);
                const isLongEnough = newPassword.length >= 6;

                if (!isLongEnough || !hasUpperCase || !hasLowerCase) {
                    showToast("Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ hoa và chữ thường", 'error');
                    return false;
                }

                return confirm("Bạn có chắc chắn muốn đổi mật khẩu?");
            }
        </script>
    </body>
</html>
