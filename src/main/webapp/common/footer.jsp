<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<footer class="bg-gray-900 text-white">
  <div class="container mx-auto px-4 py-12">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
      <!-- Thông tin công ty -->
      <div>
        <img src="/imgs/logo2.png" alt="AutoCu Logo" class="h-12 mb-4" />
        <p class="text-gray-400 mb-4">
          AutoCu - Nơi bạn tìm thấy những sản phẩm chất lượng nhất cho xe của
          bạn.
        </p>
        <div class="flex space-x-4">
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-facebook-f"></i>
          </a>
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-twitter"></i>
          </a>
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-instagram"></i>
          </a>
          <a href="#" class="text-gray-400 hover:text-white transition-colors">
            <i class="fab fa-youtube"></i>
          </a>
        </div>
      </div>

      <!-- Liên kết nhanh -->
      <div>
        <h3 class="text-lg font-semibold mb-4">Liên kết nhanh</h3>
        <ul class="space-y-2">
          <li>
            <a
              href="/trangchu"
              class="text-gray-400 hover:text-white transition-colors"
            >
              <i class="fas fa-chevron-right mr-2 text-xs"></i>
              Trang chủ
            </a>
          </li>
          <li>
            <a
              href="#"
              class="text-gray-400 hover:text-white transition-colors"
            >
              <i class="fas fa-chevron-right mr-2 text-xs"></i>
              Sản phẩm
            </a>
          </li>
          <li>
            <a
              href="#"
              class="text-gray-400 hover:text-white transition-colors"
            >
              <i class="fas fa-chevron-right mr-2 text-xs"></i>
              Về chúng tôi
            </a>
          </li>
          <li>
            <a
              href="#"
              class="text-gray-400 hover:text-white transition-colors"
            >
              <i class="fas fa-chevron-right mr-2 text-xs"></i>
              Liên hệ
            </a>
          </li>
        </ul>
      </div>

      <!-- Thông tin liên hệ -->
      <div>
        <h3 class="text-lg font-semibold mb-4">Thông tin liên hệ</h3>
        <ul class="space-y-3">
          <li class="flex items-start">
            <i class="fas fa-map-marker-alt mt-1 mr-3 text-orange-500"></i>
            <span class="text-gray-400">123 Đường ABC, Quận 1, TP.HCM</span>
          </li>
          <li class="flex items-start">
            <i class="fas fa-phone mt-1 mr-3 text-orange-500"></i>
            <span class="text-gray-400">+84 382 948 198</span>
          </li>
          <li class="flex items-start">
            <i class="fas fa-envelope mt-1 mr-3 text-orange-500"></i>
            <span class="text-gray-400">autocu@gmail.com</span>
          </li>
          <li class="flex items-start">
            <i class="fas fa-clock mt-1 mr-3 text-orange-500"></i>
            <span class="text-gray-400">Thứ 2 - Chủ nhật: 8:00 - 22:00</span>
          </li>
        </ul>
      </div>

      <!-- Đăng ký nhận tin -->
      <div>
        <h3 class="text-lg font-semibold mb-4">Đăng ký nhận tin</h3>
        <p class="text-gray-400 mb-4">
          Đăng ký để nhận những thông tin mới nhất về sản phẩm và khuyến mãi.
        </p>
        <form class="flex">
          <input
            type="email"
            placeholder="Email của bạn"
            class="flex-1 px-4 py-2 rounded-l-lg text-gray-900 focus:outline-none focus:ring-2 focus:ring-orange-500"
          />
          <button
            type="submit"
            class="bg-orange-500 text-white px-4 py-2 rounded-r-lg hover:bg-orange-600 transition-colors"
          >
            <i class="fas fa-paper-plane"></i>
          </button>
        </form>
      </div>
    </div>

    <!-- Phần bottom -->
    <div class="border-t border-gray-800 mt-12 pt-8">
      <div class="flex flex-col md:flex-row justify-between items-center">
        <p class="text-gray-400 text-sm">
          © 2024 AutoCu. Tất cả quyền được bảo lưu.
        </p>
        <div class="flex space-x-6 mt-4 md:mt-0">
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
        </div>
      </div>
    </div>
  </div>
</footer>
