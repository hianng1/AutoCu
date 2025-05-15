<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thống kê bán hàng</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
        />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
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
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <jsp:include page="sidebar.jsp">
                    <jsp:param name="activeMenu" value="thongke" />
                    <jsp:param name="activeSubmenu" value="banhang" />
                </jsp:include>

                <!-- Main content -->
                <main class="col-md-9 ms-sm-auto col-lg-9 main-content">
                    <div class="container my-5">
                        <!-- Tiêu đề trang và chọn khoảng thời gian -->
                        <div class="row mb-4 align-items-center">
                            <div class="col-md-6">
                                <h2>
                                    <i class="fas fa-chart-line"></i> Thống kê
                                    bán hàng
                                </h2>
                            </div>
                            <div class="col-md-6">
                                <form
                                    id="dateRangeForm"
                                    action="${pageContext.request.contextPath}/thongke/banhang"
                                    method="get"
                                    class="d-flex"
                                >
                                    <input
                                        type="text"
                                        id="dateRange"
                                        class="form-control date-range-picker me-2"
                                        placeholder="Chọn khoảng thời gian..."
                                        readonly
                                    />
                                    <input
                                        type="hidden"
                                        id="startDate"
                                        name="startDate"
                                    />
                                    <input
                                        type="hidden"
                                        id="endDate"
                                        name="endDate"
                                    />
                                    <button
                                        type="submit"
                                        class="btn btn-primary"
                                    >
                                        <i class="fas fa-search"></i> Lọc
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Hiển thị lỗi nếu có -->
                        <c:if test="${not empty error}">
                            <div class="error-message">
                                <i class="fas fa-exclamation-triangle"></i>
                                ${error}
                            </div>
                        </c:if>

                        <!-- Hiển thị khoảng thời gian đang xem -->
                        <div class="alert alert-info mb-4">
                            <i class="fas fa-calendar"></i>
                            Thống kê từ
                            <strong
                                ><fmt:formatDate
                                    value="${startDate}"
                                    pattern="dd/MM/yyyy"
                            /></strong>
                            đến
                            <strong
                                ><fmt:formatDate
                                    value="${endDate}"
                                    pattern="dd/MM/yyyy"
                            /></strong>
                        </div>

                        <!-- Thống kê tổng quan -->
                        <div class="row">
                            <!-- Tổng doanh thu card -->
                            <div class="col-md-4">
                                <div class="stat-card revenue-card">
                                    <div class="icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <h3>
                                        <fmt:formatNumber
                                            value="${tongDoanhThu}"
                                            type="currency"
                                            currencySymbol="VND "
                                            maxFractionDigits="0"
                                        />
                                    </h3>
                                    <p>Tổng doanh thu</p>
                                </div>
                            </div>

                            <!-- Tổng đơn hàng card -->
                            <div class="col-md-4">
                                <div class="stat-card orders-card">
                                    <div class="icon">
                                        <i class="fas fa-shopping-cart"></i>
                                    </div>
                                    <h3>${tongSoDonHang}</h3>
                                    <p>Tổng số đơn hàng đã giao</p>
                                </div>
                            </div>

                            <!-- Tổng sản phẩm card -->
                            <div class="col-md-4">
                                <div class="stat-card products-card">
                                    <div class="icon">
                                        <i class="fas fa-box-open"></i>
                                    </div>
                                    <h3>${tongSoLuongSanPham}</h3>
                                    <p>Tổng sản phẩm bán ra</p>
                                </div>
                            </div>
                        </div>

                        <!-- Biểu đồ phân tích -->
                        <div class="row mt-4">
                            <div class="col-md-7">
                                <div class="card shadow-sm">
                                    <div
                                        class="card-header bg-primary text-white"
                                    >
                                        <h5 class="mb-0">
                                            <i class="fas fa-chart-bar"></i>
                                            Doanh thu theo ngày
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas
                                            id="salesChart"
                                            height="300"
                                        ></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-5">
                                <div class="card shadow-sm">
                                    <div
                                        class="card-header bg-success text-white"
                                    >
                                        <h5 class="mb-0">
                                            <i class="fas fa-chart-pie"></i>
                                            Trạng thái đơn hàng
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <canvas
                                            id="orderStatusChart"
                                            height="300"
                                        ></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bảng thống kê chi tiết -->
                        <div class="card shadow-sm mt-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-table"></i> Chi tiết doanh
                                    thu theo ngày
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table
                                        class="table table-striped table-hover"
                                    >
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Ngày</th>
                                                <th>Số đơn hàng</th>
                                                <th>Doanh thu</th>
                                                <th>Sản phẩm bán ra</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Dữ liệu thực từ database -->
                                            <c:if
                                                test="${empty chiTietTheoNgay}"
                                            >
                                                <tr>
                                                    <td
                                                        colspan="5"
                                                        class="text-center"
                                                    >
                                                        Không có dữ liệu
                                                    </td>
                                                </tr>
                                            </c:if>

                                            <c:forEach
                                                var="item"
                                                items="${chiTietTheoNgay}"
                                                varStatus="status"
                                            >
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${item.ngay}</td>
                                                    <td>${item.soDonHang}</td>
                                                    <td>
                                                        <fmt:formatNumber
                                                            value="${item.doanhThu}"
                                                            type="currency"
                                                            currencySymbol="VND "
                                                            maxFractionDigits="0"
                                                        />
                                                    </td>
                                                    <td>${item.soSanPham}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script>
            // Khởi tạo date picker
            document.addEventListener("DOMContentLoaded", function () {
                // Cấu hình flatpickr cho chọn khoảng thời gian
                flatpickr("#dateRange", {
                    mode: "range",
                    dateFormat: "Y-m-d",
                    altInput: true,
                    altFormat: "d/m/Y",
                    locale: {
                        firstDayOfWeek: 1,
                        weekdays: {
                            shorthand: [
                                "CN",
                                "T2",
                                "T3",
                                "T4",
                                "T5",
                                "T6",
                                "T7",
                            ],
                            longhand: [
                                "Chủ Nhật",
                                "Thứ Hai",
                                "Thứ Ba",
                                "Thứ Tư",
                                "Thứ Năm",
                                "Thứ Sáu",
                                "Thứ Bảy",
                            ],
                        },
                        months: {
                            shorthand: [
                                "Th1",
                                "Th2",
                                "Th3",
                                "Th4",
                                "Th5",
                                "Th6",
                                "Th7",
                                "Th8",
                                "Th9",
                                "Th10",
                                "Th11",
                                "Th12",
                            ],
                            longhand: [
                                "Tháng 1",
                                "Tháng 2",
                                "Tháng 3",
                                "Tháng 4",
                                "Tháng 5",
                                "Tháng 6",
                                "Tháng 7",
                                "Tháng 8",
                                "Tháng 9",
                                "Tháng 10",
                                "Tháng 11",
                                "Tháng 12",
                            ],
                        },
                    },
                    onChange: function (selectedDates, dateStr) {
                        if (selectedDates.length === 2) {
                            var startDate = flatpickr.formatDate(
                                selectedDates[0],
                                "Y-m-d"
                            );
                            var endDate = flatpickr.formatDate(
                                selectedDates[1],
                                "Y-m-d"
                            );

                            document.getElementById("startDate").value =
                                startDate;
                            document.getElementById("endDate").value = endDate;
                        }
                    },
                });

                // Biểu đồ doanh thu theo ngày với dữ liệu thực
                var salesCtx = document
                    .getElementById("salesChart")
                    .getContext("2d");
                var salesChart = new Chart(salesCtx, {
                    type: "line",
                    data: {
                        labels: [
                            <c:forEach
                                var="label"
                                items="${labelsDoanhThu}"
                                varStatus="status"
                            >
                                '${label}'<c:if test="${!status.last}">,</c:if>
                            </c:forEach>,
                        ],
                        datasets: [
                            {
                                label: "Doanh thu (VNĐ)",
                                data: [
                                    <c:forEach
                                        var="data"
                                        items="${dataDoanhThu}"
                                        varStatus="status"
                                    >
                                        ${data}
                                        <c:if test="${!status.last}">,</c:if>
                                    </c:forEach>,
                                ],
                                backgroundColor: "rgba(54, 162, 235, 0.2)",
                                borderColor: "rgba(54, 162, 235, 1)",
                                borderWidth: 2,
                                tension: 0.3,
                            },
                        ],
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function (value) {
                                        return (
                                            value.toLocaleString("vi-VN") +
                                            " VNĐ"
                                        );
                                    },
                                },
                            },
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return (
                                            context.parsed.y.toLocaleString(
                                                "vi-VN"
                                            ) + " VNĐ"
                                        );
                                    },
                                },
                            },
                        },
                    },
                });

                // Biểu đồ trạng thái đơn hàng với dữ liệu thực
                var statusCtx = document
                    .getElementById("orderStatusChart")
                    .getContext("2d");
                var statusChart = new Chart(statusCtx, {
                    type: "doughnut",
                    data: {
                        labels: [
                            <c:forEach
                                var="label"
                                items="${labelsTrangThai}"
                                varStatus="status"
                            >
                                '${label}'<c:if test="${!status.last}">,</c:if>
                            </c:forEach>,
                        ],
                        datasets: [
                            {
                                data: [
                                    <c:forEach
                                        var="data"
                                        items="${dataTrangThai}"
                                        varStatus="status"
                                    >
                                        ${data}
                                        <c:if test="${!status.last}">,</c:if>
                                    </c:forEach>,
                                ],
                                backgroundColor: [
                                    "rgba(75, 192, 192, 0.7)",
                                    "rgba(54, 162, 235, 0.7)",
                                    "rgba(255, 206, 86, 0.7)",
                                    "rgba(255, 99, 132, 0.7)",
                                    "rgba(153, 102, 255, 0.7)",
                                ],
                                borderColor: [
                                    "rgba(75, 192, 192, 1)",
                                    "rgba(54, 162, 235, 1)",
                                    "rgba(255, 206, 86, 1)",
                                    "rgba(255, 99, 132, 1)",
                                    "rgba(153, 102, 255, 1)",
                                ],
                                borderWidth: 1,
                            },
                        ],
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: "bottom",
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        var label = context.label || "";
                                        var value = context.parsed;
                                        var total = context.dataset.data.reduce(
                                            (a, b) => a + b,
                                            0
                                        );
                                        var percentage = Math.round(
                                            (value / total) * 100
                                        );
                                        return (
                                            label +
                                            ": " +
                                            value +
                                            " đơn hàng (" +
                                            percentage +
                                            "%)"
                                        );
                                    },
                                },
                            },
                        },
                    },
                });
            });
        </script>
    </body>
</html>
