<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<div class="bg-gray-100 py-2 text-sm">
  <div class="container mx-auto flex justify-between items-center">
    <div class="flex items-center space-x-4">
      <select name="" id="">
        <option>
          VN
          <i class="fas fa-chevron-down"> </i>
        </option>
        <option>EN</option>
      </select>
      <div>
        Gọi ngay cho chúng tôi:
        <a class="text-gray-600" href="tel:+15417543010"> +84 382 948 198 </a>
      </div>
      <div>
        Gửi mail cho chúng tôi:
        <a class="text-gray-600" href="mailto:contact@example.com">
          autocu@gmail.com
        </a>
      </div>
    </div>
    <div class="flex items-center space-x-4">
      <div>
        <i class="fas fa-truck text-green-600"> </i>
        <a href="">Order Tracking</a>
      </div>
      <div>
        <i class="fas fa-heart text-red-600"> </i>
        <a href="">Wishlist</a>
      </div>
    </div>
  </div>
</div>
<!-- Header -->
<header class="bg-white py-4 shadow-sm">
  <div class="container mx-auto flex justify-between items-center">
    <div class="flex items-center space-x-3">
      <a href="/trangchu">
      	<img
        src="/imgs/logo2.png"
        alt="logo"
        class="h-16 max-w-[300px] object-contain"
      />
      </a>
    </div>
    <div class="relative flex items-center w-full max-w-2xl mx-auto">
      <form action="/search" method="get" class="flex w-full">
        <input
          name="keyword"
          class="border border-gray-300 rounded-l px-4 py-2 w-full"
          placeholder="Tìm kiếm sản phẩm..."
          type="text"
          value="${param.keyword}"
        />
        <button
          type="submit"
          class="bg-orange-500 text-white px-6 py-2 rounded-r hover:bg-orange-600 transition-colors"
        >
          <i class="fas fa-search"></i>
        </button>
      </form>
    </div>
    <div class="flex items-center space-x-4">
      <div class="text-center">
        <div class="flex items-center justify-center space-x-2">
          <a href="/cart/views" class="relative flex items-center">
            <h2 class="text-lg font-semibold hover:text-orange-500 mr-2">
              Giỏ Hàng
            </h2>
            <div class="relative">
              <i class="fas fa-shopping-basket text-orange-400 text-lg"></i>
              <c:if test="${not empty CART_ITEMS}">
                <span
                  class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center"
                >
                  ${CART_ITEMS.size()}
                </span>
              </c:if>
            </div>
          </a>
        </div>
        <!-- <p class="text-gray-500 text-sm">
            0 items - <span class="font-semibold">0.00 VND</span>
          </p> -->
      </div>
    </div>
  </div>
</header>
<!-- Navigation -->
<nav class="bg-orange-500 text-white py-2">
  <div class="container mx-auto flex justify-between items-center">
    <div class="flex space-x-4">
      <a href="/trangchu">
        <button
          class="bg-orange-500 text-white px-4 py-2 rounded flex items-center space-x-2 hover:bg-orange-600"
        >
          <i class="fas fa-home"></i>
          <span> Trang Chủ </span>
        </button>
      </a>
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#"> Xe oto cũ </a>

      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#">
        Phụ kiện xe
      </a>
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#"> Thuê xe </a>
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#"> Tin xe hơi </a>
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#"> Hỗ trợ </a>
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#"> Liên hệ </a>
    </div>
   <!--  <div   >
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="/login">
        <i class="fas fa-user"> </i> Đăng Nhập
      </a>
    </div> -->
    
    
    
    
    
    
    <!-- test -->
    
    
    <div>
  <c:choose>
    <c:when test="${not empty sessionScope.loggedInUser}">
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="#">
        <i class="fas fa-user"></i> ${sessionScope.loggedInUser.username}
      </a>
      <a class="ml-2 text-red-600" href="/logout">Đăng Xuất</a>
    </c:when>
    <c:otherwise>
      <a class="hover:bg-orange-600 px-4 py-2 rounded" href="/login">
        <i class="fas fa-user"></i> Đăng Nhập
      </a>
    </c:otherwise>
  </c:choose>
</div>
  </div>
</nav>
