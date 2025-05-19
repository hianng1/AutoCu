<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Viết đánh giá - ${product.tenPhuKien}</title>
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
            .rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-end;
            }
            .rating input {
                display: none;
            }
            .rating label {
                cursor: pointer;
                width: 40px;
                height: 40px;
                font-size: 2rem;
                color: #ccc;
                padding: 5px;
            }
            .rating input:checked ~ label,
            .rating label:hover,
            .rating label:hover ~ label {
                color: #ffb700;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/common/header.jsp" />

        <div class="container py-5">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h1 class="h4 mb-0 fw-bold">Đánh giá sản phẩm</h1>
                        </div>
                        <div class="card-body">
                            <div class="d-flex mb-4">
                                <div class="flex-shrink-0">
                                    <img
                                        src="${pageContext.request.contextPath}/imgs/${product.anhDaiDien}"
                                        alt="${product.tenPhuKien}"
                                        class="img-thumbnail"
                                        style="
                                            width: 100px;
                                            height: 100px;
                                            object-fit: cover;
                                        "
                                    />
                                </div>
                                <div class="ms-3">
                                    <h5 class="fw-bold">
                                        ${product.tenPhuKien}
                                    </h5>
                                    <p class="text-muted mb-0">
                                        ${product.hangSanXuat}
                                    </p>
                                    <p class="text-danger fw-bold">
                                        <fmt:formatNumber
                                            value="${product.gia}"
                                            type="currency"
                                            currencySymbol=""
                                        />đ
                                    </p>
                                </div>
                            </div>

                            <form
                                action="${pageContext.request.contextPath}/reviews/submit"
                                method="post"
                            >
                                <input
                                    type="hidden"
                                    name="productId"
                                    value="${product.accessoryID}"
                                />
                                <input
                                    type="hidden"
                                    name="orderId"
                                    value="${orderId}"
                                />

                                <div class="mb-4">
                                    <label class="form-label fw-bold"
                                        >Đánh giá của bạn</label
                                    >
                                    <div class="rating">
                                        <input
                                            type="radio"
                                            name="rating"
                                            value="5"
                                            id="star5"
                                            required
                                        />
                                        <label for="star5" title="5 sao"
                                            ><i class="fas fa-star"></i
                                        ></label>
                                        <input
                                            type="radio"
                                            name="rating"
                                            value="4"
                                            id="star4"
                                        />
                                        <label for="star4" title="4 sao"
                                            ><i class="fas fa-star"></i
                                        ></label>
                                        <input
                                            type="radio"
                                            name="rating"
                                            value="3"
                                            id="star3"
                                        />
                                        <label for="star3" title="3 sao"
                                            ><i class="fas fa-star"></i
                                        ></label>
                                        <input
                                            type="radio"
                                            name="rating"
                                            value="2"
                                            id="star2"
                                        />
                                        <label for="star2" title="2 sao"
                                            ><i class="fas fa-star"></i
                                        ></label>
                                        <input
                                            type="radio"
                                            name="rating"
                                            value="1"
                                            id="star1"
                                        />
                                        <label for="star1" title="1 sao"
                                            ><i class="fas fa-star"></i
                                        ></label>
                                    </div>
                                    <div
                                        id="rating-message"
                                        class="form-text text-muted mt-2"
                                    >
                                        Hãy chọn số sao đánh giá
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label
                                        for="content"
                                        class="form-label fw-bold"
                                        >Nhận xét của bạn</label
                                    >
                                    <textarea
                                        class="form-control"
                                        id="content"
                                        name="content"
                                        rows="5"
                                        placeholder="Hãy chia sẻ trải nghiệm của bạn về sản phẩm này..."
                                    ></textarea>
                                    <div class="form-text text-muted">
                                        Nhận xét của bạn sẽ giúp người khác đưa
                                        ra quyết định tốt hơn.
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <a
                                        href="${pageContext.request.contextPath}/reviews/my-reviews"
                                        class="btn btn-outline-secondary"
                                    >
                                        <i class="fas fa-arrow-left me-2"></i
                                        >Quay lại
                                    </a>
                                    <button
                                        type="submit"
                                        class="btn btn-primary"
                                    >
                                        <i class="fas fa-paper-plane me-2"></i
                                        >Gửi đánh giá
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/common/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Update the rating message when user selects a rating
            document
                .querySelectorAll('input[name="rating"]')
                .forEach((input) => {
                    input.addEventListener("change", function () {
                        const ratingMessage =
                            document.getElementById("rating-message");
                        const value = this.value;
                        const messages = {
                            1: "Rất không hài lòng",
                            2: "Không hài lòng",
                            3: "Bình thường",
                            4: "Hài lòng",
                            5: "Rất hài lòng",
                        };
                        ratingMessage.textContent =
                            messages[value] || "Hãy chọn số sao đánh giá";
                    });
                });
        </script>
    </body>
</html>
