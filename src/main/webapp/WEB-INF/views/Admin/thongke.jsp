<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thống kê doanh thu</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
        />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"
        />
        <!-- Admin CSS -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/resources/css/admin-style.css"
        />
    </head>
    <body class="bg-light">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <jsp:include page="sidebar.jsp">
                    <jsp:param name="activeMenu" value="thongke" />
                    <jsp:param name="activeSubmenu" value="doanhthu" />
                </jsp:include>

                <!-- Main content -->
                <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
                    <div class="container mt-4">
                        <!-- Tiêu đề và form chọn ngày -->
                        <div
                            class="d-flex justify-content-between align-items-center mb-4"
                        >
                            <h2>
                                <i class="fas fa-chart-line text-primary"></i>
                                Thống kê doanh thu
                            </h2>
                        </div>

                        <!-- Hiển thị lỗi nếu có -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger mb-4">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                            </div>
                        </c:if>

                        <!-- Form chọn thời gian -->
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-calendar-alt me-2"></i>
                                    Chọn khoảng thời gian
                                </h5>
                            </div>
                            <div class="card-body">
                                <form
                                    id="reportForm"
                                    action="${pageContext.request.contextPath}/thongke"
                                    method="get"
                                >
                                    <div class="mb-3">
                                        <label
                                            for="reportRange"
                                            class="form-label"
                                            >Khoảng thời gian thống kê:</label
                                        >
                                        <input
                                            type="text"
                                            id="reportRange"
                                            name="reportRange"
                                            class="form-control"
                                            placeholder="Chọn khoảng thời gian..."
                                            readonly
                                            value="${param.reportRange}"
                                        />
                                    </div>
                                    <button
                                        type="submit"
                                        class="btn btn-primary"
                                    >
                                        <i class="fas fa-search me-1"></i> Thống
                                        kê
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Hiển thị khoảng thời gian đã chọn -->
                        <c:if
                            test="${not empty startDate and not empty endDate}"
                        >
                            <div class="alert alert-info mb-4">
                                <i class="fas fa-info-circle me-2"></i>
                                Dữ liệu thống kê từ
                                <strong>${startDate}</strong> đến
                                <strong>${endDate}</strong>
                            </div>

                            <!-- Thẻ tổng quan thống kê doanh thu -->
                            <c:if test="${not empty doanhThuTheoNgay}">
                                <%-- Tính tổng doanh thu từ JSP --%>
                                <c:set var="totalRevenue" value="0" />
                                <c:forEach
                                    var="entry"
                                    items="${doanhThuTheoNgay}"
                                >
                                    <c:set
                                        var="totalRevenue"
                                        value="${totalRevenue + entry.value}"
                                    />
                                </c:forEach>

                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <div
                                            class="card text-white bg-success mb-3 h-100"
                                        >
                                            <div
                                                class="card-body text-center py-4"
                                            >
                                                <h1 class="display-4 mb-3">
                                                    <i
                                                        class="fas fa-money-bill-wave mb-3 d-block"
                                                    ></i>
                                                    <fmt:formatNumber
                                                        value="${totalRevenue}"
                                                        type="currency"
                                                        currencySymbol=""
                                                        maxFractionDigits="0"
                                                    />
                                                </h1>
                                                <h5 class="card-title">
                                                    VNĐ Tổng doanh thu
                                                </h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div
                                            class="card text-white bg-primary mb-3 h-100"
                                        >
                                            <div
                                                class="card-body text-center py-4"
                                            >
                                                <h1 class="display-4 mb-3">
                                                    <i
                                                        class="fas fa-calendar-check mb-3 d-block"
                                                    ></i>
                                                    ${doanhThuTheoNgay.size()}
                                                </h1>
                                                <h5 class="card-title">
                                                    Ngày có doanh thu
                                                </h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>

                        <!-- Hiển thị bảng dữ liệu thống kê -->
                        <c:if test="${not empty doanhThuTheoNgay}">
                            <div class="row">
                                <!-- Biểu đồ doanh thu -->
                                <div class="col-md-8 mb-4">
                                    <div class="card shadow-sm">
                                        <div
                                            class="card-header bg-primary text-white"
                                        >
                                            <h5 class="mb-0">
                                                <i
                                                    class="fas fa-chart-bar me-2"
                                                ></i>
                                                Biểu đồ doanh thu theo ngày
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <canvas
                                                id="revenueChart"
                                                height="300"
                                            ></canvas>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bảng dữ liệu -->
                                <div class="col-md-4 mb-4">
                                    <div class="card shadow-sm">
                                        <div
                                            class="card-header bg-success text-white"
                                        >
                                            <h5 class="mb-0">
                                                <i
                                                    class="fas fa-table me-2"
                                                ></i>
                                                Chi tiết doanh thu
                                            </h5>
                                        </div>
                                        <div class="card-body p-0">
                                            <div
                                                class="table-responsive"
                                                style="max-height: 350px"
                                            >
                                                <table
                                                    class="table table-hover table-striped mb-0"
                                                >
                                                    <thead
                                                        class="table-light sticky-top"
                                                    >
                                                        <tr>
                                                            <th class="px-3">
                                                                Ngày
                                                            </th>
                                                            <th
                                                                class="text-end px-3"
                                                            >
                                                                Doanh thu
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach
                                                            var="entry"
                                                            items="${doanhThuTheoNgay}"
                                                        >
                                                            <tr>
                                                                <td
                                                                    class="px-3"
                                                                >
                                                                    ${entry.key.replace('"',
                                                                    '')}
                                                                </td>
                                                                <td
                                                                    class="text-end px-3"
                                                                >
                                                                    <fmt:formatNumber
                                                                        value="${entry.value}"
                                                                        type="currency"
                                                                        currencySymbol="VND "
                                                                        maxFractionDigits="0"
                                                                    />
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Biểu đồ đường xu hướng -->
                                <div class="col-md-12">
                                    <div class="card shadow-sm">
                                        <div
                                            class="card-header bg-info text-white"
                                        >
                                            <h5 class="mb-0">
                                                <i
                                                    class="fas fa-chart-line me-2"
                                                ></i>
                                                Xu hướng doanh thu theo thời
                                                gian
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <canvas
                                                id="trendChart"
                                                height="200"
                                            ></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Hướng dẫn khi chưa có dữ liệu -->
                        <c:if test="${empty doanhThuTheoNgay and empty error}">
                            <div class="alert alert-warning">
                                <h4 class="alert-heading">
                                    <i class="fas fa-info-circle me-2"></i> Chưa
                                    có dữ liệu thống kê
                                </h4>
                                <p class="mb-0">
                                    Vui lòng chọn khoảng thời gian và nhấn
                                    "Thống kê" để xem báo cáo doanh thu.
                                </p>
                            </div>
                        </c:if>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script>
            $(document).ready(function() {
                // Cấu hình flatpickr với định dạng ngày đúng
                flatpickr("#reportRange", {
                    mode: "range",
                    dateFormat: "Y-m-d",
                    allowInput: true,
                    altInput: true,
                    altFormat: "d/m/Y",
                    locale: {
                        firstDayOfWeek: 1,
                        weekdays: {
                            shorthand: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
                            longhand: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy']
                        },
                        months: {
                            shorthand: ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'],
                            longhand: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12']
                        }
                    },
                    onChange: function(selectedDates, dateStr, instance) {
                        if(selectedDates.length === 2) {
                            // Khi người dùng chọn đủ 2 ngày, gán giá trị vào input
                            $("#reportRange").val(dateStr);
                            console.log("Đã chọn khoảng thời gian:", dateStr);
                        }
                    }
                });

                // Log giá trị khi form được submit để debug
                $("#reportForm").submit(function(e) {
                    var dateRange = $("#reportRange").val();
                    console.log("Giá trị reportRange khi submit:", dateRange);

                    // Nếu không có giá trị, không submit form
                    if (!dateRange || dateRange.trim() === "") {
                        e.preventDefault();
                        alert("Vui lòng chọn khoảng thời gian trước khi thống kê");
                        return false;
                    }
                });

                // Hover effect for sidebar links using Bootstrap classes
                $('.nav-link').hover(function() {
                    if (!$(this).hasClass('bg-success')) {
                        $(this).removeClass('text-white-50').addClass('text-white');
                    }
                }, function() {
                    if (!$(this).hasClass('bg-success')) {
                        $(this).removeClass('text-white').addClass('text-white-50');
                    }
                });
            });

            // Lấy dữ liệu từ model
            <c:if test="${not empty doanhThuTheoNgay}">
            // Chuẩn bị dữ liệu cho biểu đồ
            var doanhThuTheoNgay = ${doanhThuTheoNgay};
            var labels = Object.keys(doanhThuTheoNgay).map(key => key.replace(/"/g, ''));
            var data = Object.values(doanhThuTheoNgay);

            // Dữ liệu được sắp xếp theo thứ tự ngày tăng dần
            var sortedIndices = labels.map((label, index) => ({label, index}))
                                     .sort((a, b) => new Date(a.label) - new Date(b.label))
                                     .map(item => item.index);

            var sortedLabels = sortedIndices.map(index => labels[index]);
            var sortedData = sortedIndices.map(index => data[index]);

            // Tạo định dạng hiển thị ngày
            var formattedLabels = sortedLabels.map(label => {
                var date = new Date(label);
                return date.getDate() + '/' + (date.getMonth() + 1);
            });

            // Biểu đồ cột doanh thu
            var ctxBar = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: formattedLabels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: sortedData,
                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString('vi-VN') + ' VNĐ';
                                }
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.parsed.y.toLocaleString('vi-VN') + ' VNĐ';
                                }
                            }
                        }
                    }
                }
            });

            // Biểu đồ xu hướng
            var ctxLine = document.getElementById('trendChart').getContext('2d');
            var trendChart = new Chart(ctxLine, {
                type: 'line',
                data: {
                    labels: formattedLabels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: sortedData,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 2,
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString('vi-VN') + ' VNĐ';
                                }
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.parsed.y.toLocaleString('vi-VN') + ' VNĐ';
                                }
                            }
                        }
                    }
                }
            });
            </c:if>
        </script>
    </body>
</html>
