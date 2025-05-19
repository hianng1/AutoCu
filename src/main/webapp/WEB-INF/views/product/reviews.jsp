<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đánh giá sản phẩm - ${product.tenPhuKien}</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
        />
        <style>
            .star-rating {
                color: #ccc;
            }
            .star-rating .filled {
                color: #ffb700;
            }
            .review-card {
                border-bottom: 1px solid #eee;
                padding: 20px 0;
            }
            .review-card:last-child {
                border-bottom: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/common/header.jsp" />

        <div class="container py-5">
            <c:if test="${not empty successMessage}">
                <div
                    class="alert alert-success alert-dismissible fade show"
                    role="alert"
                >
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                    ></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div
                    class="alert alert-danger alert-dismissible fade show"
                    role="alert"
                >
                    <i class="fas fa-exclamation-circle me-2"></i
                    >${errorMessage}
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                    ></button>
                </div>
            </c:if>

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="d-flex">
                        <div class="flex-shrink-0">
                            <img
                                src="${pageContext.request.contextPath}/imgs/${product.anhDaiDien}"
                                alt="${product.tenPhuKien}"
                                class="img-thumbnail"
                                style="
                                    width: 150px;
                                    height: 150px;
                                    object-fit: cover;
                                "
                            />
                        </div>
                        <div class="ms-3">
                            <h1 class="h3 fw-bold">${product.tenPhuKien}</h1>
                            <p class="text-muted mb-2">
                                ${product.hangSanXuat}
                            </p>
                            <p class="text-danger fw-bold fs-4">
                                <fmt:formatNumber
                                    value="${product.gia}"
                                    type="currency"
                                    currencySymbol=""
                                />đ
                            </p>
                            <div class="d-flex align-items-center mt-2">
                                <div class="star-rating me-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i
                                            class="fas fa-star ${i <= averageRating ? 'filled' : ''}"
                                        ></i>
                                    </c:forEach>
                                </div>
                                <span class="text-muted">
                                    <fmt:formatNumber
                                        value="${averageRating}"
                                        maxFractionDigits="1"
                                    />
                                    (${reviewCount} đánh giá)
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 text-md-end mt-3 mt-md-0">
                    <a
                        href="${pageContext.request.contextPath}/accessories"
                        class="btn btn-outline-secondary"
                    >
                        <i class="fas fa-arrow-left me-2"></i>Quay lại mua sắm
                    </a>

                    <c:if test="${canReview}">
                        <a
                            href="${pageContext.request.contextPath}/reviews/write/${product.accessoryID}"
                            class="btn btn-primary ms-2"
                        >
                            <i class="fas fa-star me-2"></i>Viết đánh giá
                        </a>
                    </c:if>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-header bg-white py-3">
                    <h2 class="h5 fw-bold mb-0">
                        <i class="fas fa-comments me-2"></i>Đánh giá của khách
                        hàng (${reviewCount})
                    </h2>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="review" items="${reviews}">
                                <div class="review-card px-4">
                                    <div
                                        class="d-flex justify-content-between align-items-center mb-2"
                                    >
                                        <div>
                                            <h5 class="mb-0 fw-bold">
                                                ${review.user.hovaten}
                                            </h5>
                                            <div class="star-rating">
                                                <c:forEach
                                                    begin="1"
                                                    end="5"
                                                    var="i"
                                                >
                                                    <i
                                                        class="fas fa-star ${i <= review.saoDanhGia ? 'filled' : ''}"
                                                    ></i>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="text-muted small">
                                            <fmt:formatDate
                                                value="${review.ngayDanhGia}"
                                                pattern="dd/MM/yyyy HH:mm"
                                            />
                                        </div>
                                    </div>
                                    <p class="mb-0">${review.noiDung}</p>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="p-4 text-center">
                                <i
                                    class="fas fa-comment-slash text-muted mb-3"
                                    style="font-size: 3rem"
                                ></i>
                                <p>Sản phẩm này chưa có đánh giá nào.</p>
                                <c:if test="${canReview}">
                                    <p>
                                        Hãy là người đầu tiên đánh giá sản phẩm
                                        này!
                                    </p>
                                    <a
                                        href="${pageContext.request.contextPath}/reviews/write/${product.accessoryID}"
                                        class="btn btn-outline-primary mt-2"
                                    >
                                        <i class="fas fa-star me-2"></i>Viết
                                        đánh giá
                                    </a>
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
