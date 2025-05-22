<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Gửi lại email xác thực - AutoCu</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
        />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            rel="stylesheet"
        />
    </head>
    <body>
        <jsp:include page="/common/header.jsp" />

        <main class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow-sm">
                        <div class="card-body p-4">
                            <h2 class="card-title text-center mb-4">
                                Gửi lại email xác thực
                            </h2>

                            <c:if test="${not empty message}">
                                <div
                                    class="${message.contains('thành công') ? 'alert alert-success' : 'alert alert-danger'} mb-4"
                                >
                                    ${message}
                                </div>
                            </c:if>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i
                                        class="fas fa-exclamation-circle me-2"
                                    ></i
                                    >${error}
                                </div>
                            </c:if>

                            <c:if test="${not empty success}">
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle me-2"></i
                                    >${success}
                                </div>
                            </c:if>

                            <p class="text-muted mb-4">
                                Nhập email đăng ký của bạn để nhận lại email xác
                                thực.
                            </p>

                            <form
                                action="/resend-verification"
                                method="post"
                                class="needs-validation"
                                novalidate
                            >
                                <div class="mb-3">
                                    <label for="email" class="form-label"
                                        >Email đã đăng ký</label
                                    >
                                    <input
                                        type="email"
                                        class="form-control"
                                        id="email"
                                        name="email"
                                        required
                                        placeholder="Nhập email bạn đã dùng để đăng ký"
                                    />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập địa chỉ email hợp lệ
                                    </div>
                                </div>

                                <button
                                    type="submit"
                                    class="btn btn-primary w-100"
                                >
                                    <i class="fas fa-paper-plane me-2"></i> Gửi
                                    lại email xác thực
                                </button>
                            </form>

                            <div class="mt-4 text-center">
                                <a href="/login" class="text-decoration-none">
                                    <i class="fas fa-arrow-left me-1"></i> Quay
                                    lại trang đăng nhập
                                </a>
                            </div>
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

                const forms = document.querySelectorAll(".needs-validation");

                Array.from(forms).forEach((form) => {
                    form.addEventListener(
                        "submit",
                        (event) => {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }

                            form.classList.add("was-validated");
                        },
                        false
                    );
                });
            })();
        </script>
    </body>
</html>
