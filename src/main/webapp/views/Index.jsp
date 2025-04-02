<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Danh sách sản phẩm</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Số ghế</th>
                <th>Truyền động</th>
                <th>Nhiên liệu</th>
                <th>Địa điểm lấy xe</th>
                <th>Hãng xe</th>
                <th>Giá</th>
                <th>Số lượng trong kho</th>
                <th>Ngày sản xuất</th>
                <th>Bảo hành</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.productID}</td>
                    <td>${item.tenSanPham}</td>
                    <td>${item.soGhe}</td>
                    <td>${item.truyenDong}</td>
                    <td>${item.nhienLieu}</td>
                    <td>${item.diaDiemLayXe}</td>
                    <td>${item.hangXe}</td>
                    <td>${item.gia}</td>
                    <td>${item.soLuongTrongKho}</td>
                    <td>${item.ngaySanXuat}</td>
                    <td>${item.baoHanh}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách dữ liệu</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        h2 {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <h1>Danh sách dữ liệu từ cơ sở dữ liệu QuanLyXe</h1>

    <!-- Bảng Danh Mục -->
    <h2>Danh mục xe</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dm" items="${danhMucList}">
                <tr>
                    <td>${dm.categoryID}</td>
                    <td>${dm.tenDanhMuc}</td>
                    <td>${dm.moTa}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Bảng Sản Phẩm -->
    <h2>Danh sách sản phẩm (Xe)</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Số ghế</th>
                <th>Truyền động</th>
                <th>Nhiên liệu</th>
                <th>Địa điểm lấy xe</th>
                <th>Hãng xe</th>
                <th>Giá</th>
                <th>Số lượng trong kho</th>
                <th>Ngày sản xuất</th>
                <th>Bảo hành</th>
            </tr>
        </thead>
        <tbody>
		    <c:forEach var="sp" items="${sanPhamList}">
		        <tr>
		            <td>${sp.productID}</td>
		            <td>${sp.tenSanPham}</td>
		            <td>${sp.soGhe}</td>
		            <td>${sp.truyenDong}</td>
		            <td>${sp.nhienLieu}</td>
		            <td>${sp.diaDiemLayXe}</td>
		            <td>${sp.hangXe}</td>
		            <td>${sp.gia}</td>
		            <td>${sp.soLuongTrongKho}</td>
		            <td>${sp.ngaySanXuat}</td>
		            <td>${sp.baoHanh}</td>	
		            <td>
		                <img src="/imgs/${sp.anhDaiDien}" alt="${sp.tenSanPham}" width="100"/>
		            </td>
		        </tr>
		    </c:forEach>
		</tbody>

        </tbody>
    </table>

    <!-- Bảng Nhân Viên -->
    <h2>Danh sách nhân viên</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên nhân viên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Vai trò</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="nv" items="${nhanVienList}">
                <tr>
                    <td>${nv.staffID}</td>
                    <td>${nv.tenNhanVien}</td>
                    <td>${nv.email}</td>
                    <td>${nv.soDienThoai}</td>
                    <td>${nv.vaiTro ? "Quản lý" : "Nhân viên"}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Bảng Khách Hàng -->
    <h2>Danh sách khách hàng</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên khách hàng</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Mật Khẩu</th>
                <th>Địa Chỉ</th>
                <th>Vai Trò</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="kh" items="${khachHangList}">
                <tr>
                    <td>${kh.userID}</td>
                    <td>${kh.tenKhachHang}</td>
                    <td>${kh.email}</td>
                    <td>${kh.soDienThoai}</td>
                    <td>${kh.matKhau}</td>
                    <td>${kh.diaChi}</td>
                    <td>${kh.vaiTro}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Bảng Mã Khuyến Mãi -->
    <h2>Danh sách mã khuyến mãi</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Mã khuyến mãi</th>
                <th>Phần trăm giảm</th>
                <th>Hạn sử dụng</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="km" items="${maKhuyenMaiList}">
                <tr>
                    <td>${km.couponID}</td>
                    <td>${km.maKhuyenMai}</td>
                    <td>${km.phanTramGiam}%</td>
                    <td>${km.hanSuDung}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
	
    <%-- <!-- Bảng Đơn Hàng -->
    <h2>Danh sách đơn hàng</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Khách hàng</th>
                <th>Nhân viên</th>
                <th>Ngày đặt</th>
                <th>Trạng thái</th>
                <th>Tổng tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dh" items="${donHangList}">
                <tr>
                    <td>${dh.orderID}</td>
                    <td>${dh.customerID}</td>
                    <td>${dh.staffID}</td>
                    <td>${dh.ngayDat}</td>
                    <td>${dh.trangThai}</td>
                    <td>${dh.tongTien}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table> --%>
</body>
</html>
