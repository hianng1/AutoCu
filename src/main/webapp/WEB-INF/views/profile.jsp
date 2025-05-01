<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.User" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoCu - Chuyên xe cũ & phụ tùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap" rel="stylesheet">

    <style>
     body {
            font-family: 'Roboto', sans-serif;
            background-color: #f3f4f6;
            color: #1f2937;
        }

        .container {
            max-width: 800px;
        }

        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6b7280;
            font-size: 1rem;
        }

        .password-toggle:hover {
            color: #1f2937;
        }

        .lorem-ipsum {
            background-color: #e5e7eb;
            padding: 15px;
            border-radius: 5px;
            color: #4b5563;
            font-size: 0.9rem;
            line-height: 1.6;
            margin-top: 20px;
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
            display: none;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
        }

        .toast {
            padding: 15px;
            border-radius: 5px;
            color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            margin-bottom: 10px;
            min-width: 250px;
            max-width: 350px;
        }

        .toast.success {
            background-color: #4CAF50;
        }

        .toast.error {
            background-color: #f44336;
        }

    </style>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div id="toastContainer" class="toast-container">
    <div id="toastMessage" class="toast">
        </div>
</div>


<div class="container mx-auto px-4 py-8">
    <div class="bg-white shadow-md rounded-lg p-6">

        <h2 class="text-2xl font-semibold text-gray-800 mb-1">Tài khoản</h2>
        <h3 class="text-xl text-gray-600 mb-6">Chi tiết tài khoản</h3>
        <p class="text-gray-700 mb-6">Cập nhật thông tin cá nhân của bạn tại đây.</p>

        <form id="profileUpdateForm" action="/profile/update" method="post" onsubmit="return confirmUpdate()">
            <div class="mb-4">
                <label for="fullname" class="block text-sm font-medium text-gray-700 mb-1">Họ và tên:</label>
                <input type="text" id="fullname" name="fullname"
                       value="${userInfo.hovaten}"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

            <div class="mb-4">
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ email:</label>
                <input type="email" id="email" name="email"
                       value="${userInfo.email}"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

            <div class="mb-4">
                <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ:</label>
                <input type="text" id="address" name="address"
                       value="${userInfo.diaChi}"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>


            <div class="mb-4">
                <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại:</label>
                <input type="tel" id="phone" name="phone"
                       value="${userInfo.sodienthoai}"
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

			    <button type="submit" class="w-full inline-flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
			        Lưu Thay Đổi
			    </button>


        </form>

        <div class="lorem-ipsum">
            <p>
                Lưu ý: Vui lòng kiểm tra kỹ thông tin trước khi lưu.
            </p>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script>
    function togglePasswordVisibility() {
        var passwordInput = document.getElementById("password");
        var passwordToggleIcon = document.querySelector(".password-toggle i");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            passwordToggleIcon.classList.remove("fa-eye");
            passwordToggleIcon.classList.add("fa-eye-slash");
        } else {
            passwordInput.type = "password";
            passwordToggleIcon.classList.remove("fa-eye-slash");
            passwordToggleIcon.classList.add("fa-eye");
        }
    }

    function showToast(message, type = 'success') {
        const toastContainer = document.getElementById('toastContainer');
        const toastMessage = document.getElementById('toastMessage');

        toastMessage.textContent = message;
        toastMessage.className = 'toast ' + type;

        toastContainer.style.display = 'block';
        setTimeout(() => {
            toastContainer.style.opacity = 1;
        }, 10);

        setTimeout(() => {
            toastContainer.style.opacity = 0;
            setTimeout(() => {
                toastContainer.style.display = 'none';
            }, 500);
        }, 5000);
    }

    window.onload = function() {
        <% String successMessage = (String) request.getAttribute("successMessage"); %>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>

        <% if (successMessage != null) { %>
            showToast("<%= successMessage %>", 'success');
        <% } else if (errorMessage != null) { %>
            showToast("<%= errorMessage %>", 'error');
        <% } %>
    };

    function confirmUpdate() {
        var isConfirmed = confirm("Bạn có chắc chắn muốn cập nhật thông tin tài khoản?");

        return isConfirmed;
    }

</script>
</body>
</html>