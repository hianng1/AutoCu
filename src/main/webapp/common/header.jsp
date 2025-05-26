<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- Top bar - ẩn trên mobile -->
<div class="bg-gray-100 py-2 text-sm hidden md:block">
    <div class="container mx-auto flex justify-between items-center px-4">
        <div class="flex items-center space-x-4">
            <select name="" id="" class="text-sm">
                <option>
                    VN
                    <i class="fas fa-chevron-down"> </i>
                </option>
                <option>EN</option>
            </select>
            <div>
                Gọi ngay cho chúng tôi:
                <a class="text-gray-600" href="">
                    <b>+84 382 948 198</b>
                </a>
            </div>
            <div>
                Gửi mail cho chúng tôi:
                <a class="text-gray-600" href="">
                    <b>autocu@gmail.com</b>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Header - ẩn trên mobile -->
<header class="bg-white py-4 shadow-sm hidden md:block">
    <div class="container mx-auto flex justify-between items-center px-4">
        <div class="flex items-center space-x-3">
            <a href="${pageContext.request.contextPath}/trangchu">
                <img
                    src="${pageContext.request.contextPath}/imgs/logo2.png"
                    alt="logo"
                    class="h-16 max-w-[300px] object-contain"
                />
            </a>
        </div>
        <div class="relative flex items-center w-full max-w-2xl mx-auto">
            <form
                action="${pageContext.request.contextPath}/search"
                method="get"
                class="flex w-full"
            >
                <input
                    name="keyword"
                    class="border border-gray-300 rounded-l px-4 py-2 w-full"
                    placeholder="Tìm kiếm sản phẩm..."
                    type="text"
                    value="${param.keyword}"
                />
                <select
                    name="type"
                    class="border-y border-gray-300 px-2 py-2 text-gray-700 bg-white"
                >
                    <option value="all">Tất cả</option>
                    <option value="xe">Xe ô tô</option>
                    <option value="phukien">Phụ kiện</option>
                </select>
                <button
                    type="submit"
                    class="bg-orange-500 text-white px-6 py-2 rounded-r hover:bg-orange-600 transition-colors"
                >
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
        <div class="flex items-center space-x-4">
            <!-- Wishlist Icon -->
            <sec:authorize access="isAuthenticated()">
                <div class="text-center">
                    <a
                        href="${pageContext.request.contextPath}/wishlist"
                        class="relative flex items-center"
                        title="Danh sách yêu thích"
                    >
                        <i
                            class="fas fa-heart text-2xl text-gray-700 hover:text-red-500 transition-colors"
                        ></i>
                        <span
                            id="wishlist-count"
                            class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
                            style="display: none"
                        >
                            0
                        </span>
                    </a>
                </div>
            </sec:authorize>

            <!-- Cart Icon -->
            <div class="text-center">
                <div class="flex items-center justify-center space-x-2">
                    <a
                        href="${pageContext.request.contextPath}/cart/views"
                        class="relative flex items-center"
                        title="Giỏ hàng"
                    >
                        <c:if test="${not empty CART_ITEMS}">
                            <span
                                class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
                            >
                                ${CART_ITEMS.size()}
                            </span>
                        </c:if>
                        <i
                            class="fas fa-shopping-cart text-2xl text-gray-700 hover:text-orange-500 transition-colors"
                        ></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Mobile Header - chỉ hiện trên mobile -->
