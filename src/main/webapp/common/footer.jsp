<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<style>
    .footer-wave {
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 320'%3E%3Cpath fill='%23111827' fill-opacity='1' d='M0,288L48,272C96,256,192,224,288,213.3C384,203,480,213,576,229.3C672,245,768,267,864,261.3C960,256,1056,224,1152,208C1248,192,1344,192,1392,192L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z'%3E%3C/path%3E%3C/svg%3E");
        height: 120px;
        background-size: cover;
        background-repeat: no-repeat;
        margin-bottom: -1px;
    }

    .footer-main {
        background-color: #111827;
        position: relative;
        z-index: 10;
    }

    .footer-gradient {
        background: linear-gradient(
            90deg,
            rgba(249, 115, 22, 0.15) 0%,
            rgba(249, 115, 22, 0) 100%
        );
        border-radius: 8px;
        padding: 1.5rem;
    }

    .social-icon {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        background-color: rgba(255, 255, 255, 0.1);
        transition: all 0.3s ease;
    }

    .social-icon:hover {
        background-color: #f97316;
        transform: translateY(-3px);
    }

    .footer-contact-item {
        transition: all 0.3s ease;
    }

    .footer-contact-item:hover {
        transform: translateX(5px);
    }

    .footer-link {
        position: relative;
        padding-left: 0;
        transition: all 0.3s ease;
    }

    .footer-link:before {
        content: "";
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 0;
        height: 1px;
        background-color: #f97316;
        transition: width 0.3s ease;
    }

    .footer-link:hover {
        color: #f97316 !important;
        padding-left: 8px;
    }
    .footer-link:hover:before {
        width: 100%;
    }

    .back-to-top {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 45px;
        height: 45px;
        background: #f97316;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
        z-index: 99;
        box-shadow: 0 4px 10px rgba(249, 115, 22, 0.3);
    }

    .back-to-top.visible {
        opacity: 1;
        visibility: visible;
    }

    .back-to-top:hover {
        background: #ea580c;
        transform: translateY(-3px);
    }
</style>

<!-- Wave separator -->
<div class="footer-wave"></div>

<!-- Main Footer -->
<footer class="footer-main text-white">
    <div class="container px-4 py-12 mx-auto">
        <!-- Top footer section -->
        <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Company info -->
            <div class="footer-gradient">
                <img
                    src="/imgs/logo2.png"
                    alt="AutoCu Logo"
                    class="h-14 mb-5"
                />
                <p class="text-gray-300 mb-5 leading-relaxed">
                    AutoCu - Điểm đến đáng tin cậy cho tất cả nhu cầu về ô tô đã
                    qua sử dụng và phụ kiện chính hãng với chất lượng tốt nhất.
                </p>
                <div class="flex space-x-3 mt-6">
                    <a href="#" class="social-icon">
                        <i class="fab fa-facebook-f text-white"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-twitter text-white"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-instagram text-white"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-youtube text-white"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-tiktok text-white"></i>
                    </a>
                </div>
            </div>

            <!-- Quick links -->
            <div>
                <h3 class="text-xl font-bold mb-5 flex items-center">
                    <span
                        class="w-8 h-1 bg-orange-500 inline-block mr-3"
                    ></span>
                    Liên kết nhanh
                </h3>
                <ul class="space-y-3">
                    <li>
                        <a
                            href="/trangchu"
                            class="text-gray-300 hover:text-white transition-colors footer-link inline-block"
                        >
                            Trang chủ
                        </a>
                    </li>
                    <li>
                        <a
                            href="/cars"
                            class="text-gray-300 hover:text-white transition-colors footer-link inline-block"
                        >
                            Xe ô tô
                        </a>
                    </li>
                    <li>
                        <a
                            href="/accessories"
                            class="text-gray-300 hover:text-white transition-colors footer-link inline-block"
                        >
                            Phụ kiện
                        </a>
                    </li>
                    <li>
                        <a
                            href="/contact"
                            class="text-gray-300 hover:text-white transition-colors footer-link inline-block"
                        >
                            Liên hệ
                        </a>
                    </li>
                    <li>
                        <a
                            href="#"
                            class="text-gray-300 hover:text-white transition-colors footer-link inline-block"
                        >
                            Blog & Tin tức
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Contact info -->
            <div>
                <h3 class="text-xl font-bold mb-5 flex items-center">
                    <span
                        class="w-8 h-1 bg-orange-500 inline-block mr-3"
                    ></span>
                    Thông tin liên hệ
                </h3>
                <ul class="space-y-4">
                    <li class="flex items-start footer-contact-item">
                        <div class="mt-1 mr-3 text-orange-500">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <span class="text-gray-300"
                            >123 Đường ABC, Quận 1, TP.HCM</span
                        >
                    </li>
                    <li class="flex items-start footer-contact-item">
                        <div class="mt-1 mr-3 text-orange-500">
                            <i class="fas fa-phone"></i>
                        </div>
                        <a
                            href="tel:+84382948198"
                            class="text-gray-300 hover:text-white"
                            >+84 382 948 198</a
                        >
                    </li>
                    <li class="flex items-start footer-contact-item">
                        <div class="mt-1 mr-3 text-orange-500">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <a
                            href="mailto:autocu@gmail.com"
                            class="text-gray-300 hover:text-white"
                            >autocu@gmail.com</a
                        >
                    </li>
                    <li class="flex items-start footer-contact-item">
                        <div class="mt-1 mr-3 text-orange-500">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="text-gray-300">
                            <div>Thứ 2 - Thứ 6: 8:00 - 20:00</div>
                            <div>Thứ 7 - Chủ nhật: 9:00 - 22:00</div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Bottom footer section -->
        <div class="border-t border-gray-800 mt-10 pt-8">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <p class="text-gray-400 text-sm">
                    © 2024
                    <span class="text-orange-500 font-medium">AutoCu</span>. Tất
                    cả quyền được bảo lưu.
                </p>
                <div class="flex flex-wrap justify-center gap-4 mt-4 md:mt-0">
                    <a
                        href="#"
                        class="text-gray-400 hover:text-white text-sm transition-colors"
                        >Chính sách bảo mật</a
                    >
                    <a
                        href="#"
                        class="text-gray-400 hover:text-white text-sm transition-colors"
                        >Điều khoản sử dụng</a
                    >
                    <a
                        href="#"
                        class="text-gray-400 hover:text-white text-sm transition-colors"
                        >Chính sách hoàn tiền</a
                    >
                    <a
                        href="#"
                        class="text-gray-400 hover:text-white text-sm transition-colors"
                        >Trợ giúp</a
                    >
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Back to top button -->
<div id="backToTop" class="back-to-top">
    <i class="fas fa-arrow-up"></i>
</div>

<script>
    // Back to top button functionality
    document.addEventListener("DOMContentLoaded", function () {
        const backToTopButton = document.getElementById("backToTop");

        window.addEventListener("scroll", function () {
            if (window.pageYOffset > 300) {
                backToTopButton.classList.add("visible");
            } else {
                backToTopButton.classList.remove("visible");
            }
        });

        backToTopButton.addEventListener("click", function () {
            window.scrollTo({
                top: 0,
                behavior: "smooth",
            });
        });
    });
</script>
