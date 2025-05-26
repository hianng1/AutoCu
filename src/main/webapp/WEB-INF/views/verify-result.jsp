<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Xác thực tài khoản - AutoCu</title>
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
                        <div class="card-body text-center p-5">
                            <c:choose>
                                <c:when test="${success}">
                                    <div class="mb-4">
                                        <i
                                            class="fas fa-check-circle text-success"
                                            style="font-size: 4rem"
                                        ></i>
                                    </div>
                                    <h2 class="mb-3">Xác thực thành công!</h2>
                                    <p class="text-muted mb-4">
                                        Tài khoản của bạn đã được xác thực thành
                                        công. Bây giờ bạn có thể đăng nhập và sử
                                        dụng đầy đủ các tính năng của AutoCu.
                                    </p>
                                    <a
                                        href="${pageContext.request.contextPath}/login"
                                        class="btn btn-primary"
                                    >
                                        <i class="fas fa-sign-in-alt me-2"></i
                                        >Đăng nhập ngay
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="mb-4">
                                        <i
                                            class="fas fa-times-circle text-danger"
                                            style="font-size: 4rem"
                                        ></i>
                                    </div>
                                    <h2 class="mb-3">
                                        Xác thực không thành công
                                    </h2>
                                    <p class="text-muted mb-4">${message}</p>
                                    <div
                                        class="d-flex justify-content-center gap-3"
                                    >
                                        <a
                                            href="${pageContext.request.contextPath}/resend-verification"
                                            class="btn btn-outline-primary"
                                        >
                                            <i
                                                class="fas fa-paper-plane me-2"
                                            ></i
                                            >Gửi lại email xác thực
                                        </a>
                                        <a
                                            href="${pageContext.request.contextPath}/"
                                            class="btn btn-outline-secondary"
                                        >
                                            <i class="fas fa-home me-2"></i
                                            >Trang chủ
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="/common/footer.jsp" />
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