<header class="bg-white py-3 shadow-md md:hidden">
    <div class="container mx-auto flex justify-between items-center px-4">
        <!-- Logo -->
        <div class="flex items-center">
            <a href="${pageContext.request.contextPath}/trangchu">
                <img
                    src="${pageContext.request.contextPath}/imgs/logo2.png"
                    alt="logo"
                    class="h-10 max-w-[120px] object-contain"
                />
            </a>
        </div>

        <!-- Mobile Icons -->
        <div class="flex items-center space-x-4">
            <!-- Search Icon -->
            <button
                id="mobile-search-btn"
                class="text-orange-500 text-xl hover:text-orange-600 transition-colors"
            >
                <i class="fas fa-search"></i>
            </button>

            <!-- Wishlist Icon -->
            <sec:authorize access="isAuthenticated()">
                <a
                    href="${pageContext.request.contextPath}/wishlist"
                    class="relative text-orange-500 text-xl hover:text-orange-600 transition-colors"
                    title="Danh sách yêu thích"
                >
                    <i class="fas fa-heart"></i>
                    <span
                        id="mobile-wishlist-count"
                        class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
                        style="display: none"
                    >
                        0
                    </span>
                </a>
            </sec:authorize>

            <!-- Cart Icon -->
            <a
                href="${pageContext.request.contextPath}/cart/views"
                class="relative text-orange-500 text-xl hover:text-orange-600 transition-colors"
                title="Giỏ hàng"
            >
                <i class="fas fa-shopping-cart"></i>
                <c:if test="${not empty CART_ITEMS}">
                    <span
                        class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
                    >
                        ${CART_ITEMS.size()}
                    </span>
                </c:if>
            </a>

            <!-- Menu Toggle -->
            <button
                id="mobile-menu-btn"
                class="text-orange-500 text-xl hover:text-orange-600 transition-colors"
            >
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </div>

    <!-- Mobile Search Bar -->
    <div
        id="mobile-search"
        class="hidden bg-white mx-4 mt-3 rounded-lg shadow-lg"
    >
        <form
            action="${pageContext.request.contextPath}/search"
            method="get"
            class="flex"
        >
            <input
                name="keyword"
                class="border-0 rounded-l-lg px-3 py-2 w-full focus:outline-none"
                placeholder="Tìm kiếm sản phẩm..."
                type="text"
                value="${param.keyword}"
            />
            <select
                name="type"
                class="border-0 px-2 py-2 text-gray-700 bg-white focus:outline-none"
            >
                <option value="all">Tất cả</option>
                <option value="xe">Xe ô tô</option>
                <option value="phukien">Phụ kiện</option>
            </select>
            <button
                type="submit"
                class="bg-orange-500 text-white px-4 py-2 rounded-r-lg"
            >
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>
</header>

<!-- Desktop Navigation -->
<nav class="bg-orange-500 text-white hidden md:block">
    <div
        class="container mx-auto flex justify-between items-center whitespace-nowrap px-4"
    >
        <div class="flex items-center flex-nowrap">
            <a
                href="${pageContext.request.contextPath}/trangchu"
                class="px-4 py-3 hover:bg-orange-600 inline-block"
                ><i class="fas fa-home"></i> Trang Chủ</a
            >
            <a href="/cars" class="px-4 py-3 hover:bg-orange-600 inline-block"
                >Xe oto cũ</a
            >
            <a
                href="/accessories"
                class="px-4 py-3 hover:bg-orange-600 inline-block"
                >Phụ kiện xe</a
            >
            <a
                href="/support"
                class="px-4 py-3 hover:bg-orange-600 inline-block"
                >Hỗ trợ</a
            >
            <a
                href="/theodoidonhang"
                class="px-4 py-3 hover:bg-orange-600 inline-block"
                >Tra cứu</a
            >
            <a
                href="/contact"
                class="px-4 py-3 hover:bg-orange-600 inline-block"
                >Liên hệ</a
            >
        </div>

        <div class="flex items-center flex-shrink-0 ml-4">
            <%-- Kiểm tra nếu người dùng ĐÃ xác thực --%>
            <sec:authorize access="isAuthenticated()">
                <%-- Lấy username từ Principal của Spring Security --%>
                <a
                    href="${pageContext.request.contextPath}/profile"
                    class="px-4 py-3 font-medium hover:bg-orange-700"
                >
                    <i class="fas fa-user"></i>
                    <sec:authentication property="principal.username" />
                </a>

                <%-- Hiển thị nút "Quản Trị" chỉ khi user có role "ADMIN" --%>
                <sec:authorize access="hasRole('ADMIN')">
                    <a
                        href="${pageContext.request.contextPath}/quantri"
                        class="px-4 py-3 hover:bg-orange-700 ml-2"
                    >
                        <i class="fas fa-cog"></i> Quản Trị
                    </a>
                </sec:authorize>
                <%-- Link đăng xuất (Spring Security sẽ xử lý) --%>
                <a
                    href="${pageContext.request.contextPath}/logout"
                    class="px-4 py-3 hover:bg-orange-700 ml-2"
                >
                    <i class="fas fa-sign-out-alt"></i> Đăng Xuất
                </a>
            </sec:authorize>

            <%-- Kiểm tra nếu người dùng CHƯA xác thực --%>
            <sec:authorize access="!isAuthenticated()">
                <%-- Link đăng nhập --%>
                <a
                    href="${pageContext.request.contextPath}/login"
                    class="px-4 py-3 hover:bg-orange-700"
                    >Đăng Nhập</a
                >
                <a
                    href="${pageContext.request.contextPath}/register"
                    class="px-4 py-3 hover:bg-orange-700"
                    >Đăng Ký</a
                >
            </sec:authorize>
        </div>
    </div>
