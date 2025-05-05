<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c"%> <%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    
    <style>
    	.card-hover-effect {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-hover-effect:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .price-text {
            color: #dc3545;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .section-divider {
            width: 15%;
            height: 1px;
            background-color: #e5e7eb;
        }
      .support-banner {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("https://pos.nvncdn.com/4e732c-26/art/artCT/20201015_LLLUpBDKbLdsrj0KfjLjj46G.jpg"); /* Overlay gradient for better text readability */
        background-size: cover;
        background-position: center;
        color: white;
        padding: 4rem 0; /* More vertical padding */
        text-shadow: 0 2px 8px rgba(0,0,0,0.7); /* Stronger text shadow */
      }
      .support-card {
        border: 1px solid #e5e7eb;
        background-color: white;
        border-radius: 0.5rem;
        padding: 1.5rem;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
      }
      .support-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        border-color: #f97316;
      }
      .faq-item summary::-webkit-details-marker {
        display: none;
      }
      .alert {
        border-radius: 0.375rem;
        padding: 1rem;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
      }
      .alert-success {
        background-color: #ecfdf5;
        border: 1px solid #10b981;
        color: #047857;
      }
      .alert-error {
        background-color: #fef2f2;
        border: 1px solid #ef4444;
        color: #b91c1c;
      }
      .alert-icon {
        margin-right: 0.75rem;
        font-size: 1.25rem;
      }
      /* Hiệu ứng hover cho icon */
      .support-icon {
        transition: transform 0.3s ease;
      }
      .support-card:hover .support-icon {
        transform: scale(1.2);
      }
      /* Hiệu ứng nút */
      .btn-primary {
        background-color: #f97316;
        color: white;
        padding: 0.5rem 1.5rem;
        border-radius: 0.375rem;
        font-weight: 500;
        transition: all 0.3s ease;
        border: 1px solid transparent;
        position: relative;
        overflow: hidden;
        display: inline-flex;
        align-items: center;
        justify-content: center;
      }
      .btn-primary:hover {
        background-color: #ea580c;
        box-shadow: 0 4px 6px rgba(234, 88, 12, 0.25);
        transform: translateY(-2px);
      }
      .btn-primary:active {
        transform: translateY(0);
      }
      .btn-rounded {
        border-radius: 9999px;
      }
      /* Hiệu ứng cho form input */
      .form-input {
        width: 100%;
        border: 1px solid #e5e7eb;
        border-radius: 0.375rem;
        padding: 0.5rem 0.75rem;
        transition: all 0.3s ease;
      }
      .form-input:focus {
        outline: none;
        border-color: #f97316;
        box-shadow: 0 0 0 3px rgba(249, 115, 22, 0.15);
      }
      /* Hiệu ứng cho FAQ */
      .faq-item summary {
        transition: all 0.3s ease;
      }
      .faq-item summary:hover {
        color: #f97316;
      }
      .faq-item[open] summary {
        color: #f97316;
        font-weight: 600;
      }
      .group-open\:rotate-180 {
        transition: transform 0.3s ease;
      }
      details[open] .group-open\:rotate-180 {
        transform: rotate(180deg);
      }
      .card-hover-effect {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-hover-effect:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .price-text {
            color: #dc3545;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .section-divider {
            width: 15%;
            height: 1px;
            background-color: #e5e7eb;
        }
      .chat-container {
        position: fixed;
        bottom: 60px;
        right: 20px;
        width: 350px;
        height: 500px;
        background: white;
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.25);
        display: flex;
        flex-direction: column;
        z-index: 1000;
        transition: all 0.3s ease;
        overflow: hidden;
      }
      .chat-header {
        background: #f97316;
        color: white;
        padding: 18px 20px;
        border-radius: 18px 18px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 1.1rem;
        font-weight: 600;
        box-shadow: 0 2px 8px rgba(249,115,22,0.08);
      }
      .chat-messages {
        flex: 1;
        padding: 18px 12px 20px 12px;
        overflow-y: auto;
        background: #f8fafc;
        display: flex;
        flex-direction: column;
        gap: 10px;
        scroll-behavior: smooth;
      }
      .message {
        margin-bottom: 0;
        padding: 10px 16px;
        border-radius: 18px;
        max-width: 80%;
        font-size: 1rem;
        line-height: 1.5;
        box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        word-break: break-word;
      }
      .message.sent {
        background: linear-gradient(90deg, #f97316 80%, #fb923c 100%);
        color: white;
        margin-left: auto;
        border-bottom-right-radius: 4px;
        border-bottom-left-radius: 18px;
        border-top-left-radius: 18px;
        border-top-right-radius: 18px;
      }
      .message.received {
        background: #fff;
        color: #222;
        margin-right: auto;
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 18px;
        border-top-left-radius: 18px;
        border-top-right-radius: 18px;
        border: 1px solid #f3f4f6;
      }
      .chat-input {
        padding: 14px 12px 14px 12px;
        border-top: 1px solid #e5e7eb;
        background: #fff;
        display: flex;
        gap: 10px;
        align-items: center;
        position: static;
        width: 100%;
        z-index: 2;
      }
      .chat-input input {
        flex: 1;
        padding: 10px 16px;
        border: 1px solid #e5e7eb;
        border-radius: 20px;
        outline: none;
        font-size: 1rem;
        background: #f8fafc;
        transition: border 0.2s;
      }
      .chat-input input:focus {
        border: 1.5px solid #f97316;
        background: #fff;
      }
      .chat-input button {
        background: #f97316;
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 20px;
        cursor: pointer;
        font-size: 1rem;
        font-weight: 500;
        transition: background 0.2s;
      }
      .chat-input button:hover {
        background: #ea580c;
      }
      .chat-toggle {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #f97316;
        color: white;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        z-index: 1001;
        box-shadow: 0 4px 16px rgba(249,115,22,0.18);
      }
      .chat-toggle:hover {
        background: #ea580c;
      }
    </style>
  </head>
  <body>
    <jsp:include page="/common/header.jsp"></jsp:include>

    <!-- Chat Toggle Button -->
    <div class="chat-toggle" onclick="toggleChat()">
      <i class="fas fa-comments"></i>
    </div>

    <!-- Chat Container -->
    <div id="chatContainer" class="chat-container" style="display: none;">
      <div class="chat-header">
        <span>Chat với chúng tôi</span>
        <button onclick="toggleChat()" style="background: none; border: none; color: white; cursor: pointer;">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <div id="chatMessages" class="chat-messages"></div>
      <div class="chat-input">
        <input type="text" id="messageInput" placeholder="Nhập tin nhắn...">
        <button onclick="sendMessage()">Gửi</button>
      </div>
    </div>

   	<div>
   		<!-- Banner -->
    <div class="support-banner py-16 text-white">
      <div class="container mx-auto text-center px-4">
        <h1 class="text-4xl font-bold mb-4 drop-shadow-md">
          Hỗ Trợ Khách Hàng
        </h1>
        <p class="text-xl max-w-2xl mx-auto">
          Đội ngũ chuyên viên của AutoCu luôn sẵn sàng hỗ trợ bạn mọi lúc, mọi
          nơi
        </p>
      </div>
    </div>

    <!-- Main Content -->
    <div class="container mx-auto py-10 px-4">
      <!-- Thông báo thành công/lỗi -->
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success mb-6">
          <span class="alert-icon"><i class="fas fa-check-circle"></i></span>
          <span>${successMessage}</span>
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-error mb-6">
          <span class="alert-icon"><i class="fas fa-exclamation-circle"></i></span>
          <span>${error}</span>
        </div>
      </c:if>
    
      <!-- Các dịch vụ hỗ trợ -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <div class="support-card">
          <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i class="fas fa-phone-alt text-2xl text-orange-500 support-icon"></i>
          </div>
          <h3 class="text-xl font-semibold mb-3 text-center">
            Hỗ Trợ Qua Điện Thoại
          </h3>
          <p class="text-gray-600 mb-4 text-center">
            Đội ngũ tư vấn viên giàu kinh nghiệm sẵn sàng giải đáp mọi thắc mắc
          </p>
          <div class="text-center">
            <a href="tel:+84382948198" class="text-orange-500 font-bold text-lg block mb-1 hover:underline">
              +84 382 948 198
            </a>
            <p class="text-gray-500 text-sm">
              Thời gian: 8:00 - 21:00 (Thứ 2 - Chủ Nhật)
            </p>
          </div>
        </div>

        <div class="support-card">
          <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i class="fas fa-envelope text-2xl text-orange-500 support-icon"></i>
          </div>
          <h3 class="text-xl font-semibold mb-3 text-center">
            Hỗ Trợ Qua Email
          </h3>
          <p class="text-gray-600 mb-4 text-center">
            Gửi yêu cầu hỗ trợ qua email và nhận phản hồi trong vòng 24 giờ
          </p>
          <div class="text-center">
            <a href="mailto:autocu@gmail.com" class="text-orange-500 font-bold text-lg block mb-1 hover:underline">
              autocu@gmail.com
            </a>
            <p class="text-gray-500 text-sm">
              Chúng tôi sẽ phản hồi nhanh nhất có thể
            </p>
          </div>
        </div>

        <div class="support-card">
          <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i class="fas fa-comment-dots text-2xl text-orange-500 support-icon"></i>
          </div>
          <h3 class="text-xl font-semibold mb-3 text-center">
            Chat Trực Tuyến
          </h3>
          <p class="text-gray-600 mb-4 text-center">
            Trò chuyện trực tiếp với nhân viên tư vấn của chúng tôi
          </p>
          <div class="text-center">
            <button class="btn-primary btn-rounded">
              <i class="fas fa-comment-alt mr-2"></i> Bắt đầu chat
            </button>
            <p class="text-gray-500 text-sm mt-1">
              Trực tuyến: 8:00 - 21:00 (Thứ 2 - Chủ Nhật)
            </p>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-5 gap-8 mb-10">
        <!-- Form liên hệ -->
        <div class="lg:col-span-3">
          <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
            <div class="flex items-center mb-6">
              <div
                class="w-10 h-10 bg-orange-100 rounded-full flex items-center justify-center mr-3"
              >
                <i class="fas fa-paper-plane text-orange-500"></i>
              </div>
              <h2 class="text-xl font-bold">Gửi Yêu Cầu Hỗ Trợ</h2>
            </div>

            <form action="/support/submit" method="post">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                <div>
                  <label
                    class="block text-gray-700 text-sm font-medium mb-2"
                    for="name"
                    >Họ và tên</label
                  >
                  <input
                    type="text"
                    id="name"
                    name="name"
                    class="form-input"
                    required
                    value="${name}"
                  />
                </div>
                <div>
                  <label
                    class="block text-gray-700 text-sm font-medium mb-2"
                    for="email"
                    >Email</label
                  >
                  <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-input"
                    required
                    value="${email}"
                  />
                </div>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                <div>
                  <label
                    class="block text-gray-700 text-sm font-medium mb-2"
                    for="phone"
                    >Số điện thoại</label
                  >
                  <input
                    type="tel"
                    id="phone"
                    name="phone"
                    class="form-input"
                    required
                    value="${phone}"
                  />
                </div>
                <div>
                  <label
                    class="block text-gray-700 text-sm font-medium mb-2"
                    for="subject"
                    >Chủ đề</label
                  >
                  <select
                    id="subject"
                    name="subject"
                    class="form-input"
                    required
                  >
                    <option value="">Chọn chủ đề</option>
                    <option value="purchase" ${subject == 'purchase' ? 'selected' : ''}>Tư vấn mua xe</option>
                    <option value="technical" ${subject == 'technical' ? 'selected' : ''}>Hỗ trợ kỹ thuật</option>
                    <option value="warranty" ${subject == 'warranty' ? 'selected' : ''}>Bảo hành sản phẩm</option>
                    <option value="payment" ${subject == 'payment' ? 'selected' : ''}>Thanh toán và tài chính</option>
                    <option value="other" ${subject == 'other' ? 'selected' : ''}>Khác</option>
                  </select>
                </div>
              </div>

              <div class="mb-4">
                <label
                  class="block text-gray-700 text-sm font-medium mb-2"
                  for="message"
                  >Nội dung</label
                >
                <textarea
                  id="message"
                  name="message"
                  rows="5"
                  class="form-input"
                  required
                >${message}</textarea>
              </div>

              <div class="text-right">
                <button
                  type="submit"
                  class="btn-primary"
                >
                  <i class="fas fa-paper-plane mr-2"></i> Gửi yêu cầu
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Thông tin liên hệ bổ sung -->
        <div class="lg:col-span-2">
          <div
            class="bg-white p-6 rounded-lg shadow-sm border border-gray-100 mb-6"
          >
            <div class="flex items-center mb-4">
              <div
                class="w-10 h-10 bg-orange-100 rounded-full flex items-center justify-center mr-3"
              >
                <i class="fas fa-map-marker-alt text-orange-500"></i>
              </div>
              <h2 class="text-xl font-bold">Địa Chỉ Showroom</h2>
            </div>
            <div class="pl-14">
              <p class="text-gray-700 mb-2">
                293 Đường Lý Thường Kiệt, Phường 15, Quận 11, TP. Hồ Chí Minh
              </p>
              <p class="text-gray-700 mb-1">
                <span class="font-medium">Giờ mở cửa:</span> 8:00 - 21:00
              </p>
              <p class="text-gray-700">
                <span class="font-medium">Ngày làm việc:</span> Thứ 2 - Chủ Nhật
              </p>
            </div>
          </div>

          <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
            <div class="flex items-center mb-4">
              <div
                class="w-10 h-10 bg-orange-100 rounded-full flex items-center justify-center mr-3"
              >
                <i class="fas fa-shield-alt text-orange-500"></i>
              </div>
              <h2 class="text-xl font-bold">Cam Kết Của Chúng Tôi</h2>
            </div>
            <ul class="pl-14 space-y-3">
              <li class="flex items-start">
                <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                <span class="text-gray-700"
                  >Phản hồi nhanh chóng trong vòng 24h</span
                >
              </li>
              <li class="flex items-start">
                <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                <span class="text-gray-700"
                  >Đội ngũ tư vấn chuyên nghiệp, nhiệt tình</span
                >
              </li>
              <li class="flex items-start">
                <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                <span class="text-gray-700"
                  >Bảo mật thông tin khách hàng tuyệt đối</span
                >
              </li>
              <li class="flex items-start">
                <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                <span class="text-gray-700"
                  >Hỗ trợ kỹ thuật sau bán hàng 24/7</span
                >
              </li>
            </ul>
          </div>
        </div>
      </div>

      <!-- Câu hỏi thường gặp -->
      <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
        <div class="flex items-center mb-6">
          <div
            class="w-10 h-10 bg-orange-100 rounded-full flex items-center justify-center mr-3"
          >
            <i class="fas fa-question text-orange-500"></i>
          </div>
          <h2 class="text-xl font-bold">Câu Hỏi Thường Gặp</h2>
        </div>

        <div class="max-w-4xl mx-auto divide-y">
          <div class="py-4">
            <details class="group faq-item">
              <summary
                class="flex justify-between items-center font-medium cursor-pointer list-none"
              >
                <div class="flex items-center">
                  <div
                    class="w-8 h-8 bg-orange-50 rounded-full flex items-center justify-center mr-3"
                  >
                    <i class="fas fa-car text-orange-500 text-sm"></i>
                  </div>
                  <span>Làm thế nào để đặt mua xe ô tô cũ?</span>
                </div>
                <span class="transition group-open:rotate-180">
                  <i class="fas fa-chevron-down text-orange-500"></i>
                </span>
              </summary>
              <div class="text-gray-600 mt-3 pl-11 group-open:animate-fadeIn">
                <p>
                  Để đặt mua xe ô tô cũ tại AutoCu, bạn có thể thực hiện theo
                  các bước sau:
                </p>
                <ol class="list-decimal pl-5 mt-2 space-y-1">
                  <li>Chọn xe ưng ý trên trang web</li>
                  <li>Kiểm tra thông tin chi tiết xe</li>
                  <li>
                    Thêm vào giỏ hàng hoặc liên hệ trực tiếp với chúng tôi để
                    được tư vấn
                  </li>
                  <li>Tiến hành thanh toán theo hướng dẫn</li>
                </ol>
              </div>
            </details>
          </div>

          <div class="py-4">
            <details class="group faq-item">
              <summary
                class="flex justify-between items-center font-medium cursor-pointer list-none"
              >
                <div class="flex items-center">
                  <div
                    class="w-8 h-8 bg-orange-50 rounded-full flex items-center justify-center mr-3"
                  >
                    <i class="fas fa-shield-alt text-orange-500 text-sm"></i>
                  </div>
                  <span>Chính sách bảo hành xe ô tô cũ như thế nào?</span>
                </div>
                <span class="transition group-open:rotate-180">
                  <i class="fas fa-chevron-down text-orange-500"></i>
                </span>
              </summary>
              <p class="text-gray-600 mt-3 pl-11 group-open:animate-fadeIn">
                Tất cả xe ô tô cũ tại AutoCu đều được bảo hành từ 3-12 tháng tùy
                theo từng loại xe và tình trạng xe. Chúng tôi cam kết bảo hành
                động cơ, hộp số và các hệ thống chính của xe. Chi tiết cụ thể sẽ
                được ghi rõ trong hợp đồng mua bán.
              </p>
            </details>
          </div>

          <div class="py-4">
            <details class="group faq-item">
              <summary
                class="flex justify-between items-center font-medium cursor-pointer list-none"
              >
                <div class="flex items-center">
                  <div
                    class="w-8 h-8 bg-orange-50 rounded-full flex items-center justify-center mr-3"
                  >
                    <i class="fas fa-search text-orange-500 text-sm"></i>
                  </div>
                  <span>Tôi có thể kiểm tra xe trước khi mua không?</span>
                </div>
                <span class="transition group-open:rotate-180">
                  <i class="fas fa-chevron-down text-orange-500"></i>
                </span>
              </summary>
              <p class="text-gray-600 mt-3 pl-11 group-open:animate-fadeIn">
                Tất nhiên! Chúng tôi khuyến khích khách hàng kiểm tra xe trực
                tiếp hoặc có thể mang theo kỹ thuật viên để kiểm tra xe trước
                khi quyết định mua. Bạn có thể đặt lịch xem xe tại showroom của
                chúng tôi hoặc yêu cầu dịch vụ kiểm tra xe tận nơi.
              </p>
            </details>
          </div>

          <div class="py-4">
            <details class="group faq-item">
              <summary
                class="flex justify-between items-center font-medium cursor-pointer list-none"
              >
                <div class="flex items-center">
                  <div
                    class="w-8 h-8 bg-orange-50 rounded-full flex items-center justify-center mr-3"
                  >
                    <i class="fas fa-credit-card text-orange-500 text-sm"></i>
                  </div>
                  <span>AutoCu có hỗ trợ trả góp khi mua xe không?</span>
                </div>
                <span class="transition group-open:rotate-180">
                  <i class="fas fa-chevron-down text-orange-500"></i>
                </span>
              </summary>
              <p class="text-gray-600 mt-3 pl-11 group-open:animate-fadeIn">
                Có, AutoCu có liên kết với nhiều ngân hàng và tổ chức tài chính
                để hỗ trợ khách hàng mua xe trả góp với lãi suất ưu đãi. Thời
                gian vay có thể lên đến 7 năm với thủ tục đơn giản, giải ngân
                nhanh chóng. Vui lòng liên hệ với nhân viên tư vấn để được hỗ
                trợ chi tiết.
              </p>
            </details>
          </div>

          <div class="py-4">
            <details class="group faq-item">
              <summary
                class="flex justify-between items-center font-medium cursor-pointer list-none"
              >
                <div class="flex items-center">
                  <div
                    class="w-8 h-8 bg-orange-50 rounded-full flex items-center justify-center mr-3"
                  >
                    <i class="fas fa-tools text-orange-500 text-sm"></i>
                  </div>
                  <span>Làm thế nào để đăng ký dịch vụ bảo dưỡng xe?</span>
                </div>
                <span class="transition group-open:rotate-180">
                  <i class="fas fa-chevron-down text-orange-500"></i>
                </span>
              </summary>
              <p class="text-gray-600 mt-3 pl-11 group-open:animate-fadeIn">
                Để đăng ký dịch vụ bảo dưỡng xe, bạn có thể liên hệ trực tiếp
                qua số điện thoại hotline hoặc đặt lịch trực tuyến trên website
                của chúng tôi. Chúng tôi cung cấp các gói bảo dưỡng định kỳ với
                chi phí hợp lý và được thực hiện bởi đội ngũ kỹ thuật viên
                chuyên nghiệp.
              </p>
            </details>
          </div>
        </div>
      </div>
    </div>
   	</div>

    <jsp:include page="/common/footer.jsp"></jsp:include>

    <script>
      let stompClient = null;
      let username = null;
      var loggedInUsername = "${sessionScope.userInfo.username}";

      function connect() {
        const socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, onConnected, onError);
      }

      function onConnected() {
        if (loggedInUsername && loggedInUsername !== 'null' && loggedInUsername !== 'undefined' && loggedInUsername !== '') {
          username = loggedInUsername;
        } else {
          username = prompt('Nhập tên của bạn:');
        }
        if (username) {
          stompClient.subscribe('/topic/public', onMessageReceived);
          stompClient.send("/app/chat.addUser", {}, JSON.stringify({
            sender: username,
            type: 'JOIN'
          }));
        }
      }

      function onError(error) {
        console.error('Lỗi kết nối:', error);
      }

      function sendMessage() {
        const messageInput = document.getElementById('messageInput');
        const messageContent = messageInput.value.trim();
        if (messageContent && stompClient) {
          const chatMessage = {
            sender: username,
            content: messageContent,
            type: 'CHAT'
          };
          stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
          messageInput.value = '';
        }
      }

      // Gửi tin nhắn bằng Enter, Shift+Enter để xuống dòng
      document.addEventListener('DOMContentLoaded', function() {
        const messageInput = document.getElementById('messageInput');
        messageInput.addEventListener('keydown', function(e) {
          if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
          }
        });
      });

      function onMessageReceived(payload) {
        const message = JSON.parse(payload.body);
        const messageElement = document.createElement('div');
        messageElement.classList.add('message');
        if (message.type === 'JOIN') {
          messageElement.classList.add('received');
          messageElement.textContent = message.sender + ' (' + message.role + ') đã tham gia chat';
        } else if (message.type === 'LEAVE') {
          messageElement.classList.add('received');
          messageElement.textContent = message.sender + ' (' + message.role + ') đã rời khỏi chat';
        } else {
          messageElement.classList.add(message.sender === username ? 'sent' : 'received');
          messageElement.textContent = message.sender + ' (' + message.role + '): ' + message.content;
        }
        document.getElementById('chatMessages').appendChild(messageElement);
        document.getElementById('chatMessages').scrollTop = document.getElementById('chatMessages').scrollHeight;
      }

      function toggleChat() {
        const chatContainer = document.getElementById('chatContainer');
        if (chatContainer.style.display === 'none') {
          chatContainer.style.display = 'flex';
          if (!stompClient) {
            connect();
          }
        } else {
          chatContainer.style.display = 'none';
        }
      }

      window.onload = function() {
        connect();
      };
    </script>
  </body>
</html>
