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
                        <div class="card-body text-center p-5">
                            <div class="mb-4">
                                <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
                            </div>
                            <h1 class="h3 mb-3">Đăng ký thành công!</h1>
                            
                            <c:if test="${not empty message}">
                                <div class="alert alert-info">${message}</div>
                            </c:if>
                            
                            <p class="text-muted mb-4">
                                Chúng tôi đã gửi một email xác nhận đến địa chỉ email bạn đã đăng ký. 
                                Vui lòng kiểm tra hộp thư đến và nhấp vào liên kết xác nhận để kích hoạt tài khoản của bạn.
                            </p>
                            
                            <div class="alert alert-warning">
                                <p><i class="fas fa-exclamation-triangle me-2"></i> <strong>Không nhận được email?</strong></p>
                                <ul class="mb-0 text-start ps-3">
                                    <li>Vui lòng kiểm tra thư mục spam hoặc thùng rác</li>
                                    <li>Đảm bảo địa chỉ email đã nhập chính xác</li>
                                    <li>Đợi vài phút vì email có thể bị trì hoãn</li>
                                </ul>
                            </div>
                            
                            <div class="d-grid gap-2 mt-4">
                                <a href="/resend-verification" class="btn btn-outline-primary">
                                    <i class="fas fa-paper-plane me-2"></i>Gửi lại email xác nhận
                                </a>
                                <a href="/login" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đi đến trang đăng nhập
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
</html>
