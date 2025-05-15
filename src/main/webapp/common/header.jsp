
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        <a class="text-gray-600" href="tel:+84382948198"> +84 382 948 198 </a>
      </div>
      <div>
        Gửi mail cho chúng tôi:
        <a class="text-gray-600" href="mailto:autocu@gmail.com">
          autocu@gmail.com
        </a>
      </div>
    </div>
  </div>
</div>

<header class="bg-white py-4 shadow-sm">
  <div class="container mx-auto flex justify-between items-center">
    <div class="flex items-center space-x-3">
      <a href="${pageContext.request.contextPath}/trangchu">
      	<img src="${pageContext.request.contextPath}/imgs/logo2.png" alt="logo" class="h-16 max-w-[300px] object-contain"/>
      </a>
    </div>
    <div class="relative flex items-center w-full max-w-2xl mx-auto">
      <form action="${pageContext.request.contextPath}/search" method="get" class="flex w-full">
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
      <div class="text-center">
        <div class="flex items-center justify-center space-x-2">
          <a href="${pageContext.request.contextPath}/cart/views" class="relative flex items-center">
            <c:if test="${not empty CART_ITEMS}">
              <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">
                ${CART_ITEMS.size()}
              </span>
            </c:if>
            <i class="fas fa-shopping-cart text-2xl text-gray-700"></i>
          </a>
        </div>
      </div>
    </div>
  </div>
</header>

<nav class="bg-orange-500 text-white">
  <div class="container mx-auto flex justify-between items-center whitespace-nowrap">
    <div class="flex items-center flex-nowrap">
      <a href="${pageContext.request.contextPath}/trangchu" class="px-4 py-3 hover:bg-orange-600 inline-block"><i class="fas fa-home"></i> Trang Chủ</a>
      <a href="/cars" class="px-4 py-3 hover:bg-orange-600 inline-block">Xe oto cũ</a>
      <a href="/accessories" class="px-4 py-3 hover:bg-orange-600 inline-block">Phụ kiện xe</a>
      <a href="/support" class="px-4 py-3 hover:bg-orange-600 inline-block">Hỗ trợ</a>
      <a href="/theodoidonhang" class="px-4 py-3 hover:bg-orange-600 inline-block">Tra cứu</a>
      <a href="/contact" class="px-4 py-3 hover:bg-orange-600 inline-block">Liên hệ</a>
    </div>

    <div class="flex items-center flex-shrink-0 ml-4">
      <%-- Kiểm tra nếu người dùng ĐÃ xác thực --%>
	  <sec:authorize access="isAuthenticated()">
        <%-- Lấy username từ Principal của Spring Security --%>
	    <a href="${pageContext.request.contextPath}/profile" class="px-4 py-3 font-medium hover:bg-orange-700">
	      <i class="fas fa-user"></i> <sec:authentication property="principal.username"/>
	    </a>
        <%-- Hiển thị nút "Quản Trị" chỉ khi user có role "ADMIN" --%>
        <sec:authorize access="hasRole('ADMIN')">
          <a href="${pageContext.request.contextPath}/quantri" class="px-4 py-3 hover:bg-orange-700 ml-2">
            <i class="fas fa-cog"></i> Quản Trị
          </a>
        </sec:authorize>
	    <%-- Link đăng xuất (Spring Security sẽ xử lý) --%>
	    <a href="${pageContext.request.contextPath}/logout" class="px-4 py-3 hover:bg-orange-700 ml-2">
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
