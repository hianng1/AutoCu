<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Cập nhật URI taglib JSTL sang chuẩn mới --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- THÊM TAGLIB CỦA SPRING SECURITY --%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


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
        <a class="text-gray-600" href="tel:+84382948198"> +84 382 948 198 </a> <%-- Định dạng lại tel link --%>
      </div>
      <div>
        Gửi mail cho chúng tôi:
        <a class="text-gray-600" href="mailto:autocu@gmail.com">
          autocu@gmail.com
        </a>
      </div>
    </div>
    <div class="flex items-center space-x-4">
      <div>
        <i class="fas fa-truck text-green-600"> </i>
        <a href="#">Order Tracking</a> <%-- Link placeholder --%>
      </div>
      <div>
        <i class="fas fa-heart text-red-600"> </i>
        <a href="#">Wishlist</a> <%-- Link placeholder --%>
      </div>
    </div>
  </div>
</div>

<header class="bg-white py-4 shadow-sm">
  <div class="container mx-auto flex justify-between items-center">
    <div class="flex items-center space-x-3">
      <%-- THÊM contextPath vào link logo --%>
      <a href="${pageContext.request.contextPath}/trangchu">
      	<%-- THÊM contextPath vào src ảnh logo --%>
      	<img src="${pageContext.request.contextPath}/imgs/logo2.png" alt="logo" class="h-16 max-w-[300px] object-contain"/>
      </a>
    </div>
    <div class="relative flex items-center w-full max-w-2xl mx-auto">
      <%-- THÊM contextPath vào action form tìm kiếm --%>
      <form action="${pageContext.request.contextPath}/search" method="get" class="flex w-full">
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
          <%-- THÊM contextPath vào link giỏ hàng --%>
          <a href="${pageContext.request.contextPath}/cart/views" class="relative flex items-center">
            <h2 class="text-lg font-semibold hover:text-orange-500 mr-2">
              Giỏ Hàng
            </h2>
            <div class="relative">
              <i class="fas fa-shopping-basket text-orange-400 text-lg"></i>
              <%-- Giữ logic đếm số lượng trong giỏ hàng nếu CART_ITEMS được set ở nơi khác --%>
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
        </div>
    </div>
  </div>
</header>

<nav class="bg-orange-500 text-white">
  <div class="container mx-auto flex justify-between items-center whitespace-nowrap">

    <div class="flex items-center flex-nowrap">
      <%-- THÊM contextPath vào các link menu chính --%>
      <a href="${pageContext.request.contextPath}/trangchu" class="px-4 py-3 hover:bg-orange-600 inline-block"><i class="fas fa-home"></i> Trang Chủ</a>
      <a href="/cars" class="px-4 py-3 hover:bg-orange-600 inline-block">Xe oto cũ</a> <%-- Link placeholder --%>
      <a href="/accessories" class="px-4 py-3 hover:bg-orange-600 inline-block">Phụ kiện xe</a> <%-- Link placeholder --%>
      <a href="/support" class="px-4 py-3 hover:bg-orange-600 inline-block">Hỗ trợ</a> <%-- Link placeholder --%>
      <a href="/contact" class="px-4 py-3 hover:bg-orange-600 inline-block">Liên hệ</a> <%-- Link placeholder --%>
    </div>

    <div class="flex items-center flex-shrink-0 bg-orange-600 ml-4">
      <%-- Kiểm tra nếu người dùng ĐÃ xác thực --%>
	  <sec:authorize access="isAuthenticated()">
          <%-- Lấy username từ Principal của Spring Security --%>
	      <a href="${pageContext.request.contextPath}/profile" class="px-4 py-3 font-medium hover:bg-orange-700">
	        <i class="fas fa-user"></i> <sec:authentication property="principal.username"/>
	      </a>
	      <%-- Link đăng xuất (Spring Security sẽ xử lý) --%>
	      <a href="${pageContext.request.contextPath}/logout" class="px-4 py-3 hover:bg-orange-700">
	        <i class="fas fa-sign-out-alt"></i> Đăng Xuất
	      </a>
	  </sec:authorize>

      <%-- Kiểm tra nếu người dùng CHƯA xác thực --%>
	  <sec:authorize access="!isAuthenticated()">
          <%-- Link đăng nhập --%>
	      <a href="${pageContext.request.contextPath}/login" class="px-4 py-3 hover:bg-orange-700">Đăng Nhập</a>
	  </sec:authorize>
	</div>

  </div>
</nav>