</nav>

<!-- Mobile Navigation Menu -->
<nav
    id="mobile-menu"
    class="bg-white border-t-2 border-orange-500 text-gray-800 md:hidden hidden shadow-lg"
>
    <div class="container mx-auto px-4 py-2">
        <!-- Main Navigation -->
        <div class="space-y-1">
            <a
                href="${pageContext.request.contextPath}/trangchu"
                class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                ><i class="fas fa-home w-5 text-orange-500"></i> Trang Chủ</a
            >
            <a
                href="/cars"
                class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                ><i class="fas fa-car w-5 text-orange-500"></i> Xe oto cũ</a
            >
            <a
                href="/accessories"
                class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                ><i class="fas fa-tools w-5 text-orange-500"></i> Phụ kiện xe</a
            >
            <a
                href="/support"
                class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                ><i class="fas fa-headset w-5 text-orange-500"></i> Hỗ trợ</a
            >
            <a
                href="/theodoidonhang"
                class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                ><i class="fas fa-search w-5 text-orange-500"></i> Tra cứu</a
            >
            <a
                href="/contact"
                class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                ><i class="fas fa-phone w-5 text-orange-500"></i> Liên hệ</a
            >
        </div>

        <!-- User Menu -->
        <div class="border-t border-gray-200 mt-3 pt-3">
            <sec:authorize access="isAuthenticated()">
                <a
                    href="${pageContext.request.contextPath}/profile"
                    class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                >
                    <i class="fas fa-user w-5 text-orange-500"></i>
                    <sec:authentication property="principal.username" />
                </a>

                <sec:authorize access="hasRole('ADMIN')">
                    <a
                        href="${pageContext.request.contextPath}/quantri"
                        class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                    >
                        <i class="fas fa-cog w-5 text-orange-500"></i> Quản Trị
                    </a>
                </sec:authorize>

                <a
                    href="${pageContext.request.contextPath}/logout"
                    class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                >
                    <i class="fas fa-sign-out-alt w-5 text-orange-500"></i> Đăng
                    Xuất
                </a>
            </sec:authorize>

            <sec:authorize access="!isAuthenticated()">
                <a
                    href="${pageContext.request.contextPath}/login"
                    class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                    ><i class="fas fa-sign-in-alt w-5 text-orange-500"></i> Đăng
                    Nhập</a
                >
                <a
                    href="${pageContext.request.contextPath}/register"
                    class="block px-3 py-3 rounded hover:bg-orange-50 hover:text-orange-600 transition-colors"
                    ><i class="fas fa-user-plus w-5 text-orange-500"></i> Đăng
                    Ký</a
                >
            </sec:authorize>
        </div>
    </div>
</nav>

