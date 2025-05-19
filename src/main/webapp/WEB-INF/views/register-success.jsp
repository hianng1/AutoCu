<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đăng ký thành công - AutoCu</title>
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
                        <div class="card-body p-4 text-center">
                            <i
                                class="fas fa-envelope text-primary fa-5x mb-3"
                            ></i>
                            <h2 class="card-title mb-4">Đăng ký thành công!</h2>
                            <div class="alert alert-success">
                                ${message != null ? message : 'Vui lòng kiểm tra
                                email của bạn để xác thực tài khoản.'}
                            </div>
                            <p class="mb-4">
                                Chúng tôi đã gửi một email xác thực đến địa chỉ
                                email mà bạn đã đăng ký.<br />
                                Vui lòng kiểm tra hộp thư đến và nhấn vào liên
                                kết xác thực để hoàn tất quá trình đăng ký.
                            </p>
                            <p class="mb-4">
                                <strong>Không nhận được email?</strong><br />
                                Hãy kiểm tra thư mục spam hoặc nhấn vào nút bên
                                dưới để gửi lại email xác thực.
                            </p>
                            <div class="d-flex justify-content-center gap-3">
                                <a
                                    href="/resend-verification"
                                    class="btn btn-outline-primary"
                                >
                                    <i class="fas fa-paper-plane me-2"></i> Gửi
                                    lại email xác thực
                                </a>
                                <a href="/login" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt me-2"></i> Đi
                                    đến trang đăng nhập
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
    </body>
</html>
