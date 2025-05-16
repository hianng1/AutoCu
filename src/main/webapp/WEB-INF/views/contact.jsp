<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>AutoCu - Liên Hệ</title>

        <%-- Using Tailwind CSS for utility classes --%>
        <script src="https://cdn.tailwindcss.com"></script>

        <%-- Font Awesome for icons --%>
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            rel="stylesheet"
        />

        <%-- Google Fonts - Roboto --%>
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap"
            rel="stylesheet"
        />

        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
        />

        <style>
            /* Custom styles to enhance the design */
            body {
                font-family: "Roboto", ui-sans-serif, system-ui, -apple-system,
                    BlinkMacSystemFont, "Segoe UI", "Helvetica Neue", Arial,
                    "Noto Sans", sans-serif, "Apple Color Emoji",
                    "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
                background-color: #f4f7f6;
                color: #333;
                line-height: 1.6;
            }

            /* Contact banner style */
            .contact-banner {
                background: linear-gradient(
                        rgba(0, 0, 0, 0.6),
                        rgba(0, 0, 0, 0.6)
                    ),
                    url("https://images.unsplash.com/photo-1521791136064-7986c2920216?q=80&w=2069&auto=format&fit=crop");
                background-size: cover;
                background-position: center;
                color: white;
                padding: 4rem 0;
                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.7);
            }

            .contact-banner h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .contact-banner p {
                font-size: 1.15rem;
                margin-top: 0.5rem;
            }

            /* General section styling */
            .autocu-section {
                background-color: #fff;
                padding: 2.5rem;
                margin-bottom: 2rem;
                border-radius: 0.75rem;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            }

            /* Typography */
            .autocu-section h2 {
                font-size: 1.8rem;
                font-weight: 700;
                color: #1a202c;
                margin-bottom: 1.8rem;
                position: relative;
                padding-bottom: 0.5rem;
            }

            .autocu-section h2::after {
                content: "";
                position: absolute;
                left: 0;
                bottom: 0;
                width: 60px;
                height: 4px;
                background-color: #f97316;
                border-radius: 2px;
            }

            .autocu-section h3 {
                font-size: 1.4rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1.2rem;
            }

            .autocu-section p {
                font-size: 1.05rem;
                color: #4a5568;
                line-height: 1.7;
                margin-bottom: 1.2rem;
            }

            .autocu-section p:last-child {
                margin-bottom: 0;
            }

            /* Container utility */
            .container-custom {
                max-width: 1200px;
                margin-left: auto;
                margin-right: auto;
                padding-left: 1rem;
                padding-right: 1rem;
            }

            /* Form styling */
            .contact-form .form-control {
                padding: 0.75rem;
                border-radius: 0.5rem;
                border: 1px solid #e2e8f0;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            .contact-form .form-control:focus {
                border-color: #f97316;
                box-shadow: 0 0 0 3px rgba(249, 115, 22, 0.2);
                outline: none;
            }

            .contact-form label {
                font-weight: 500;
                margin-bottom: 0.5rem;
                display: block;
                color: #4a5568;
            }

            .contact-btn {
                background-color: #f97316;
                color: white;
                font-weight: 600;
                padding: 0.75rem 2rem;
                border-radius: 0.5rem;
                border: none;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 4px 10px rgba(249, 115, 22, 0.3);
            }

            .contact-btn:hover {
                background-color: #ea580c;
                box-shadow: 0 6px 15px rgba(249, 115, 22, 0.4);
            }

            .contact-btn:active {
                background-color: #c2410c;
                transform: scale(0.98);
                box-shadow: 0 2px 8px rgba(249, 115, 22, 0.5);
            }

            /* Contact info box */
            .contact-info-item {
                display: flex;
                align-items: flex-start;
                margin-bottom: 1.5rem;
            }

            .contact-info-item .icon {
                flex-shrink: 0;
                width: 40px;
                height: 40px;
                background-color: #fff7ed;
                color: #f97316;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                font-size: 1.2rem;
                border: 1px solid rgba(249, 115, 22, 0.2);
            }

            .contact-info-item .content {
                flex-grow: 1;
            }

            .contact-info-item h3 {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 0.3rem;
                color: #1a202c;
            }

            .contact-info-item p {
                font-size: 1rem;
                color: #4a5568;
                margin-bottom: 0;
            }

            /* Map container */
            .map-container {
                height: 400px;
                width: 100%;
                border-radius: 0.75rem;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                border: 1px solid #e2e8f0;
            }

            .map-container iframe {
                width: 100%;
                height: 100%;
                border: 0;
            }

            /* Social icons */
            .social-links {
                display: flex;
                gap: 1rem;
                margin-top: 1.5rem;
            }

            .social-links a {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                background-color: #f97316;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.1rem;
                transition: all 0.3s;
            }

            .social-links a:hover {
                background-color: #ea580c;
                transform: translateY(-3px);
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            }

            /* FAQ accordion custom styles */
            .faq-item {
                border: 1px solid #e2e8f0;
                border-radius: 0.5rem;
                margin-bottom: 1rem;
                overflow: hidden;
            }

            .faq-question {
                padding: 1.25rem;
                background-color: #f8fafc;
                cursor: pointer;
                font-weight: 600;
                color: #1a202c;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: background-color 0.3s;
            }

            .faq-question:hover {
                background-color: #f1f5f9;
            }

            .faq-answer {
                padding: 1.25rem;
                border-top: 1px solid #e2e8f0;
                background-color: white;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .contact-info-grid {
                    grid-template-columns: 1fr;
                }

                .contact-banner {
                    padding: 3rem 0;
                }

                .contact-banner h1 {
                    font-size: 2rem;
                }

                .autocu-section {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <%-- Include Header --%>
        <jsp:include page="/common/header.jsp"></jsp:include>

        <%-- Use flex to push footer down and add padding to main content --%>
        <div class="flex flex-col min-h-screen">
            <%-- Banner --%>
            <div class="contact-banner">
                <div class="container-custom text-center">
                    <h1 class="drop-shadow-md">Liên Hệ Với Chúng Tôi</h1>
                    <p class="max-w-3xl mx-auto">
                        Chúng tôi luôn sẵn sàng hỗ trợ bạn mọi lúc. Hãy liên hệ
                        ngay với AutoCu.
                    </p>
                </div>
            </div>

            <%-- Main content area --%>
            <div class="container-custom py-12 flex-grow">
                <%-- Contact Grid - Two columns on desktop, one column on mobile
                --%>
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <%-- Contact Form Column --%>
                    <div class="autocu-section">
                        <h2>Gửi Tin Nhắn Cho Chúng Tôi</h2>
                        <p class="mb-6">
                            Hãy điền thông tin vào mẫu dưới đây, chúng tôi sẽ
                            liên hệ lại với bạn trong thời gian sớm nhất.
                        </p>

                        <form class="contact-form">
                            <div class="mb-4">
                                <label for="fullName">Họ và tên</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    id="fullName"
                                    placeholder="Nhập họ và tên của bạn"
                                    required
                                />
                            </div>

                            <div class="mb-4">
                                <label for="email">Email</label>
                                <input
                                    type="email"
                                    class="form-control"
                                    id="email"
                                    placeholder="Nhập địa chỉ email của bạn"
                                    required
                                />
                            </div>

                            <div class="mb-4">
                                <label for="phone">Số điện thoại</label>
                                <input
                                    type="tel"
                                    class="form-control"
                                    id="phone"
                                    placeholder="Nhập số điện thoại của bạn"
                                />
                            </div>

                            <div class="mb-4">
                                <label for="subject">Chủ đề</label>
                                <select
                                    class="form-control"
                                    id="subject"
                                    required
                                >
                                    <option value="" selected disabled>
                                        Chọn chủ đề
                                    </option>
                                    <option value="rental">Thuê xe</option>
                                    <option value="technical">
                                        Hỗ trợ kỹ thuật
                                    </option>
                                    <option value="billing">Thanh toán</option>
                                    <option value="partnership">
                                        Hợp tác kinh doanh
                                    </option>
                                    <option value="other">Khác</option>
                                </select>
                            </div>

                            <div class="mb-5">
                                <label for="message">Nội dung tin nhắn</label>
                                <textarea
                                    class="form-control"
                                    id="message"
                                    rows="5"
                                    placeholder="Nhập nội dung tin nhắn của bạn"
                                    required
                                ></textarea>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="contact-btn">
                                    <i class="fas fa-paper-plane me-2"></i> Gửi
                                    Tin Nhắn
                                </button>
                            </div>
                        </form>
                    </div>

                    <%-- Contact Information Column --%>
                    <div>
                        <%-- Contact Info Box --%>
                        <div class="autocu-section mb-8">
                            <h2>Thông Tin Liên Hệ</h2>

                            <div class="contact-info-item">
                                <div class="icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="content">
                                    <h3>Địa chỉ</h3>
                                    <p>
                                        Tòa nhà Innovation, 108 Nguyễn Hoàng,
                                        Phường An Phú, Quận 2, TP. Hồ Chí Minh
                                    </p>
                                </div>
                            </div>

                            <div class="contact-info-item">
                                <div class="icon">
                                    <i class="fas fa-phone-alt"></i>
                                </div>
                                <div class="content">
                                    <h3>Điện thoại</h3>
                                    <p>
                                        Hotline:
                                        <a
                                            href="tel:19002090"
                                            class="text-orange-600 hover:underline"
                                            >1900 2090</a
                                        >
                                    </p>
                                    <p>
                                        Hỗ trợ:
                                        <a
                                            href="tel:0987654321"
                                            class="text-orange-600 hover:underline"
                                            >0987 654 321</a
                                        >
                                    </p>
                                </div>
                            </div>

                            <div class="contact-info-item">
                                <div class="icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <div class="content">
                                    <h3>Email</h3>
                                    <p>
                                        <a
                                            href="mailto:info@autocu.com.vn"
                                            class="text-orange-600 hover:underline"
                                            >info@autocu.com.vn</a
                                        >
                                    </p>
                                    <p>
                                        <a
                                            href="mailto:support@autocu.com.vn"
                                            class="text-orange-600 hover:underline"
                                            >support@autocu.com.vn</a
                                        >
                                    </p>
                                </div>
                            </div>

                            <div class="contact-info-item">
                                <div class="icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="content">
                                    <h3>Giờ làm việc</h3>
                                    <p>Thứ Hai - Thứ Sáu: 8:00 - 18:00</p>
                                    <p>Thứ Bảy: 8:00 - 12:00</p>
                                    <p>Chủ Nhật: Nghỉ</p>
                                </div>
                            </div>

                            <div class="social-links">
                                <a href="#" aria-label="Facebook"
                                    ><i class="fab fa-facebook-f"></i
                                ></a>
                                <a href="#" aria-label="Instagram"
                                    ><i class="fab fa-instagram"></i
                                ></a>
                                <a href="#" aria-label="Twitter"
                                    ><i class="fab fa-twitter"></i
                                ></a>
                                <a href="#" aria-label="LinkedIn"
                                    ><i class="fab fa-linkedin-in"></i
                                ></a>
                                <a href="#" aria-label="YouTube"
                                    ><i class="fab fa-youtube"></i
                                ></a>
                            </div>
                        </div>

                        <%-- Map Box --%>
                        <div class="autocu-section">
                            <h2>Bản Đồ</h2>
                            <div class="map-container">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.722910977441!2d106.61362590893513!3d10.832504189275157!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752bcde67315d9%3A0x9f103df98b4f8a91!2zMTY0IFTDom4gVGjhu5tpIE5o4bqldCAxMywgVMOibiBUaOG7m2kgTmjhuqV0LCBRdeG6rW4gMTIsIEjhu5MgQ2jDrSBNaW5oIDcwMDAwLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1747381515759!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- FAQ Section --%>
                <div class="autocu-section mt-10">
                    <h2>Câu Hỏi Thường Gặp</h2>

                    <div class="faq-container">
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this)">
                                <span
                                    >Làm thế nào để đặt thuê xe trên
                                    AutoCu?</span
                                >
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="faq-answer" style="display: none">
                                <p>
                                    Để đặt thuê xe trên AutoCu, bạn cần thực
                                    hiện các bước sau:
                                </p>
                                <ol class="list-decimal pl-5 space-y-2">
                                    <li>
                                        Đăng ký tài khoản trên website hoặc ứng
                                        dụng AutoCu
                                    </li>
                                    <li>
                                        Tìm kiếm xe phù hợp với nhu cầu của bạn
                                    </li>
                                    <li>Chọn ngày và thời gian thuê</li>
                                    <li>
                                        Hoàn tất thanh toán để xác nhận đơn đặt
                                        xe
                                    </li>
                                    <li>
                                        Nhận xe tại địa điểm đã chọn hoặc được
                                        giao đến địa chỉ của bạn
                                    </li>
                                </ol>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this)">
                                <span
                                    >Tôi cần những giấy tờ gì để thuê xe từ
                                    AutoCu?</span
                                >
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="faq-answer" style="display: none">
                                <p>
                                    Để thuê xe từ AutoCu, bạn cần có các giấy tờ
                                    sau:
                                </p>
                                <ul class="list-disc pl-5 space-y-2">
                                    <li>CMND/CCCD/Hộ chiếu còn hiệu lực</li>
                                    <li>
                                        Giấy phép lái xe hợp lệ (đối với loại xe
                                        bạn muốn thuê)
                                    </li>
                                    <li>
                                        Một trong các giấy tờ: Hộ khẩu/KT3/Giấy
                                        xác nhận tạm trú/Giấy tờ nhà
                                    </li>
                                </ul>
                                <p class="mt-3">
                                    Lưu ý: Các giấy tờ trên đều phải là bản gốc
                                    và còn hiệu lực.
                                </p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this)">
                                <span
                                    >Chính sách bảo hiểm của AutoCu như thế
                                    nào?</span
                                >
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="faq-answer" style="display: none">
                                <p>
                                    Tất cả các xe trên AutoCu đều được bảo hiểm
                                    đầy đủ theo quy định pháp luật. Chúng tôi
                                    cung cấp các gói bảo hiểm sau:
                                </p>
                                <ul class="list-disc pl-5 space-y-2">
                                    <li>Bảo hiểm cơ bản (bắt buộc)</li>
                                    <li>Bảo hiểm vật chất</li>
                                    <li>Bảo hiểm toàn diện (Premium)</li>
                                </ul>
                                <p class="mt-3">
                                    Mỗi gói bảo hiểm có mức miễn thường và phạm
                                    vi bảo hiểm khác nhau. Bạn có thể đọc chi
                                    tiết trong điều khoản dịch vụ hoặc liên hệ
                                    với bộ phận CSKH để được tư vấn.
                                </p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this)">
                                <span
                                    >Làm thế nào để trở thành đối tác chủ xe của
                                    AutoCu?</span
                                >
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="faq-answer" style="display: none">
                                <p>
                                    Để trở thành đối tác chủ xe của AutoCu, bạn
                                    cần:
                                </p>
                                <ol class="list-decimal pl-5 space-y-2">
                                    <li>
                                        Đăng ký tài khoản trên hệ thống AutoCu
                                    </li>
                                    <li>
                                        Cung cấp thông tin và giấy tờ xe đầy đủ
                                        (đăng ký xe, đăng kiểm, bảo hiểm)
                                    </li>
                                    <li>
                                        Cung cấp thông tin cá nhân và tài khoản
                                        ngân hàng
                                    </li>
                                    <li>Ký hợp đồng hợp tác với AutoCu</li>
                                    <li>
                                        Tham gia buổi hướng dẫn sử dụng hệ thống
                                    </li>
                                </ol>
                                <p class="mt-3">
                                    Sau khi hoàn tất các bước trên, xe của bạn
                                    sẽ được kiểm tra kỹ thuật và đưa lên hệ
                                    thống cho thuê.
                                </p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this)">
                                <span>AutoCu có giao xe tận nơi không?</span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="faq-answer" style="display: none">
                                <p>
                                    Có, AutoCu có cung cấp dịch vụ giao xe tận
                                    nơi với mức phí phụ thuộc vào khoảng cách
                                    giao xe. Khi đặt xe, bạn có thể chọn địa
                                    điểm nhận xe phù hợp và hệ thống sẽ thông
                                    báo phí giao xe (nếu có).
                                </p>
                                <p class="mt-3">
                                    Lưu ý, dịch vụ giao xe tận nơi chỉ áp dụng
                                    trong phạm vi thành phố và tùy thuộc vào
                                    chính sách của từng chủ xe.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Include Footer --%>
            <jsp:include page="/common/footer.jsp"></jsp:include>
        </div>

        <script>
            // Function to toggle FAQ answers
            function toggleFaq(element) {
                const answer = element.nextElementSibling;
                const icon = element.querySelector("i");

                if (answer.style.display === "none") {
                    answer.style.display = "block";
                    icon.classList.remove("fa-chevron-down");
                    icon.classList.add("fa-chevron-up");
                } else {
                    answer.style.display = "none";
                    icon.classList.remove("fa-chevron-up");
                    icon.classList.add("fa-chevron-down");
                }
            }

            // Form validation
            document
                .querySelector(".contact-form")
                .addEventListener("submit", function (e) {
                    e.preventDefault();

                    // Simple validation
                    const fullName = document
                        .getElementById("fullName")
                        .value.trim();
                    const email = document.getElementById("email").value.trim();
                    const message = document
                        .getElementById("message")
                        .value.trim();

                    if (!fullName || !email || !message) {
                        alert("Vui lòng điền đầy đủ thông tin bắt buộc!");
                        return;
                    }

                    // Email validation
                    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailPattern.test(email)) {
                        alert("Vui lòng nhập địa chỉ email hợp lệ!");
                        return;
                    }

                    // If validation passes, we would normally submit the form
                    // For demo purposes, just show success message
                    alert(
                        "Cảm ơn bạn đã liên hệ với chúng tôi! Chúng tôi sẽ phản hồi sớm nhất có thể."
                    );
                    this.reset();
                });
        </script>
    </body>
</html>