<style>
    /* Mobile-first responsive design */
    .container {
        padding-left: 1rem;
        padding-right: 1rem;
    }

    /* Hide desktop elements on mobile */
    @media (max-width: 767px) {
        .hidden-mobile {
            display: none !important;
        }
    }

    /* Mobile navigation improvements */
    #mobile-menu {
        transition: all 0.3s ease-in-out;
        max-height: 0;
        overflow: hidden;
    }

    #mobile-menu.show {
        display: block !important;
        max-height: 500px;
    }

    #mobile-search {
        transition: all 0.3s ease-in-out;
        max-height: 0;
        overflow: hidden;
    }

    #mobile-search.show {
        display: block !important;
        max-height: 100px;
        padding: 12px;
    }

    /* Icon styling */
    .w-5 {
        width: 1.25rem;
        display: inline-block;
        text-align: center;
        margin-right: 0.5rem;
    }

    /* Smooth transitions */
    .transition-colors {
        transition: background-color 0.2s ease, color 0.2s ease;
    }

    /* Button hover effects */
    button:hover {
        transform: scale(1.05);
        transition: transform 0.2s ease;
    }

    /* Mobile menu animation */
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    #mobile-menu.show {
        animation: slideDown 0.3s ease-out;
    }

    /* Ensure proper spacing for mobile */
    @media (max-width: 767px) {
        body {
            padding-top: 0;
        }

        .container {
            padding-left: 0.75rem;
            padding-right: 0.75rem;
        }
    }
</style>

<script>
    // Mobile menu toggle functionality
    document.addEventListener("DOMContentLoaded", function () {
        const mobileMenuBtn = document.getElementById("mobile-menu-btn");
        const mobileMenu = document.getElementById("mobile-menu");
        const mobileSearchBtn = document.getElementById("mobile-search-btn");
        const mobileSearch = document.getElementById("mobile-search");

        // Toggle mobile menu
        if (mobileMenuBtn && mobileMenu) {
            mobileMenuBtn.addEventListener("click", function () {
                mobileMenu.classList.toggle("hidden");
                mobileMenu.classList.toggle("show");

                // Change icon
                const icon = mobileMenuBtn.querySelector("i");
                if (mobileMenu.classList.contains("show")) {
                    icon.className = "fas fa-times";
                } else {
                    icon.className = "fas fa-bars";
                }
            });
        }

        // Toggle mobile search
        if (mobileSearchBtn && mobileSearch) {
            mobileSearchBtn.addEventListener("click", function () {
                mobileSearch.classList.toggle("hidden");
                mobileSearch.classList.toggle("show");

                // Focus on search input when opened
                if (mobileSearch.classList.contains("show")) {
                    const searchInput = mobileSearch.querySelector(
                        "input[name='keyword']"
                    );
                    if (searchInput) {
                        setTimeout(() => searchInput.focus(), 100);
                    }
                }
            });
        }

        // Close mobile menu when clicking on a link
        const mobileMenuLinks = mobileMenu?.querySelectorAll("a");
        if (mobileMenuLinks) {
            mobileMenuLinks.forEach((link) => {
                link.addEventListener("click", function () {
                    mobileMenu.classList.add("hidden");
                    mobileMenu.classList.remove("show");
                    const icon = mobileMenuBtn.querySelector("i");
                    icon.className = "fas fa-bars";
                });
            });
        }

        // Load wishlist count for authenticated users (desktop)
        const wishlistCountElement = document.getElementById("wishlist-count");
        if (wishlistCountElement) {
            const wishlistLink = document.querySelector('a[href*="/wishlist"]');
            if (wishlistLink) {
                fetch("${pageContext.request.contextPath}/api/wishlist/count")
                    .then((response) => response.json())
                    .then((data) => {
                        if (data.count > 0) {
                            wishlistCountElement.textContent = data.count;
                            wishlistCountElement.style.display = "flex";
                        }
                    })
                    .catch((error) =>
                        console.log("Could not load wishlist count")
                    );
            }
        }

        // Load wishlist count for mobile
        const mobileWishlistCountElement = document.getElementById(
            "mobile-wishlist-count"
        );
        if (mobileWishlistCountElement) {
            const mobileWishlistLink = document.querySelector(
                'a[href*="/wishlist"]'
            );
            if (mobileWishlistLink) {
                fetch("${pageContext.request.contextPath}/api/wishlist/count")
                    .then((response) => response.json())
                    .then((data) => {
                        if (data.count > 0) {
                            mobileWishlistCountElement.textContent = data.count;
                            mobileWishlistCountElement.style.display = "flex";
                        }
                    })
                    .catch((error) =>
                        console.log("Could not load mobile wishlist count")
                    );
            }
        }
    });
</script>
