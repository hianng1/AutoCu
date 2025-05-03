
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê doanh thu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        /* Sidebar */
        /* Sidebar */
        #barChart {
    width: 600px !important; /* Sử dụng !important để đảm bảo ghi đè các style khác */
    height: 400px !important;
}
#sidebar {
    background-color: #343a40;
    color: white;
    padding: 20px;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    width: 300px; /* Độ rộng sidebar */
    z-index: 1000;
    box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.1);
}

/* Tăng kích thước font chữ cho header sidebar */
.sidebar-heading span {
    font-size: 1.5rem;
    color: #007bff;
    font-weight: bold;
}

/* Hiệu ứng cho link sidebar */
.sidebar .nav-link {
    padding: 0.75rem 1rem;
    color: #adb5bd;
    transition: background-color 0.3s, padding-left 0.3s;
}

.sidebar .nav-link:hover {
    background-color: #007bff;
    color: white;
    padding-left: 1.5rem; /* Tăng khoảng cách khi hover */
}

.sidebar .nav-link i {
    margin-right: 10px;
}

/* Hiệu ứng collapse item */
.sidebar .nav-item .collapse {
    background-color: #495057;
}

.sidebar .nav-item .collapse .nav-link {
    color: #ccc;
    padding-left: 2rem;
}

.sidebar .nav-item .collapse .nav-link:hover {
    background-color: #6c757d;
}

.sidebar .nav-link.active {
    background-color: #28a745;
    color: white;
}

/* Thêm hiệu ứng cho các item có icon */
.sidebar .nav-link i {
    font-size: 1.2rem;
}

    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar">
    <div class="position-sticky">
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Quản lý user</span>
        </h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/quantri">
                    <i class="fas fa-tachometer-alt"></i> Quản trị
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-user-circle"></i> Tài khoản
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-bs-target="#thongTinTaiKhoan">
                    <i class="fas fa-cogs"></i> Thông tin tài khoản <i class="fas fa-caret-down"></i>
                </a>
                <div class="collapse show" id="thongTinTaiKhoan">
                    <ul class="nav flex-column ps-3">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/khachhang">Danh sách khách hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/themnhanvien">Thêm Nhân Viên</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/quantri">
                    <i class="fas fa-users"></i> Quản lý user
                </a>
            </li>
          <li class="nav-item">
    <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-bs-target="#quanLySanPham">
        <i class="fas fa-box"></i> Quản lý Sản Phẩm <i class="fas fa-caret-down"></i>
    </a>
    <div class="collapse" id="quanLySanPham">
        <ul class="nav flex-column ps-3">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/sanpham">Quản lý sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/phukien/list">Quản lý phụ kiện</a></li>
        </ul>
    </div>
</li>
<li class="nav-item">
    <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-bs-target="#thongKe">
        <i class="fas fa-chart-bar"></i> Thống kê <i class="fas fa-caret-down"></i>
    </a>
    <div class="collapse show" id="thongKe">
        <ul class="nav flex-column ps-3">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/thongke">Thống kê bán hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/donhang">Thống kê đơn hàng</a></li>

        </ul>
    </div>
</li>


        </ul>
    </div>
</nav>


        <main class="col-md-3 ms-sm-auto col-lg-9 main-content">

<div class="container my-5">
    <h2>Thống kê doanh thu</h2>
    <form id="reportForm" action="${pageContext.request.contextPath}/thongke" method="get">
        <div class="mb-3">
            <label for="reportRange" class="form-label">Chọn khoảng thời gian:</label>
            <input type="text" id="reportRange" name="reportRange" class="form-control flatpickr">
        </div>
        <button type="submit" class="btn btn-primary">Thống kê</button>
    </form>

    <c:if test="${not empty doanhThuTheoNgay}">
        <h3>Doanh thu theo ngày từ ${startDate} đến ${endDate}:</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Ngày</th>
                    <th>Doanh thu</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="entry" items="${doanhThuTheoNgay}">
                    <tr>
                        <td>${entry.key}</td>
                        <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="VND "/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div class="row">
        <div class="col-md-6">
            <h3>Biểu đồ doanh thu</h3>
         <canvas id="barChart" width="600" height="400"></canvas>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    $(document).ready(function() {
    	flatpickr(".flatpickr", {
    	    mode: "range",
    	    dateFormat: "Y-MM-DD", // Sử dụng MM và DD viết hoa để có 2 chữ số
    	    onClose: function(selectedDates, dateStr, instance) {
    	        console.log("Giá trị dateStr khi đóng flatpickr:", dateStr);
    	        $("#reportRange").val(dateStr);
    	    }
    	});

    	$("#reportForm").submit(function() {
    	    if ($("#reportRange").val() === "") {
    	        alert("Vui lòng chọn khoảng thời gian thống kê.");
    	        return false; // Ngăn chặn submit nếu chưa chọn
    	    }
    	    var encodedReportRange = encodeURIComponent($("#reportRange").val());
    	    console.log("Giá trị reportRange khi submit:", encodedReportRange);
    	    $("#reportRange").val(encodedReportRange); // Gán giá trị đã mã hóa trở lại input
    	    return true; // Cho phép submit
    	});

    	  // Lấy dữ liệu từ model
      // Lấy dữ liệu từ model
    <c:if test="${not empty doanhThuTheoNgay}">
    var doanhThuTheoNgay = ${doanhThuTheoNgay};
    console.log("TOÀN BỘ doanhThuTheoNgay:", JSON.stringify(doanhThuTheoNgay)); // In ra toàn bộ object

    var labels = Object.keys(doanhThuTheoNgay);
    console.log("Labels:", labels); // In ra mảng labels

    var data = Object.values(doanhThuTheoNgay).map(Number); // Chuyển giá trị sang số
    console.log("Data (sau map Number):", data); // In ra mảng data sau khi chuyển đổi

    // Kiểm tra kiểu dữ liệu của từng phần tử trong data
    data.forEach(function(item, index) {
        console.log("Data [" + index + "] (" + typeof item + "):", item);
    });

    // Biểu đồ cột (Bar Chart)
    var ctxBar = document.getElementById('barChart').getContext('2d');
    console.log("ctxBar:", ctxBar); // Kiểm tra context của canvas

    // Biểu đồ cột (Bar Chart)
    var ctxBar = document.getElementById('barChart').getContext('2d');
    var barChart = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Tổng doanh thu',
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    </c:if>
</script>


        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
