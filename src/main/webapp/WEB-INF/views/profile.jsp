<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.edu.Model.User" %> <%-- Import your User model class --%>
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
    <%-- Removed redundant Bootstrap and old Font Awesome links --%>

    <style>
     body {
            font-family: 'Roboto', sans-serif; /* Using Roboto from Google Fonts */
            background-color: #f3f4f6;
            color: #1f2937; /* Updated text color */
        }

        .container {
            max-width: 800px; /* Set a max-width for the container */
        }

        /* Custom styling for password container and toggle */
        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px; /* Adjusted for better spacing */
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6b7280; /* Adjusted color */
            font-size: 1rem; /* Adjusted font size */
        }

        .password-toggle:hover {
            color: #1f2937; /* Darker color on hover */
        }

        /* Styling for the lorem ipsum section */
        .lorem-ipsum {
            background-color: #e5e7eb; /* Lighter background */
            padding: 15px;
            border-radius: 5px;
            color: #4b5563; /* Darker text */
            font-size: 0.9rem; /* Slightly smaller font */
            line-height: 1.6;
            margin-top: 20px;
        }

        /* --- Toast Notification Styling --- */
        .toast-container {
            position: fixed;
            top: 20px; /* Position from the top */
            right: 20px; /* Position from the right */
            z-index: 1050; /* Ensure it's above most content */
            display: none; /* Hidden by default */
            opacity: 0; /* Start with opacity 0 for fade-in */
            transition: opacity 0.5s ease-in-out; /* Fade transition */
        }

        .toast {
            padding: 15px;
            border-radius: 5px;
            color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            margin-bottom: 10px; /* Space between multiple toasts if needed */
            min-width: 250px;
            max-width: 350px;
        }

        .toast.success {
            background-color: #4CAF50; /* Green */
        }

        .toast.error {
            background-color: #f44336; /* Red */
        }
         /* --- End Toast Notification Styling --- */

    </style>
</head>
<body>
<jsp:include page="/common/header.jsp" />

<%-- --- Toast Notification HTML Structure --- --%>
<div id="toastContainer" class="toast-container">
    <div id="toastMessage" class="toast">
        </div>
</div>
<%-- --- End Toast Notification HTML Structure --- --%>


<div class="container mx-auto px-4 py-8"> <%-- Added padding and centering --%>
    <div class="bg-white shadow-md rounded-lg p-6"> <%-- More padding, rounded corners, and shadow --%>

        <h2 class="text-2xl font-semibold text-gray-800 mb-1">Tài khoản</h2> <%-- Larger, bolder title --%>
        <h3 class="text-xl text-gray-600 mb-6">Chi tiết tài khoản</h3> <%-- Slightly smaller, less bold subtitle --%>
        <p class="text-gray-700 mb-6">Cập nhật thông tin cá nhân của bạn tại đây.</p> <%-- Standard paragraph text --%>

        <form action="/profile/update" method="post"> <%-- Added action and method for form submission --%>
            <div class="mb-4"> <%-- Margin bottom for form groups --%>
                <label for="fullname" class="block text-sm font-medium text-gray-700 mb-1">Họ và tên:</label>
                <input type="text" id="fullname" name="fullname"
                       value="${userInfo.hovaten}" <%-- Pre-fill fullname --%>
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

            <div class="mb-4">
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ email:</label>
                <input type="email" id="email" name="email"
                       value="${userInfo.email}" <%-- Pre-fill email --%>
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

            <div class="mb-4">
                <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ:</label>
                <input type="text" id="address" name="address"
                       value="${userInfo.diaChi}" <%-- Pre-fill address --%>
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>

             <%-- End Added Ward and District fields back --%>

            <div class="mb-4">
                <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại:</label>
                <input type="tel" id="phone" name="phone"
                       value="${userInfo.sodienthoai}" <%-- Pre-fill phone --%>
                       class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
            </div>
			    <form action="/profile/update" method="post">
			    <button type="submit" class="w-full inline-flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
			        Lưu Thay Đổi
			    </button>
			</form>

        </form> <%-- Corrected form nesting --%>

        <%-- Styled lorem ipsum section --%>
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
        var passwordToggleIcon = document.querySelector(".password-toggle i"); // Select the icon

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            passwordToggleIcon.classList.remove("fa-eye"); // Remove eye icon
            passwordToggleIcon.classList.add("fa-eye-slash"); // Add eye-slash icon
        } else {
            passwordInput.type = "password";
            passwordToggleIcon.classList.remove("fa-eye-slash"); // Remove eye-slash icon
            passwordToggleIcon.classList.add("fa-eye"); // Add eye icon
        }
    }

    // --- Toast Notification JavaScript ---
    function showToast(message, type = 'success') {
        const toastContainer = document.getElementById('toastContainer');
        const toastMessage = document.getElementById('toastMessage');

        // Set message and type class
        toastMessage.textContent = message;
        toastMessage.className = 'toast ' + type; // Reset classes and add type

        // Show container and fade in toast
        toastContainer.style.display = 'block';
        setTimeout(() => {
            toastContainer.style.opacity = 1;
        }, 10); // Small delay to allow display: block to take effect before fading

        // Hide and fade out after 5 seconds
        setTimeout(() => {
            toastContainer.style.opacity = 0;
            // Hide container after fade out
            setTimeout(() => {
                toastContainer.style.display = 'none';
            }, 500); // Match this duration with the transition duration
        }, 5000); // Display time (5000 milliseconds = 5 seconds)
    }

    // Check for flash attributes and show toast on page load
    window.onload = function() {
        // Use JSP scriptlets to check for flash attributes
        <% String successMessage = (String) request.getAttribute("successMessage"); %>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>

        <% if (successMessage != null) { %>
            showToast("<%= successMessage %>", 'success');
        <% } else if (errorMessage != null) { %>
            showToast("<%= errorMessage %>", 'error');
        <% } %>
    };
    // --- End Toast Notification JavaScript ---

</script>
</body>
</html>